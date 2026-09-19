-- 0045_translate_pohudenie_muzhchiny_doma_es.sql
-- Испанский перевод: Похудение — Мужчины — Дома
-- Часть Фазы 6 (Локализация контента), испанский заход — см. PROJECT_PLAN.md.
-- Зеркалирует английские 0031-0038. Сопоставление — по (slug, week_order,
-- "order") для тренировок, по диапазону "order" для подходов, с проверкой
-- количества в конце (см. 0018 — исходный RU-контент).
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

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
  set title_es = 'Pérdida de peso para hombres (en casa) — anual programa', description_es = 'Pérdida de peso para hombres (en casa) — anual programa. Equipo: Mancuernas, banda elástica, турник (por disponibilidad), стул/banco, esterilla'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 1 — START (Mes 1, semanas 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps + Cardio', week_label_es = 'LEVEL 1 — START (Mes 1, semanas 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Viernes · Piernas + FULL BODY', week_label_es = 'LEVEL 1 — START (Mes 1, semanas 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 2 — FAT BURN + STRENGTH (Mes 2, semanas 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12–20'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 2 — FAT BURN + STRENGTH (Mes 2, semanas 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 2 — FAT BURN + STRENGTH (Mes 2, semanas 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY + FAT BURN', week_label_es = 'LEVEL 2 — FAT BURN + STRENGTH (Mes 2, semanas 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Mes 3, semanas 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Mes 3, semanas 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Mes 3, semanas 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY FAT BURN', week_label_es = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Mes 3, semanas 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 4 — METABOLIC STRENGTH (Mes 4, semanas 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 4 — METABOLIC STRENGTH (Mes 4, semanas 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 4 — METABOLIC STRENGTH (Mes 4, semanas 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY METABOLIC', week_label_es = 'LEVEL 4 — METABOLIC STRENGTH (Mes 4, semanas 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Mes 5, semanas 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Mes 5, semanas 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Mes 5, semanas 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY DEFINITION', week_label_es = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Mes 5, semanas 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Mes 6, semanas 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Mes 6, semanas 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Mes 6, semanas 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY + HIIT', week_label_es = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Mes 6, semanas 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 7 — ADVANCED FAT LOSS (Mes 7, semanas 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 7 — ADVANCED FAT LOSS (Mes 7, semanas 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 7 — ADVANCED FAT LOSS (Mes 7, semanas 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY ADVANCED', week_label_es = 'LEVEL 7 — ADVANCED FAT LOSS (Mes 7, semanas 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 8 — DEFINITION + CONDITIONING (Mes 8, semanas 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 8 — DEFINITION + CONDITIONING (Mes 8, semanas 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 8 — DEFINITION + CONDITIONING (Mes 8, semanas 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY CONDITIONING', week_label_es = 'LEVEL 8 — DEFINITION + CONDITIONING (Mes 8, semanas 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 9 — ADVANCED DEFINITION (Mes 9, semanas 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 9 — ADVANCED DEFINITION (Mes 9, semanas 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 9 — ADVANCED DEFINITION (Mes 9, semanas 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY ADVANCED', week_label_es = 'LEVEL 9 — ADVANCED DEFINITION (Mes 9, semanas 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 10 — PEAK FAT LOSS (Mes 10, semanas 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 10 — PEAK FAT LOSS (Mes 10, semanas 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 10 — PEAK FAT LOSS (Mes 10, semanas 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY PEAK', week_label_es = 'LEVEL 10 — PEAK FAT LOSS (Mes 10, semanas 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 11 — FINAL CUT (Mes 11, semanas 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 11 — FINAL CUT (Mes 11, semanas 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 11 — FINAL CUT (Mes 11, semanas 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY FINAL CUT', week_label_es = 'LEVEL 11 — FINAL CUT (Mes 11, semanas 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'LEVEL 12 — FINAL TRANSFORMATION (Mes 12, semanas 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Bíceps', week_label_es = 'LEVEL 12 — FINAL TRANSFORMATION (Mes 12, semanas 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10–12 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'LEVEL 12 — FINAL TRANSFORMATION (Mes 12, semanas 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8–10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 🏆 FINAL FULL BODY TEST', week_label_es = 'LEVEL 12 — FINAL TRANSFORMATION (Mes 12, semanas 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_es = 'Test'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
  end if;

  if v_updated_workouts <> 47 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-muzhchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 47, v_updated_workouts;
  end if;
end $$;
