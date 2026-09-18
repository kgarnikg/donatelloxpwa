-- 0022_add_lifetime_gift_access.sql
-- Добавляет «безлимитный доступ» (подарок близким / награда), не как роль
-- в CMS, а как обычную подписку особого вида — переиспользует уже
-- существующий механизм проверки доступа (useActiveSubscription
-- в apps/web ищет последнюю подписку со статусом active/trialing/past_due,
-- ей всё равно, откуда она взялась). Никаких изменений во фронтенде
-- пользовательского приложения не требуется.
--
-- provider = 'gift' — чтобы в отчётах по платежам такие подписки не
-- путались с настоящими оплаченными (stripe/paypal/yookassa/usdt).
-- plan = 'lifetime' — новый план без ограничения по времени.
-- current_period_end = 'infinity' — Postgres поддерживает это значение
-- для timestamptz, оно буквально означает "никогда не истекает".
--
-- Доступ выдаётся/отзывается только через RPC (security definer),
-- доступный лишь администраторам — обычные пользователи не могут выдать
-- себе безлимит напрямую через RLS.
-- Безопасно выполнять повторно.

alter table public.subscriptions drop constraint if exists subscriptions_provider_check;
alter table public.subscriptions add constraint subscriptions_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'gift'));

alter table public.subscriptions drop constraint if exists subscriptions_plan_check;
alter table public.subscriptions add constraint subscriptions_plan_check
  check (plan in ('monthly', 'quarterly', 'semiannual', 'annual', 'lifetime'));

-- ---------------------------------------------------------------------------
-- Выдать безлимитный доступ пользователю (для близких/наград).
-- Отменяет любые предыдущие активные gift-подписки этого пользователя,
-- чтобы не плодить дубли при повторном нажатии кнопки в CMS.
-- ---------------------------------------------------------------------------
create or replace function public.grant_lifetime_access(p_user_id uuid)
returns public.subscriptions
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.subscriptions;
begin
  if not public.is_admin() then
    raise exception 'Только администратор может выдавать безлимитный доступ';
  end if;

  update public.subscriptions
  set status = 'canceled', updated_at = now()
  where user_id = p_user_id and provider = 'gift' and status = 'active';

  insert into public.subscriptions
    (user_id, plan, status, current_period_start, current_period_end, provider)
  values
    (p_user_id, 'lifetime', 'active', now(), 'infinity'::timestamptz, 'gift')
  returning * into v_result;

  return v_result;
end;
$$;

-- ---------------------------------------------------------------------------
-- Отозвать безлимитный доступ (если выдали по ошибке или отношения
-- изменились). Не трогает настоящие оплаченные подписки этого пользователя.
-- ---------------------------------------------------------------------------
create or replace function public.revoke_lifetime_access(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Только администратор может отзывать безлимитный доступ';
  end if;

  update public.subscriptions
  set status = 'canceled', updated_at = now()
  where user_id = p_user_id and provider = 'gift' and status = 'active';
end;
$$;

grant execute on function public.grant_lifetime_access(uuid) to authenticated;
grant execute on function public.revoke_lifetime_access(uuid) to authenticated;
