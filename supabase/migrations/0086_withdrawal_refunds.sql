-- 0086: отказ от подписки и возврат денег (право на отказ 14 дней).
--
-- Закон: ЕС (директива 2011/83, в Испании TRLGDCU ст. 102–108) и Армения
-- (с 1.07.2026) — 14 дней с оплаты на отказ без объяснения причин; деньги
-- вернуть не позже 14 дней после заявления. Если при оплате человек явно
-- попросил открыть доступ сразу (галочка на экране оплаты,
-- payments.withdrawal_consent_at), удерживаем стоимость использованных дней
-- пропорционально сроку; без такого согласия возвращаем всю сумму.
--
-- Как устроено:
--   • get_withdrawal_info() — приложение показывает, можно ли отказаться,
--     до какого числа и сколько вернём;
--   • request_withdrawal(причина) — "кнопка отказа" в приложении создаёт
--     заявку (refund_requests). Сумма считается здесь, на сервере;
--   • админка: admin_update_refund(заявка, 'approve' | 'refunded' | 'reject',
--     сумма, комментарий). "Одобрить" сразу закрывает доступ за этот
--     оплаченный период; "Деньги возвращены" — после возврата в кабинете
--     банка (пока vPOS не подключён, возврат делается вручную там).
--
-- Суммы — в минорных единицах (центы, копейки; у драма — лумы), как цены в
-- packages/types/src/pricing.ts. Так же payments.amount пишет будущая
-- серверная функция оплаты.

-- ---------------------------------------------------------------------------
-- 1. Согласие "открыть доступ сразу" — записывается при создании оплаты
-- ---------------------------------------------------------------------------
alter table public.payments
  add column if not exists withdrawal_consent_at timestamptz;

comment on column public.payments.withdrawal_consent_at is
  'Когда покупатель отметил "Прошу открыть доступ сразу; при отказе в течение 14 дней оплачу использованные дни" (0086).';

-- ---------------------------------------------------------------------------
-- 2. Заявки на возврат
-- ---------------------------------------------------------------------------
create table if not exists public.refund_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.users (id) on delete set null,
  payment_id uuid references public.payments (id) on delete set null,
  subscription_id uuid references public.subscriptions (id) on delete set null,
  requested_at timestamptz not null default now(),
  reason text,
  plan text,
  paid_at timestamptz,
  days_used integer,
  period_days integer,
  paid_amount numeric,
  currency text,
  refund_amount numeric,
  consent_given boolean not null default false,
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'refunded', 'rejected')),
  admin_comment text,
  decided_at timestamptz,
  decided_by uuid references public.users (id) on delete set null,
  refunded_at timestamptz
);

create index if not exists refund_requests_user_idx on public.refund_requests (user_id, requested_at desc);
create index if not exists refund_requests_status_idx on public.refund_requests (status, requested_at);
-- по одному платежу — одна действующая заявка (после отказа можно подать снова)
create unique index if not exists refund_requests_payment_active_key
  on public.refund_requests (payment_id) where status <> 'rejected';

alter table public.refund_requests enable row level security;

drop policy if exists "refund_requests_select_own_or_admin" on public.refund_requests;
create policy "refund_requests_select_own_or_admin" on public.refund_requests
  for select using (user_id = auth.uid() or public.is_admin());
-- писать напрямую нельзя никому: только функции ниже

