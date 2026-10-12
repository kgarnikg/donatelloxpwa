-- 0091: оплата через vPOS Америабанка (REST API vPOS 3.1).
--
-- Как идёт оплата (apps/web/api):
--   1. create-checkout   — сервер считает сумму сам, создаёт запись платежа
--                          (vpos_create_payment), регистрирует его в банке
--                          (InitPayment) и отправляет человека на страницу
--                          оплаты банка;
--   2. payment-return    — банк возвращает человека на BackURL. Параметрам в
--                          адресе не верим: сервер спрашивает банк
--                          (GetPaymentDetails) и только при подтверждённой
--                          оплате открывает доступ (vpos_payment_paid);
--   3. admin/vpos        — из админки: отмена (CancelPayment, в течение 72 ч)
--                          и возврат (RefundPayment) → vpos_payment_reversed.
--
-- Тестовая среда банка: номер заказа (OrderID) — только из диапазона
-- 4687001–4688000, сумма — 10 драм. Поэтому номера заказов берутся из
-- последовательности, начинающейся с 4687001, а сумму в тестовом режиме
-- подставляет сервер (переменная VPOS_TEST_MODE на Vercel). Тестовые
-- платежи помечаются is_test.
--
-- Все функции — только для сервера (service_role), из браузера их не вызвать.
-- Суммы — в минорных единицах, как везде (0086): 10 драм = 1000.
-- Безопасно выполнять повторно.

-- ---------------------------------------------------------------------------
-- 1. Провайдер, статусы, поля
-- ---------------------------------------------------------------------------
alter table public.payments drop constraint if exists payments_provider_check;
alter table public.payments add constraint payments_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'ararat', 'ameria'));

alter table public.subscriptions drop constraint if exists subscriptions_provider_check;
alter table public.subscriptions add constraint subscriptions_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'gift', 'ararat', 'ameria'));

-- 'canceled' — оплату отменили в банке целиком (CancelPayment)
alter table public.payments drop constraint if exists payments_status_check;
alter table public.payments add constraint payments_status_check
  check (status in ('pending', 'confirmed', 'failed', 'refunded', 'expired', 'canceled'));

alter table public.payments add column if not exists bank_order_id bigint;
alter table public.payments add column if not exists is_test boolean not null default false;
alter table public.payments add column if not exists refunded_amount numeric not null default 0;

comment on column public.payments.bank_order_id is 'OrderID, под которым платёж зарегистрирован в vPOS (0091).';
comment on column public.payments.is_test is 'Платёж в тестовой среде банка (0091) — деньги не списывались.';
comment on column public.payments.refunded_amount is 'Сколько уже возвращено через банк, в минорных единицах (0091).';

create unique index if not exists payments_bank_order_id_key
  on public.payments (provider, bank_order_id) where bank_order_id is not null;

create sequence if not exists public.vpos_order_seq start with 4687001;

