-- 0038_translate_nabor_massy_muzhchiny_zal.sql
-- Английский перевод: Набор массы — Мужчины — Зал
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0021).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (96), миграция падает с ошибкой вместо того, чтобы
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
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-muzhchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-muzhchiny-zal';
  end if;

  update public.workout_programs
  set title_en = 'Gain mass for men (gym) — year-long program', description_en = 'Gain mass for men (gym) — year-long program. Equipment: Full gain зала: Barbell, dumbbells, тренажёры, турник, канаты, TRX, kettlebell'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 1–2 — Фундамент'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'To failure'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'To failure'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 1–2 — Фундамент'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 52;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 1–2 — Фундамент'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 1–2 — Фундамент'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 3–4 — Фундамент (new cable)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 3–4 — Фундамент (new cable)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 3–4 — Фундамент (new cable)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'To failure'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 3–4 — Фундамент (new cable)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 5–6 — Наращивание mass'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 5–6 — Наращивание mass'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 5–6 — Наращивание mass'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'To failure'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 5–6 — Наращивание mass'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 7–8 — Калистеника and функционал'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 7–8 — Калистеника and функционал'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 7–8 — Калистеника and функционал'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 7–8 — Калистеника and функционал'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 9–10 — New stress: Strength + растяжение'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + ФУНКЦИОНАЛ', week_label_en = 'Weeks 9–10 — New stress: Strength + растяжение'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 9–10 — New stress: Strength + растяжение'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 9–10 — New stress: Strength + растяжение'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '30 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 11–12 — New stress: Completely new program'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 11–12 — New stress: Completely new program'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 11–12 — New stress: Completely new program'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'To failure'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 11–12 — New stress: Completely new program'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 13–14 — Strength + Mass: Heavy press'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 13–14 — Strength + Mass: Heavy press'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = '90 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 13–14 — Strength + Mass: Heavy press'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 13–14 — Strength + Mass: Heavy press'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 15–16 — Strength + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 15–16 — Strength + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 15–16 — Strength + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 15–16 — Strength + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps + ФУНКЦ. Finisher', week_label_en = 'Weeks 17–18 — Hypertrophy 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + АТЛЕТИКА', week_label_en = 'Weeks 17–18 — Hypertrophy 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 17–18 — Hypertrophy 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 17–18 — Hypertrophy 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 19–20 — Мышечная endurance'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 19–20 — Мышечная endurance'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 19–20 — Мышечная endurance'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 19–20 — Мышечная endurance'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 21–22 — Шоковая adaptation'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + ВЗРЫВНАЯ Work', week_label_en = 'Weeks 21–22 — Шоковая adaptation'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 21–22 — Шоковая adaptation'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 21–22 — Шоковая adaptation'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '40 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 23–24 — Атлетизм: Muscles как at спортсмена'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 23–24 — Атлетизм: Muscles как at спортсмена'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '24 шага'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 23–24 — Атлетизм: Muscles как at спортсмена'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 23–24 — Атлетизм: Muscles как at спортсмена'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 25–26 — Peak hypertrophy: максимальный volume chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 67;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 25–26 — Peak hypertrophy: максимальный volume chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 25–26 — Peak hypertrophy: максимальный volume chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Core/abs', week_label_en = 'Weeks 25–26 — Peak hypertrophy: максимальный volume chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 27–28 — Бодибилдинг + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 27–28 — Бодибилдинг + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 27–28 — Бодибилдинг + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 27–28 — Бодибилдинг + атлетизм'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps + Core/abs', week_label_en = 'Weeks 29–30 — Специализация: Upper body chest + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + ФУНКЦ. Strength', week_label_en = 'Weeks 29–30 — Специализация: Upper body chest + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 29–30 — Специализация: Upper body chest + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 29–30 — Специализация: Upper body chest + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '45 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 31–32 — Muscles + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 31–32 — Muscles + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '30 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 31–32 — Muscles + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 31–32 — Muscles + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 33–34 — Strength пик: Heavy weight + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 33–34 — Strength пик: Heavy weight + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 33–34 — Strength пик: Heavy weight + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '50 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 76;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 33–34 — Strength пик: Heavy weight + Volume'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 35–36 — Strength + тело атлета'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 35–36 — Strength + тело атлета'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '30 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 35–36 — Strength + тело атлета'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders', week_label_en = 'Weeks 35–36 — Strength + тело атлета'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'Weeks 37–38 — Upper body body 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + Core', week_label_en = 'Weeks 37–38 — Upper body body 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 37–38 — Upper body body 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Arms + Core/abs', week_label_en = 'Weeks 37–38 — Upper body body 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 16;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 39–40 — Памп + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 39–40 — Памп + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '30 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 39–40 — Памп + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Arms', week_label_en = 'Weeks 39–40 — Памп + Checkpoint body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 41–42 — PRO ATHLETE: Maximum strength chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 41–42 — PRO ATHLETE: Maximum strength chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 58;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 41–42 — PRO ATHLETE: Maximum strength chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_en = '60 метров'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 86;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Arms', week_label_en = 'Weeks 41–42 — PRO ATHLETE: Maximum strength chest'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Triceps', week_label_en = 'Weeks 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Arms', week_label_en = 'Weeks 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Shoulders + Triceps', week_label_en = 'Weeks 45–46 — 3D upper body body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'Min'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs + АТЛЕТИЗМ', week_label_en = 'Weeks 45–46 — 3D upper body body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 45–46 — 3D upper body body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Arms + Core', week_label_en = 'Weeks 45–46 — 3D upper body body'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Chest + Arms', week_label_en = 'Weeks 47–48 — FINAL BOSS: памп, рельеф, форма'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = 'Max.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · Legs', week_label_en = 'Weeks 47–48 — FINAL BOSS: памп, рельеф, форма'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '40 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 48;
    update public.workout_sets set notes_en = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Back + Biceps', week_label_en = 'Weeks 47–48 — FINAL BOSS: памп, рельеф, форма'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '100'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · Shoulders + Final ПАМП', week_label_en = 'Weeks 47–48 — FINAL BOSS: памп, рельеф, форма'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 20;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_en = 'Round'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  if v_updated_workouts <> 96 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-muzhchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 96, v_updated_workouts;
  end if;
end $$;
