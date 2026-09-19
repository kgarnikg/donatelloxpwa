-- 0029_add_english_translations.sql
-- Инфраструктура под англоязычный контент программ.
--
-- Архитектурное решение (пересмотрено перед реализацией): НЕ дублируем
-- целые деревья workouts/workout_sets на программу под каждый язык —
-- это почти 700 тренировок × их подходы, дублирование без реальной
-- необходимости. Вместо этого — колонки *_en рядом с существующими:
-- - exercises.title_en — общий каталог (2040 строк), используется всеми
--   программами, где это упражнение встречается.
-- - workout_programs.title_en / description_en — перевод карточки программы.
-- - workouts.title_en / week_label_en — перевод заголовка тренировки и
--   подписи недельного блока.
-- - workout_sets.notes_en — перевод заметки по подходу (диапазоны
--   повторений, темп, инструкции).
-- Компонент на клиенте сам выбирает title/title_en (и т.д.) в зависимости
-- от текущего языка интерфейса — см. патчи apps/web.
--
-- workout_programs.locale (уже существует с 0001) этой фичей не
-- используется и не трогается — оставляем как есть, чтобы не плодить
-- отдельные программы-дубликаты на каждый язык.
--
-- Безопасно выполнять повторно.

alter table public.exercises
  add column if not exists title_en text;

alter table public.workout_programs
  add column if not exists title_en text,
  add column if not exists description_en text;

alter table public.workouts
  add column if not exists title_en text,
  add column if not exists week_label_en text;

alter table public.workout_sets
  add column if not exists notes_en text;

comment on column public.exercises.title_en is
  'Английский перевод названия упражнения — общий для всех программ, где это упражнение используется.';
comment on column public.workout_programs.title_en is 'Английский перевод названия программы.';
comment on column public.workout_programs.description_en is 'Английский перевод описания программы.';
comment on column public.workouts.title_en is 'Английский перевод заголовка тренировки (день + группа мышц).';
comment on column public.workouts.week_label_en is 'Английский перевод подписи недельного блока.';
comment on column public.workout_sets.notes_en is
  'Английский перевод notes (диапазоны повторений/темп/инструкции тренера) для этого подхода.';

