-- 0090: на какие мышцы человек хочет сделать акцент.
--
-- Новый шаг анкеты: 3D-фигура, на которой нажимают на мышцы (или отмечают
-- их в списке). Шаг необязательный — пустой массив значит "не выбирал".
-- Значения — из списка FOCUS_MUSCLES (packages/types):
--   chest, shoulders, biceps, triceps, forearms, abs, traps, back,
--   lower_back, glutes, quads, hamstrings, calves.
-- Видно в админке (Пользователи → "Акцент: …").

alter table public.user_profiles
  add column if not exists focus_muscles text[] not null default '{}';

comment on column public.user_profiles.focus_muscles is
  'Мышцы, на которые человек хочет сделать акцент (анкета, 0090). Пусто — не выбирал.';

do $$
begin
  if not exists (select 1 from pg_constraint where conname = 'user_profiles_focus_muscles_known') then
    alter table public.user_profiles
      add constraint user_profiles_focus_muscles_known check (
        focus_muscles <@ array[
          'chest', 'shoulders', 'biceps', 'triceps', 'forearms', 'abs', 'traps',
          'back', 'lower_back', 'glutes', 'quads', 'hamstrings', 'calves'
        ]::text[]
      );
  end if;
end $$;

notify pgrst, 'reload schema';
