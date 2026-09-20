-- 0031_translate_pohudenie_zhenshchiny_doma.sql
-- Английский перевод: Похудение — Женщины — Дома
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0014).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (94), миграция падает с ошибкой вместо того, чтобы
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
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-zhenshchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-zhenshchiny-doma';
  end if;

  update public.workout_programs
  set title_en = 'Weight loss for women (home) — DonatelleX, year-long program', description_en = 'Weight loss for women (home) — DonatelleX, year-long program. Equipment: Dumbbells, resistance band various resistance, mat, stable platform/step/step (per availability)'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · LOWER BODY + GLUTES', week_label_en = 'LEVEL 1.1 — ADAPTATION (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · UPPER BODY + FAT BURN', week_label_en = 'LEVEL 1.1 — ADAPTATION (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · FULL BODY FAT BURN', week_label_en = 'LEVEL 1.1 — ADAPTATION (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · LOWER BODY BOOST', week_label_en = 'LEVEL 1.2 — BOOST (weeks 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · UPPER BODY BOOST', week_label_en = 'LEVEL 1.2 — BOOST (weeks 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · FULL BODY — LEVEL BOOST', week_label_en = 'LEVEL 1.2 — BOOST (weeks 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTES + LEGS', week_label_en = 'LEVEL 2.1 — BUILD (weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY + CARDIO', week_label_en = 'LEVEL 2.1 — BUILD (weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY + METABOLIC', week_label_en = 'LEVEL 2.1 — BUILD (weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — LEVEL 2', week_label_en = 'LEVEL 2.1 — BUILD (weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'LEVEL 2.2 — SHOCK (weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '14 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY SHOCK', week_label_en = 'LEVEL 2.2 — SHOCK (weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LEGS + METABOLIC SHOCK', week_label_en = 'LEVEL 2.2 — SHOCK (weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 🏆 LEVEL 2 — BOSS TRAINING', week_label_en = 'LEVEL 2.2 — SHOCK (weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'LEVEL 3.1 — IGNITION 🔥 (weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY + CONDITIONING', week_label_en = 'LEVEL 3.1 — IGNITION 🔥 (weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY — POWER + METABOLIC', week_label_en = 'LEVEL 3.1 — IGNITION 🔥 (weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — IGNITION', week_label_en = 'LEVEL 3.1 — IGNITION 🔥 (weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE OVERDRIVE', week_label_en = 'LEVEL 3.2 — OVERDRIVE ⚡ (weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY OVERDRIVE', week_label_en = 'LEVEL 3.2 — OVERDRIVE ⚡ (weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY — SHOCK', week_label_en = 'LEVEL 3.2 — OVERDRIVE ⚡ (weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 👑 BOSS FIGHT — LEVEL 3', week_label_en = 'LEVEL 3.2 — OVERDRIVE ⚡ (weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '5 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'LEVEL 4.1 — POWER ⚡ (weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '16 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY POWER', week_label_en = 'LEVEL 4.1 — POWER ⚡ (weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY — STRENGTH + CONDITIONING', week_label_en = 'LEVEL 4.1 — POWER ⚡ (weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER CHALLENGE', week_label_en = 'LEVEL 4.1 — POWER ⚡ (weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'AMRAP 8 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE CHAOS', week_label_en = 'LEVEL 4.2 — CHAOS 🔥 (weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '18 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY CHAOS', week_label_en = 'LEVEL 4.2 — CHAOS 🔥 (weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY — CHAOS', week_label_en = 'LEVEL 4.2 — CHAOS 🔥 (weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 👑 BOSS FIGHT — LEVEL 4', week_label_en = 'LEVEL 4.2 — CHAOS 🔥 (weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE OVERLOAD', week_label_en = 'LEVEL 5.1 — OVERLOAD 🔥 (weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY OVERLOAD', week_label_en = 'LEVEL 5.1 — OVERLOAD 🔥 (weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY OVERLOAD', week_label_en = 'LEVEL 5.1 — OVERLOAD 🔥 (weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — OVERLOAD CHALLENGE', week_label_en = 'LEVEL 5.1 — OVERLOAD 🔥 (weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE TURBO', week_label_en = 'LEVEL 5.2 — TURBO ⚡ (weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '18 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY TURBO', week_label_en = 'LEVEL 5.2 — TURBO ⚡ (weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · LOWER BODY TURBO', week_label_en = 'LEVEL 5.2 — TURBO ⚡ (weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 👑 BOSS FIGHT — LEVEL 5', week_label_en = 'LEVEL 5.2 — TURBO ⚡ (weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 LOWER BODY CONTROL', week_label_en = 'LEVEL 6.1 — STRENGTH + CONTROL (weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY + CONDITIONING', week_label_en = 'LEVEL 6.1 — STRENGTH + CONTROL (weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LOWER BODY + METABOLIC', week_label_en = 'LEVEL 6.1 — STRENGTH + CONTROL (weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 🏆 FULL BODY TRANSFORMATION', week_label_en = 'LEVEL 6.1 — STRENGTH + CONTROL (weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE SPEED', week_label_en = 'LEVEL 6.2 — SPEED + CONDITIONING (weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 🔥 UPPER BODY CONDITIONING', week_label_en = 'LEVEL 6.2 — SPEED + CONDITIONING (weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LEG CONDITIONING', week_label_en = 'LEVEL 6.2 — SPEED + CONDITIONING (weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 👑 BOSS FIGHT — LEVEL 6', week_label_en = 'LEVEL 6.2 — SPEED + CONDITIONING (weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 ATHLETE GLUTES', week_label_en = 'LEVEL 7.1 — ATHLETE STRENGTH (weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 ATHLETE UPPER BODY', week_label_en = 'LEVEL 7.1 — ATHLETE STRENGTH (weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 ATHLETE LEGS', week_label_en = 'LEVEL 7.1 — ATHLETE STRENGTH (weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 🏆 ATHLETE BOSS FIGHT', week_label_en = 'LEVEL 7.1 — ATHLETE STRENGTH (weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE POWER', week_label_en = 'LEVEL 7.2 — ATHLETE SPEED (weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 🔥 UPPER BODY SPEED', week_label_en = 'LEVEL 7.2 — ATHLETE SPEED (weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LOWER BODY SPEED', week_label_en = 'LEVEL 7.2 — ATHLETE SPEED (weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 👑 LEVEL 7 BOSS FIGHT', week_label_en = 'LEVEL 7.2 — ATHLETE SPEED (weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 METABOLIC GLUTES', week_label_en = 'LEVEL 8.1 — METABOLIC CONTROL (weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 METABOLIC UPPER BODY', week_label_en = 'LEVEL 8.1 — METABOLIC CONTROL (weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🔥 LOWER BODY METABOLIC', week_label_en = 'LEVEL 8.1 — METABOLIC CONTROL (weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ METABOLIC BOSS FIGHT', week_label_en = 'LEVEL 8.1 — METABOLIC CONTROL (weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE CHAOS', week_label_en = 'LEVEL 8.2 — METABOLIC CHAOS (weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · ⚡ UPPER BODY CHAOS', week_label_en = 'LEVEL 8.2 — METABOLIC CHAOS (weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LOWER BODY CHAOS', week_label_en = 'LEVEL 8.2 — METABOLIC CHAOS (weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ LEVEL 8 BOSS FIGHT', week_label_en = 'LEVEL 8.2 — METABOLIC CHAOS (weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE ARENA', week_label_en = 'LEVEL 9.1 — TIME ATTACK (weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY ARENA', week_label_en = 'LEVEL 9.1 — TIME ATTACK (weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LOWER BODY SPEED', week_label_en = 'LEVEL 9.1 — TIME ATTACK (weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ FAT BURNER BOSS FIGHT', week_label_en = 'LEVEL 9.1 — TIME ATTACK (weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE POWER ARENA', week_label_en = 'LEVEL 9.2 — ARENA CHAOS (weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY CHAOS', week_label_en = 'LEVEL 9.2 — ARENA CHAOS (weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 LEG CHAOS', week_label_en = 'LEVEL 9.2 — ARENA CHAOS (weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ LEVEL 9 FINAL BOSS', week_label_en = 'LEVEL 9.2 — ARENA CHAOS (weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 LOWER BODY POWER', week_label_en = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '6 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY CONDITIONING', week_label_en = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 ATHLETIC LEGS', week_label_en = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ CONDITIONING BEAST', week_label_en = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE BEAST', week_label_en = 'LEVEL 10.2 — BEAST MODE 🐺 (weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 BEAST UPPER BODY', week_label_en = 'LEVEL 10.2 — BEAST MODE 🐺 (weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 BEAST LEGS', week_label_en = 'LEVEL 10.2 — BEAST MODE 🐺 (weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ LEVEL 10 FINAL BOSS', week_label_en = 'LEVEL 10.2 — BEAST MODE 🐺 (weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE SCULPT', week_label_en = 'LEVEL 11.1 — SCULPT & POWER ⚡ (weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY PEAK', week_label_en = 'LEVEL 11.1 — SCULPT & POWER ⚡ (weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 ATHLETIC LEGS', week_label_en = 'LEVEL 11.1 — SCULPT & POWER ⚡ (weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ PEAK SHAPE BOSS', week_label_en = 'LEVEL 11.1 — SCULPT & POWER ⚡ (weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · 🍑 GLUTE POWER', week_label_en = 'LEVEL 11.2 — PEAK PERFORMANCE (weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · 💪 UPPER BODY BEAST', week_label_en = 'LEVEL 11.2 — PEAK PERFORMANCE (weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · 🦵 PEAK LEGS', week_label_en = 'LEVEL 11.2 — PEAK PERFORMANCE (weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Ladder'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ☠️ PEAK PERFORMANCE FINAL BOSS', week_label_en = 'LEVEL 11.2 — PEAK PERFORMANCE (weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 1 · Legs + Glutes', week_label_en = '🔥 Month 12 — Final Level (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '40 sec'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 2 · Upper body Body + Cardio', week_label_en = '🔥 Month 12 — Final Level (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15 per side'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '8 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 4 · Glutes + Legs', week_label_en = '🔥 Month 12 — Final Level (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '4 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Day 6 · FULL BODY 🔥', week_label_en = '🔥 Month 12 — Final Level (weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Week 4, Day 1 · Legs + Glutes (new level)', week_label_en = '🔴 Month 12 — Week 3 (UP) + 🟠 Week 4 (New Level) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '30 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Week 4, Day 2 · Upper body + Cardio (new level)', week_label_en = '🔴 Month 12 — Week 3 (UP) + 🟠 Week 4 (New Level) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Week 4, Day 4 · GLUTE ATTACK 🍑', week_label_en = '🔴 Month 12 — Week 3 (UP) + 🟠 Week 4 (New Level) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '45 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Week 4, Day 6 · 🔥 FINAL BOSS — Final Year', week_label_en = '🔴 Month 12 — Week 3 (UP) + 🟠 Week 4 (New Level) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '3 min'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
