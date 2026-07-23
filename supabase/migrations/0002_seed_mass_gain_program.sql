-- 0002_seed_mass_gain_program.sql
-- Первая программа тренировок: "Набор массы для начинающих" (мужчины, зал).
-- Предлагается всем новым пользователям с целью build_muscle на первый месяц.
-- Выполнить после 0001_init_schema.sql.

-- ---------------------------------------------------------------------------
-- 1. Упражнения (создаются один раз, переиспользуются в будущих программах)
-- ---------------------------------------------------------------------------
insert into public.exercises (slug, title, muscle_groups, difficulty, duration_seconds) values
  ('bench-press', 'Жим лёжа', array['chest','arms'], 'beginner', 60),
  ('incline-bench-press', 'Жим лёжа на наклонной скамье', array['chest','arms'], 'beginner', 60),
  ('cable-crossover', 'Кроссовер', array['chest'], 'beginner', 45),
  ('push-ups', 'Отжимания от пола', array['chest','arms'], 'beginner', 45),
  ('triceps-pushdown-standing', 'Тяга на трицепс у блока стоя', array['arms'], 'beginner', 45),
  ('triceps-extension-bench', 'Разгибание на трицепс с упором на скамью', array['arms'], 'beginner', 45),

  ('lat-pulldown-narrow', 'Тяга верхнего блока узким хватом', array['back','arms'], 'beginner', 60),
  ('lat-pulldown-reverse', 'Тяга верхнего блока к груди обратным хватом', array['back','arms'], 'beginner', 60),
  ('seated-cable-row', 'Тяга к поясу горизонтальная сидя', array['back'], 'beginner', 60),
  ('wide-grip-pull-up', 'Подтягивания широким хватом на турнике', array['back','arms'], 'intermediate', 45),
  ('incline-dumbbell-row', 'Тяга гантелей лёжа на наклонной скамье', array['back'], 'beginner', 60),
  ('cable-curl-medium-grip', 'Бицепс: тяга нижнего блока средним хватом', array['arms'], 'beginner', 45),
  ('standing-dumbbell-curl', 'Бицепс с гантелями стоя/сидя', array['arms'], 'beginner', 45),

  ('seated-leg-extension', 'Разгибание ног в тренажёре сидя', array['legs'], 'beginner', 60),
  ('bulgarian-split-squat', 'Болгарские выпады', array['legs'], 'intermediate', 60),
  ('lying-leg-curl', 'Сгибание ног (бицепс бедра) в тренажёре лёжа', array['legs'], 'beginner', 60),
  ('barbell-squat', 'Классические приседания', array['legs','full_body'], 'intermediate', 90),

  ('seated-dumbbell-press', 'Подъём гантелей сидя (жим)', array['shoulders'], 'beginner', 60),
  ('reverse-grip-dumbbell-press', 'Подъём гантелей обратным хватом', array['shoulders'], 'intermediate', 60),
  ('front-lateral-raise-superset', 'Подъём гантелей перед собой и в стороны (суперсет)', array['shoulders'], 'intermediate', 45),
  ('cable-rope-pullover', 'Пуловер на верхнем блоке с канатной рукоятью', array['back','shoulders'], 'intermediate', 45),
  ('bent-over-lateral-raise', 'Махи гантелями в наклоне', array['shoulders','back'], 'intermediate', 45),

  ('steady-cardio-15min', 'Кардио 15 минут (беговая дорожка / велотренажёр)', array['cardio'], 'beginner', 900),
  ('abs-crunches', 'Скручивания на пресс', array['core'], 'beginner', 45),
  ('leg-raises', 'Подъём ног лёжа/в висе', array['core'], 'beginner', 45)
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- 2. Программа
-- ---------------------------------------------------------------------------
insert into public.workout_programs
  (slug, title, description, goal, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
values (
  'nabor-massy-nachinayushchim',
  'Набор массы для начинающих',
  'Первая программа для мужчин, которые хотят начать набирать мышечную массу в зале. '
  || '7-дневный цикл: 4 силовые тренировки на разные группы мышц и 3 дня лёгкого кардио с прессом. '
  || 'Подходит новичкам — без сложной техники, акцент на объём и технику выполнения.',
  'build_muscle',
  'beginner',
  4,
  4,
  false, -- бесплатная: предлагается всем новым пользователям на первый месяц
  'ru'
)
on conflict (slug) do update set
  title = excluded.title,
  description = excluded.description,
  goal = excluded.goal,
  difficulty = excluded.difficulty,
  duration_weeks = excluded.duration_weeks,
  workouts_per_week = excluded.workouts_per_week,
  updated_at = now();

-- ---------------------------------------------------------------------------
-- 3. Тренировки (7 дней) + подходы
-- ---------------------------------------------------------------------------
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-nachinayushchim';

  -- Если тренировки для этой программы уже есть — не дублируем при повторном запуске.
  if exists (select 1 from public.workouts where program_id = v_program_id) then
    raise notice 'Тренировки для программы % уже существуют, пропускаем сид', v_program_id;
    return;
  end if;

  -- === День 1: Грудь, трицепс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 1 · Грудь и трицепс', 1, 60)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds)
  select v_workout_id, e.id, s.ord, s.reps, 90
  from (values
    ('bench-press', 1, 15),
    ('incline-bench-press', 2, 15),
    ('cable-crossover', 3, 20),
    ('push-ups', 4, 20),
    ('triceps-pushdown-standing', 5, 20),
    ('triceps-extension-bench', 6, 20)
  ) as s(slug, ord, reps)
  join public.exercises e on e.slug = s.slug;
  -- 3-4 подхода на упражнение: дублируем строки подходов по количеству сетов
  -- (жим лёжа/наклонный/отжимания — 3 подхода; кроссовер/трицепс — 4 подхода)

  -- === День 2: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 2 · Кардио + пресс', 2, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.ord, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 1, null::int, 900),
    ('abs-crunches', 2, 20, null::int),
    ('leg-raises', 3, 15, null::int)
  ) as s(slug, ord, reps, dur)
  join public.exercises e on e.slug = s.slug;

  -- === День 3: Спина и бицепс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 3 · Спина и бицепс', 3, 65)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds)
  select v_workout_id, e.id, s.ord, s.reps, 90
  from (values
    ('lat-pulldown-narrow', 1, 15),
    ('lat-pulldown-reverse', 2, 15),
    ('seated-cable-row', 3, 20),
    ('wide-grip-pull-up', 4, 10),
    ('incline-dumbbell-row', 5, 20),
    ('cable-curl-medium-grip', 6, 20),
    ('standing-dumbbell-curl', 7, 15)
  ) as s(slug, ord, reps)
  join public.exercises e on e.slug = s.slug;

  -- === День 4: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 4 · Кардио + пресс', 4, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.ord, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 1, null::int, 900),
    ('abs-crunches', 2, 20, null::int),
    ('leg-raises', 3, 15, null::int)
  ) as s(slug, ord, reps, dur)
  join public.exercises e on e.slug = s.slug;

  -- === День 5: Ноги ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 5 · Ноги', 5, 55)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds, notes)
  select v_workout_id, e.id, s.ord, s.reps, 90, s.notes
  from (values
    ('seated-leg-extension', 1, 25, null::text),
    ('bulgarian-split-squat', 2, 15, 'На каждую ногу'),
    ('lying-leg-curl', 3, 25, null::text),
    ('barbell-squat', 4, 20, null::text)
  ) as s(slug, ord, reps, notes)
  join public.exercises e on e.slug = s.slug;

  -- === День 6: Кардио + пресс ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 6 · Кардио + пресс', 6, 30)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds)
  select v_workout_id, e.id, s.ord, s.reps, s.dur, 45
  from (values
    ('steady-cardio-15min', 1, null::int, 900),
    ('abs-crunches', 2, 20, null::int),
    ('leg-raises', 3, 15, null::int)
  ) as s(slug, ord, reps, dur)
  join public.exercises e on e.slug = s.slug;

  -- === День 7: Плечи ===
  insert into public.workouts (program_id, title, "order", estimated_duration_minutes)
  values (v_program_id, 'День 7 · Плечи', 7, 50)
  returning id into v_workout_id;

  insert into public.workout_sets (workout_id, exercise_id, "order", reps, rest_seconds, notes)
  select v_workout_id, e.id, s.ord, s.reps, 75, s.notes
  from (values
    ('seated-dumbbell-press', 1, 10, null::text),
    ('reverse-grip-dumbbell-press', 2, 10, null::text),
    ('front-lateral-raise-superset', 3, 8, 'Суперсет: перед собой + в стороны, на каждую руку'),
    ('cable-rope-pullover', 4, 10, 'Суперсет с махами в наклоне'),
    ('bent-over-lateral-raise', 5, 10, 'Суперсет с пуловером на блоке')
  ) as s(slug, ord, reps, notes)
  join public.exercises e on e.slug = s.slug;

end $$;
