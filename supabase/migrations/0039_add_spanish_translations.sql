-- 0039_add_spanish_translations.sql
-- Испанские переводные поля — зеркалирует 0029 (английские), тот же
-- принцип: колонки *_es рядом с существующими, без дублирования строк.
--
-- Терминология — испанский Испании (не латиноамериканский вариант),
-- согласно целевому рынку проекта (см. "sin matrícula" в лендинге).
--
-- Безопасно выполнять повторно.

alter table public.exercises
  add column if not exists title_es text;

alter table public.workout_programs
  add column if not exists title_es text,
  add column if not exists description_es text;

alter table public.workouts
  add column if not exists title_es text,
  add column if not exists week_label_es text;

alter table public.workout_sets
  add column if not exists notes_es text;

comment on column public.exercises.title_es is 'Испанский перевод названия упражнения.';
comment on column public.workout_programs.title_es is 'Испанский перевод названия программы.';
comment on column public.workout_programs.description_es is 'Испанский перевод описания программы.';
comment on column public.workouts.title_es is 'Испанский перевод заголовка тренировки.';
comment on column public.workouts.week_label_es is 'Испанский перевод подписи недельного блока.';
comment on column public.workout_sets.notes_es is 'Испанский перевод заметки по подходу.';
