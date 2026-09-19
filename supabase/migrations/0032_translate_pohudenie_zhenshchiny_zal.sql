-- 0032_translate_pohudenie_zhenshchiny_zal.sql
-- Английский перевод: Похудение — Женщины — Зал
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0015).
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
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-zhenshchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-zhenshchiny-zal';
  end if;

  update public.workout_programs
  set title_en = 'Weight loss for women (gym) — year-long program', description_en = 'Weight loss for women (gym) — year-long program. Equipment: Беговая treadmill, elliptical/ski, тренажёры, dumbbells, тросы, mat'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Legs + Glutes + Core/abs', week_label_en = 'Month 1 — LEVEL 1: START + ADAPTATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Shoulders + Arms', week_label_en = 'Month 1 — LEVEL 1: START + ADAPTATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · FULL BODY + Cardio', week_label_en = 'Month 1 — LEVEL 1: START + ADAPTATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Legs + Glutes', week_label_en = 'Month 2 — LEVEL 2: PROGRESSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 2 — LEVEL 2: PROGRESSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes + Cardio', week_label_en = 'Month 2 — LEVEL 2: PROGRESSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + CONDITIONING', week_label_en = 'Month 2 — LEVEL 2: PROGRESSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 3 — LEVEL 3: SHAPE + FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 3 — LEVEL 3: SHAPE + FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 3 — LEVEL 3: SHAPE + FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + METABOLIC', week_label_en = 'Month 3 — LEVEL 3: SHAPE + FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 4 — LEVEL 4: BODY SCULPT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 4 — LEVEL 4: BODY SCULPT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 4 — LEVEL 4: BODY SCULPT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + METABOLIC CONDITIONING', week_label_en = 'Month 4 — LEVEL 4: BODY SCULPT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '10–12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + FAT BURN', week_label_en = 'Month 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 6 — LEVEL 6: INTENSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8–10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 6 — LEVEL 6: INTENSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 6 — LEVEL 6: INTENSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + HIIT', week_label_en = 'Month 6 — LEVEL 6: INTENSIVE FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 7 — LEVEL 7: ADVANCED SHAPE'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 7 — LEVEL 7: ADVANCED SHAPE'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '16 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'Month 7 — LEVEL 7: ADVANCED SHAPE'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + CONDITIONING', week_label_en = 'Month 7 — LEVEL 7: ADVANCED SHAPE'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 8 — LEVEL 8: DEFINITION & CONDITIONING'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 8 — LEVEL 8: DEFINITION & CONDITIONING'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '16 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'Month 8 — LEVEL 8: DEFINITION & CONDITIONING'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + CONDITIONING', week_label_en = 'Month 8 — LEVEL 8: DEFINITION & CONDITIONING'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 9 — LEVEL 9: ADVANCED FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 9 — LEVEL 9: ADVANCED FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '16–18 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 9 — LEVEL 9: ADVANCED FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + METABOLIC CONDITIONING', week_label_en = 'Month 9 — LEVEL 9: ADVANCED FAT LOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 10 — LEVEL 10: PEAK DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 10 — LEVEL 10: PEAK DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '18 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · КВАДРИЦЕПС + Glutes', week_label_en = 'Month 10 — LEVEL 10: PEAK DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '16 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + METABOLIC CONDITIONING', week_label_en = 'Month 10 — LEVEL 10: PEAK DEFINITION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 11 — LEVEL 11: FINAL CUT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 11 — LEVEL 11: FINAL CUT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '18 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'Month 11 — LEVEL 11: FINAL CUT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '16 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + FINAL CONDITIONING', week_label_en = 'Month 11 — LEVEL 11: FINAL CUT'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + Rear Chain Thighs', week_label_en = 'Month 12 — LEVEL 12: FINAL TRANSFORMATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 12 — LEVEL 12: FINAL TRANSFORMATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 140 and "order" < 143;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'Month 12 — LEVEL 12: FINAL TRANSFORMATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY + FINAL CHALLENGE', week_label_en = 'Month 12 — LEVEL 12: FINAL TRANSFORMATION'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 94;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_en = '10–12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  if v_updated_workouts <> 47 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-zhenshchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 47, v_updated_workouts;
  end if;
end $$;
