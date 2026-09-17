-- 0013_add_workout_week_grouping.sql
-- Добавляет группировку тренировок по неделям/уровням программы.
--
-- Контекст: текущая схема хранит workouts как плоский пронумерованный
-- список ("Тренировка 1, 2, 3..."), что подходило для единственной
-- тестовой программы (7-дневный цикл по кругу). Восемь полных годовых
-- программ, которые заливаем в Шаге 3, построены на 12-месячной
-- прогрессии блоками по 2 недели (LEVEL 1A, 1B, 2A...) — без группировки
-- по неделям пользователь увидит нечитаемый список из ~50-90 тренировок
-- подряд без какой-либо структуры.
--
-- week_label — человекочитаемый заголовок блока для UI, например:
--   'Недели 1–2 · LEVEL 1A — Адаптация'
-- week_order — порядок блоков в программе (1, 2, 3...), отдельно от
--   "order", который остаётся порядком дней ВНУТРИ блока (1-4).
--
-- Для уже существующей программы (плоский 7-дневный цикл без блоков)
-- проставляем один общий week_label — она как была одной неделей, так
-- и остаётся, поведение не меняется.
-- Безопасно выполнять повторно.

alter table public.workouts
  add column if not exists week_label text,
  add column if not exists week_order integer not null default 1;

comment on column public.workouts.week_label is
  'Человекочитаемый заголовок блока недель, напр. "Недели 1–2 · LEVEL 1A". NULL — программа без деления на блоки (плоский цикл).';
comment on column public.workouts.week_order is
  'Порядок блока недель внутри программы (1, 2, 3...). "order" внутри блока — порядок дня (1-4).';

create index if not exists workouts_program_week_idx
  on public.workouts (program_id, week_order, "order");

update public.workouts
set week_label = 'Недельный цикл', week_order = 1
where week_label is null
  and program_id = (select id from public.workout_programs where slug = 'nabor-massy-nachinayushchim');