-- ---------------------------------------------------------------------------
-- 3. Расчёт: последний оплаченный период человека
-- ---------------------------------------------------------------------------
create or replace function public.withdrawal_calc(p_user_id uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_pay public.payments%rowtype;
  v_start timestamptz;
  v_months integer;
  v_period integer;
  v_used integer;
  v_refund numeric;
  v_req public.refund_requests%rowtype;
begin
  select * into v_pay
  from public.payments p
  where p.user_id = p_user_id
    and p.status in ('confirmed', 'refunded')
  order by coalesce(p.confirmed_at, p.created_at) desc
  limit 1;

  if not found then
    return jsonb_build_object('eligible', false, 'reason', 'no_paid');
  end if;

  select * into v_req
  from public.refund_requests r
  where r.payment_id = v_pay.id
  order by r.requested_at desc
  limit 1;

  v_start := coalesce(v_pay.confirmed_at, v_pay.created_at);
  v_months := case v_pay.plan when 'quarterly' then 3 when 'semiannual' then 6 when 'annual' then 12 else 1 end;
  v_period := greatest(1, extract(day from (v_start + make_interval(months => v_months)) - v_start)::integer);
  v_used := least(v_period, greatest(1, ceil(extract(epoch from (now() - v_start)) / 86400.0)::integer));
  v_refund := case
    when v_pay.withdrawal_consent_at is not null
      then floor(v_pay.amount * (v_period - v_used) / v_period)
    else v_pay.amount
  end;

  return jsonb_build_object(
    'eligible', v_pay.status = 'confirmed'
                and now() <= v_start + interval '14 days'
                and (v_req.id is null or v_req.status = 'rejected'),
    'reason', case
      when v_req.id is not null and v_req.status <> 'rejected' then 'already_requested'
      when v_pay.status <> 'confirmed' then 'refunded'
      when now() > v_start + interval '14 days' then 'window_passed'
      else null
    end,
    'payment_id', v_pay.id,
    'subscription_id', v_pay.subscription_id,
    'plan', v_pay.plan,
    'paid_at', v_start,
    'deadline', v_start + interval '14 days',
    'paid_amount', v_pay.amount,
    'currency', v_pay.currency,
    'consent_given', v_pay.withdrawal_consent_at is not null,
    'days_used', v_used,
    'period_days', v_period,
    'refund_amount', v_refund,
    'request', case when v_req.id is null then null else jsonb_build_object(
      'id', v_req.id,
      'status', v_req.status,
      'requested_at', v_req.requested_at,
      'refund_amount', v_req.refund_amount,
      'currency', v_req.currency,
      'admin_comment', v_req.admin_comment,
      'refunded_at', v_req.refunded_at,
      'pay_by', v_req.requested_at + interval '14 days'
    ) end
  );
end;
$$;

revoke all on function public.withdrawal_calc(uuid) from public, anon, authenticated;

create or replace function public.get_withdrawal_info()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select case when auth.uid() is null then null else public.withdrawal_calc(auth.uid()) end
$$;

grant execute on function public.get_withdrawal_info() to authenticated;

-- ---------------------------------------------------------------------------
-- 4. "Кнопка отказа"
-- ---------------------------------------------------------------------------
create or replace function public.request_withdrawal(p_reason text default null)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v jsonb;
  v_id uuid;
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;
  v := public.withdrawal_calc(auth.uid());
  if not coalesce((v ->> 'eligible')::boolean, false) then
    raise exception 'withdrawal_not_available:%', coalesce(v ->> 'reason', 'unknown') using errcode = 'P0001';
  end if;

  insert into public.refund_requests (
    user_id, payment_id, subscription_id, reason, plan, paid_at,
    days_used, period_days, paid_amount, currency, refund_amount, consent_given
  ) values (
    auth.uid(),
    (v ->> 'payment_id')::uuid,
    nullif(v ->> 'subscription_id', '')::uuid,
    nullif(btrim(left(p_reason, 1000)), ''),
    v ->> 'plan',
    (v ->> 'paid_at')::timestamptz,
    (v ->> 'days_used')::integer,
    (v ->> 'period_days')::integer,
    (v ->> 'paid_amount')::numeric,
    v ->> 'currency',
    (v ->> 'refund_amount')::numeric,
    coalesce((v ->> 'consent_given')::boolean, false)
  )
  returning id into v_id;
  return v_id;
end;
$$;

revoke all on function public.request_withdrawal(text) from public, anon;
grant execute on function public.request_withdrawal(text) to authenticated;

-- ---------------------------------------------------------------------------
-- 5. Админка: одобрить / деньги возвращены / отклонить
-- ---------------------------------------------------------------------------
create or replace function public.admin_update_refund(
  p_id uuid,
  p_action text,
  p_refund_amount numeric default null,
  p_comment text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  r public.refund_requests%rowtype;
  v_months integer;
begin
  if not public.is_admin() then
    raise exception 'Недостаточно прав' using errcode = '42501';
  end if;

  select * into r from public.refund_requests where id = p_id for update;
  if not found then
    raise exception 'Заявка не найдена';
  end if;

  if p_action = 'reject' then
    if r.status <> 'pending' then
      raise exception 'Отклонить можно только новую заявку';
    end if;
    update public.refund_requests
    set status = 'rejected',
        admin_comment = nullif(btrim(p_comment), ''),
        decided_at = now(),
        decided_by = auth.uid()
    where id = p_id;
    return;
  end if;

  if p_action not in ('approve', 'refunded') then
    raise exception 'Неизвестное действие %', p_action;
  end if;

  if r.status = 'pending' then
    -- Доступ за этот оплаченный период закрываем сразу при одобрении.
    -- Если период был продлением (дата окончания сдвигалась) — срезаем
    -- именно его срок; если ничего не остаётся — подписка отменена.
    v_months := case r.plan when 'quarterly' then 3 when 'semiannual' then 6 when 'annual' then 12 else 1 end;
    update public.subscriptions s
    set current_period_end = greatest(now(), s.current_period_end - make_interval(months => v_months)),
        status = case
          when s.current_period_end - make_interval(months => v_months) <= now() then 'canceled'
          else s.status
        end,
        reminder_sent_at = null,
        updated_at = now()
    where s.id = r.subscription_id;

    update public.refund_requests
    set status = 'approved',
        refund_amount = coalesce(p_refund_amount, refund_amount),
        admin_comment = coalesce(nullif(btrim(p_comment), ''), admin_comment),
        decided_at = now(),
        decided_by = auth.uid()
    where id = p_id;
  elsif r.status <> 'approved' then
    raise exception 'Заявка уже закрыта';
  elsif p_refund_amount is not null then
    update public.refund_requests set refund_amount = p_refund_amount where id = p_id;
  end if;

  if p_action = 'refunded' then
    update public.refund_requests
    set status = 'refunded',
        refunded_at = now(),
        admin_comment = coalesce(nullif(btrim(p_comment), ''), admin_comment)
    where id = p_id;
    update public.payments set status = 'refunded' where id = r.payment_id;
  end if;
end;
$$;

revoke all on function public.admin_update_refund(uuid, text, numeric, text) from public, anon;
grant execute on function public.admin_update_refund(uuid, text, numeric, text) to authenticated;

notify pgrst, 'reload schema';
