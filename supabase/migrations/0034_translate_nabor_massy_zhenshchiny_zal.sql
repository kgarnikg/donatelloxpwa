-- 0034_translate_nabor_massy_zhenshchiny_zal.sql
-- Английский перевод: Набор массы — Женщины — Зал
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0017).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (63), миграция падает с ошибкой вместо того, чтобы
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
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-zhenshchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-zhenshchiny-zal';
  end if;

  update public.workout_programs
  set title_en = 'Gain mass for women (gym) — year-long program «12 LEVELS»', description_en = 'Gain mass for women (gym) — year-long program «12 LEVELS». Equipment: Barbell, dumbbells, тренажёры (Hip Thrust, Hack Squat, Leg Press, блоки), resistance band, kettlebell, TRX, medicine ball'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + КВАДРИЦЕПС', week_label_en = 'Month 1 — ФУНДАМЕНТ — weeks 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10/leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders + Arms', week_label_en = 'Month 1 — ФУНДАМЕНТ — weeks 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Glutes + Rear Chain', week_label_en = 'Month 1 — ФУНДАМЕНТ — weeks 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12/leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15/leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Upper body + Glutes + CORE', week_label_en = 'Month 1 — ФУНДАМЕНТ — weeks 1–2'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 1 — ФУНДАМЕНТ (New СТИМУЛ) — weeks 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12/leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 1 — ФУНДАМЕНТ (New СТИМУЛ) — weeks 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 1 — ФУНДАМЕНТ (New СТИМУЛ) — weeks 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 1 — ФУНДАМЕНТ (New СТИМУЛ) — weeks 3–4'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + КВАДРИЦЕПС', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ — weeks 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '10.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ — weeks 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Glutes + Biceps Thighs', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ — weeks 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Upper body + Glutes', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ — weeks 5–6'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ (Hypertrophy + ФУНКЦИОНАЛ) — weeks 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ (Hypertrophy + ФУНКЦИОНАЛ) — weeks 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ (Hypertrophy + ФУНКЦИОНАЛ) — weeks 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 2 — НАРАЩИВАНИЕ МЫШЦ (Hypertrophy + ФУНКЦИОНАЛ) — weeks 7–8'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes', week_label_en = 'Month 3 — New Stress — weeks 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Back + Shoulders', week_label_en = 'Month 3 — New Stress — weeks 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN', week_label_en = 'Month 3 — New Stress — weeks 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Upper body + Glutes', week_label_en = 'Month 3 — New Stress — weeks 9–10'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 3 — New Stress — weeks 11–12'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 4 — Strength + Mass — weeks 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 4 — Strength + Mass — weeks 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 4 — Strength + Mass — weeks 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 4 — Strength + Mass — weeks 13–14'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 4 — Strength + Mass — weeks 15–16'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 5 — Hypertrophy 2.0 — weeks 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 5 — Hypertrophy 2.0 — weeks 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 5 — Hypertrophy 2.0 — weeks 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 5 — Hypertrophy 2.0 — weeks 17–18'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 5 — Hypertrophy 2.0 — weeks 19–20'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 6 — ШОКОВАЯ Adaptation — weeks 21–22'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_en = '4'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 6 — ШОКОВАЯ Adaptation — weeks 23–24'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '24'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + КВАДРИЦЕПС', week_label_en = 'Month 7 — Peak Hypertrophy + ФОРМА — weeks 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 67;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 7 — Peak Hypertrophy + ФОРМА — weeks 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 7 — Peak Hypertrophy + ФОРМА — weeks 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 7 — Peak Hypertrophy + ФОРМА — weeks 25–26'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · Focus Cable', week_label_en = 'Month 7 — Peak Hypertrophy + ФОРМА — weeks 27–28'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SPECIALIZATION', week_label_en = 'Month 8 — СПЕЦИАЛИЗАЦИЯ — weeks 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 8 — СПЕЦИАЛИЗАЦИЯ — weeks 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 8 — СПЕЦИАЛИЗАЦИЯ — weeks 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 8 — СПЕЦИАЛИЗАЦИЯ — weeks 29–30'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 8 — СПЕЦИАЛИЗАЦИЯ — weeks 31–32'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 + 10-секундная изометрия последнего повтора.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 9 — Strength ПИК — weeks 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 9 — Strength ПИК — weeks 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 9 — Strength ПИК — weeks 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 9 — Strength ПИК — weeks 33–34'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 9 — Strength ПИК — weeks 35–36'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 10 — Maximum Hypertrophy + ФОРМА — weeks 37–38'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '15–20.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 10 — Maximum Hypertrophy + ФОРМА — weeks 39–40'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '20.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Workout 1', week_label_en = 'Month 11 — Final Gain Mass + Strength — weeks 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '4–5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_en = '4–5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Workout 2', week_label_en = 'Month 11 — Final Gain Mass + Strength — weeks 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Workout 3', week_label_en = 'Month 11 — Final Gain Mass + Strength — weeks 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 11 — Final Gain Mass + Strength — weeks 41–42'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'All week · New gain exercises (all тренировочные days this cable)', week_label_en = 'Month 11 — Final Gain Mass + Strength — weeks 43–44'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE 3D', week_label_en = 'Month 12 — FINAL TRANSFORMATION — weeks 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER 3D', week_label_en = 'Month 12 — FINAL TRANSFORMATION — weeks 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE/HAMSTRING', week_label_en = 'Month 12 — FINAL TRANSFORMATION — weeks 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · Workout 4', week_label_en = 'Month 12 — FINAL TRANSFORMATION — weeks 45–46'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Exercise not детализированы тренером — используйте movements from соответствующего day previous cable for этой группы мышц'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes', week_label_en = 'Month 12 — FINAL TRANSFORMATION (FINAL BOSS) — weeks 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Upper body', week_label_en = 'Month 12 — FINAL TRANSFORMATION (FINAL BOSS) — weeks 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 40;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Legs + Glutes', week_label_en = 'Month 12 — FINAL TRANSFORMATION (FINAL BOSS) — weeks 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FINAL PUMP', week_label_en = 'Month 12 — FINAL TRANSFORMATION (FINAL BOSS) — weeks 47–48'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 20;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10 — through/every week снова 4×10».'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '15–20 min in week.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  if v_updated_workouts <> 63 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-zhenshchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 63, v_updated_workouts;
  end if;
end $$;