-- ---------------------------------------------------------------------------
-- 2. Новый платёж (до отправки в банк)
-- ---------------------------------------------------------------------------
create or replace function public.vpos_create_payment(
  p_user_id uuid,
  p_plan text,
  p_currency text,
  p_amount numeric,
  p_discount_percent integer,
  p_consent boolean,
  p_is_test boolean
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_order bigint;
  v_id uuid;
begin
  v_order := nextval('public.vpos_order_seq');
  if p_is_test and v_order > 4688000 then
    raise exception 'Закончились тестовые номера заказов (4687001–4688000)';
  end if;

  insert into public.payments (
    user_id, provider, provider_payment_id, amount, currency, status,
    order_number, bank_order_id, plan, discount_percent,
    withdrawal_consent_at, is_test
  ) values (
    p_user_id, 'ameria', 'order-' || v_order, p_amount, p_currency, 'pending',
    v_order::text, v_order, p_plan, coalesce(p_discount_percent, 0),
    case when p_consent then now() end, coalesce(p_is_test, false)
  )
  returning id into v_id;

  return jsonb_build_object('payment_id', v_id, 'order_id', v_order);
end;
$$;

-- PaymentID банка (из InitPayment) — по нему потом спрашиваем статус
create or replace function public.vpos_attach_bank_payment(p_payment_id uuid, p_bank_payment_id text)
returns void
language sql
security definer
set search_path = public
as $$
  update public.payments
  set provider_payment_id = p_bank_payment_id
  where id = p_payment_id and provider = 'ameria';
$$;

-- ---------------------------------------------------------------------------
-- 3. Оплата подтверждена банком → доступ
-- ---------------------------------------------------------------------------
create or replace function public.vpos_payment_paid(p_payment_id uuid, p_details jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pay public.payments%rowtype;
  v_sub public.subscriptions%rowtype;
  v_months integer;
  v_sub_id uuid;
begin
  select * into v_pay from public.payments where id = p_payment_id for update;
  if not found then
    raise exception 'Платёж не найден';
  end if;
  -- Повторный заход на BackURL (обновили страницу) — ничего не продлеваем второй раз
  if v_pay.status <> 'pending' and v_pay.status <> 'failed' then
    return jsonb_build_object('status', v_pay.status, 'subscription_id', v_pay.subscription_id);
  end if;

  v_months := case v_pay.plan when 'quarterly' then 3 when 'semiannual' then 6 when 'annual' then 12 else 1 end;

  -- Есть действующая оплаченная подписка — продлеваем её, иначе новая.
  -- Подарочный безлимит (gift) не трогаем.
  select * into v_sub
  from public.subscriptions s
  where s.user_id = v_pay.user_id
    and s.provider <> 'gift'
    and s.status in ('active', 'trialing', 'past_due')
    and s.current_period_end > now()
  order by s.current_period_end desc
  limit 1
  for update;

  if found then
    update public.subscriptions
    set current_period_end = current_period_end + make_interval(months => v_months),
        plan = coalesce(v_pay.plan, plan),
        reminder_sent_at = null,
        updated_at = now()
    where id = v_sub.id;
    v_sub_id := v_sub.id;
  else
    insert into public.subscriptions (
      user_id, plan, status, current_period_start, current_period_end, provider
    ) values (
      v_pay.user_id, coalesce(v_pay.plan, 'monthly'), 'active', now(),
      now() + make_interval(months => v_months), 'ameria'
    )
    returning id into v_sub_id;
  end if;

  update public.payments
  set status = 'confirmed',
      confirmed_at = now(),
      subscription_id = v_sub_id,
      raw_payload = coalesce(raw_payload, '{}'::jsonb) || jsonb_build_object('paid', p_details)
  where id = p_payment_id;

  -- Реферальная скидка использована
  if v_pay.discount_percent > 0 then
    perform set_config('donatellex.trusted', 'on', true);
    update public.users
    set pending_discount_percent = 0,
        pending_discount_reason = null
    where id = v_pay.user_id;
  end if;

  return jsonb_build_object('status', 'confirmed', 'subscription_id', v_sub_id);
end;
$$;

create or replace function public.vpos_payment_failed(p_payment_id uuid, p_details jsonb)
returns void
language sql
security definer
set search_path = public
as $$
  update public.payments
  set status = 'failed',
      raw_payload = coalesce(raw_payload, '{}'::jsonb) || jsonb_build_object('failed', p_details)
  where id = p_payment_id and status = 'pending';
$$;

-- ---------------------------------------------------------------------------
-- 4. Отмена / возврат через банк
-- ---------------------------------------------------------------------------
-- p_kind: 'cancel' (вся сумма, CancelPayment) или 'refund' (RefundPayment,
-- можно частично). Когда возвращена вся сумма — доступ за этот период
-- закрывается (если его ещё не закрыли, одобрив заявку на возврат), а
-- заявка на возврат, если есть, помечается "деньги возвращены".
create or replace function public.vpos_payment_reversed(
  p_payment_id uuid,
  p_kind text,
  p_amount numeric,
  p_details jsonb
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pay public.payments%rowtype;
  v_req public.refund_requests%rowtype;
  v_total numeric;
  v_full boolean;
  v_months integer;
begin
  if p_kind not in ('cancel', 'refund') then
    raise exception 'Неизвестное действие %', p_kind;
  end if;

  select * into v_pay from public.payments where id = p_payment_id for update;
  if not found then
    raise exception 'Платёж не найден';
  end if;

  v_total := least(v_pay.amount, coalesce(v_pay.refunded_amount, 0) + coalesce(p_amount, v_pay.amount));
  v_full := p_kind = 'cancel' or v_total >= v_pay.amount;

  update public.payments
  set refunded_amount = case when p_kind = 'cancel' then amount else v_total end,
      status = case
        when p_kind = 'cancel' then 'canceled'
        when v_full then 'refunded'
        else status
      end,
      raw_payload = coalesce(raw_payload, '{}'::jsonb)
        || jsonb_build_object(p_kind || '_' || to_char(now(), 'YYYYMMDDHH24MISS'), p_details)
  where id = p_payment_id;

  if not v_full then
    return jsonb_build_object('status', v_pay.status, 'refunded_amount', v_total);
  end if;

  select * into v_req
  from public.refund_requests r
  where r.payment_id = p_payment_id and r.status <> 'rejected'
  order by r.requested_at desc
  limit 1
  for update;

  -- Доступ закрываем, если его не закрыло одобрение заявки
  if v_req.id is null or v_req.status = 'pending' then
    v_months := case v_pay.plan when 'quarterly' then 3 when 'semiannual' then 6 when 'annual' then 12 else 1 end;
    update public.subscriptions s
    set current_period_end = greatest(now(), s.current_period_end - make_interval(months => v_months)),
        status = case
          when s.current_period_end - make_interval(months => v_months) <= now() then 'canceled'
          else s.status
        end,
        reminder_sent_at = null,
        updated_at = now()
    where s.id = v_pay.subscription_id;
  end if;

  if v_req.id is not null and v_req.status in ('pending', 'approved') then
    update public.refund_requests
    set status = 'refunded',
        refund_amount = coalesce(p_amount, refund_amount),
        decided_at = coalesce(decided_at, now()),
        refunded_at = now()
    where id = v_req.id;
  end if;

  return jsonb_build_object(
    'status', case when p_kind = 'cancel' then 'canceled' else 'refunded' end,
    'refunded_amount', case when p_kind = 'cancel' then v_pay.amount else v_total end
  );
end;
$$;

revoke all on function public.vpos_create_payment(uuid, text, text, numeric, integer, boolean, boolean) from public, anon, authenticated;
revoke all on function public.vpos_attach_bank_payment(uuid, text) from public, anon, authenticated;
revoke all on function public.vpos_payment_paid(uuid, jsonb) from public, anon, authenticated;
revoke all on function public.vpos_payment_failed(uuid, jsonb) from public, anon, authenticated;
revoke all on function public.vpos_payment_reversed(uuid, text, numeric, jsonb) from public, anon, authenticated;
grant execute on function public.vpos_create_payment(uuid, text, text, numeric, integer, boolean, boolean) to service_role;
grant execute on function public.vpos_attach_bank_payment(uuid, text) to service_role;
grant execute on function public.vpos_payment_paid(uuid, jsonb) to service_role;
grant execute on function public.vpos_payment_failed(uuid, jsonb) to service_role;
grant execute on function public.vpos_payment_reversed(uuid, text, numeric, jsonb) to service_role;
grant usage on sequence public.vpos_order_seq to service_role;

notify pgrst, 'reload schema';
