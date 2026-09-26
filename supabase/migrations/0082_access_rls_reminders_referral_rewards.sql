-- 0082: защита контента в базе + напоминания об окончании доступа +
--       награда за приглашённого друга.
--
-- 1) Защита доступа (RLS). Раньше workout_sets (сами упражнения, подходы,
--    повторы) мог прочитать любой вошедший пользователь — закрытые
--    программы "закрывало" только приложение. Теперь база отдаёт подходы
--    тренировки только если к её программе есть доступ:
--      • админ / тренер;
--      • программа бесплатная (is_premium = false);
--      • активная подписка (в т.ч. подарок/безлимит из CMS, награда за друга);
--      • бесплатная неделя: 7 дней с регистрации, только программа
--        user_profiles.trial_program_id (пока она не записана — любая).
--    Названия тренировок (workouts) остаются видны всем — они нужны для
--    каталога и истории тренировок после окончания подписки.
--
-- 2) Напоминание за 3 дня до конца оплаченного периода: приложение
--    (ежедневная задача Vercel Cron, apps/web/api/cron/daily.ts) берёт
--    список из due_subscription_reminders(), отправляет письма через Resend
--    и отмечает mark_subscription_reminded(). Автопродления нет, поэтому
--    без напоминания люди просто теряют доступ.
--
-- 3) Награда за друга: пригласивший получает +1 месяц доступа, когда
--    приглашённый оплатил любую подписку и прозанимался минимум месяц
--    (с начала оплаченного периода прошёл месяц и за это время у него
--    не меньше 4 тренировок). Начисляет grant_referral_rewards() — её
--    вызывает та же ежедневная задача. Если у пригласившего уже есть
--    доступ — он продлевается на месяц, если нет — выдаётся месяц с
--    сегодняшнего дня (provider = 'referral').
--
-- Функции для ежедневной задачи вызываются только с service role key
-- (на сервере Vercel), обычным пользователям они недоступны.

-- ---------------------------------------------------------------------------
-- 0. Язык пользователя: все 10 языков приложения (для писем)
-- ---------------------------------------------------------------------------
alter table public.users drop constraint if exists users_locale_check;
alter table public.users add constraint users_locale_check
  check (locale in ('ru', 'en', 'es', 'de', 'it', 'uk', 'hy', 'ar', 'hi', 'pa'));

-- ---------------------------------------------------------------------------
-- 1. Доступ к программе
-- ---------------------------------------------------------------------------
create or replace function public.has_program_access(p_program_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select
    auth.uid() is not null
    and (
      exists (
        select 1 from public.users u
        where u.id = auth.uid() and u.role in ('admin', 'superadmin', 'coach')
      )
      or exists (
        select 1 from public.workout_programs p
        where p.id = p_program_id and not p.is_premium
      )
      or exists (
        select 1 from public.subscriptions s
        where s.user_id = auth.uid()
          and s.status in ('active', 'trialing', 'past_due')
          and s.current_period_end > now()
      )
      or exists (
        select 1
        from public.users u
        left join public.user_profiles up on up.user_id = u.id
        where u.id = auth.uid()
          and u.created_at > now() - interval '7 days'
          and (up.trial_program_id is null or up.trial_program_id = p_program_id)
      )
    )
$$;

grant execute on function public.has_program_access(uuid) to authenticated;

drop policy if exists "workout_sets_read_all" on public.workout_sets;
drop policy if exists "workout_sets_read_with_access" on public.workout_sets;
-- Подзапрос по workouts считается один раз на запрос (а не на каждую строку
-- подходов), поэтому страница программы с сотнями тренировок не тормозит.
create policy "workout_sets_read_with_access" on public.workout_sets
  for select using (
    workout_id in (
      select w.id from public.workouts w
      where public.has_program_access(w.program_id)
    )
  );

-- Подбор замены упражнения (0079) смотрит на подходы ВСЕХ программ того же
-- формата — иначе при новом правиле пользователь пробной недели видел бы
-- замены только из своей одной программы. Отдаёт он только сами
-- упражнения (они и так публичные), поэтому выполняем от владельца.
alter function public.suggest_exercise_swaps(uuid, uuid) security definer;

-- ---------------------------------------------------------------------------
-- 2. Напоминание об окончании доступа
-- ---------------------------------------------------------------------------
alter table public.subscriptions
  add column if not exists reminder_sent_at timestamptz;

comment on column public.subscriptions.reminder_sent_at is
  'Когда отправлено письмо "доступ скоро закончится" (0082). Сбрасывается при продлении периода.';

create or replace function public.due_subscription_reminders(p_days integer default 3)
returns table (
  subscription_id uuid,
  user_id uuid,
  email text,
  first_name text,
  full_name text,
  locale text,
  period_end timestamptz
)
language sql
stable
security definer
set search_path = public
as $$
  select s.id, u.id, u.email, u.first_name, u.full_name, u.locale, s.current_period_end
  from public.subscriptions s
  join public.users u on u.id = s.user_id
  where s.status in ('active', 'trialing', 'past_due')
    and s.plan <> 'lifetime'
    and s.reminder_sent_at is null
    and s.current_period_end > now()
    and s.current_period_end <= now() + make_interval(days => p_days)
    -- уже есть доступ, который заканчивается позже (продлил заранее) — не пишем
    and not exists (
      select 1 from public.subscriptions s2
      where s2.user_id = s.user_id
        and s2.id <> s.id
        and s2.status in ('active', 'trialing', 'past_due')
        and s2.current_period_end > s.current_period_end
    )
    and coalesce(u.email, '') <> ''
$$;

create or replace function public.mark_subscription_reminded(p_ids uuid[])
returns void
language sql
security definer
set search_path = public
as $$
  update public.subscriptions set reminder_sent_at = now() where id = any (p_ids);
$$;

revoke all on function public.due_subscription_reminders(integer) from public, anon, authenticated;
revoke all on function public.mark_subscription_reminded(uuid[]) from public, anon, authenticated;
grant execute on function public.due_subscription_reminders(integer) to service_role;
grant execute on function public.mark_subscription_reminded(uuid[]) to service_role;

-- ---------------------------------------------------------------------------
-- 3. Награда за приглашённого друга
-- ---------------------------------------------------------------------------
alter table public.subscriptions drop constraint if exists subscriptions_provider_check;
alter table public.subscriptions add constraint subscriptions_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'gift', 'ararat', 'referral'));

