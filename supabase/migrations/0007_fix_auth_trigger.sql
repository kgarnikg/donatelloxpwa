-- 0007_fix_auth_trigger.sql
-- Гарантированно пересоздаёт триггер автосоздания профиля при регистрации
-- (на случай, если сам триггер, а не функция, где-то потерялся или был
-- случайно отключён) и повторно подтягивает всех пользователей, у которых
-- нет строки в public.users.
-- Безопасно выполнять повторно.

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_auth_user();

-- Подтягиваем всех, кто зарегистрировался, пока триггера не было.
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
