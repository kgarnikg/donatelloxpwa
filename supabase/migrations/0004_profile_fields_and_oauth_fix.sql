-- 0004_profile_fields_and_oauth_fix.sql
-- 1. Добавляет недостающие поля анкеты: формат тренировок (зал/дом) и
--    количество тренировочных дней в неделю — были в ТЗ, но не собирались.
-- 2. Чинит автосоздание профиля: раньше имя и аватар брались только из
--    ключа `full_name`, которого нет в ответе Google/Apple OAuth — из-за
--    этого у пользователей, вошедших через Google, профиль оставался
--    безымянным. Теперь проверяются все варианты ключей, которые реально
--    приходят от Supabase Auth для email/Google/Apple.
-- Безопасно выполнять повторно.

alter table public.user_profiles
  add column if not exists training_format text
    check (training_format in ('gym', 'home')) default 'gym',
  add column if not exists days_per_week smallint check (days_per_week between 1 and 7);

create or replace function public.handle_new_auth_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.users (id, email, full_name, avatar_url, auth_provider, email_verified)
  values (
    new.id,
    new.email,
    coalesce(
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      new.raw_user_meta_data ->> 'user_name',
      ''
    ),
    coalesce(
      new.raw_user_meta_data ->> 'avatar_url',
      new.raw_user_meta_data ->> 'picture'
    ),
    coalesce(new.raw_app_meta_data ->> 'provider', 'email'),
    new.email_confirmed_at is not null
  )
  on conflict (id) do update set
    full_name = case when public.users.full_name = '' then excluded.full_name else public.users.full_name end,
    avatar_url = coalesce(public.users.avatar_url, excluded.avatar_url);
  return new;
end;
$$;

-- Триггер уже существует (создан в 0001) и переиспользует эту же функцию —
-- пересоздавать сам триггер не нужно, достаточно было заменить функцию.
