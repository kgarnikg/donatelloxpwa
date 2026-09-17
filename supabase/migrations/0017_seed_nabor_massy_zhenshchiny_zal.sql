-- 0017_seed_nabor_massy_zhenshchiny_zal.sql
-- Программа: Набор массы — Женщины — Зал
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0017), по одной на каждую комбинацию
-- пол × цель × формат — см. 0016..0021 и журнал в PROJECT_PLAN.md.
--
-- 63 тренировок, 85 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Набор массы — Женщины — Зал)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('hip-thrust', 'Hip Thrust'),
  ('goblet-squat', 'Goblet Squat'),
  ('bulgarian-split-squat', 'Bulgarian Split Squat'),
  ('leg-press', 'Leg Press'),
  ('leg-extension', 'Leg Extension'),
  ('hip-abduction', 'Hip Abduction'),
  ('finisher-glute-bridge-2-30', 'Финишер: Glute Bridge 2×30'),
  ('lat-pulldown', 'Lat Pulldown'),
  ('seated-cable-row', 'Seated Cable Row'),
  ('one-arm-dumbbell-row', 'One Arm Dumbbell Row'),
  ('dumbbell-shoulder-press', 'Dumbbell Shoulder Press'),
  ('lateral-raise', 'Lateral Raise'),
  ('cable-biceps-curl', 'Cable Biceps Curl'),
  ('rope-triceps-extension', 'Rope Triceps Extension'),
  ('romanian-deadlift', 'Romanian Deadlift'),
  ('reverse-lunges', 'Reverse Lunges'),
  ('lying-leg-curl', 'Lying Leg Curl'),
  ('cable-kickback', 'Cable Kickback'),
  ('finisher-frog-pumps-2-30', 'Финишер: Frog Pumps 2×30'),
  ('incline-dumbbell-press', 'Incline Dumbbell Press'),
  ('seated-row', 'Seated Row'),
  ('glute-bridge', 'Glute Bridge'),
  ('face-pull', 'Face Pull'),
  ('core-3-4-kruga-dead-bug-plank-reverse-crunch-bird-dog', 'Core — 3–4 круга: Dead Bug, Plank, Reverse Crunch, Bird Dog'),
  ('hack-squat', 'Hack Squat'),
  ('smith-hip-thrust', 'Smith Hip Thrust'),
  ('walking-lunges', 'Walking Lunges'),
  ('abduction-machine', 'Abduction Machine'),
  ('finisher-step-up', 'Финишер: Step-Up'),
  ('assisted-pull-up', 'Assisted Pull-Up'),
  ('chest-supported-row', 'Chest Supported Row'),
  ('single-arm-pulldown', 'Single Arm Pulldown'),
  ('arnold-press', 'Arnold Press'),
  ('cable-lateral-raise', 'Cable Lateral Raise'),
  ('dumbbell-curl', 'Dumbbell Curl'),
  ('rope-extension', 'Rope Extension'),
  ('smith-glute-bridge', 'Smith Glute Bridge'),
  ('reverse-lunge', 'Reverse Lunge'),
  ('seated-leg-curl', 'Seated Leg Curl'),
  ('abduction', 'Abduction'),
  ('finisher-frog-pumps-3-25', 'Финишер: Frog Pumps 3×25'),
  ('incline-press', 'Incline Press'),
  ('cable-row', 'Cable Row'),
  ('barbell-hip-thrust', 'Barbell Hip Thrust'),
  ('posledniy-podhod-abduction-chastichnye', 'Последний подход Abduction — частичные'),
  ('t-bar-row', 'T-Bar Row'),
  ('rear-delt-fly', 'Rear Delt Fly'),
  ('single-arm-row', 'Single Arm Row'),
  ('rear-delt', 'Rear Delt'),
  ('leg-curl', 'Leg Curl'),
  ('trenirovka-4', 'Тренировка 4'),
  ('kickback', 'Kickback'),
  ('finisher-20-step-ups-20-bodyweight-squats-3', 'Финишер: 20 Step-Ups + 20 Bodyweight Squats ×3.'),
  ('front-squat', 'Front Squat'),
  ('back-squat', 'Back Squat'),
  ('pull-up-assisted', 'Pull-Up/Assisted'),
  ('shoulder-press', 'Shoulder Press'),
  ('trap-bar-deadlift', 'Trap Bar Deadlift'),
  ('bulgarian', 'Bulgarian'),
  ('rdl', 'RDL'),
  ('kettlebell-swing', 'Kettlebell Swing'),
  ('4', '4'),
  ('20-20', '20 + 20'),
  ('3', '3'),
  ('trenirovka-2', 'Тренировка 2'),
  ('trenirovka-3', 'Тренировка 3'),
  ('plechi-ruki-yagodichnyy-pamp', 'Плечи + руки + ягодичный памп.'),
  ('bodybuilding-athletic-glavnyy-aktsent-yagoditsy-bokovye-delty-spina-345120', 'Bodybuilding + Athletic Главный акцент: ягодицы; боковые дельты; спина; задняя поверхность бедра. FST-7 переносим на ягодичный тренажёр/abduction.'),
  ('abduction-partial', 'Abduction partial —'),
  ('back-shoulders-specialization', 'Back + Shoulders Specialization.'),
  ('squat', 'Squat'),
  ('rdl-hip-thrust-lunges-leg-curl', 'RDL + Hip Thrust + Lunges + Leg Curl.'),
  ('nordic-curl', 'Nordic Curl'),
  ('bodyweight-squat', 'Bodyweight Squat'),
  ('fst-7-abduction', 'FST-7 Abduction'),
  ('abduction-7', 'Abduction: 7'),
  ('pull-up', 'Pull-Up'),
  ('good-morning', 'Good Morning'),
  ('gigantskiy-set-abduction-20-kickback-15-glute-bridge-20-bodyweight-b933db', 'Гигантский сет: Abduction ×20, Kickback ×15, Glute Bridge ×20, Bodyweight Squat ×15'),
  ('upper-3d', 'Upper 3D'),
  ('plechi-ruki-core-glute-pump', 'Плечи + руки + Core + Glute Pump.'),
  ('row', 'Row'),
  ('gigantskiy-set-biceps-10-hammer-12-triceps-15', 'Гигантский сет: Biceps ×10, Hammer ×12, Triceps ×15'),
  ('segodnya-sdelala-4', '«Сегодня сделала 4'),
  ('i-esche-kardio-ya-by-ne-stavil-posle-kazhdoy-trenirovki-kak-56b701', 'И ещё: кардио я бы не ставил после каждой тренировки как обязательное условие для набора массы. В исходнике оно присутствует практически постоянно; например, в первом месяце — 10–15 минут после каждой тренировки. Для набора мышц девушке важнее восстановление и профицит калорий, поэтому кардио здесь лучше использовать умеренно — например, 2')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Набор массы — Женщины — Зал)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('nabor-massy-zhenshchiny-zal', 'Набор массы для женщин (зал) — годовая программа «12 LEVELS»', 'Набор массы для женщин (зал) — годовая программа «12 LEVELS». Оборудование: Штанга, гантели, тренажёры (Hip Thrust, Hack Squat, Leg Press, блоки), резинки, гири, TRX, медбол', 'build_muscle', 'female', 'gym', 'intermediate', 48, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + КВАДРИЦЕПС', 1, 'МЕСЯЦ 1 — ФУНДАМЕНТ — недели 1–2', 1, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 12, null::int, 60, 4, '12'),
    ('goblet-squat', 10, 10, null::int, 60, 4, '10–12'),
    ('bulgarian-split-squat', 20, 10, null::int, 60, 3, '10/нога'),
    ('leg-press', 30, 12, null::int, 60, 3, '12'),
    ('leg-extension', 40, 15, null::int, 60, 3, '15'),
    ('hip-abduction', 50, 15, null::int, 60, 4, '15–20'),
    ('finisher-glute-bridge-2-30', 60, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'МЕСЯЦ 1 — ФУНДАМЕНТ — недели 1–2', 1, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('lat-pulldown', 0, 12, null::int, 60, 4, '12'),
    ('seated-cable-row', 10, 12, null::int, 60, 4, '12'),
    ('one-arm-dumbbell-row', 20, 12, null::int, 60, 3, '12'),
    ('dumbbell-shoulder-press', 30, 10, null::int, 60, 3, '10'),
    ('lateral-raise', 40, 15, null::int, 60, 4, '15'),
    ('cable-biceps-curl', 50, 12, null::int, 60, 3, '12'),
    ('rope-triceps-extension', 60, 15, null::int, 60, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ', 3, 'МЕСЯЦ 1 — ФУНДАМЕНТ — недели 1–2', 1, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 10, null::int, 60, 4, '10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunges', 20, 12, null::int, 60, 3, '12/нога'),
    ('lying-leg-curl', 30, 12, null::int, 60, 4, '12'),
    ('cable-kickback', 40, 15, null::int, 60, 3, '15/нога'),
    ('hip-abduction', 50, 20, null::int, 60, 4, '20'),
    ('finisher-frog-pumps-2-30', 60, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ВЕРХ + ЯГОДИЦЫ + CORE', 4, 'МЕСЯЦ 1 — ФУНДАМЕНТ — недели 1–2', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('incline-dumbbell-press', 0, 10, null::int, 60, 3, '10'),
    ('lat-pulldown', 10, 12, null::int, 60, 3, '12'),
    ('seated-row', 20, 12, null::int, 60, 3, '12'),
    ('lateral-raise', 30, 15, null::int, 60, 4, '15'),
    ('glute-bridge', 40, 15, null::int, 60, 4, '15'),
    ('cable-kickback', 50, 15, null::int, 60, 3, '15'),
    ('face-pull', 60, 15, null::int, 60, 3, '15'),
    ('core-3-4-kruga-dead-bug-plank-reverse-crunch-bird-dog', 70, null::int, null::int, 60, 1, 'отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 1 — ФУНДАМЕНТ (НОВЫЙ СТИМУЛ) — недели 3–4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hack-squat', 0, 10, null::int, 60, 4, '10'),
    ('smith-hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('walking-lunges', 20, 12, null::int, 60, 3, '12/нога'),
    ('leg-press', 30, 15, null::int, 60, 3, '15'),
    ('leg-extension', 40, 15, null::int, 60, 3, '15'),
    ('abduction-machine', 50, 20, null::int, 60, 4, '20'),
    ('finisher-step-up', 60, 12, null::int, 60, 3, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 1 — ФУНДАМЕНТ (НОВЫЙ СТИМУЛ) — недели 3–4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('assisted-pull-up', 0, 10, null::int, 60, 4, '10'),
    ('chest-supported-row', 10, 12, null::int, 60, 4, '12'),
    ('single-arm-pulldown', 20, 12, null::int, 60, 3, '12'),
    ('arnold-press', 30, 10, null::int, 60, 3, '10'),
    ('cable-lateral-raise', 40, 15, null::int, 60, 4, '15'),
    ('dumbbell-curl', 50, 12, null::int, 60, 3, '12'),
    ('rope-extension', 60, 15, null::int, 60, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 1 — ФУНДАМЕНТ (НОВЫЙ СТИМУЛ) — недели 3–4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 10, null::int, 60, 4, '10'),
    ('smith-glute-bridge', 10, 12, null::int, 60, 4, '12'),
    ('reverse-lunge', 20, 12, null::int, 60, 3, '12'),
    ('seated-leg-curl', 30, 12, null::int, 60, 4, '12'),
    ('cable-kickback', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 20, null::int, 60, 3, '20'),
    ('finisher-frog-pumps-3-25', 60, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 1 — ФУНДАМЕНТ (НОВЫЙ СТИМУЛ) — недели 3–4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('incline-press', 0, 10, null::int, 60, 3, '10'),
    ('cable-row', 10, 12, null::int, 60, 3, '12'),
    ('lat-pulldown', 20, 12, null::int, 60, 3, '12'),
    ('lateral-raise', 30, 15, null::int, 60, 4, '15'),
    ('hip-thrust', 40, 15, null::int, 60, 3, '15'),
    ('abduction', 50, 20, null::int, 60, 3, '20'),
    ('face-pull', 60, 15, null::int, 60, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + КВАДРИЦЕПС', 1, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ — недели 5–6', 3, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('barbell-hip-thrust', 0, 8, null::int, 60, 4, '8–10'),
    ('hack-squat', 10, 10, null::int, 60, 4, '10'),
    ('bulgarian-split-squat', 20, 10, null::int, 60, 4, '10'),
    ('leg-press', 30, 12, null::int, 60, 4, '12'),
    ('leg-extension', 40, 15, null::int, 60, 3, '15'),
    ('abduction', 50, 20, null::int, 60, 4, '20'),
    ('posledniy-podhod-abduction-chastichnye', 60, 10, null::int, 60, 1, '10.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ', 2, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ — недели 5–6', 3, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('t-bar-row', 0, 10, null::int, 60, 4, '10'),
    ('lat-pulldown', 10, 12, null::int, 60, 3, '12'),
    ('arnold-press', 20, 10, null::int, 60, 4, '10'),
    ('lateral-raise', 30, 15, null::int, 60, 4, '15'),
    ('rear-delt-fly', 40, 15, null::int, 60, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ЯГОДИЦЫ + БИЦЕПС БЕДРА', 3, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ — недели 5–6', 3, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 8, null::int, 60, 4, '8–10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge', 20, 10, null::int, 60, 4, '10'),
    ('seated-leg-curl', 30, 12, null::int, 60, 4, '12'),
    ('cable-kickback', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 15, null::int, 60, 5, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ВЕРХ + ЯГОДИЦЫ', 4, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ — недели 5–6', 3, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('incline-dumbbell-press', 0, 10, null::int, 60, 4, '10'),
    ('seated-cable-row', 10, 10, null::int, 60, 4, '10'),
    ('lat-pulldown', 20, 12, null::int, 60, 3, '12'),
    ('lateral-raise', 30, 15, null::int, 60, 5, '15'),
    ('hip-thrust', 40, 12, null::int, 60, 3, '12'),
    ('cable-kickback', 50, 15, null::int, 60, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ (ГИПЕРТРОФИЯ + ФУНКЦИОНАЛ) — недели 7–8', 4, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 4, '8–10'),
    ('bulgarian-split-squat', 10, 12, null::int, 60, 3, '12'),
    ('leg-extension', 20, 15, null::int, 60, 3, '15'),
    ('walking-lunges', 30, 20, null::int, 60, 3, '20 шагов')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ (ГИПЕРТРОФИЯ + ФУНКЦИОНАЛ) — недели 7–8', 4, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('lat-pulldown', 0, 10, null::int, 60, 4, '10'),
    ('chest-supported-row', 10, 10, null::int, 60, 4, '10'),
    ('single-arm-row', 20, 12, null::int, 60, 3, '12'),
    ('arnold-press', 30, 10, null::int, 60, 4, '10'),
    ('lateral-raise', 40, 15, null::int, 60, 5, '15'),
    ('rear-delt', 50, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ (ГИПЕРТРОФИЯ + ФУНКЦИОНАЛ) — недели 7–8', 4, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 10, null::int, 60, 4, '10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('leg-curl', 20, 12, null::int, 60, 4, '12'),
    ('reverse-lunge', 30, 12, null::int, 60, 3, '12'),
    ('cable-kickback', 40, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 2 — НАРАЩИВАНИЕ МЫШЦ (ГИПЕРТРОФИЯ + ФУНКЦИОНАЛ) — недели 7–8', 4, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ', 1, 'МЕСЯЦ 3 — НОВЫЙ СТРЕСС — недели 9–10', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 4, '8–10'),
    ('hack-squat', 10, 10, null::int, 60, 4, '10'),
    ('bulgarian-split-squat', 20, 12, null::int, 60, 3, '12'),
    ('leg-press', 30, 12, null::int, 60, 4, '12'),
    ('abduction', 40, 15, null::int, 60, 4, '15'),
    ('kickback', 50, 15, null::int, 60, 3, '15'),
    ('finisher-20-step-ups-20-bodyweight-squats-3', 60, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ', 2, 'МЕСЯЦ 3 — НОВЫЙ СТРЕСС — недели 9–10', 5, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('t-bar-row', 0, 10, null::int, 60, 4, '10'),
    ('lat-pulldown', 10, 12, null::int, 60, 4, '12'),
    ('arnold-press', 20, 10, null::int, 60, 4, '10'),
    ('lateral-raise', 30, 15, null::int, 60, 5, '15'),
    ('face-pull', 40, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN', 3, 'МЕСЯЦ 3 — НОВЫЙ СТРЕСС — недели 9–10', 5, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 10, null::int, 60, 4, '10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge', 20, 12, null::int, 60, 3, '12'),
    ('leg-curl', 30, 12, null::int, 60, 4, '12'),
    ('kickback', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 20, null::int, 60, 4, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ВЕРХ + ЯГОДИЦЫ', 4, 'МЕСЯЦ 3 — НОВЫЙ СТРЕСС — недели 9–10', 5, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('incline-press', 0, 10, null::int, 60, 1, '10'),
    ('cable-row', 10, 12, null::int, 60, 1, '12'),
    ('lateral-raise', 20, 15, null::int, 60, 1, '15'),
    ('face-pull', 30, 15, null::int, 60, 1, '15'),
    ('glute-bridge', 40, 15, null::int, 60, 1, '15'),
    ('abduction', 50, 20, null::int, 60, 1, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 3 — НОВЫЙ СТРЕСС — недели 11–12', 6, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('smith-hip-thrust', 0, 8, null::int, 60, 5, '8'),
    ('front-squat', 10, 8, null::int, 60, 4, '8'),
    ('romanian-deadlift', 20, 8, null::int, 60, 4, '8'),
    ('walking-lunges', 30, 20, null::int, 60, 4, '20'),
    ('leg-curl', 40, 12, null::int, 60, 4, '12'),
    ('abduction', 50, 15, null::int, 60, 5, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 4 — СИЛА + МАССА — недели 13–14', 7, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('barbell-hip-thrust', 0, 6, null::int, 60, 5, '6–8'),
    ('back-squat', 10, 6, null::int, 60, 5, '6–8'),
    ('bulgarian-split-squat', 20, 8, null::int, 60, 4, '8'),
    ('leg-press', 30, 10, null::int, 60, 4, '10'),
    ('leg-extension', 40, 12, null::int, 60, 3, '12'),
    ('abduction', 50, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 4 — СИЛА + МАССА — недели 13–14', 7, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('pull-up-assisted', 0, 6, null::int, 60, 5, '6–8'),
    ('t-bar-row', 10, 8, null::int, 60, 5, '8'),
    ('lat-pulldown', 20, 10, null::int, 60, 4, '10'),
    ('shoulder-press', 30, 8, null::int, 60, 4, '8'),
    ('lateral-raise', 40, 12, null::int, 60, 5, '12'),
    ('rear-delt', 50, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 4 — СИЛА + МАССА — недели 13–14', 7, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 6, null::int, 60, 5, '6–8'),
    ('hip-thrust', 10, 8, null::int, 60, 4, '8'),
    ('reverse-lunge', 20, 8, null::int, 60, 4, '8'),
    ('leg-curl', 30, 10, null::int, 60, 4, '10'),
    ('kickback', 40, 12, null::int, 60, 4, '12'),
    ('abduction', 50, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 4 — СИЛА + МАССА — недели 13–14', 7, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 4 — СИЛА + МАССА — недели 15–16', 8, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 6, null::int, 60, 5, '6'),
    ('hip-thrust', 10, 6, null::int, 60, 5, '6'),
    ('trap-bar-deadlift', 20, 6, null::int, 60, 4, '6–8'),
    ('walking-lunges', 30, 20, null::int, 60, 4, '20'),
    ('leg-curl', 40, 10, null::int, 60, 4, '10'),
    ('abduction', 50, 15, null::int, 60, 5, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 5 — ГИПЕРТРОФИЯ 2.0 — недели 17–18', 9, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 4, '8–10'),
    ('hack-squat', 10, 10, null::int, 60, 4, '10'),
    ('bulgarian', 20, 12, null::int, 60, 4, '12'),
    ('leg-extension', 30, 15, null::int, 60, 1, '15'),
    ('leg-curl', 40, 15, null::int, 60, 1, '15'),
    ('abduction', 50, 20, null::int, 60, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 5 — ГИПЕРТРОФИЯ 2.0 — недели 17–18', 9, 52)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('t-bar-row', 0, 10, null::int, 60, 4, '10'),
    ('lat-pulldown', 10, 12, null::int, 60, 4, '12'),
    ('rear-delt', 20, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 5 — ГИПЕРТРОФИЯ 2.0 — недели 17–18', 9, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rdl', 0, 10, null::int, 60, 4, '10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge', 20, 12, null::int, 60, 4, '12'),
    ('leg-curl', 30, 15, null::int, 60, 4, '15'),
    ('kickback', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 20, null::int, 60, 4, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 5 — ГИПЕРТРОФИЯ 2.0 — недели 17–18', 9, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 5 — ГИПЕРТРОФИЯ 2.0 — недели 19–20', 10, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trap-bar-deadlift', 0, 6, null::int, 60, 5, '6'),
    ('front-squat', 10, 8, null::int, 60, 4, '8'),
    ('walking-lunges', 20, 20, null::int, 60, 4, '20'),
    ('kettlebell-swing', 30, 15, null::int, 60, 4, '15'),
    ('hip-thrust', 40, 10, null::int, 60, 4, '10'),
    ('abduction', 50, 20, null::int, 60, 4, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 6 — ШОКОВАЯ АДАПТАЦИЯ — недели 21–22', 11, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('4', 0, 8, null::int, 60, 1, '8'),
    ('4', 10, 10, null::int, 60, 1, '10'),
    ('4', 20, 10, null::int, 60, 1, '10'),
    ('20-20', 30, 4, null::int, 60, 1, '4'),
    ('4', 40, 12, null::int, 60, 1, '12'),
    ('3', 50, 15, null::int, 60, 1, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 6 — ШОКОВАЯ АДАПТАЦИЯ — недели 23–24', 12, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trap-bar-deadlift', 0, 5, null::int, 60, 5, '5'),
    ('hip-thrust', 10, 8, null::int, 60, 4, '8'),
    ('hack-squat', 20, 10, null::int, 60, 4, '10'),
    ('walking-lunges', 30, 24, null::int, 60, 4, '24'),
    ('kettlebell-swing', 40, 20, null::int, 60, 4, '20'),
    ('abduction', 50, 20, null::int, 60, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + КВАДРИЦЕПС', 1, 'МЕСЯЦ 7 — ПИКОВАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 25–26', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 10, null::int, 60, 4, '10'),
    ('hack-squat', 10, 10, null::int, 60, 4, '10'),
    ('bulgarian', 20, 12, null::int, 60, 4, '12'),
    ('leg-press', 30, 15, null::int, 60, 4, '15'),
    ('leg-extension', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 20, null::int, 60, 4, '20'),
    ('abduction', 60, 15, null::int, 60, 7, '15–20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 7 — ПИКОВАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 25–26', 13, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-2', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 7 — ПИКОВАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 25–26', 13, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-3', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 7 — ПИКОВАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 25–26', 13, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('plechi-ruki-yagodichnyy-pamp', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · ФОКУС БЛОКА', 1, 'МЕСЯЦ 7 — ПИКОВАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 27–28', 14, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bodybuilding-athletic-glavnyy-aktsent-yagoditsy-bokovye-delty-spina-345120', 0, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SPECIALIZATION', 1, 'МЕСЯЦ 8 — СПЕЦИАЛИЗАЦИЯ — недели 29–30', 15, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 5, '8–10'),
    ('bulgarian', 10, 10, null::int, 60, 4, '10'),
    ('leg-press', 20, 12, null::int, 60, 4, '12'),
    ('cable-kickback', 30, 15, null::int, 60, 4, '15'),
    ('abduction', 40, 15, null::int, 60, 5, '15'),
    ('abduction-partial', 50, 20, null::int, 60, 1, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 8 — СПЕЦИАЛИЗАЦИЯ — недели 29–30', 15, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('back-shoulders-specialization', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 8 — СПЕЦИАЛИЗАЦИЯ — недели 29–30', 15, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-3', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 8 — СПЕЦИАЛИЗАЦИЯ — недели 29–30', 15, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 8 — СПЕЦИАЛИЗАЦИЯ — недели 31–32', 16, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 10, null::int, 60, 4, '10 + 10-секундная изометрия последнего повтора.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 9 — СИЛОВОЙ ПИК — недели 33–34', 17, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 5, null::int, 60, 5, '5'),
    ('squat', 10, 5, null::int, 60, 5, '5'),
    ('bulgarian', 20, 8, null::int, 60, 4, '8'),
    ('leg-press', 30, 10, null::int, 60, 4, '10'),
    ('leg-curl', 40, 10, null::int, 60, 4, '10'),
    ('abduction', 50, 15, null::int, 60, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 9 — СИЛОВОЙ ПИК — недели 33–34', 17, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('pull-up-assisted', 0, 5, null::int, 60, 5, '5–8'),
    ('t-bar-row', 10, 6, null::int, 60, 5, '6–8'),
    ('lat-pulldown', 20, 10, null::int, 60, 4, '10'),
    ('shoulder-press', 30, 6, null::int, 60, 5, '6'),
    ('lateral-raise', 40, 12, null::int, 60, 5, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 9 — СИЛОВОЙ ПИК — недели 33–34', 17, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rdl-hip-thrust-lunges-leg-curl', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 9 — СИЛОВОЙ ПИК — недели 33–34', 17, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 9 — СИЛОВОЙ ПИК — недели 35–36', 18, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 5, null::int, 60, 5, '5'),
    ('trap-bar-deadlift', 10, 5, null::int, 60, 5, '5'),
    ('hip-thrust', 20, 8, null::int, 60, 4, '8'),
    ('walking-lunges', 30, 30, null::int, 60, 4, '30'),
    ('nordic-curl', 40, 6, null::int, 60, 3, '6–8'),
    ('abduction', 50, 20, null::int, 60, 4, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 10 — МАКСИМАЛЬНАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 37–38', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 5, '8–10'),
    ('hack-squat', 10, 10, null::int, 60, 4, '10'),
    ('bulgarian', 20, 12, null::int, 60, 4, '12'),
    ('leg-press', 30, 15, null::int, 60, 4, '15'),
    ('leg-extension', 40, 15, null::int, 60, 1, '15'),
    ('abduction', 50, 20, null::int, 60, 1, '20'),
    ('bodyweight-squat', 60, 15, null::int, 60, 1, '15'),
    ('fst-7-abduction', 70, 15, null::int, 60, 7, '15–20.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 10 — МАКСИМАЛЬНАЯ ГИПЕРТРОФИЯ + ФОРМА — недели 39–40', 20, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('abduction-7', 0, 20, null::int, 60, 1, '20.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ТРЕНИРОВКА 1', 1, 'МЕСЯЦ 11 — ФИНАЛЬНЫЙ НАБОР МАССЫ + СИЛА — недели 41–42', 21, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 4, null::int, 60, 6, '4–5'),
    ('squat', 10, 4, null::int, 60, 5, '4–5'),
    ('bulgarian', 20, 8, null::int, 60, 4, '8'),
    ('leg-press', 30, 10, null::int, 60, 5, '10'),
    ('leg-curl', 40, 12, null::int, 60, 5, '12'),
    ('abduction', 50, 15, null::int, 60, 5, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ТРЕНИРОВКА 2', 2, 'МЕСЯЦ 11 — ФИНАЛЬНЫЙ НАБОР МАССЫ + СИЛА — недели 41–42', 21, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('pull-up', 0, 5, null::int, 60, 5, '5'),
    ('t-bar-row', 10, 6, null::int, 60, 5, '6'),
    ('lat-pulldown', 20, 10, null::int, 60, 4, '10'),
    ('shoulder-press', 30, 5, null::int, 60, 5, '5'),
    ('lateral-raise', 40, 12, null::int, 60, 6, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ТРЕНИРОВКА 3', 3, 'МЕСЯЦ 11 — ФИНАЛЬНЫЙ НАБОР МАССЫ + СИЛА — недели 41–42', 21, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rdl', 0, 6, null::int, 60, 5, '6'),
    ('hip-thrust', 10, 6, null::int, 60, 5, '6'),
    ('reverse-lunge', 20, 8, null::int, 60, 4, '8'),
    ('leg-curl', 30, 10, null::int, 60, 5, '10'),
    ('kickback', 40, 12, null::int, 60, 4, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 11 — ФИНАЛЬНЫЙ НАБОР МАССЫ + СИЛА — недели 41–42', 21, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trenirovka-4', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вся неделя · Новый набор упражнений (все тренировочные дни этого блока)', 1, 'МЕСЯЦ 11 — ФИНАЛЬНЫЙ НАБОР МАССЫ + СИЛА — недели 43–44', 22, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('smith-hip-thrust', 0, 6, null::int, 60, 5, '6'),
    ('front-squat', 10, 8, null::int, 60, 5, '8'),
    ('hack-squat', 20, 10, null::int, 60, 5, '10'),
    ('reverse-lunges', 30, 12, null::int, 60, 4, '12'),
    ('good-morning', 40, 10, null::int, 60, 3, '10'),
    ('seated-leg-curl', 50, 12, null::int, 60, 5, '12'),
    ('abduction', 60, 15, null::int, 60, 6, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE 3D', 1, 'МЕСЯЦ 12 — FINAL TRANSFORMATION — недели 45–46', 23, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 8, null::int, 60, 4, '8'),
    ('squat', 10, 8, null::int, 60, 4, '8'),
    ('bulgarian', 20, 10, null::int, 60, 4, '10'),
    ('leg-press', 30, 15, null::int, 60, 4, '15'),
    ('gigantskiy-set-abduction-20-kickback-15-glute-bridge-20-bodyweight-b933db', 40, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER 3D', 2, 'МЕСЯЦ 12 — FINAL TRANSFORMATION — недели 45–46', 23, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('upper-3d', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE/HAMSTRING', 3, 'МЕСЯЦ 12 — FINAL TRANSFORMATION — недели 45–46', 23, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rdl', 0, 10, null::int, 60, 4, '10'),
    ('hip-thrust', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge', 20, 12, null::int, 60, 4, '12'),
    ('leg-curl', 30, 15, null::int, 60, 4, '15'),
    ('kickback', 40, 15, null::int, 60, 4, '15'),
    ('abduction', 50, 20, null::int, 60, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ТРЕНИРОВКА 4', 4, 'МЕСЯЦ 12 — FINAL TRANSFORMATION — недели 45–46', 23, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('plechi-ruki-core-glute-pump', 0, null::int, null::int, 60, 1, 'Упражнения не детализированы тренером — используйте движения из соответствующего дня предыдущего блока для этой группы мышц')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ', 1, 'МЕСЯЦ 12 — FINAL TRANSFORMATION (FINAL BOSS) — недели 47–48', 24, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust', 0, 12, null::int, 60, 4, '12'),
    ('hack-squat', 10, 12, null::int, 60, 4, '12'),
    ('bulgarian', 20, 12, null::int, 60, 4, '12'),
    ('leg-press', 30, 15, null::int, 60, 4, '15'),
    ('abduction', 40, 20, null::int, 60, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ВЕРХ', 2, 'МЕСЯЦ 12 — FINAL TRANSFORMATION (FINAL BOSS) — недели 47–48', 24, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('lat-pulldown', 0, 12, null::int, 60, 4, '12'),
    ('row', 10, 12, null::int, 60, 4, '12'),
    ('single-arm-pulldown', 20, 15, null::int, 60, 3, '15'),
    ('lateral-raise', 30, 10, null::int, 60, 10, '10'),
    ('rear-delt', 40, 20, null::int, 60, 5, '20'),
    ('gigantskiy-set-biceps-10-hammer-12-triceps-15', 50, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'МЕСЯЦ 12 — FINAL TRANSFORMATION (FINAL BOSS) — недели 47–48', 24, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 8, null::int, 60, 4, '8'),
    ('hack-squat', 10, 12, null::int, 60, 4, '12'),
    ('walking-lunges', 20, 30, null::int, 60, 4, '30'),
    ('leg-curl', 30, 15, null::int, 60, 5, '15'),
    ('hip-thrust', 40, 12, null::int, 60, 4, '12'),
    ('abduction', 50, 20, null::int, 60, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FINAL PUMP', 4, 'МЕСЯЦ 12 — FINAL TRANSFORMATION (FINAL BOSS) — недели 47–48', 24, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 12, null::int, 60, 4, '12'),
    ('lateral-raise', 10, 10, null::int, 60, 10, '10'),
    ('rear-delt', 20, 20, null::int, 60, 5, '20'),
    ('kickback', 30, 15, null::int, 60, 4, '15'),
    ('abduction', 40, 20, null::int, 60, 4, '20'),
    ('glute-bridge', 50, 20, null::int, 60, 3, '20'),
    ('segodnya-sdelala-4', 60, 10, null::int, 60, 1, '10 — через неделю снова 4×10».'),
    ('i-esche-kardio-ya-by-ne-stavil-posle-kazhdoy-trenirovki-kak-56b701', 70, 15, null::int, 60, 1, '15–20 минут в неделю.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
