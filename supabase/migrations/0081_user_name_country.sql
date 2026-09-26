-- 0081: регистрация — имя и фамилия отдельно + страна (все поля обязательные).
--
-- Форма регистрации кладёт first_name / last_name / country (ISO-код страны,
-- напр. "ES", "AM") в метаданные пользователя Supabase Auth; full_name по-
-- прежнему пишется как "Имя Фамилия", поэтому всё, что уже читает full_name
-- (приветствие на главной, админка, письма), работает как раньше.
--
-- Строку public.users создают две функции (handle_new_auth_user и
-- ensure_user_profile) — чтобы не переписывать обе, новые поля заполняет
-- отдельный триггер BEFORE INSERT из тех же метаданных. Для входа через
-- Google берём given_name / family_name; страну такие пользователи
-- указывают в анкете (онбординге), если её нет.

alter table public.users
  add column if not exists first_name text,
  add column if not exists last_name text,
  add column if not exists country text;

do $$ begin
  alter table public.users
    add constraint users_country_iso2 check (country is null or country ~ '^[A-Z]{2}$');
exception when duplicate_object then null; end $$;

comment on column public.users.country is 'Страна пользователя, ISO 3166-1 alpha-2 (например ES, AM, RU).';

create or replace function public.fill_user_name_country()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  meta jsonb;
begin
  select au.raw_user_meta_data into meta from auth.users au where au.id = new.id;
  if meta is null then
    return new;
  end if;

  new.first_name := coalesce(new.first_name, nullif(btrim(coalesce(meta ->> 'first_name', meta ->> 'given_name')), ''));
  new.last_name := coalesce(new.last_name, nullif(btrim(coalesce(meta ->> 'last_name', meta ->> 'family_name')), ''));
  if new.country is null and upper(coalesce(meta ->> 'country', '')) ~ '^[A-Z]{2}$' then
    new.country := upper(meta ->> 'country');
  end if;
  return new;
end;
$$;

drop trigger if exists users_fill_name_country on public.users;
create trigger users_fill_name_country
  before insert on public.users
  for each row execute function public.fill_user_name_country();

-- Уже зарегистрированные: имя/фамилию берём из метаданных, если они там есть.
update public.users u
set first_name = coalesce(u.first_name, nullif(btrim(coalesce(au.raw_user_meta_data ->> 'first_name', au.raw_user_meta_data ->> 'given_name')), '')),
    last_name = coalesce(u.last_name, nullif(btrim(coalesce(au.raw_user_meta_data ->> 'last_name', au.raw_user_meta_data ->> 'family_name')), ''))
from auth.users au
where au.id = u.id
  and (u.first_name is null or u.last_name is null);

notify pgrst, 'reload schema';
