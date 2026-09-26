-- 0080: бесплатная неделя — для всех и ровно на одну программу.
--
-- Было: пробная неделя действовала только для мужчин "зал + набор массы",
-- и в эти 7 дней им открывались ВСЕ программы; остальным (женщины, дома,
-- похудение) пробной недели не было вовсе, хотя лендинг обещает её всем.
-- Плюс "Набор массы для начинающих" была бесплатной навсегда (is_premium = false).
--
-- Стало: 7 дней с регистрации открыта одна программа — подобранная по анкете
-- (пол, цель, место). Она запоминается в user_profiles.trial_program_id при
-- первом заходе, чтобы нельзя было "перебрать" все программы, меняя анкету.
-- Остальные программы — по подписке.

alter table public.user_profiles
  add column if not exists trial_program_id uuid
  references public.workout_programs (id) on delete set null;

comment on column public.user_profiles.trial_program_id is
  'Программа бесплатной недели (7 дней с регистрации). Ставится один раз приложением — подобранная по анкете программа.';

-- Один раз выбранную программу пробной недели пользователь сам не меняет
-- (политика profiles_update_own разрешает править свою строку целиком).
-- Админ может поменять через service role / SQL Editor.
create or replace function public.keep_trial_program_id()
returns trigger
language plpgsql
as $$
begin
  if old.trial_program_id is not null
     and new.trial_program_id is distinct from old.trial_program_id
     and coalesce(auth.role(), '') <> 'service_role'
     and not public.is_admin() then
    new.trial_program_id := old.trial_program_id;
  end if;
  return new;
end;
$$;

drop trigger if exists user_profiles_keep_trial_program on public.user_profiles;
create trigger user_profiles_keep_trial_program
  before update on public.user_profiles
  for each row execute function public.keep_trial_program_id();

-- "Набор массы для начинающих" больше не бесплатна навсегда — общие правила.
update public.workout_programs
set is_premium = true
where slug = 'nabor-massy-nachinayushchim';

notify pgrst, 'reload schema';
