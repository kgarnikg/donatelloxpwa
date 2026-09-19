-- 0035_translate_pohudenie_muzhchiny_doma.sql
-- Английский перевод: Похудение — Мужчины — Дома
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0018).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (47), миграция падает с ошибкой вместо того, чтобы
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
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-muzhchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-muzhchiny-doma';
  end if;

  update public.workout_programs
  set title_en = 'Weight loss for men (home) — year-long program', description_en = 'Weight loss for men (home) — year-long program. Equipment: Dumbbells, resistance band, турник (per availability), стул/bench, mat'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 1 — START (Month 1, weeks 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps + Cardio', week_label_en = 'LEVEL 1 — START (Month 1, weeks 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · Legs + FULL BODY', week_label_en = 'LEVEL 1 — START (Month 1, weeks 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 2 — FAT BURN + STRENGTH (Month 2, weeks 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12–20'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 2 — FAT BURN + STRENGTH (Month 2, weeks 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 2 — FAT BURN + STRENGTH (Month 2, weeks 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + FAT BURN', week_label_en = 'LEVEL 2 — FAT BURN + STRENGTH (Month 2, weeks 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Month 3, weeks 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Month 3, weeks 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Month 3, weeks 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY FAT BURN', week_label_en = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Month 3, weeks 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 4 — METABOLIC STRENGTH (Month 4, weeks 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 4 — METABOLIC STRENGTH (Month 4, weeks 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 4 — METABOLIC STRENGTH (Month 4, weeks 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY METABOLIC', week_label_en = 'LEVEL 4 — METABOLIC STRENGTH (Month 4, weeks 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Month 5, weeks 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Month 5, weeks 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Month 5, weeks 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY DEFINITION', week_label_en = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Month 5, weeks 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Month 6, weeks 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Month 6, weeks 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Month 6, weeks 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + HIIT', week_label_en = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Month 6, weeks 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 7 — ADVANCED FAT LOSS (Month 7, weeks 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 7 — ADVANCED FAT LOSS (Month 7, weeks 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 7 — ADVANCED FAT LOSS (Month 7, weeks 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY ADVANCED', week_label_en = 'LEVEL 7 — ADVANCED FAT LOSS (Month 7, weeks 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 8 — DEFINITION + CONDITIONING (Month 8, weeks 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 8 — DEFINITION + CONDITIONING (Month 8, weeks 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 8 — DEFINITION + CONDITIONING (Month 8, weeks 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY CONDITIONING', week_label_en = 'LEVEL 8 — DEFINITION + CONDITIONING (Month 8, weeks 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 9 — ADVANCED DEFINITION (Month 9, weeks 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 9 — ADVANCED DEFINITION (Month 9, weeks 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 9 — ADVANCED DEFINITION (Month 9, weeks 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY ADVANCED', week_label_en = 'LEVEL 9 — ADVANCED DEFINITION (Month 9, weeks 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 10 — PEAK FAT LOSS (Month 10, weeks 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 10 — PEAK FAT LOSS (Month 10, weeks 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 10 — PEAK FAT LOSS (Month 10, weeks 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY PEAK', week_label_en = 'LEVEL 10 — PEAK FAT LOSS (Month 10, weeks 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 11 — FINAL CUT (Month 11, weeks 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 11 — FINAL CUT (Month 11, weeks 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 11 — FINAL CUT (Month 11, weeks 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY FINAL CUT', week_label_en = 'LEVEL 11 — FINAL CUT (Month 11, weeks 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'LEVEL 12 — FINAL TRANSFORMATION (Month 12, weeks 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Biceps', week_label_en = 'LEVEL 12 — FINAL TRANSFORMATION (Month 12, weeks 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'LEVEL 12 — FINAL TRANSFORMATION (Month 12, weeks 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 🏆 FINAL FULL BODY TEST', week_label_en = 'LEVEL 12 — FINAL TRANSFORMATION (Month 12, weeks 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = 'Test'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
  end if;

  if v_updated_workouts <> 47 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-muzhchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 47, v_updated_workouts;
  end if;
end $$;
