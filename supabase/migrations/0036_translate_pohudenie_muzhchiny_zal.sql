-- 0036_translate_pohudenie_muzhchiny_zal.sql
-- Английский перевод: Похудение — Мужчины — Зал
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0019).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (141), миграция падает с ошибкой вместо того, чтобы
-- молча оставить часть контента непереведённой (см. "безопасно" в задаче).
--
-- Перевод — первый автоматический проход (см. Фазу 6 в PROJECT_PLAN.md),
-- корректен терминологически, рекомендуется вычитка носителем языка.
--
-- Безопасно выполнять повторно (полностью перезаписывает *_en поля).

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
  v_updated_workouts int := 0;
begin
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-muzhchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-muzhchiny-zal';
  end if;

  update public.workout_programs
  set title_en = 'Weight loss for men (gym) — year-long program', description_en = 'Weight loss for men (gym) — year-long program. Equipment: Barbell, dumbbells, тренажёры, блоки, Battle Rope, SkiErg/rowing machine, cardio-зона (treadmill/elliptical/stationary bike)'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps + Cardio', week_label_en = 'Month 1 — LEVEL 1: ЗАПУСК (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps + Cardio', week_label_en = 'Month 1 — LEVEL 1: ЗАПУСК (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · Legs + Shoulders + Cardio', week_label_en = 'Month 1 — LEVEL 1: ЗАПУСК (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps (+5% weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps (+5% weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · Legs + Shoulders (+5% weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Arms', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 3 · Legs + Shoulders', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 2 — LEVEL 2: УСКОРЕНИЕ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 2 — LEVEL 2: УСКОРЕНИЕ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 2 — LEVEL 2: УСКОРЕНИЕ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY', week_label_en = 'Month 2 — LEVEL 2: УСКОРЕНИЕ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps (+Weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps (+Weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders (+Weight)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY (no rest between exercises.)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Arms', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC FULL BODY', week_label_en = 'New Level — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 3 — LEVEL 3: УСКОРЕНИЕ And Density (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 3 — LEVEL 3: УСКОРЕНИЕ And Density (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 3 — LEVEL 3: УСКОРЕНИЕ And Density (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY', week_label_en = 'Month 3 — LEVEL 3: УСКОРЕНИЕ And Density (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3 (density)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 + Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3 (density)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3 (density)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC FULL BODY', week_label_en = 'LEVEL UP — week 3 (density)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Arms', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · CROSS TRAINING', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 4 — LEVEL 4: Strength + МЕТАБОЛИЧЕСКИЙ Stress (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 88;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 4 — LEVEL 4: Strength + МЕТАБОЛИЧЕСКИЙ Stress (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '6–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 4 — LEVEL 4: Strength + МЕТАБОЛИЧЕСКИЙ Stress (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY', week_label_en = 'Month 4 — LEVEL 4: Strength + МЕТАБОЛИЧЕСКИЙ Stress (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC LEVEL', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Arms', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · CROSS TRAINING', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 5 — LEVEL 5: Strength + Speed + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 5 — LEVEL 5: Strength + Speed + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 5 — LEVEL 5: Strength + Speed + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY', week_label_en = 'Month 5 — LEVEL 5: Strength + Speed + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC LEVEL', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Arms', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · CROSS TRAINING', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 6 — LEVEL 6: Strength + МЕТАБОЛИЧЕСКИЙ Stress + New Movements (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 6 — LEVEL 6: Strength + МЕТАБОЛИЧЕСКИЙ Stress + New Movements (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 6 — LEVEL 6: Strength + МЕТАБОЛИЧЕСКИЙ Stress + New Movements (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY', week_label_en = 'Month 6 — LEVEL 6: Strength + МЕТАБОЛИЧЕСКИЙ Stress + New Movements (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · CROSS TRAINING', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'Month 7 — LEVEL 7: Strength + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 7 — LEVEL 7: Strength + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'Month 7 — LEVEL 7: Strength + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC FULL BODY', week_label_en = 'Month 7 — LEVEL 7: Strength + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC CHALLENGE', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 8 — LEVEL 8: Strength + Endurance + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 8 — LEVEL 8: Strength + Endurance + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 8 — LEVEL 8: Strength + Endurance + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC FULL BODY', week_label_en = 'Month 8 — LEVEL 8: Strength + Endurance + Density + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC CHALLENGE', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 25 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 9 — LEVEL 9: Strength + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 25 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 9 — LEVEL 9: Strength + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 25 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 9 — LEVEL 9: Strength + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 25 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC FULL BODY', week_label_en = 'Month 9 — LEVEL 9: Strength + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 26 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 26 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 26 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 26 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 27 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 27 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 27 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 27 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC CHALLENGE', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 28 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'Month 10 — LEVEL 10: Strength + ЖИРОСЖИГАНИЕ + Speed (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 28 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 10 — LEVEL 10: Strength + ЖИРОСЖИГАНИЕ + Speed (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 28 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'Month 10 — LEVEL 10: Strength + ЖИРОСЖИГАНИЕ + Speed (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 28 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC FULL BODY', week_label_en = 'Month 10 — LEVEL 10: Strength + ЖИРОСЖИГАНИЕ + Speed (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 29 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 29 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 29 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 29 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 30 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 30 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 30 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Shoulders', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 30 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC CHALLENGE', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 31 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'Month 11 — LEVEL 11: ATHLETIC CUT — Strength + РЕЛЬЕФ + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 31 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 11 — LEVEL 11: ATHLETIC CUT — Strength + РЕЛЬЕФ + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 31 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'Month 11 — LEVEL 11: ATHLETIC CUT — Strength + РЕЛЬЕФ + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 31 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC FULL BODY', week_label_en = 'Month 11 — LEVEL 11: ATHLETIC CUT — Strength + РЕЛЬЕФ + Endurance (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 32 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps (LEVEL UP)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 32 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps (LEVEL UP)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 32 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes (LEVEL UP)', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 32 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · ATHLETIC LEVEL UP', week_label_en = 'LEVEL UP — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 33 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 33 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 33 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 33 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · METABOLIC CHALLENGE', week_label_en = 'New LEVEL — week 4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 34 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Chest + Shoulders + Triceps', week_label_en = 'Month 12 — FINAL LEVEL 🏆 (weeks 1–2, FINAL PREPARATION)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 92;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 34 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Back + Biceps', week_label_en = 'Month 12 — FINAL LEVEL 🏆 (weeks 1–2, FINAL PREPARATION)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 82;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 34 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Legs + Glutes', week_label_en = 'Month 12 — FINAL LEVEL 🏆 (weeks 1–2, FINAL PREPARATION)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 34 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FINAL ATHLETIC', week_label_en = 'Month 12 — FINAL LEVEL 🏆 (weeks 1–2, FINAL PREPARATION)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 35 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · FINAL BOSS: Chest + Shoulders + Triceps', week_label_en = 'FINAL BOSS — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 82;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 35 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · FINAL BOSS: Back + Biceps', week_label_en = 'FINAL BOSS — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 35 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · FINAL BOSS: Legs + Glutes', week_label_en = 'FINAL BOSS — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10+10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 35 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FINAL BOSS CHALLENGE', week_label_en = 'FINAL BOSS — week 3'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 36 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · FINAL CHEST CHALLENGE', week_label_en = 'FINAL CHALLENGE — week 4 + GRAND FINAL'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 36 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · FINAL BACK CHALLENGE', week_label_en = 'FINAL CHALLENGE — week 4 + GRAND FINAL'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 36 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · FINAL LEG CHALLENGE', week_label_en = 'FINAL CHALLENGE — week 4 + GRAND FINAL'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 36 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · 🏆 GRAND FINAL', week_label_en = 'FINAL CHALLENGE — week 4 + GRAND FINAL'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '20 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = 'Test'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
  end if;

  if v_updated_workouts <> 141 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-muzhchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 141, v_updated_workouts;
  end if;
end $$;
