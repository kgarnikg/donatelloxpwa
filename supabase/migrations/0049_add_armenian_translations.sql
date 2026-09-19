-- 0049_add_armenian_translations.sql
-- Армянские переводные поля — зеркалирует 0029 (EN) / 0039 (ES).
-- Безопасно выполнять повторно.

alter table public.exercises
  add column if not exists title_hy text;

alter table public.workout_programs
  add column if not exists title_hy text,
  add column if not exists description_hy text;

alter table public.workouts
  add column if not exists title_hy text,
  add column if not exists week_label_hy text;

alter table public.workout_sets
  add column if not exists notes_hy text;

comment on column public.exercises.title_hy is 'Армянский перевод названия упражнения.';
comment on column public.workout_programs.title_hy is 'Армянский перевод названия программы.';
comment on column public.workout_programs.description_hy is 'Армянский перевод описания программы.';
comment on column public.workouts.title_hy is 'Армянский перевод заголовка тренировки.';
comment on column public.workouts.week_label_hy is 'Армянский перевод подписи недельного блока.';
comment on column public.workout_sets.notes_hy is 'Армянский перевод заметки по подходу.';
