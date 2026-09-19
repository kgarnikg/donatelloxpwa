-- 0043_translate_nabor_massy_zhenshchiny_doma_es.sql
-- Испанский перевод: Набор массы — Женщины — Дома
-- Часть Фазы 6 (Локализация контента), испанский заход — см. PROJECT_PLAN.md.
-- Зеркалирует английские 0031-0038. Сопоставление — по (slug, week_order,
-- "order") для тренировок, по диапазону "order" для подходов, с проверкой
-- количества в конце (см. 0016 — исходный RU-контент).
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
  v_updated_workouts int := 0;
begin
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-zhenshchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-zhenshchiny-doma';
  end if;

  update public.workout_programs
  set title_es = 'Ganancia de masa para mujeres (en casa) — anual programa', description_es = 'Ganancia de masa para mujeres (en casa) — anual programa. Equipo: Mancuernas, banda elástica variada resistencia, esterilla, estable plataforma/step/step'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · Glúteos + Cuádriceps', week_label_es = 'Mes 1 — LEVEL 1A — Adaptación (Semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15 (Mancuerna antes con apoyo en pecho. Últimos 5 reps: Lento fase excéntrica/bajada.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '20 (En верхней точке: 2 seg сжатия ягодиц.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna (Корпус слегка наклонён adelante. Толкаемся пяткой.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15 (Fase excéntrica/bajada: 3 seg. No округлять поясницу.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30 seg (Rodillas примерно bajo углом 90°.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 ejercicio × 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · Glúteos + Posterior Cadena Muslos', week_label_es = 'Mes 1 — LEVEL 1A — Adaptación (Semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15 (Широкая postura piernas.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '3 series 15 reps ↓ 30 seg mantenimiento en нижней точке'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20 (Últimos 5: короткие пульсирующие movimientos.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 por lado'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 ejercicio × 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Viernes · Espalda + Hombros + Brazos', week_label_es = 'Mes 1 — LEVEL 1A — Adaptación (Semanas 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15 (Контролируем movimiento.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '20 (Énfasis en/para posterior deltoides.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15 (Elevaciones laterales mancuernas en lados ↓ сразу Elevación mancuernas antes собой 3 × 12 Descanso después dos…)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = 'Máximo de calidad reps (Puedes realizar con rodilla. Главное — контролировать movimiento.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio × 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'Mes 1 — LEVEL 1B — Primero Salto (Semana 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Peso: +5–10% относительно semanas 1–2, si técnica позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Último repetición каждого series: Mantenimiento 3 seg desde arriba.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 (Lento fase excéntrica/bajada: 3 seg.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '3 rondas: 20 Frog Pumps 20 pulsos en ягодичном мосте 20 seg статики desde arriba Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Ahora: 3 rondas cada ejercicio: 60 seg Dead Bug Reverse Crunch Mountain Climbers…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Miércoles · GLUTE + HAMSTRING', week_label_es = 'Mes 1 — LEVEL 1B — Primero Salto (Semana 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '3 series 12 reps 40 seg удержания'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20 (Último serie: 20 reps + 20 pulsos.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25 por lado'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Viernes · BACK + SHOULDERS + ARMS', week_label_es = 'Mes 1 — LEVEL 1B — Primero Salto (Semana 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Últimos 5: Lento.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Realizar подряд: Elevaciones laterales en lados 12 ↓ Elevación antes собой 12 ↓ Posterior deltoides en inclinado 15…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '3 rondas cada ejercicio: 60 seg Ronda: Mountain Climbers elevación de piernas Russian Twist…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE + QUAD', week_label_es = 'Mes 2 — LEVEL 2A — BUILD (Semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (En верхней точке: 2 seg удержания.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Último serie: +5 коротких pulsos.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna (Толчок выполняется преимущественно рабочей pierna.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '45 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · BACK + SHOULDERS + ARMS', week_label_es = 'Mes 2 — LEVEL 2A — BUILD (Semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15 (Имитируем вертикальную тягу.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Elevaciones laterales mancuernas en lados 15 Posterior deltoides en inclinado 15 4 rondas Descanso: 60 seg.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Curl de bíceps con mancuernas 12 extensión de tríceps con banda elástica 15 3 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '8–12 (Это primero элемент калистеники. Si тяжело: делать con более alto apoyo.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE + HAMSTRING', week_label_es = 'Mes 2 — LEVEL 2A — BUILD (Semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Fase excéntrica/bajada: 3 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna (Peso moderado тяжелый.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12–15 (Si cadena позволяет безопасно скользить. Альтернатива: Curl femoral con banda elástica.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas: 20 Frog Pumps 15 abducciones atrás каждой pierna 20 seg puente de glúteos Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY ATHLETIC', week_label_es = 'Mes 2 — LEVEL 2A — BUILD (Semanas 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Máximo de calidad reps (Puedes con rodilla.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '8 por brazo (Si тяжело: Realizar con rodilla.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '40 seg (Тяжелые mancuernas. Корпус máximo стабильный.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 rondas 20 seg: Step-Up rápido 20 seg: Mountain Climbers 20 seg: Descanso Después…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHAPE', week_label_es = 'Mes 2 — LEVEL 2B — NEW STIMULUS (Semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Peso: +5–10% относительно semanas 5–6, si técnica позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por lado (Una pierna выполняет основную работу.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por lado (Nuevo estímulo para piernas y ягодиц.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '40'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
    update public.workout_sets set notes_es = '3 rondas 30 seg: Puente de glúteos 20 pulsos 20 seg isometría desde arriba Descanso: 45 seg.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · BACK + SHOULDERS', week_label_es = 'Mes 2 — LEVEL 2B — NEW STIMULUS (Semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15 por brazo'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Pausa: 2 seg en верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Elevaciones laterales en lados 12 Arnold Press 10 Posterior deltoides 15 Isometría brazos en lados 20 seg 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '8–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN', week_label_es = 'Mes 2 — LEVEL 2B — NEW STIMULUS (Semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '10 (Lento.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Puente de glúteos: 45 seg isometría 20 pulsos 30 seg isometría 2 rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — ATHLETE LEVEL', week_label_es = 'Mes 2 — LEVEL 2B — NEW STIMULUS (Semanas 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Sentadilla + Press con mancuernas.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '45 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'AMRAP — 8 min Сделать como puedes más de calidad rondas: 8 sentadillas 8 flexiones 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Mountain Climbers Russian Twist Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE + QUAD POWER', week_label_es = 'Mes 3 — LEVEL 3A — SHAPE (Semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por pierna (Últimos 2 reps должны ser тяжелыми.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Ritmo: 2 seg arriba → 2 seg mantenimiento → lento abajo.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15 (Пятки слегка приподняты. Último serie: +10 pulsos.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 5 reps каждого series — lento.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '25 (Últimos 10 reps: короткие пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '12 por pierna (Usar estable plataforma.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 30 seg: Glute Bridge 20 seg: пульсации 20 seg: Estático mantenimiento…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · BACK + SHOULDERS + ARMS', week_label_es = 'Mes 3 — LEVEL 3A — SHAPE (Semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Lento fase excéntrica/bajada: 3 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por brazo (En верхней точке: 2 seg mantenimiento.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 12 Elevaciones laterales mancuernas en lados 15 4 rondas Descanso: 60 seg.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Martillo curl 12 Tríceps con banda elástica abajo 15 3 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '8–12 (Si тяжело — brazos en/para возвышенности.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '30 seg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE + HAMSTRING', week_label_es = 'Mes 3 — LEVEL 3A — SHAPE (Semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Ritmo: 3 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '12 (Стопы en/para estable опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12 (Si нет disponibilidad usar полотенце: Curl femoral con banda elástica.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 15 curls piernas 20 glúteos puentes 20 pulsos 20 seg isometría Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY POWER', week_label_es = 'Mes 3 — LEVEL 3A — SHAPE (Semanas 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Máximo de calidad reps'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '45 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Cada minuto начать nuevo мини-ronda.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'Mes 3 — LEVEL 3B — POWER & CONTROL (Semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Últimos 5 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna (Передняя pierna en/para небольшой estable опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '2 rondas 40 Frog Pumps 30 Abductions 20 Kickbacks каждой pierna 30 seg Glute Bridge Hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — CONTROL', week_label_es = 'Mes 3 — LEVEL 3B — POWER & CONTROL (Semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Pausa: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Elevaciones laterales en lados 15 Reverse Fly 15 Isometría en положении «brazos en lados» 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Curl de bíceps con banda elástica 15 Tríceps sobre la cabeza con banda elástica 15 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Máximo de calidad reps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE + POSTERIOR POWER', week_label_es = 'Mes 3 — LEVEL 3B — POWER & CONTROL (Semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 15 Good Morning 15 Hamstring Walkout 20 Glute Bridge 30 seg isometría Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — BOSS LEVEL', week_label_es = 'Mes 3 — LEVEL 3B — POWER & CONTROL (Semanas 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 (Movimiento realizar технически чисто.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'AMRAP — 10 min Сделать максимальное cantidad de calidad rondas: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'En al final mes пользователь фиксирует: Hip Thrust Mes 1: кг Mes 2: кг Mes…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE + QUAD', week_label_es = 'Mes 4 — LEVEL 4A — GLUTE BUILD (Semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Último repetición каждого series: 2 seg mantenimiento desde arriba.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna (Передняя pierna en/para небольшой estable опоре. Últimos 3 reps: Lento fase excéntrica/bajada.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Completo sentadilla → подняться наполовину → снова abajo → completamente arriba. Это одно repetición.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 3 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '25 (Últimos 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 20 glúteos puentes 20 Frog Pumps 20 Abductions 20 seg isometría desde arriba Descanso:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — SHAPE', week_label_es = 'Mes 4 — LEVEL 4A — GLUTE BUILD (Semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por brazo (Pausa: 2 seg desde arriba.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Elevaciones laterales en lados 15 Передние elevaciones laterales 12 Posterior deltoides 15 4 rondas Descanso: 60…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Bíceps con mancuernas 12 Tríceps con banda elástica 15 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '40 seg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 72;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE + HAMSTRING', week_label_es = 'Mes 4 — LEVEL 4A — GLUTE BUILD (Semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Ritmo: 3 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna (Énfasis: Glúteos.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 15 Hamstring Slides 20 Glute Bridge 20 Frog Pumps 30 seg mantenimiento desde arriba…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER', week_label_es = 'Mes 4 — LEVEL 4A — GLUTE BUILD (Semanas 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = 'Máximo de calidad reps'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10 por brazo'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Чередуем: Нечетная минута 10 Goblet Squats Четная минута 8 Push-Ups + 10 Mountain…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 4 — LEVEL 4B — GLUTE SHOCK (Semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Último serie: +15 pulsos.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna (Posterior pierna уходит atrás con небольшой возвышенности bajo delantero pierna.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 30 seg: Frog Pumps 20 seg: Glute Bridge Hold 20 pulsos 20 abducciones piernas…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — NEW ANGLES', week_label_es = 'Mes 4 — LEVEL 4B — GLUTE SHOCK (Semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Это уменьшает помощь поясницы.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Elevaciones laterales en lados 15 Reverse Fly 15 4 rondas Descanso: 60 seg.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Martillo curl 12 Extensión mancuernas sobre la cabeza 12 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '30 seg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN SHOCK', week_label_es = 'Mes 4 — LEVEL 4B — GLUTE SHOCK (Semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 15 Hamstring Walkout 20 Glute Bridge 20 Kickbacks 30 seg isometría Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — BOSS LEVEL', week_label_es = 'Mes 4 — LEVEL 4B — GLUTE SHOCK (Semanas 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'AMRAP — 12 min Максимальное cantidad de calidad rondas: 10 Sumo Squats 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'Пользователь фиксирует resultado: Hip Thrust Mes 1: кг Mes 2: кг Mes 3:…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_es = 'Después 16- semanas пользователь должен получить ощущение перехода en/para nuevo nivel: 3…'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE STRENGTH', week_label_es = 'Mes 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Último serie: Rest-pause Después выполнения series: 20 seg descanso → дополнительные…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 (Último serie: +10 pulsos abajo.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–10 por pierna (Peso: тяжелый, pero técnica completamente контролируется.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna (En верхней точке: 1 seg удержания.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '20 (Último serie: 20 normales 20 pulsos.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '2 rondas 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 seg isometría Descanso: 90…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY STRENGTH', week_label_es = 'Mes 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por brazo (Últimos 2 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Elevaciones laterales mancuernas en lados 15 4 rondas'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Передние elevaciones laterales 12 Posterior deltoides en inclinado 15 3 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Martillo curl 12 Tríceps con una mancuerna sobre la cabeza 12 3 rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING + GLUTE STRENGTH', week_label_es = 'Mes 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 3 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10 (Pausa desde arriba: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = 'Curl femoral 12 reps 20 seg descanso 5 reps 20 seg descanso 5 reps'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — STRENGTH + ATHLETIC', week_label_es = 'Mes 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Semanas 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '16 pasos'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máximo de calidad reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Нечетные minutos 10 Goblet Squats Четные minutos 8 Push-Ups 10 Mountain Climbers Оставшееся…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 5 — LEVEL 5B — MUSCLE SHOCK (Semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Último serie: 1,5 reps × 8)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '30 (Último serie: +20 pulsos.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 20 Frog Pumps ↓ 20 Glute Bridge ↓ 20 seg isometría ↓ 20 pulsos Descanso: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY SHOCK', week_label_es = 'Mes 5 — LEVEL 5B — MUSCLE SHOCK (Semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Pausa: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Elevaciones laterales en lados 15 Reverse Fly 15 Isometría en lados 20 seg 4 rondas…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '3 rondas Martillo curl: 10 ↓ normales curl: 10 ↓ частичные reps: 10 Descanso:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR SHOCK', week_label_es = 'Mes 5 — LEVEL 5B — MUSCLE SHOCK (Semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 seg isometría Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — LEVEL 5 BOSS', week_label_es = 'Mes 5 — LEVEL 5B — MUSCLE SHOCK (Semanas 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '12 min Максимальное cantidad de calidad rondas: 10 Sumo Squats 8 Push-Ups 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'Пользователь фиксирует: Hip Thrust Mes 1: кг Mes 2: кг Mes 3: кг…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_es = 'Después 20- semanas пользователь переходит en/para siguiente nivel.'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'Mes 6 — LEVEL 6A — POWER HYPERTROPHY (Semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 (Último serie: 8 reps + 20 seg descanso + 4–5 reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Posterior pierna no используется para толчка.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Ritmo: 3 seg abajo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 (En нижней точке: 2 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20 (Último serie: 20 normales 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30 (Últimos 10: Máximo короткая rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 12 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 seg mantenimiento desde arriba…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg Reverse Crunch Mountain Climbers Dead Bug Plancha…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — STRENGTH', week_label_es = 'Mes 6 — LEVEL 6A — POWER HYPERTROPHY (Semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por brazo (Pausa en верхней точке: 2 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 ↓ Elevaciones laterales en lados 12 ↓ Elevaciones laterales вперед 12 ↓ Reverse Fly 15 Descanso:…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Martillo curl 12 Extensión mancuernas sobre la cabeza 12 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 rondas V-Ups — 60 seg Bicycle — 60 seg Hollow Hold — 60 seg Leg Raise — 60 seg Descanso: 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING + GLUTE', week_label_es = 'Mes 6 — LEVEL 6A — POWER HYPERTROPHY (Semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Últimos 2 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna (Pausa desde arriba: 2 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 (Si слишком легко: Usar более медленную fase возвращения.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 30 seg mantenimiento Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas Reverse Crunch — 60 seg Bicycle — 60 seg Mountain Climbers — 60 seg Plancha con…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER', week_label_es = 'Mes 6 — LEVEL 6A — POWER HYPERTROPHY (Semanas 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10 por brazo'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '10 (entre series: 60 seg)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 rondas 10 Goblet Squats 8 Push-Ups 10 Dumbbell Rows 10 Reverse Lunges 15 Dumbbell…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 rondas V-Ups — 60 seg Mountain Climbers — 60 seg Russian Twist — 60 seg Hollow Hold — 60…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 6 — LEVEL 6B — ATHLETIC SHOCK (Semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Пятки слегка приподняты. Último serie: +10 pulsos)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna (En верхней точке: 2 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 seg isometría desde arriba Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg Bicycle Reverse Crunch Mountain Climbers Plank…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY SHOCK', week_label_es = 'Mes 6 — LEVEL 6B — ATHLETIC SHOCK (Semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa: 2 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 seg…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Bíceps 12 normales curls ↓ 10 молотковых ↓ 10 parciales 3 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 rondas Leg Raise — 60 seg Bicycle — 60 seg Hollow Hold — 60 seg Mountain Climbers — 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN SHOCK', week_label_es = 'Mes 6 — LEVEL 6B — ATHLETIC SHOCK (Semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10 (Cada repetición: Completo arriba → половина abajo → снова arriba → completo abajo.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 seg Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '5 rondas Dead Bug — 60 seg Reverse Crunch — 60 seg Mountain Climbers — 60 seg Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ATHLETIC FULL BODY', week_label_es = 'Mes 6 — LEVEL 6B — ATHLETIC SHOCK (Semanas 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '—'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 (Descanso: 75 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Máximo'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = 'Por/detrás 12 min realizar máximo качественное cantidad rondas: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'En течение mes фиксируются: HIP THRUST Semana 21: кг Semana 22: кг Semana 23:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'Después 24- semanas пользователь получает: +1 LEVEL y переходит a:'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE MASS', week_label_es = 'Mes 7 — LEVEL 7A — GLUTE BUILD (Semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Último serie: 10 reps + 20 seg descanso + 5 reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Énfasis: ягодица.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna (Передняя pierna стоит en/para небольшой estable step.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12 (Últimos 3 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '25 (Último serie: 25 reps 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30 (Últimos 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 30 seg isometría Descanso: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY + SHOULDERS', week_label_es = 'Mes 7 — LEVEL 7A — GLUTE BUILD (Semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Pausa: 2 seg en верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 reps ↓ Elevaciones laterales mancuernas en lados 15 reps ↓ Isometría en lados…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '12 (Martillo curl Tríceps con una mancuerna sobre la cabeza 3 × 12 Выполняются суперсетом.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING + GLUTE', week_label_es = 'Mes 7 — LEVEL 7A — GLUTE BUILD (Semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna (Pausa desde arriba: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 seg Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · ATHLETIC — LOWER BODY POWER', week_label_es = 'Mes 7 — LEVEL 7A — GLUTE BUILD (Semanas 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 (Descanso: 60–75 seg.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = 'Máximo de calidad reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '60 seg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 7 — LEVEL 7B — GLUTE SHOCK (Semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Último serie: 12 reps + 10 pulsos.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna (En верхней точке: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 seg isometría Descanso: 45 seg.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY SHOCK', week_label_es = 'Mes 7 — LEVEL 7B — GLUTE SHOCK (Semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 4 rondas Descanso: 60 seg.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '3 rondas 12 normales curls ↓ 10 молотковых ↓ 10 parciales reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '15 (Extensión con banda elástica: Último serie: +15 parciales reps.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · GLUTE + HAMSTRING SHOCK', week_label_es = 'Mes 7 — LEVEL 7B — GLUTE SHOCK (Semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 12 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 seg isometría Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · LEVEL 7 — BOSS FIGHT', week_label_es = 'Mes 7 — LEVEL 7B — GLUTE SHOCK (Semanas 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 (Dumbbell Clean Squat Jump 4 × 8 Descanso: 75 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Thruster Reverse Lunge 4 × 10 por pierna Descanso: 75 seg.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 por brazo (Renegade Row Push-Up 4 × máximo Descanso: 75 seg.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = 'Максимальное cantidad de calidad rondas: 10 Goblet Squats 10 Walking Lunges 8…'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_es = '3 rondas 20 Frog Pumps 20 Abduction 20 seg Glute Bridge Hold 10 Squat Pulses Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Пользователь фиксирует лучшие показатели.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '28 semanas пройдено.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE TENSION', week_label_es = 'Mes 8 — LEVEL 8A — TENSION BUILD (Semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Ritmo: 2 seg arriba → 2 seg mantenimiento → lento abajo.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Ritmo: 3 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por lado (Pausa en нижней точке: 1 seg.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 (Último serie: 25 reps 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 15 Glute Bridge 15 Frog Pumps 15 Abduction 30 seg Glute Bridge Hold Descanso: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — CALISTHENICS', week_label_es = 'Mes 8 — LEVEL 8A — TENSION BUILD (Semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 por brazo'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8–15 (Si normales слишком легкие: Piernas en/para estable возвышенности.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Últimos 3 reps: медленная негативная fase.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 seg…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Hammer Curl 12 Overhead Triceps Extension 12 4 rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '2 rondas 10 normales curls 10 молотковых 10 parciales'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN', week_label_es = 'Mes 8 — LEVEL 8A — TENSION BUILD (Semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna (Pausa desde arriba: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '20 pasos'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Hamstring Walkouts ↓ 15 Glute Bridges ↓ 20 Frog Pumps ↓ 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER', week_label_es = 'Mes 8 — LEVEL 8A — TENSION BUILD (Semanas 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Goblet Squat Squat Jump 4 × 8 Descanso: 90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Romanian Deadlift Broad Jump 4 × 6 Si нет безопасного места para saltos:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Dumbbell Push Press Mountain Climbers 4 × 30 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 por brazo (Renegade Row Push-Up 3 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 8 — LEVEL 8B — ATHLETIC SHOCK (Semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Últimos 5 reps: короткая rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Después каждого series: 10 pulsos.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 15 Hip Thrust 20 Frog Pumps 20 Abduction 15 Squat Pulses 30 seg isometría Descanso:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY SHOCK', week_label_es = 'Mes 8 — LEVEL 8B — ATHLETIC SHOCK (Semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–12 (Pausa abajo: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 por brazo'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '4 rondas Lateral Raise 12 Arnold Press 10 Reverse Fly 15 Descanso: 60 seg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Bíceps 10 normales curls ↓ 10 молотковых ↓ 10 parciales 3 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING + GLUTE SHOCK', week_label_es = 'Mes 8 — LEVEL 8B — ATHLETIC SHOCK (Semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Pausa: 3 seg desde arriba.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–10 (En completamente вытянутом положении: 1 seg.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · LEVEL 8 — BOSS FIGHT', week_label_es = 'Mes 8 — LEVEL 8B — ATHLETIC SHOCK (Semanas 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Dumbbell Thruster Squat Jump 4 × 8 Descanso: 75–90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8 (Dumbbell Clean Reverse Lunge + Knee Drive 4 × 10 por pierna)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 (Renegade Row Push-Up 4 × máximo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 40 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Максимальное cantidad de calidad rondas: 10 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '3 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg Glute…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Пользователь фиксирует: HIP THRUST Semana 29: кг Semana 30: кг Semana 31: …'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Después 32 semanas пользователь переходит en/para:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'Mes 9 — LEVEL 9A — POWER BUILD (Semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 2 seg arriba → 2 seg mantenimiento → 3 seg abajo Último serie: 10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Ritmo: 3 seg abajo Últimos 2 reps: Máximo контролируемые.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Pausa en нижней точке: 1 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna (Después последнего series: 10 rápido reps peso corporal por pierna)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '12 (Últimos 3 reps: 3-секундная негативная fase)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25 (Último serie: 25 reps 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 15 Hip Thrust 15 Frog Pumps 15 Squat Pulses 20 Abduction 30 seg Glute Bridge…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — POWER', week_label_es = 'Mes 9 — LEVEL 9A — POWER BUILD (Semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–12 (Si тяжело: Normales flexión.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por brazo (Últimos 3 reps: Lento fase excéntrica/bajada.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 (Pausa: 2 seg en растянутом положении)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 reps Lateral Raise 12 reps Reverse Fly 15 reps…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '12 por brazo (Alternating Dumbbell Curl Último serie: 12 + 10 parciales reps)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '12 (Overhead Dumbbell Extension Band Triceps Pushdown 3 × 20)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 8 Push-Ups 10 Knee Push-Ups 10 seg mantenimiento en нижней точке Descanso: 45 seg'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING POWER', week_label_es = 'Mes 9 — LEVEL 9A — POWER BUILD (Semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna (Pausa desde arriba: 3 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Usar полотенце/скользящую cadena.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 pasos en cada lado'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 10 Sliding Leg Curl 15 Glute Bridge 15 Frog Pumps 20 Band Abduction 30 seg…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · POWER CONDITIONING', week_label_es = 'Mes 9 — LEVEL 9A — POWER BUILD (Semanas 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Dumbbell Squat Squat Jump 4 × 8 Descanso: 90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Romanian Deadlift Skater Jump 4 × 10 por lado Si saltos…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Dumbbell Push Press Mountain Climbers 4 × 40 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8 por brazo (Renegade Row Push-Up 3 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '3 rondas 20 Frog Pumps 15 Squat Pulses 20 Band Abduction 15 Glute Bridge 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE OVERLOAD', week_label_es = 'Mes 9 — LEVEL 9B — GLUTE OVERLOAD (Semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Pausa desde arriba: 3 seg)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Ritmo: 3 seg abajo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 (Último serie: 25 + 20 pulsos)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '25 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 10 Bulgarian Split Squats ↓ 15 Reverse Lunges ↓ 20 Bodyweight Squats ↓ 30 seg…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — CALISTHENICS LEVEL', week_label_es = 'Mes 9 — LEVEL 9B — GLUTE OVERLOAD (Semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Pausa abajo: 2 seg)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '6–8 por lado (Si сложно: делать con rodilla o con уменьшенной rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Raise Hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Hammer Curl 12 Band Triceps Extension 20 4 rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '3 rondas 10 Dumbbell Curl ↓ 10 Hammer Curl ↓ 10 parciales reps'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN OVERLOAD', week_label_es = 'Mes 9 — LEVEL 9B — GLUTE OVERLOAD (Semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa desde arriba: 3 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '30 (Últimos 10: частичные.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 rondas 8 Sliding Leg Curl 12 Single-Leg Glute Bridge 15 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · LEVEL 9 — BOSS FIGHT', week_label_es = 'Mes 9 — LEVEL 9B — GLUTE OVERLOAD (Semanas 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 por lado)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Renegade Row Push-Up 4 × máximo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 45 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Максимальное cantidad de calidad rondas: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'En/para каждой тренировке пользователь записывает de trabajo peso.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Después прохождения 9- mes пользователь открывает:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE HYPERTROPHY', week_label_es = 'Mes 10 — LEVEL 10A — HYPERTROPHY BUILD (Semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 2 seg arriba → 2 seg mantenimiento → 3 seg abajo Último serie: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por pierna (Posterior pierna elevado.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Pausa en нижней точке: 2 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 3 reps: медленная негативная fase.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '30 (Último serie: 30 reps 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 12 Hip Thrust ↓ 15 Bodyweight Squats ↓ 20 Frog Pumps ↓ 20 Abduction ↓ 30 seg…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — STRENGTH', week_label_es = 'Mes 10 — LEVEL 10A — HYPERTROPHY BUILD (Semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Último serie: +3–5 parciales reps.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por brazo (Pausa en верхней точке: 2 seg.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 (Ritmo: 3 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 reps Lateral Raise 15 reps Front Raise 12 reps…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Superserie Dumbbell Curl 12 Overhead Triceps Extension 12 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Bíceps 10 normales curls 10 молотковых 10 parciales Tríceps 15 extensiones con banda elástica 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN', week_label_es = 'Mes 10 — LEVEL 10A — HYPERTROPHY BUILD (Semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Pausa: 3 seg desde arriba.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12 (Si слишком тяжело: Hamstring Walkout.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_es = '25 (Últimos 10: частичная rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '3 rondas 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 20 Abduction 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER + DENSITY', week_label_es = 'Mes 10 — LEVEL 10A — HYPERTROPHY BUILD (Semanas 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Dumbbell Thruster Squat Jump 4 × 8 Descanso: 90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 por pierna)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 por brazo (Renegade Row Push-Up 4 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 40 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '3 rondas 20 Frog Pumps 15 Squat Pulses 20 Abduction 15 Glute Bridge 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE DENSITY', week_label_es = 'Mes 10 — LEVEL 10B — DENSITY SHOCK (Semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '15 (Pausa desde arriba: 3 seg Último serie: 15 + 10 pulsos + 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 3 reps: 1,5 reps.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '15 (Ritmo: 4 seg abajo.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '15 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '30 (Último serie: 30 + 20 pulsos.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 rondas 15 Reverse Lunges 20 Frog Pumps 20 Squat Pulses 20 Abduction 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — CALISTHENICS SHOCK', week_label_es = 'Mes 10 — LEVEL 10B — DENSITY SHOCK (Semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8 por lado (Si тяжело: делать con rodilla.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8 por lado'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 ↓ Lateral Raise 12 ↓ Partial Lateral Raise 15 ↓ Reverse Fly 15…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Bíceps 8 reps ↓ 20 seg descanso ↓ 4 reps ↓ 20 seg descanso ↓ 4 reps…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '3 rondas 10 Push-Ups 10 Knee Push-Ups 20 seg isometría en нижней точке Descanso: 45 seg.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING + GLUTE DENSITY', week_label_es = 'Mes 10 — LEVEL 10B — DENSITY SHOCK (Semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa: 3 seg desde arriba.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '14 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '30 por lado'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · LEVEL 10 — FINAL BOSS', week_label_es = 'Mes 10 — LEVEL 10B — DENSITY SHOCK (Semanas 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 por lado Si saltos realizar небезопасно:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Renegade Row Push-Up 4 × máximo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 45 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Максимальное cantidad de calidad rondas: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Пользователь фиксирует показатели cada semana.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'NEXT LEVEL'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE POWER', week_label_es = 'Mes 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 2 seg arriba → 2 seg mantenimiento → 3 seg abajo Último serie: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8–10 por pierna (Передняя pierna en/para pequeño superficie elevada. Ritmo: 3 seg abajo Último serie: +5 pulsos)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Pausa en нижней точке: 1 seg)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por pierna (Últimos 3 reps: Lento.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna (Pausa desde arriba: 2 seg)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 (Último serie: 25 normales 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 12 Hip Thrust 15 Bulgarian Pulses 20 Frog Pumps 20 Abduction 30 seg Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · UPPER BODY — STRENGTH', week_label_es = 'Mes 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Último serie: +5 parciales reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8–10 por brazo (Pausa: 2 seg en верхней точке)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12 (Si слишком тяжело: Normales flexión.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10–12 (Ritmo: 3 seg abajo)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Descanso: 60 seg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Superserie Dumbbell Curl 10–12 Overhead Triceps Extension 10–12 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Bíceps 10 normales 10 молотковых 10 parciales Tríceps 15 extensiones 15 pulsos 20 seg…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · HAMSTRING POWER', week_label_es = 'Mes 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 3 seg abajo)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '25 por lado (Últimos 10: короткая rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FULL BODY — POWER', week_label_es = 'Mes 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Semanas 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Dumbbell Thruster Squat Jump 4 × 8 Descanso: 90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 por pierna)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 por lado (Renegade Row Push-Up 4 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 40 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Cada minuto начинается новое ejercicio.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · GLUTE SHOCK', week_label_es = 'Mes 11 — LEVEL 11B — MUSCLE SHOCK (Semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Pausa: 3 seg desde arriba Último serie: 12 10 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Últimos 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Ritmo: 4 seg abajo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '30 (Últimos 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_es = '4 rondas 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · CALISTHENICS UPPER BODY', week_label_es = 'Mes 11 — LEVEL 11B — MUSCLE SHOCK (Semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8 por lado (Si тяжело: делать облегченный variante.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '8–10 por lado'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '8 reps ↓ 20 seg descanso ↓ 4 reps ↓ 20 seg descanso ↓ 4 reps 3 rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '10 reps ↓ 20 seg descanso ↓ 5 reps ↓ 20 seg descanso ↓ 5 reps 3 rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '3 rondas 10 Push-Ups 10 Knee Push-Ups 20 seg mantenimiento Descanso: 45 seg.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · POSTERIOR CHAIN SHOCK', week_label_es = 'Mes 11 — LEVEL 11B — MUSCLE SHOCK (Semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa: 3 seg desde arriba)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '30 por lado'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · LEVEL 11 — FINAL BOSS', week_label_es = 'Mes 11 — LEVEL 11B — MUSCLE SHOCK (Semanas 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 por lado Si saltos no подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10 (Renegade Row Push-Up 4 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 45 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Максимальное cantidad de calidad rondas: 12 Goblet Squats 10 Reverse Lunges 8…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Cada semana фиксируем: HIP THRUST / GLUTE BRIDGE Semana 41: кг Semana 42: кг…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Después este пользователь переходит en/para:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · FINAL GLUTE STRENGTH', week_label_es = 'Mes 12 — FINAL BUILD (semanas 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8 (Ritmo: 2 seg arriba → 2 seg mantenimiento → 3 seg abajo Último serie: 8 reps ↓ снизить…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '8–10 por pierna (Ritmo: 3 seg abajo Último serie: +5 pulsos)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '10–12 (Pausa: 2 seg abajo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10 por lado'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna (Últimos 3 reps: медленная негативная fase.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '25 (Último serie: 25 normales 20 pulsos 20 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '3 rondas 12 Hip Thrust 15 Bulgarian Lunges 20 Frog Pumps 20 Abduction 30 seg Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · FINAL UPPER BODY', week_label_es = 'Mes 12 — FINAL BUILD (semanas 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Último serie: +5 parciales reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 por brazo (Pausa desde arriba: 2 seg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–12 (Si тяжело: Normales flexión.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 (Ritmo: 3 seg abajo)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = 'Superserie Dumbbell Curl 12 Overhead Triceps Extension 12 4 rondas'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = 'Bíceps 10 normales 10 молотковых 10 parciales Tríceps 15 extensiones con banda elástica 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · FINAL POSTERIOR CHAIN', week_label_es = 'Mes 12 — FINAL BUILD (semanas 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '8–10 (Ritmo: 4 seg abajo)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Pausa: 3 seg desde arriba)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '20 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '30 por lado (Últimos 10: короткая rango de movimiento.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · FINAL POWER DAY', week_label_es = 'Mes 12 — FINAL BUILD (semanas 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '10 (Dumbbell Thruster Squat Jump 4 × 8 Descanso: 90 seg.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '10 (Dumbbell Sumo Deadlift Reverse Lunge + Knee Drive 4 × 10 por pierna)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8 por lado (Renegade Row Push-Up 4 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '20 (Dumbbell Swing Mountain Climbers 4 × 45 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = 'Минута 1 10 Goblet Squats Минута 2 12 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '4 rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '4 rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'Ahora completamente cambiamos ejercicio y характер carga.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Lunes · FINAL GLUTE SHOCK', week_label_es = 'Mes 12 — FINAL BOSS (semanas 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Pausa desde arriba: 3 seg Último serie: 12 15 pulsos 30 seg isometría.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_es = '10 por pierna (Últimos 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '12 (Ritmo: 4 seg abajo)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12 por pierna'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25 por pierna'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '25 por pierna'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Martes · FINAL CALISTHENICS', week_label_es = 'Mes 12 — FINAL BOSS (semanas 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '6–8 por lado (En необходимости: облегченный variante.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '8–10 por lado'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '10 por brazo'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_es = '4 rondas Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '8 reps ↓ 20 seg descanso ↓ 4 reps ↓ 20 seg descanso ↓ 4 reps 3 rondas'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = '10 reps ↓ 20 seg descanso ↓ 5 reps ↓ 20 seg descanso ↓ 5 reps 3 rondas'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '3 rondas 10 Push-Ups 10 Knee Push-Ups 20 seg mantenimiento Descanso: 45 seg.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Jueves · FINAL HAMSTRING SHOCK', week_label_es = 'Mes 12 — FINAL BOSS (semanas 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 por lado'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_es = '15 (Pausa: 3 seg desde arriba)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_es = '14 por pierna'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_es = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_es = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_es = '25 por lado'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_es = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_es = '4 rondas 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = '4 ejercicio por 60 seg, descanso 15 seg entre ejercicios., 60 seg entre rondas'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_es = 'Sábado · 🏆 FINAL BOSS — YEAR 1', week_label_es = 'Mes 12 — FINAL BOSS (semanas 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_es = '12 (Dumbbell Thruster Squat Jump 3 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_es = '15 (Dumbbell Sumo Deadlift Skater Jump 3 × 10 por lado Si saltos no подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_es = '10 por lado (Renegade Row Push-Up 3 × máximo de calidad reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_es = '25 (Dumbbell Swing Mountain Climbers 3 × 60 seg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_es = 'Realizar максимальное cantidad de calidad rondas: 10 Goblet Squats 10 Reverse Lunges…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_es = '5 Rondas 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 seg isometría…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_es = '5 Rondas cada ejercicio: 60 seg V-Ups Bicycle Mountain Climbers Hollow Hold Descanso:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_es = 'En al final 48- semanas пользователь сравнивает показатели con первым месяцем.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_es = 'Push-Ups Mes 1: Mes 12: AMRAP 20 MIN Mes 1: Rondas Mes 12: …'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_es = 'Comparar: Peso; объем бедер; объем ягодиц; объем талии; foto спереди; foto сбоку; foto…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_es = 'Ты прошла:'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
