-- 0083: админка — блокировка и полное удаление пользователя.
--       + закрыта дыра: пользователь мог сам поменять себе role.
--
-- 1) Дыра в правах. Политика users_update_own_or_admin (0001) разрешает
--    пользователю править СВОЮ строку users целиком — в том числе role.
--    То есть любой вошедший мог запросом к API назначить себе role =
--    'admin' и получить админку. Теперь служебные поля (роль, блокировка,
--    скидка, реферальный код, email, провайдер) меняет только админ или
--    сервер: для остальных триггер молча возвращает старые значения.
--    Свои имя, аватар, язык, страну, онбординг пользователь меняет как раньше.
--
-- 2) Блокировка: admin_set_user_blocked(user, true/false, причина).
--    • users.is_blocked — приложение показывает экран "Доступ заблокирован"
--      и выходит из аккаунта; has_program_access() для него всегда false.
--    • auth.users.banned_until = бесконечность — Supabase не пускает войти
--      и не обновляет токен; текущие сессии удаляются сразу.
--    Разблокировка возвращает всё обратно.
--
-- 3) Удаление: admin_delete_user(user) — удаляет аккаунт Supabase Auth, а с
--    ним каскадом ВСЁ о человеке: профиль, анкету, тренировки, прогресс,
--    замеры, достижения, подписки, приглашения. Платежи остаются (для
--    бухгалтерии), но без привязки к человеку (user_id = null).
--
-- Обе функции: только админ/суперадмин; себя заблокировать/удалить нельзя;
-- суперадмина может трогать только суперадмин.

-- ---------------------------------------------------------------------------
-- 1. Служебные поля users — только админ / сервер
-- ---------------------------------------------------------------------------
alter table public.users
  add column if not exists is_blocked boolean not null default false,
  add column if not exists blocked_at timestamptz,
  add column if not exists blocked_reason text;

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
     -- доверенные серверные функции (apply_referral и т.п.) ставят этот флаг
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
  new.created_at := old.created_at;
  return new;
end;
$$;

drop trigger if exists users_protect_privileged_columns on public.users;
create trigger users_protect_privileged_columns
  before update on public.users
  for each row execute function public.protect_user_privileged_columns();

-- Реферальная скидка ставится от имени самого пользователя (security definer,
-- но auth.uid() — его), поэтому эта функция помечает себя доверенной.
create or replace function public.apply_referral(p_referral_code text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_referrer_id uuid;
begin
  if auth.uid() is null or p_referral_code is null then
    return;
  end if;

  select id into v_referrer_id from public.users where referral_code = upper(p_referral_code);

  if v_referrer_id is null or v_referrer_id = auth.uid() then
    return;
  end if;

  insert into public.referrals (referrer_id, referred_id, discount_percent)
  values (v_referrer_id, auth.uid(), 50)
  on conflict (referred_id) do nothing;

  -- скидку ставит сервер: пропускаем защиту служебных полей (0083)
  perform set_config('donatellex.trusted', 'on', true);
  update public.users
  set pending_discount_percent = 50,
      pending_discount_reason = 'referral'
  where id = auth.uid()
    and pending_discount_percent is null;
end;
$$;


-- ---------------------------------------------------------------------------
-- 2. Блокировка
-- ---------------------------------------------------------------------------
create or replace function public.admin_can_manage(p_user_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.is_admin()
    and p_user_id is not null
    and p_user_id <> auth.uid()
    and (
      (select role from public.users where id = p_user_id) is distinct from 'superadmin'
      or exists (select 1 from public.users where id = auth.uid() and role = 'superadmin')
    )
$$;

create or replace function public.admin_set_user_blocked(
  p_user_id uuid,
  p_blocked boolean,
  p_reason text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.admin_can_manage(p_user_id) then
    raise exception 'Недостаточно прав для этого пользователя' using errcode = '42501';
  end if;

  update public.users
  set is_blocked = p_blocked,
      blocked_at = case when p_blocked then now() else null end,
      blocked_reason = case when p_blocked then nullif(btrim(p_reason), '') else null end,
      updated_at = now()
  where id = p_user_id;

  update auth.users
  set banned_until = case when p_blocked then 'infinity'::timestamptz else null end
  where id = p_user_id;

  if p_blocked then
    -- выкидываем из всех открытых сессий сразу (refresh-токены удаляются каскадом)
    delete from auth.sessions where user_id = p_user_id;
  end if;
end;
$$;

-- ---------------------------------------------------------------------------
-- 3. Полное удаление
-- ---------------------------------------------------------------------------
create or replace function public.admin_delete_user(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.admin_can_manage(p_user_id) then
    raise exception 'Недостаточно прав для этого пользователя' using errcode = '42501';
  end if;

  -- auth.users → public.users (on delete cascade) → всё остальное каскадом
  delete from auth.users where id = p_user_id;
  -- на случай строки public.users без записи в auth (старые тестовые данные)
  delete from public.users where id = p_user_id;
end;
$$;

revoke all on function public.admin_set_user_blocked(uuid, boolean, text) from public, anon;
revoke all on function public.admin_delete_user(uuid) from public, anon;
grant execute on function public.admin_set_user_blocked(uuid, boolean, text) to authenticated;
grant execute on function public.admin_delete_user(uuid) to authenticated;
grant execute on function public.admin_can_manage(uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- 4. Заблокированному — никакого доступа к тренировкам (0082 + проверка)
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
    and not coalesce((select u.is_blocked from public.users u where u.id = auth.uid()), false)
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