alter table public.referrals
  add column if not exists reward_granted_at timestamptz,
  add column if not exists reward_subscription_id uuid references public.subscriptions (id) on delete set null;

create or replace function public.grant_referral_rewards(p_min_workouts integer default 4)
returns table (
  referrer_id uuid,
  email text,
  first_name text,
  full_name text,
  locale text,
  friend_name text,
  access_until timestamptz
)
language plpgsql
security definer
set search_path = public
as $$
declare
  r record;
  v_sub public.subscriptions%rowtype;
  v_sub_id uuid;
  v_until timestamptz;
begin
  for r in
    select ref.id as referral_id, ref.referrer_id, ref.referred_id, paid.first_start
    from public.referrals ref
    join lateral (
      -- первая ОПЛАЧЕННАЯ подписка приглашённого (не подарок и не награда),
      -- которая продержалась минимум месяц (не отменена раньше)
      select min(s.current_period_start) as first_start
      from public.subscriptions s
      where s.user_id = ref.referred_id
        and s.provider not in ('gift', 'referral')
        and s.plan <> 'lifetime'
        and s.status in ('active', 'trialing', 'past_due', 'expired')
        and s.current_period_start + interval '1 month' <= least(now(), s.current_period_end)
    ) paid on paid.first_start is not null
    where not ref.reward_applied
      and (
        select count(*) from public.workout_logs wl
        where wl.user_id = ref.referred_id
          and wl.completed_at >= paid.first_start
          and wl.completed_at < paid.first_start + interval '1 month'
      ) >= p_min_workouts
    for update of ref skip locked
  loop
    select * into v_sub
    from public.subscriptions s
    where s.user_id = r.referrer_id
      and s.status in ('active', 'trialing', 'past_due')
      and s.current_period_end > now()
    order by s.current_period_end desc
    limit 1;

    if found and (v_sub.plan = 'lifetime' or v_sub.current_period_end > now() + interval '50 years') then
      -- безлимит: продлевать нечего, просто отмечаем, что награда учтена
      v_sub_id := v_sub.id;
      v_until := v_sub.current_period_end;
    elsif found then
      update public.subscriptions
      set current_period_end = current_period_end + interval '1 month',
          reminder_sent_at = null,
          updated_at = now()
      where id = v_sub.id
      returning id, current_period_end into v_sub_id, v_until;
    else
      insert into public.subscriptions
        (user_id, plan, status, current_period_start, current_period_end, provider)
      values
        (r.referrer_id, 'monthly', 'active', now(), now() + interval '1 month', 'referral')
      returning id, current_period_end into v_sub_id, v_until;
    end if;

    update public.referrals
    set reward_applied = true,
        reward_granted_at = now(),
        reward_subscription_id = v_sub_id
    where id = r.referral_id;

    return query
      select u.id, u.email, u.first_name, u.full_name, u.locale,
             coalesce(nullif(f.first_name, ''), nullif(split_part(f.full_name, ' ', 1), ''), ''),
             v_until
      from public.users u
      join public.users f on f.id = r.referred_id
      where u.id = r.referrer_id;
  end loop;
end;
$$;

revoke all on function public.grant_referral_rewards(integer) from public, anon, authenticated;
grant execute on function public.grant_referral_rewards(integer) to service_role;

notify pgrst, 'reload schema';
