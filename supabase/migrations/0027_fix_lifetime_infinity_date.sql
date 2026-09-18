-- 0027_fix_lifetime_infinity_date.sql
-- Исправляет баг из 0022: 'infinity'::timestamptz для безлимитных
-- (gift) подписок ломает отображение на клиенте — Postgres отдаёт это
-- значение как строку "infinity", а JavaScript `new Date("infinity")`
-- даёт Invalid Date (см. SubscriptionPage.tsx: "Действует до Invalid Date").
--
-- Заменяем на обычную дату далеко в будущем (+100 лет) — для человека
-- это неотличимо от "навсегда", но это настоящий timestamp, который
-- нормально парсится и форматируется где угодно на клиенте.
--
-- Правим саму функцию (на будущее) И уже существующие строки с
-- provider='gift' и current_period_end='infinity' (задним числом —
-- чтобы уже выданные подарочные доступы сразу починились, а не только
-- новые).
--
-- Безопасно выполнять повторно.

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
    (p_user_id, 'lifetime', 'active', now(), now() + interval '100 years', 'gift')
  returning * into v_result;

  return v_result;
end;
$$;

-- Чиним уже выданные подарочные подписки, у которых current_period_end
-- ещё хранит проблемное значение 'infinity'.
update public.subscriptions
set current_period_end = now() + interval '100 years', updated_at = now()
where provider = 'gift' and current_period_end = 'infinity'::timestamptz;
