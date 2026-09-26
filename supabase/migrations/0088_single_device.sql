-- 0088: один аккаунт — одно устройство (чтобы подписку не передавали).
--
-- Правило: действует только САМЫЙ НОВЫЙ вход. Вошёл на другом телефоне —
-- на старом доступ к тренировкам сразу закрывается (проверка в базе, не
-- только в приложении), а приложение там выходит из аккаунта с сообщением
-- "аккаунт открыт на другом устройстве". Блокировать сам новый вход нельзя —
-- иначе человек, потерявший телефон, не попадёт в свой аккаунт.
--
-- Сессии Supabase Auth лежат в auth.sessions; в токене пользователя есть
-- session_id. "Текущая" сессия — последняя созданная у этого пользователя.
-- Админов/тренеров правило не касается (админка и приложение — разные
-- входы одного человека).
--
-- users.session_kicks — сколько раз аккаунт выкидывало другим устройством
-- (видно в админке: частые вылеты = подписку, скорее всего, делят).

alter table public.users
  add column if not exists session_kicks integer not null default 0,
  add column if not exists last_session_kick_at timestamptz;

create or replace function public.is_current_session()
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_sid uuid;
  v_created timestamptz;
begin
  if auth.uid() is null then
    return false;
  end if;
  if exists (select 1 from public.users where id = auth.uid() and role in ('admin', 'superadmin', 'coach')) then
    return true;
  end if;
  begin
    v_sid := nullif(auth.jwt() ->> 'session_id', '')::uuid;
  exception when others then
    v_sid := null;
  end;
  if v_sid is null then
    return true; -- старые токены без session_id — не выкидываем
  end if;
  select s.created_at into v_created from auth.sessions s where s.id = v_sid;
  if v_created is null then
    return false; -- сессию уже закрыли
  end if;
  return not exists (
    select 1 from auth.sessions s
    where s.user_id = auth.uid() and s.id <> v_sid and s.created_at > v_created
  );
end;
$$;

grant execute on function public.is_current_session() to authenticated;

-- Приложение зовёт при запуске, возврате на экран и раз в минуту.
-- true — это устройство главное (старые входы закрываются, считаем вылеты);
-- false — вошли на другом устройстве, приложение выходит из аккаунта.
create or replace function public.touch_session()
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_sid uuid;
  v_removed integer;
begin
  if not public.is_current_session() then
    return false;
  end if;
  if exists (select 1 from public.users where id = auth.uid() and role in ('admin', 'superadmin', 'coach')) then
    return true;
  end if;
  begin
    v_sid := nullif(auth.jwt() ->> 'session_id', '')::uuid;
  exception when others then
    v_sid := null;
  end;
  if v_sid is null then
    return true;
  end if;

  delete from auth.sessions s where s.user_id = auth.uid() and s.id <> v_sid;
  get diagnostics v_removed = row_count;
  if v_removed > 0 then
    perform set_config('donatellex.trusted', 'on', true);
    update public.users
    set session_kicks = session_kicks + v_removed,
        last_session_kick_at = now()
    where id = auth.uid();
  end if;
  return true;
end;
$$;

revoke all on function public.touch_session() from public, anon;
grant execute on function public.touch_session() to authenticated;

-- Защита служебных полей (0083): вылеты считает только сервер
create or replace function public.protect_user_privileged_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if coalesce(auth.role(), '') = 'service_role'
     or auth.uid() is null
     or public.is_admin()
     or coalesce(current_setting('donatellex.trusted', true), '') = 'on' then
    return new;
  end if;
  new.id := old.id;
  new.email := old.email;
  new.role := old.role;
  new.auth_provider := old.auth_provider;
  new.email_verified := old.email_verified;
  new.referral_code := old.referral_code;
  new.pending_discount_percent := old.pending_discount_percent;
  new.pending_discount_reason := old.pending_discount_reason;
  new.is_blocked := old.is_blocked;
  new.blocked_at := old.blocked_at;
  new.blocked_reason := old.blocked_reason;
  new.session_kicks := old.session_kicks;
  new.last_session_kick_at := old.last_session_kick_at;
  new.created_at := old.created_at;
  return new;
end;
$$;

-- Доступ к тренировкам (0083) + только с текущего устройства
create or replace function public.has_program_access(p_program_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select
    auth.uid() is not null
    and not coalesce((select u.is_blocked from public.users u where u.id = auth.uid()), false)
    and public.is_current_session()
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

notify pgrst, 'reload schema';
