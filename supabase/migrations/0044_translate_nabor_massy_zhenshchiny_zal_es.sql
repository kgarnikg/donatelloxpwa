-- 0044_translate_nabor_massy_zhenshchiny_zal_es.sql
-- Испанский перевод: Набор массы — Женщины — Зал
-- Часть Фазы 6 (Локализация контента), испанский заход — см. PROJECT_PLAN.md.
-- Зеркалирует английские 0031-0038. Сопоставление — по (slug, week_order,
-- "order") для тренировок, по диапазону "order" для подходов, с проверкой
-- количества в конце (см. 0017 — исходный RU-контент).
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
  v_updated_workouts int := 0;
begin
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-zhenshchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-zhenshchiny-zal';
  end if;

  update public.workout_programs
  set title_es = 'Ganancia de masa para mujeres (gimnasio) — anual programa «12 LEVELS»', description_es = 'Ganancia de masa para mujeres (gimnasio) — anual programa «12 LEVELS». Equipo: Barra, mancuernas, тренажёры (Hip Thrust, Hack Squat, Leg Press, блоки), banda elástica, kettlebell, TRX, balón medicinal'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos + Cuádriceps', week_label_es = 'Mes 1 — Fundamento — semanas 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10/pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Hombros + Brazos', week_label_es = 'Mes 1 — Fundamento — semanas 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Glúteos + Posterior Cadena', week_label_es = 'Mes 1 — Fundamento — semanas 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12/pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15/pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Tren superior + Glúteos + CORE', week_label_es = 'Mes 1 — Fundamento — semanas 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 1 — Fundamento (Nuevo Estímulo) — semanas 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12/pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 1 — Fundamento (Nuevo Estímulo) — semanas 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 1 — Fundamento (Nuevo Estímulo) — semanas 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 1 — Fundamento (Nuevo Estímulo) — semanas 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos + Cuádriceps', week_label_es = 'Mes 2 — Aumento Músculos — semanas 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '10.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Hombros', week_label_es = 'Mes 2 — Aumento Músculos — semanas 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Glúteos + Bíceps Muslos', week_label_es = 'Mes 2 — Aumento Músculos — semanas 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Tren superior + Glúteos', week_label_es = 'Mes 2 — Aumento Músculos — semanas 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 2 — Aumento Músculos (Hipertrofia + Entrenamiento funcional) — semanas 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 2 — Aumento Músculos (Hipertrofia + Entrenamiento funcional) — semanas 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 2 — Aumento Músculos (Hipertrofia + Entrenamiento funcional) — semanas 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 2 — Aumento Músculos (Hipertrofia + Entrenamiento funcional) — semanas 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos', week_label_es = 'Mes 3 — Nuevo Estrés — semanas 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Espalda + Hombros', week_label_es = 'Mes 3 — Nuevo Estrés — semanas 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN', week_label_es = 'Mes 3 — Nuevo Estrés — semanas 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Tren superior + Glúteos', week_label_es = 'Mes 3 — Nuevo Estrés — semanas 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 3 — Nuevo Estrés — semanas 11–12'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 4 — Fuerza + Masa — semanas 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 4 — Fuerza + Masa — semanas 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 4 — Fuerza + Masa — semanas 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 4 — Fuerza + Masa — semanas 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 4 — Fuerza + Masa — semanas 15–16'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 5 — Hipertrofia 2.0 — semanas 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 5 — Hipertrofia 2.0 — semanas 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 5 — Hipertrofia 2.0 — semanas 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 5 — Hipertrofia 2.0 — semanas 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 5 — Hipertrofia 2.0 — semanas 19–20'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 6 — Shock Adaptación — semanas 21–22'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_es = '4'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 6 — Shock Adaptación — semanas 23–24'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '24'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos + Cuádriceps', week_label_es = 'Mes 7 — Pico Hipertrofia + Forma — semanas 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 67;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 7 — Pico Hipertrofia + Forma — semanas 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 7 — Pico Hipertrofia + Forma — semanas 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 7 — Pico Hipertrofia + Forma — semanas 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Enfoque Bloque', week_label_es = 'Mes 7 — Pico Hipertrofia + Forma — semanas 27–28'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SPECIALIZATION', week_label_es = 'Mes 8 — Especialización — semanas 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 8 — Especialización — semanas 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 8 — Especialización — semanas 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 8 — Especialización — semanas 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 8 — Especialización — semanas 31–32'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 + 10-секундная изометрия последнего повтора.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 9 — De fuerza Pico — semanas 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 9 — De fuerza Pico — semanas 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 9 — De fuerza Pico — semanas 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 9 — De fuerza Pico — semanas 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 9 — De fuerza Pico — semanas 35–36'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '6–8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 10 — Máxima Hipertrofia + Forma — semanas 37–38'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '15–20.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 10 — Máxima Hipertrofia + Forma — semanas 39–40'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '20.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Entrenamiento 1', week_label_es = 'Mes 11 — Final Ganancia De masa + Fuerza — semanas 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '4–5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_es = '4–5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Entrenamiento 2', week_label_es = 'Mes 11 — Final Ganancia De masa + Fuerza — semanas 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '5'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Entrenamiento 3', week_label_es = 'Mes 11 — Final Ganancia De masa + Fuerza — semanas 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 11 — Final Ganancia De masa + Fuerza — semanas 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Toda semana · Nuevo ganancia ejercicios (todos de entrenamiento días este bloque)', week_label_es = 'Mes 11 — Final Ganancia De masa + Fuerza — semanas 43–44'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE 3D', week_label_es = 'Mes 12 — FINAL TRANSFORMATION — semanas 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER 3D', week_label_es = 'Mes 12 — FINAL TRANSFORMATION — semanas 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE/HAMSTRING', week_label_es = 'Mes 12 — FINAL TRANSFORMATION — semanas 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · Entrenamiento 4', week_label_es = 'Mes 12 — FINAL TRANSFORMATION — semanas 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_es = 'Ejercicio no детализированы тренером — используйте movimientos desde соответствующего día anterior bloque para этой группы músculos'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos', week_label_es = 'Mes 12 — FINAL TRANSFORMATION (FINAL BOSS) — semanas 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · Tren superior', week_label_es = 'Mes 12 — FINAL TRANSFORMATION (FINAL BOSS) — semanas 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 40;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · Piernas + Glúteos', week_label_es = 'Mes 12 — FINAL TRANSFORMATION (FINAL BOSS) — semanas 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FINAL PUMP', week_label_es = 'Mes 12 — FINAL TRANSFORMATION (FINAL BOSS) — semanas 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 20;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '10 — a través de/cada semana снова 4×10».'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '15–20 min en semana.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  if v_updated_workouts <> 63 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-zhenshchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 63, v_updated_workouts;
  end if;
end $$;
