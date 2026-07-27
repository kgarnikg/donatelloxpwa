-- 0008_ensure_user_profile_rpc.sql
-- Триггер на auth.users (созданный в 0001, пересозданный в 0007) должен был
-- автоматически создавать строку в public.users при регистрации, но на
-- практике продолжает иногда не срабатывать по неясной причине — это и
-- вызывало ошибку "violates foreign key constraint workout_logs_user_id_fkey"
-- даже для новых пользователей.
--
-- Вместо того чтобы полагаться только на триггер, добавляем функцию,
-- которую само приложение вызывает явно при каждой загрузке сессии
-- (см. AuthContext.tsx). Она идемпотентна (безопасно вызывать много раз)
-- и гарантированно создаёт профиль, если его почему-то ещё нет —
-- независимо от того, сработал триггер или нет.
--
-- Безопасно выполнять повторно.

create or replace function public.ensure_user_profile()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_email text;
  v_full_name text;
  v_avatar_url text;
  v_provider text;
  v_email_confirmed boolean;
begin
  if auth.uid() is null then
    return;
  end if;

  select
    au.email,
    coalesce(au.raw_user_meta_data ->> 'full_name', au.raw_user_meta_data ->> 'name', ''),
    coalesce(au.raw_user_meta_data ->> 'avatar_url', au.raw_user_meta_data ->> 'picture'),
    coalesce(au.raw_app_meta_data ->> 'provider', 'email'),
    au.email_confirmed_at is not null
  into v_email, v_full_name, v_avatar_url, v_provider, v_email_confirmed
  from auth.users au
  where au.id = auth.uid();

  if v_email is null then
    -- Строки в auth.users почему-то нет (не должно происходить) — выходим,
    -- чтобы не вставлять профиль без email.
    return;
  end if;

  insert into public.users (id, email, full_name, avatar_url, auth_provider, email_verified)
  values (auth.uid(), v_email, v_full_name, v_avatar_url, v_provider, v_email_confirmed)
  on conflict (id) do update set
    email = excluded.email,
    email_verified = excluded.email_verified;
end;
$$;

grant execute on function public.ensure_user_profile() to authenticated;

-- И на всякий случай ещё раз подтягиваем всех, у кого до сих пор нет профиля.
insert into public.users (id, email, full_name, avatar_url, auth_provider, email_verified)
select
  au.id,
  au.email,
  coalesce(au.raw_user_meta_data ->> 'full_name', au.raw_user_meta_data ->> 'name', ''),
  coalesce(au.raw_user_meta_data ->> 'avatar_url', au.raw_user_meta_data ->> 'picture'),
  coalesce(au.raw_app_meta_data ->> 'provider', 'email'),
  au.email_confirmed_at is not null
from auth.users au
left join public.users u on u.id = au.id
where u.id is null
on conflict (id) do nothing;
