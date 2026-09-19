-- 0048_translate_nabor_massy_muzhchiny_zal_es.sql
-- Испанский перевод: Набор массы — Мужчины — Зал
-- Часть Фазы 6 (Локализация контента), испанский заход — см. PROJECT_PLAN.md.
-- Зеркалирует английские 0031-0038. Сопоставление — по (slug, week_order,
-- "order") для тренировок, по диапазону "order" для подходов, с проверкой
-- количества в конце (см. 0021 — исходный RU-контент).
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
  v_updated_workouts int := 0;
begin
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-muzhchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-muzhchiny-zal';
  end if;

  update public.workout_programs
  set title_es = 'Ganancia de masa para hombres (gimnasio) — anual programa', description_es = 'Ganancia de masa para hombres (gimnasio) — anual programa. Equipo: Completo ganancia зала: Barra, mancuernas, тренажёры, турник, канаты, TRX, kettlebell'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 1–2 — Fundamento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Hasta el fallo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Hasta el fallo'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 1–2 — Fundamento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 52;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 1–2 — Fundamento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 1–2 — Fundamento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 3–4 — Fundamento (nuevo bloque)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 3–4 — Fundamento (nuevo bloque)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 3–4 — Fundamento (nuevo bloque)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Hasta el fallo'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 3–4 — Fundamento (nuevo bloque)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 5–6 — Aumento de masa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 5–6 — Aumento de masa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 5–6 — Aumento de masa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Hasta el fallo'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 5–6 — Aumento de masa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 7–8 — Calistenia y entrenamiento funcional'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 7–8 — Calistenia y entrenamiento funcional'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 7–8 — Calistenia y entrenamiento funcional'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 7–8 — Calistenia y entrenamiento funcional'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 9–10 — Nuevo estrés: Fuerza + Estiramiento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + Entrenamiento funcional', week_label_es = 'Semanas 9–10 — Nuevo estrés: Fuerza + Estiramiento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 9–10 — Nuevo estrés: Fuerza + Estiramiento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 9–10 — Nuevo estrés: Fuerza + Estiramiento'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '30 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 11–12 — Nuevo estrés: Completamente nueva programa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 11–12 — Nuevo estrés: Completamente nueva programa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 11–12 — Nuevo estrés: Completamente nueva programa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Hasta el fallo'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 11–12 — Nuevo estrés: Completamente nueva programa'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 13–14 — Fuerza + Masa: Pesado press'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 13–14 — Fuerza + Masa: Pesado press'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = '90 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 13–14 — Fuerza + Masa: Pesado press'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 13–14 — Fuerza + Masa: Pesado press'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 15–16 — Fuerza + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 15–16 — Fuerza + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 15–16 — Fuerza + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 15–16 — Fuerza + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps + ФУНКЦ. Finisher', week_label_es = 'Semanas 17–18 — Hipertrofia 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + АТЛЕТИКА', week_label_es = 'Semanas 17–18 — Hipertrofia 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 17–18 — Hipertrofia 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 17–18 — Hipertrofia 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 19–20 — Muscular resistencia'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 19–20 — Muscular resistencia'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 19–20 — Muscular resistencia'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 19–20 — Muscular resistencia'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 21–22 — Shock adaptación'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + ВЗРЫВНАЯ Trabajo', week_label_es = 'Semanas 21–22 — Shock adaptación'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 21–22 — Shock adaptación'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 21–22 — Shock adaptación'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '40 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 23–24 — Atletismo: Músculos como en atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 23–24 — Atletismo: Músculos como en atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '24 шага'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 23–24 — Atletismo: Músculos como en atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 23–24 — Atletismo: Músculos como en atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 25–26 — Pico hipertrofia: Máximo volumen pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 67;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 25–26 — Pico hipertrofia: Máximo volumen pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 25–26 — Pico hipertrofia: Máximo volumen pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Abdominales', week_label_es = 'Semanas 25–26 — Pico hipertrofia: Máximo volumen pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 27–28 — Musculación + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 27–28 — Musculación + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 27–28 — Musculación + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 27–28 — Musculación + Atletismo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps + Abdominales', week_label_es = 'Semanas 29–30 — Especialización: Tren superior pecho + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + ФУНКЦ. Fuerza', week_label_es = 'Semanas 29–30 — Especialización: Tren superior pecho + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 29–30 — Especialización: Tren superior pecho + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 29–30 — Especialización: Tren superior pecho + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '45 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 31–32 — Músculos + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 31–32 — Músculos + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '30 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 31–32 — Músculos + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 31–32 — Músculos + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 33–34 — De fuerza pico: Pesado peso + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 33–34 — De fuerza pico: Pesado peso + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 33–34 — De fuerza pico: Pesado peso + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '50 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 76;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 33–34 — De fuerza pico: Pesado peso + Volumen'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 35–36 — Fuerza + Cuerpo atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 35–36 — Fuerza + Cuerpo atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '30 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 35–36 — Fuerza + Cuerpo atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros', week_label_es = 'Semanas 35–36 — Fuerza + Cuerpo atleta'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'Semanas 37–38 — Tren superior cuerpo 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + Core', week_label_es = 'Semanas 37–38 — Tren superior cuerpo 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 37–38 — Tren superior cuerpo 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Brazos + Abdominales', week_label_es = 'Semanas 37–38 — Tren superior cuerpo 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 16;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 39–40 — Pump + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 39–40 — Pump + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '30 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 39–40 — Pump + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Brazos', week_label_es = 'Semanas 39–40 — Pump + Control cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 41–42 — PRO ATHLETE: Máxima fuerza pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 41–42 — PRO ATHLETE: Máxima fuerza pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 58;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 41–42 — PRO ATHLETE: Máxima fuerza pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_es = '60 метров'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 86;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Brazos', week_label_es = 'Semanas 41–42 — PRO ATHLETE: Máxima fuerza pecho'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Tríceps', week_label_es = 'Semanas 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Brazos', week_label_es = 'Semanas 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Hombros + Tríceps', week_label_es = 'Semanas 45–46 — 3D tren superior cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas + Atletismo', week_label_es = 'Semanas 45–46 — 3D tren superior cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 45–46 — 3D tren superior cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Brazos + Core', week_label_es = 'Semanas 45–46 — 3D tren superior cuerpo'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Pecho + Brazos', week_label_es = 'Semanas 47–48 — FINAL BOSS: Pump, definición, forma'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = 'Máx.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Piernas', week_label_es = 'Semanas 47–48 — FINAL BOSS: Pump, definición, forma'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '40 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 48;
    update public.workout_sets set notes_es = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Espalda + Bíceps', week_label_es = 'Semanas 47–48 — FINAL BOSS: Pump, definición, forma'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '100'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Hombros + Final Pump', week_label_es = 'Semanas 47–48 — FINAL BOSS: Pump, definición, forma'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 20;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = 'Ronda'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  if v_updated_workouts <> 96 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-muzhchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 96, v_updated_workouts;
  end if;
end $$;
