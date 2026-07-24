-- 0003_fix_workout_sets_repeat.sql
-- Исправление: в 0002 каждое упражнение было записано ОДНОЙ строкой вместо
-- нескольких (например «жим лёжа 3×15» стало 1 строкой, а не 3).
-- Этот скрипт удаляет тренировки программы "Набор массы для начинающих"
-- и создаёт их заново — уже с правильным количеством подходов на упражнение.
-- Безопасно выполнять повторно.

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-nachinayushchim';

  if v_program_id is null then
    raise exception 'Программа nabor-massy-nachinayushchim не найдена — сначала выполните 0002_seed_mass_gain_program.sql';
  end if;

  -- Удаляем старые тренировки этой программы (каскадно удалит и workout_sets)
  delete from public.workouts where program_id = v_program_id;

  -- === День 1: Грудь, трицепс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 1 · Грудь и трицепс', 1, 60)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, 90
  from (values
    ('bench-press', 0, 15, 3),
    ('incline-bench-press', 10, 15, 3),
    ('cable-crossover', 20, 20, 4),
    ('push-ups', 30, 20, 3),
    ('triceps-pushdown-standing', 40, 20, 4),
    ('triceps-extension-bench', 50, 20, 4)
  ) as s(slug, base_order, reps, num_sets)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 2: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 2 · Кардио + пресс', 2, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 0, null::int, 900, 1),
    ('abs-crunches', 10, 20, null::int, 3),
    ('leg-raises', 20, 15, null::int, 3)
  ) as s(slug, base_order, reps, dur, num_sets)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 3: Спина и бицепс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 3 · Спина и бицепс', 3, 65)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, 90
  from (values
    ('lat-pulldown-narrow', 0, 15, 3),
    ('lat-pulldown-reverse', 10, 15, 3),
    ('seated-cable-row', 20, 20, 4),
    ('wide-grip-pull-up', 30, 10, 3),
    ('incline-dumbbell-row', 40, 20, 4),
    ('cable-curl-medium-grip', 50, 20, 4),
    ('standing-dumbbell-curl', 60, 15, 4)
  ) as s(slug, base_order, reps, num_sets)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 4: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 4 · Кардио + пресс', 4, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 0, null::int, 900, 1),
    ('abs-crunches', 10, 20, null::int, 3),
    ('leg-raises', 20, 15, null::int, 3)
  ) as s(slug, base_order, reps, dur, num_sets)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 5: Ноги ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 5 · Ноги', 5, 55)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, 90, s.notes
  from (values
    ('seated-leg-extension', 0, 25, 3, null::text),
    ('bulgarian-split-squat', 10, 15, 4, 'На каждую ногу'),
    ('lying-leg-curl', 20, 25, 3, null::text),
    ('barbell-squat', 30, 20, 4, null::text)
  ) as s(slug, base_order, reps, num_sets, notes)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 6: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 6 · Кардио + пресс', 6, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 0, null::int, 900, 1),
    ('abs-crunches', 10, 20, null::int, 3),
    ('leg-raises', 20, 15, null::int, 3)
  ) as s(slug, base_order, reps, dur, num_sets)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  -- === День 7: Плечи ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 7 · Плечи', 7, 50)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, 75, s.notes
  from (values
    ('seated-dumbbell-press', 0, 10, 3, null::text),
    ('reverse-grip-dumbbell-press', 10, 10, 3, null::text),
    ('front-lateral-raise-superset', 20, 8, 3, 'Суперсет: перед собой + в стороны, на каждую руку'),
    ('cable-rope-pullover', 30, 10, 4, 'Суперсет с махами в наклоне'),
    ('bent-over-lateral-raise', 40, 10, 4, 'Суперсет с пуловером на блоке')
  ) as s(slug, base_order, reps, num_sets, notes)
  join public.exercises e on e.slug = s.slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
