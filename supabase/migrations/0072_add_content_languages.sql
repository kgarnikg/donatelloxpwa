-- 0072_add_content_languages.sql
-- Фаза 28: колонки переводов контента программ ещё для 6 языков
-- интерфейса — uk, de, it, ar, hi, pa (как en/es/hy в 0029/0039/0049).
-- Сами переводы — в 0073–0078. Безопасно выполнять повторно.

alter table public.exercises
  add column if not exists title_uk text,
  add column if not exists title_de text,
  add column if not exists title_it text,
  add column if not exists title_ar text,
  add column if not exists title_hi text,
  add column if not exists title_pa text;

alter table public.workout_programs
  add column if not exists title_uk text,
  add column if not exists title_de text,
  add column if not exists title_it text,
  add column if not exists title_ar text,
  add column if not exists title_hi text,
  add column if not exists title_pa text,
  add column if not exists description_uk text,
  add column if not exists description_de text,
  add column if not exists description_it text,
  add column if not exists description_ar text,
  add column if not exists description_hi text,
  add column if not exists description_pa text;

alter table public.workouts
  add column if not exists title_uk text,
  add column if not exists title_de text,
  add column if not exists title_it text,
  add column if not exists title_ar text,
  add column if not exists title_hi text,
  add column if not exists title_pa text,
  add column if not exists week_label_uk text,
  add column if not exists week_label_de text,
  add column if not exists week_label_it text,
  add column if not exists week_label_ar text,
  add column if not exists week_label_hi text,
  add column if not exists week_label_pa text;

alter table public.workout_sets
  add column if not exists notes_uk text,
  add column if not exists notes_de text,
  add column if not exists notes_it text,
  add column if not exists notes_ar text,
  add column if not exists notes_hi text,
  add column if not exists notes_pa text;

notify pgrst, 'reload schema';
