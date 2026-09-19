-- 0041_translate_pohudenie_zhenshchiny_doma_es.sql
-- Испанский перевод: Похудение — Женщины — Дома
-- Часть Фазы 6 (Локализация контента), испанский заход — см. PROJECT_PLAN.md.
-- Зеркалирует английские 0031-0038. Сопоставление — по (slug, week_order,
-- "order") для тренировок, по диапазону "order" для подходов, с проверкой
-- количества в конце (см. 0014 — исходный RU-контент).
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

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
  set title_es = 'Pérdida de peso para mujeres (en casa) — DonatelloX, anual programa', description_es = 'Pérdida de peso para mujeres (en casa) — DonatelloX, anual programa. Equipo: Mancuernas, banda elástica variada resistencia, esterilla, estable plataforma/step/step (por disponibilidad)'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · LOWER BODY + GLUTES', week_label_es = 'LEVEL 1.1 — ADAPTATION (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · UPPER BODY + FAT BURN', week_label_es = 'LEVEL 1.1 — ADAPTATION (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Viernes · FULL BODY FAT BURN', week_label_es = 'LEVEL 1.1 — ADAPTATION (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · LOWER BODY BOOST', week_label_es = 'LEVEL 1.2 — BOOST (semanas 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · UPPER BODY BOOST', week_label_es = 'LEVEL 1.2 — BOOST (semanas 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Viernes · FULL BODY — LEVEL BOOST', week_label_es = 'LEVEL 1.2 — BOOST (semanas 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTES + LEGS', week_label_es = 'LEVEL 2.1 — BUILD (semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY + CARDIO', week_label_es = 'LEVEL 2.1 — BUILD (semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY + METABOLIC', week_label_es = 'LEVEL 2.1 — BUILD (semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — LEVEL 2', week_label_es = 'LEVEL 2.1 — BUILD (semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'LEVEL 2.2 — SHOCK (semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '14 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY SHOCK', week_label_es = 'LEVEL 2.2 — SHOCK (semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LEGS + METABOLIC SHOCK', week_label_es = 'LEVEL 2.2 — SHOCK (semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 🏆 LEVEL 2 — BOSS TRAINING', week_label_es = 'LEVEL 2.2 — SHOCK (semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'LEVEL 3.1 — IGNITION 🔥 (semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY + CONDITIONING', week_label_es = 'LEVEL 3.1 — IGNITION 🔥 (semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY — POWER + METABOLIC', week_label_es = 'LEVEL 3.1 — IGNITION 🔥 (semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — IGNITION', week_label_es = 'LEVEL 3.1 — IGNITION 🔥 (semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE OVERDRIVE', week_label_es = 'LEVEL 3.2 — OVERDRIVE ⚡ (semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY OVERDRIVE', week_label_es = 'LEVEL 3.2 — OVERDRIVE ⚡ (semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY — SHOCK', week_label_es = 'LEVEL 3.2 — OVERDRIVE ⚡ (semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 👑 BOSS FIGHT — LEVEL 3', week_label_es = 'LEVEL 3.2 — OVERDRIVE ⚡ (semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '5 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'LEVEL 4.1 — POWER ⚡ (semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '16 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY POWER', week_label_es = 'LEVEL 4.1 — POWER ⚡ (semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY — STRENGTH + CONDITIONING', week_label_es = 'LEVEL 4.1 — POWER ⚡ (semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER CHALLENGE', week_label_es = 'LEVEL 4.1 — POWER ⚡ (semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'AMRAP 8 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE CHAOS', week_label_es = 'LEVEL 4.2 — CHAOS 🔥 (semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '18 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY CHAOS', week_label_es = 'LEVEL 4.2 — CHAOS 🔥 (semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY — CHAOS', week_label_es = 'LEVEL 4.2 — CHAOS 🔥 (semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 👑 BOSS FIGHT — LEVEL 4', week_label_es = 'LEVEL 4.2 — CHAOS 🔥 (semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE OVERLOAD', week_label_es = 'LEVEL 5.1 — OVERLOAD 🔥 (semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY OVERLOAD', week_label_es = 'LEVEL 5.1 — OVERLOAD 🔥 (semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY OVERLOAD', week_label_es = 'LEVEL 5.1 — OVERLOAD 🔥 (semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — OVERLOAD CHALLENGE', week_label_es = 'LEVEL 5.1 — OVERLOAD 🔥 (semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE TURBO', week_label_es = 'LEVEL 5.2 — TURBO ⚡ (semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '18 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY TURBO', week_label_es = 'LEVEL 5.2 — TURBO ⚡ (semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · LOWER BODY TURBO', week_label_es = 'LEVEL 5.2 — TURBO ⚡ (semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 👑 BOSS FIGHT — LEVEL 5', week_label_es = 'LEVEL 5.2 — TURBO ⚡ (semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 LOWER BODY CONTROL', week_label_es = 'LEVEL 6.1 — STRENGTH + CONTROL (semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY + CONDITIONING', week_label_es = 'LEVEL 6.1 — STRENGTH + CONTROL (semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LOWER BODY + METABOLIC', week_label_es = 'LEVEL 6.1 — STRENGTH + CONTROL (semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 🏆 FULL BODY TRANSFORMATION', week_label_es = 'LEVEL 6.1 — STRENGTH + CONTROL (semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'AMRAP 10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE SPEED', week_label_es = 'LEVEL 6.2 — SPEED + CONDITIONING (semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 🔥 UPPER BODY CONDITIONING', week_label_es = 'LEVEL 6.2 — SPEED + CONDITIONING (semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LEG CONDITIONING', week_label_es = 'LEVEL 6.2 — SPEED + CONDITIONING (semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 👑 BOSS FIGHT — LEVEL 6', week_label_es = 'LEVEL 6.2 — SPEED + CONDITIONING (semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 ATHLETE GLUTES', week_label_es = 'LEVEL 7.1 — ATHLETE STRENGTH (semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 ATHLETE UPPER BODY', week_label_es = 'LEVEL 7.1 — ATHLETE STRENGTH (semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 ATHLETE LEGS', week_label_es = 'LEVEL 7.1 — ATHLETE STRENGTH (semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 🏆 ATHLETE BOSS FIGHT', week_label_es = 'LEVEL 7.1 — ATHLETE STRENGTH (semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE POWER', week_label_es = 'LEVEL 7.2 — ATHLETE SPEED (semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 🔥 UPPER BODY SPEED', week_label_es = 'LEVEL 7.2 — ATHLETE SPEED (semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LOWER BODY SPEED', week_label_es = 'LEVEL 7.2 — ATHLETE SPEED (semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 👑 LEVEL 7 BOSS FIGHT', week_label_es = 'LEVEL 7.2 — ATHLETE SPEED (semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 METABOLIC GLUTES', week_label_es = 'LEVEL 8.1 — METABOLIC CONTROL (semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 METABOLIC UPPER BODY', week_label_es = 'LEVEL 8.1 — METABOLIC CONTROL (semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🔥 LOWER BODY METABOLIC', week_label_es = 'LEVEL 8.1 — METABOLIC CONTROL (semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ METABOLIC BOSS FIGHT', week_label_es = 'LEVEL 8.1 — METABOLIC CONTROL (semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 12 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE CHAOS', week_label_es = 'LEVEL 8.2 — METABOLIC CHAOS (semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · ⚡ UPPER BODY CHAOS', week_label_es = 'LEVEL 8.2 — METABOLIC CHAOS (semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LOWER BODY CHAOS', week_label_es = 'LEVEL 8.2 — METABOLIC CHAOS (semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ LEVEL 8 BOSS FIGHT', week_label_es = 'LEVEL 8.2 — METABOLIC CHAOS (semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE ARENA', week_label_es = 'LEVEL 9.1 — TIME ATTACK (semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY ARENA', week_label_es = 'LEVEL 9.1 — TIME ATTACK (semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LOWER BODY SPEED', week_label_es = 'LEVEL 9.1 — TIME ATTACK (semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ FAT BURNER BOSS FIGHT', week_label_es = 'LEVEL 9.1 — TIME ATTACK (semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE POWER ARENA', week_label_es = 'LEVEL 9.2 — ARENA CHAOS (semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY CHAOS', week_label_es = 'LEVEL 9.2 — ARENA CHAOS (semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 LEG CHAOS', week_label_es = 'LEVEL 9.2 — ARENA CHAOS (semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ LEVEL 9 FINAL BOSS', week_label_es = 'LEVEL 9.2 — ARENA CHAOS (semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 LOWER BODY POWER', week_label_es = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '6 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY CONDITIONING', week_label_es = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 ATHLETIC LEGS', week_label_es = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ CONDITIONING BEAST', week_label_es = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE BEAST', week_label_es = 'LEVEL 10.2 — BEAST MODE 🐺 (semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 BEAST UPPER BODY', week_label_es = 'LEVEL 10.2 — BEAST MODE 🐺 (semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 BEAST LEGS', week_label_es = 'LEVEL 10.2 — BEAST MODE 🐺 (semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ LEVEL 10 FINAL BOSS', week_label_es = 'LEVEL 10.2 — BEAST MODE 🐺 (semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE SCULPT', week_label_es = 'LEVEL 11.1 — SCULPT & POWER ⚡ (semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '7 min'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY PEAK', week_label_es = 'LEVEL 11.1 — SCULPT & POWER ⚡ (semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 ATHLETIC LEGS', week_label_es = 'LEVEL 11.1 — SCULPT & POWER ⚡ (semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ PEAK SHAPE BOSS', week_label_es = 'LEVEL 11.1 — SCULPT & POWER ⚡ (semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · 🍑 GLUTE POWER', week_label_es = 'LEVEL 11.2 — PEAK PERFORMANCE (semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · 💪 UPPER BODY BEAST', week_label_es = 'LEVEL 11.2 — PEAK PERFORMANCE (semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · 🦵 PEAK LEGS', week_label_es = 'LEVEL 11.2 — PEAK PERFORMANCE (semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Escalera'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ☠️ PEAK PERFORMANCE FINAL BOSS', week_label_es = 'LEVEL 11.2 — PEAK PERFORMANCE (semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'AMRAP 15 min'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '10 min'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Día 1 · Piernas + Glúteos', week_label_es = '🔥 Mes 12 — Final Nivel (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '40 seg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Día 2 · Tren superior Cuerpo + Cardio', week_label_es = '🔥 Mes 12 — Final Nivel (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15 por lado'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '8 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Día 4 · Glúteos + Piernas', week_label_es = '🔥 Mes 12 — Final Nivel (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '4 min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Día 6 · FULL BODY 🔥', week_label_es = '🔥 Mes 12 — Final Nivel (semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Semana 4, Día 1 · Piernas + Glúteos (nuevo nivel)', week_label_es = '🔴 Mes 12 — Semana 3 (UP) + 🟠 Semana 4 (Nuevo Nivel) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '30 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Semana 4, Día 2 · Tren superior + Cardio (nuevo nivel)', week_label_es = '🔴 Mes 12 — Semana 3 (UP) + 🟠 Semana 4 (Nuevo Nivel) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '12 min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Semana 4, Día 4 · GLUTE ATTACK 🍑', week_label_es = '🔴 Mes 12 — Semana 3 (UP) + 🟠 Semana 4 (Nuevo Nivel) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '45 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Semana 4, Día 6 · 🔥 FINAL BOSS — Final Año', week_label_es = '🔴 Mes 12 — Semana 3 (UP) + 🟠 Semana 4 (Nuevo Nivel) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '3 min'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
