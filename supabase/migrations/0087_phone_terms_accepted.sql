-- 0087: телефон при регистрации (обязательный) + когда приняты условия.
--
-- Форма регистрации кладёт в метаданные Supabase Auth:
--   phone             — "+37491234567" (код страны по IP, можно поменять);
--   terms_accepted_at — когда поставлена галочка "Принимаю условия
--                       использования … тренировки — рекомендации, перед
--                       началом проконсультируюсь с врачом".
-- Заполняет их тот же триггер, что имя/фамилию/страну (0081). Колонка
-- users.phone есть с 0001 — теперь она наконец заполняется. Вошедших через
-- Google спрашиваем телефон в анкете.

alter table public.users
  add column if not exists terms_accepted_at timestamptz;

comment on column public.users.phone is 'Телефон в формате E.164 (+37491234567), с регистрации (0087).';
comment on column public.users.terms_accepted_at is 'Когда принял условия использования при регистрации (0087).';

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
  if new.phone is null and coalesce(meta ->> 'phone', '') ~ '^\+[1-9][0-9]{7,14}$' then
    new.phone := meta ->> 'phone';
  end if;
  if new.terms_accepted_at is null and coalesce(meta ->> 'terms_accepted_at', '') <> '' then
    begin
      new.terms_accepted_at := (meta ->> 'terms_accepted_at')::timestamptz;
    exception when others then
      new.terms_accepted_at := now();
    end;
  end if;
  return new;
end;
$$;

notify pgrst, 'reload schema';
