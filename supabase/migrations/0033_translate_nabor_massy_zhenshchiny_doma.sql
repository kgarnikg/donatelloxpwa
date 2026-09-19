-- 0033_translate_nabor_massy_zhenshchiny_doma.sql
-- Английский перевод: Набор массы — Женщины — Дома
-- Часть Фазы 6 (Локализация контента) — см. PROJECT_PLAN.md.
--
-- НЕ создаёт новые строки — заполняет title_en/week_label_en/notes_en
-- у уже существующих workout_programs/workouts/workout_sets (залиты в
-- 0016).
-- Сопоставление workouts — по (program slug, week_order, "order") —
-- тем же детерминированным ключам, что использовались при генерации
-- исходной RU-миграции из того же файла-источника программ. Сопоставление
-- workout_sets — по диапазону "order" внутри тренировки (та же логика
-- base_order = ex_idx*10, что и в оригинальном генераторе).
--
-- В конце — проверка: если число обновлённых тренировок не совпадает с
-- ожидаемым (94), миграция падает с ошибкой вместо того, чтобы
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
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-zhenshchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-zhenshchiny-doma';
  end if;

  update public.workout_programs
  set title_en = 'Gain mass for women (home) — year-long program', description_en = 'Gain mass for women (home) — year-long program. Equipment: Dumbbells, resistance band various resistance, mat, stable platform/step/step'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · Glutes + КВАДРИЦЕПС', week_label_en = 'Month 1 — LEVEL 1A — Adaptation (Weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15 (Dumbbell before chest-supported. Последние 5 reps: Slow eccentric/lowering.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '20 (In верхней точке: 2 sec сжатия ягодиц.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg (Корпус слегка наклонён forward. Толкаемся пяткой.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15 (Eccentric/lowering: 3 sec. Not округлять поясницу.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30 sec (Knees примерно under углом 90°.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 exercise × 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · Glutes + Rear Chain Thighs', week_label_en = 'Month 1 — LEVEL 1A — Adaptation (Weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15 (Широкая stance legs.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '3 sets 15 reps ↓ 30 sec hold in нижней точке'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20 (Последние 5: короткие пульсирующие movements.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 per side'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 exercise × 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · Back + Shoulders + Arms', week_label_en = 'Month 1 — LEVEL 1A — Adaptation (Weeks 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15 (Контролируем movement.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '20 (Focus on/for rear delt.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15 (Lateral raises dumbbells in sides ↓ сразу Raise dumbbells before собой 3 × 12 Rest after two…)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = 'Max quality reps (You can выполнять with knee. Главное — контролировать movement.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise × 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'Month 1 — LEVEL 1B — First Jump (Week 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Weight: +5–10% относительно weeks 1–2, if form позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Last rep каждого sets: Hold 3 sec from the top.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 (Slow eccentric/lowering: 3 sec.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '3 rounds: 20 Frog Pumps 20 pulses in ягодичном мосте 20 sec статики from the top Rest: 45…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Now: 3 rounds each exercise: 60 sec Dead Bug Reverse Crunch Mountain Climbers…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Wednesday · GLUTE + HAMSTRING', week_label_en = 'Month 1 — LEVEL 1B — First Jump (Week 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '3 sets 12 reps 40 sec удержания'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20 (Last set: 20 reps + 20 pulses.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25 per side'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Friday · BACK + SHOULDERS + ARMS', week_label_en = 'Month 1 — LEVEL 1B — First Jump (Week 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Последние 5: Slow.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Выполнить подряд: Lateral raises in sides 12 ↓ Raise before собой 12 ↓ Rear delt in bent-over 15…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '3 rounds each exercise: 60 sec Round: Mountain Climbers leg raise Russian Twist…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE + QUAD', week_label_en = 'Month 2 — LEVEL 2A — BUILD (Weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (In верхней точке: 2 sec удержания.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Last set: +5 коротких pulses.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg (Толчок выполняется преимущественно рабочей leg.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '45 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · BACK + SHOULDERS + ARMS', week_label_en = 'Month 2 — LEVEL 2A — BUILD (Weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15 (Имитируем вертикальную тягу.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Lateral raises dumbbells in sides 15 Rear delt in bent-over 15 4 rounds Rest: 60 sec.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Bicep curl with dumbbells 12 tricep extension with resistance band 15 3 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '8–12 (Это first элемент калистеники. If тяжело: делать with более high support.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE + HAMSTRING', week_label_en = 'Month 2 — LEVEL 2A — BUILD (Weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Eccentric/lowering: 3 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg (Weight moderate тяжелый.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12–15 (If chain позволяет безопасно скользить. Альтернатива: Leg curl with resistance band.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds: 20 Frog Pumps 15 abductions back каждой leg 20 sec glute bridge Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY ATHLETIC', week_label_en = 'Month 2 — LEVEL 2A — BUILD (Weeks 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Max quality reps (You can with knee.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8 per arm (If тяжело: выполнять with knee.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '40 sec (Тяжелые dumbbells. Корпус max стабильный.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 rounds 20 sec: Step-Up fast 20 sec: Mountain Climbers 20 sec: Rest After…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHAPE', week_label_en = 'Month 2 — LEVEL 2B — NEW STIMULUS (Weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Weight: +5–10% относительно weeks 5–6, if form позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side (One leg выполняет основную работу.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per side (New stimulus for legs and ягодиц.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '40'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
    update public.workout_sets set notes_en = '3 rounds 30 sec: Glute bridge 20 pulses 20 sec static hold from the top Rest: 45 sec.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · BACK + SHOULDERS', week_label_en = 'Month 2 — LEVEL 2B — NEW STIMULUS (Weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15 per arm'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Pause: 2 sec in верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Lateral raises in sides 12 Arnold Press 10 Rear delt 15 Static hold arms in sides 20 sec 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '8–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN', week_label_en = 'Month 2 — LEVEL 2B — NEW STIMULUS (Weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '10 (Slow.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Glute bridge: 45 sec static hold 20 pulses 30 sec static hold 2 rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — ATHLETE LEVEL', week_label_en = 'Month 2 — LEVEL 2B — NEW STIMULUS (Weeks 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Squat + Dumbbell press.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '45 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'AMRAP — 8 min Сделать as/like you can more quality rounds: 8 squats 8 push-ups 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Mountain Climbers Russian Twist Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE + QUAD POWER', week_label_en = 'Month 3 — LEVEL 3A — SHAPE (Weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per leg (Последние 2 reps должны be тяжелыми.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Pace: 2 sec up → 2 sec hold → slow down.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15 (Пятки слегка приподняты. Last set: +10 pulses.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per leg (Последние 5 reps каждого sets — slow.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '25 (Последние 10 reps: короткие пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '12 per leg (Use stable platform.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 30 sec: Glute Bridge 20 sec: пульсации 20 sec: Static hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · BACK + SHOULDERS + ARMS', week_label_en = 'Month 3 — LEVEL 3A — SHAPE (Weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Slow eccentric/lowering: 3 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per arm (In верхней точке: 2 sec hold.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 12 Lateral raises dumbbells in sides 15 4 rounds Rest: 60 sec.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Hammer curl 12 Triceps with resistance band down 15 3 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '8–12 (If тяжело — arms on/for возвышенности.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '30 sec'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE + HAMSTRING', week_label_en = 'Month 3 — LEVEL 3A — SHAPE (Weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Pace: 3 sec down.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12 (Стопы on/for stable опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 (If нет availability use полотенце: Leg curl with resistance band.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 15 curls legs 20 glute bridges 20 pulses 20 sec static hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY POWER', week_label_en = 'Month 3 — LEVEL 3A — SHAPE (Weeks 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Max quality reps'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '45 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Each minute начать new мини-round.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'Month 3 — LEVEL 3B — POWER & CONTROL (Weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Последние 5 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg (Передняя leg on/for небольшой stable опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '2 rounds 40 Frog Pumps 30 Abductions 20 Kickbacks каждой leg 30 sec Glute Bridge Hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — CONTROL', week_label_en = 'Month 3 — LEVEL 3B — POWER & CONTROL (Weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Pause: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral raises in sides 15 Reverse Fly 15 Static hold in положении «arms in sides» 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Bicep curl with resistance band 15 Triceps over the head with resistance band 15 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Max quality reps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE + POSTERIOR POWER', week_label_en = 'Month 3 — LEVEL 3B — POWER & CONTROL (Weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 15 Good Morning 15 Hamstring Walkout 20 Glute Bridge 30 sec static hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — BOSS LEVEL', week_label_en = 'Month 3 — LEVEL 3B — POWER & CONTROL (Weeks 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 (Movement выполнять технически чисто.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'AMRAP — 10 min Сделать максимальное amount quality rounds: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'In at the end month пользователь фиксирует: Hip Thrust Month 1: кг Month 2: кг Month…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE + QUAD', week_label_en = 'Month 4 — LEVEL 4A — GLUTE BUILD (Weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Last rep каждого sets: 2 sec hold from the top.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg (Передняя leg on/for небольшой stable опоре. Последние 3 reps: Slow eccentric/lowering.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Full squat → подняться наполовину → снова down → completely up. Это одно rep.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 per leg (Последние 3 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '25 (Последние 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 20 glute bridges 20 Frog Pumps 20 Abductions 20 sec static hold from the top Rest:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — SHAPE', week_label_en = 'Month 4 — LEVEL 4A — GLUTE BUILD (Weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm (Pause: 2 sec from the top.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral raises in sides 15 Передние lateral raises 12 Rear delt 15 4 rounds Rest: 60…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Biceps with dumbbells 12 Triceps with resistance band 15 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '40 sec'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 72;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE + HAMSTRING', week_label_en = 'Month 4 — LEVEL 4A — GLUTE BUILD (Weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Pace: 3 sec down.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg (Focus: Glutes.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 15 Hamstring Slides 20 Glute Bridge 20 Frog Pumps 30 sec hold from the top…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER', week_label_en = 'Month 4 — LEVEL 4A — GLUTE BUILD (Weeks 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = 'Max quality reps'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Чередуем: Нечетная минута 10 Goblet Squats Четная минута 8 Push-Ups + 10 Mountain…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 4 — LEVEL 4B — GLUTE SHOCK (Weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Last set: +15 pulses.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg (Rear leg уходит back with небольшой возвышенности under front leg.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 30 sec: Frog Pumps 20 sec: Glute Bridge Hold 20 pulses 20 abductions legs…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — NEW ANGLES', week_label_en = 'Month 4 — LEVEL 4B — GLUTE SHOCK (Weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Это уменьшает помощь поясницы.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral raises in sides 15 Reverse Fly 15 4 rounds Rest: 60 sec.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Hammer curl 12 Extension dumbbells over the head 12 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '30 sec'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN SHOCK', week_label_en = 'Month 4 — LEVEL 4B — GLUTE SHOCK (Weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 15 Hamstring Walkout 20 Glute Bridge 20 Kickbacks 30 sec static hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — BOSS LEVEL', week_label_en = 'Month 4 — LEVEL 4B — GLUTE SHOCK (Weeks 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'AMRAP — 12 min Максимальное amount quality rounds: 10 Sumo Squats 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'Пользователь фиксирует result: Hip Thrust Month 1: кг Month 2: кг Month 3:…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'After 16- weeks пользователь должен получить ощущение перехода on/for new level: 3…'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE STRENGTH', week_label_en = 'Month 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Last set: Rest-pause After выполнения sets: 20 sec rest → дополнительные…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 (Last set: +10 pulses at the bottom.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–10 per leg (Weight: тяжелый, but form completely контролируется.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg (In верхней точке: 1 sec удержания.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '20 (Last set: 20 regular 20 pulses.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '2 rounds 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 sec static hold Rest: 90…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY STRENGTH', week_label_en = 'Month 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per arm (Последние 2 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral raises dumbbells in sides 15 4 rounds'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Передние lateral raises 12 Rear delt in bent-over 15 3 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Hammer curl 12 Triceps with a dumbbell over the head 12 3 rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING + GLUTE STRENGTH', week_label_en = 'Month 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 3 sec down.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 (Pause from the top: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = 'Leg curl 12 reps 20 sec rest 5 reps 20 sec rest 5 reps'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — STRENGTH + ATHLETIC', week_label_en = 'Month 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Weeks 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '16 steps'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max quality reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Нечетные min 10 Goblet Squats Четные min 8 Push-Ups 10 Mountain Climbers Оставшееся…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 5 — LEVEL 5B — MUSCLE SHOCK (Weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Last set: 1,5 reps × 8)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '30 (Last set: +20 pulses.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 20 Frog Pumps ↓ 20 Glute Bridge ↓ 20 sec static hold ↓ 20 pulses Rest: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY SHOCK', week_label_en = 'Month 5 — LEVEL 5B — MUSCLE SHOCK (Weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Pause: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral raises in sides 15 Reverse Fly 15 Static hold in sides 20 sec 4 rounds…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '3 rounds Hammer curl: 10 ↓ regular curl: 10 ↓ частичные reps: 10 Rest:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR SHOCK', week_label_en = 'Month 5 — LEVEL 5B — MUSCLE SHOCK (Weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 sec static hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — LEVEL 5 BOSS', week_label_en = 'Month 5 — LEVEL 5B — MUSCLE SHOCK (Weeks 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '12 min Максимальное amount quality rounds: 10 Sumo Squats 8 Push-Ups 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'Пользователь фиксирует: Hip Thrust Month 1: кг Month 2: кг Month 3: кг…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'After 20- weeks пользователь переходит on/for next level.'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'Month 6 — LEVEL 6A — POWER HYPERTROPHY (Weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 (Last set: 8 reps + 20 sec rest + 4–5 reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Rear leg not используется for толчка.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Pace: 3 sec down)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 (In нижней точке: 2 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20 (Last set: 20 regular 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30 (Последние 10: Max короткая range of motion.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 12 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 sec hold from the top…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec Reverse Crunch Mountain Climbers Dead Bug Plank…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — STRENGTH', week_label_en = 'Month 6 — LEVEL 6A — POWER HYPERTROPHY (Weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm (Pause in верхней точке: 2 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 ↓ Lateral raises in sides 12 ↓ Lateral raises вперед 12 ↓ Reverse Fly 15 Rest:…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Hammer curl 12 Extension dumbbells over the head 12 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 rounds V-Ups — 60 sec Bicycle — 60 sec Hollow Hold — 60 sec Leg Raise — 60 sec Rest: 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING + GLUTE', week_label_en = 'Month 6 — LEVEL 6A — POWER HYPERTROPHY (Weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Последние 2 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg (Pause from the top: 2 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 (If слишком легко: Use более медленную phase возвращения.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 30 sec hold Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds Reverse Crunch — 60 sec Bicycle — 60 sec Mountain Climbers — 60 sec Plank with…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER', week_label_en = 'Month 6 — LEVEL 6A — POWER HYPERTROPHY (Weeks 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '10 (between sets: 60 sec)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 rounds 10 Goblet Squats 8 Push-Ups 10 Dumbbell Rows 10 Reverse Lunges 15 Dumbbell…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 rounds V-Ups — 60 sec Mountain Climbers — 60 sec Russian Twist — 60 sec Hollow Hold — 60…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 6 — LEVEL 6B — ATHLETIC SHOCK (Weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Пятки слегка приподняты. Last set: +10 pulses)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg (In верхней точке: 2 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 sec static hold from the top Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec Bicycle Reverse Crunch Mountain Climbers Plank…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY SHOCK', week_label_en = 'Month 6 — LEVEL 6B — ATHLETIC SHOCK (Weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause: 2 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 sec…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Biceps 12 regular curls ↓ 10 молотковых ↓ 10 partial 3 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 rounds Leg Raise — 60 sec Bicycle — 60 sec Hollow Hold — 60 sec Mountain Climbers — 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN SHOCK', week_label_en = 'Month 6 — LEVEL 6B — ATHLETIC SHOCK (Weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 (Each rep: Full up → половина down → снова up → full down.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 sec Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '5 rounds Dead Bug — 60 sec Reverse Crunch — 60 sec Mountain Climbers — 60 sec Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ATHLETIC FULL BODY', week_label_en = 'Month 6 — LEVEL 6B — ATHLETIC SHOCK (Weeks 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '—'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 (Rest: 75 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Max'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = 'For/behind 12 min выполнить max качественное amount rounds: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'In течение month фиксируются: HIP THRUST Week 21: кг Week 22: кг Week 23:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'After 24- weeks пользователь получает: +1 LEVEL and переходит to:'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE MASS', week_label_en = 'Month 7 — LEVEL 7A — GLUTE BUILD (Weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Last set: 10 reps + 20 sec rest + 5 reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Focus: ягодица.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg (Передняя leg стоит on/for небольшой stable step.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12 (Последние 3 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '25 (Last set: 25 reps 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30 (Последние 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 30 sec static hold Rest: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY + SHOULDERS', week_label_en = 'Month 7 — LEVEL 7A — GLUTE BUILD (Weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Pause: 2 sec in верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 reps ↓ Lateral raises dumbbells in sides 15 reps ↓ Static hold in sides…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '12 (Hammer curl Triceps with a dumbbell over the head 3 × 12 Выполняются суперсетом.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING + GLUTE', week_label_en = 'Month 7 — LEVEL 7A — GLUTE BUILD (Weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg (Pause from the top: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 sec Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · ATHLETIC — LOWER BODY POWER', week_label_en = 'Month 7 — LEVEL 7A — GLUTE BUILD (Weeks 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 (Rest: 60–75 sec.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = 'Max quality reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '60 sec'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 7 — LEVEL 7B — GLUTE SHOCK (Weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Last set: 12 reps + 10 pulses.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg (In верхней точке: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 sec static hold Rest: 45 sec.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY SHOCK', week_label_en = 'Month 7 — LEVEL 7B — GLUTE SHOCK (Weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 4 rounds Rest: 60 sec.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '3 rounds 12 regular curls ↓ 10 молотковых ↓ 10 partial reps'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '15 (Extension with resistance band: Last set: +15 partial reps.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · GLUTE + HAMSTRING SHOCK', week_label_en = 'Month 7 — LEVEL 7B — GLUTE SHOCK (Weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 12 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 sec static hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · LEVEL 7 — BOSS FIGHT', week_label_en = 'Month 7 — LEVEL 7B — GLUTE SHOCK (Weeks 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 (Dumbbell Clean Squat Jump 4 × 8 Rest: 75 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Thruster Reverse Lunge 4 × 10 per leg Rest: 75 sec.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 per arm (Renegade Row Push-Up 4 × max Rest: 75 sec.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = 'Максимальное amount quality rounds: 10 Goblet Squats 10 Walking Lunges 8…'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_en = '3 rounds 20 Frog Pumps 20 Abduction 20 sec Glute Bridge Hold 10 Squat Pulses Rest: 45…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Пользователь фиксирует лучшие показатели.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '28 weeks пройдено.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE TENSION', week_label_en = 'Month 8 — LEVEL 8A — TENSION BUILD (Weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Pace: 2 sec up → 2 sec hold → slow down.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Pace: 3 sec down.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per side (Pause in нижней точке: 1 sec.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 (Last set: 25 reps 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 15 Glute Bridge 15 Frog Pumps 15 Abduction 30 sec Glute Bridge Hold Rest: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — CALISTHENICS', week_label_en = 'Month 8 — LEVEL 8A — TENSION BUILD (Weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 per arm'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–15 (If regular слишком легкие: Legs on/for stable возвышенности.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Последние 3 reps: медленная негативная phase.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 sec…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Hammer Curl 12 Overhead Triceps Extension 12 4 rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '2 rounds 10 regular curls 10 молотковых 10 partial'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN', week_label_en = 'Month 8 — LEVEL 8A — TENSION BUILD (Weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg (Pause from the top: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '20 steps'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Hamstring Walkouts ↓ 15 Glute Bridges ↓ 20 Frog Pumps ↓ 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER', week_label_en = 'Month 8 — LEVEL 8A — TENSION BUILD (Weeks 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Goblet Squat Squat Jump 4 × 8 Rest: 90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Romanian Deadlift Broad Jump 4 × 6 If нет безопасного места for jumps:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Dumbbell Push Press Mountain Climbers 4 × 30 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 per arm (Renegade Row Push-Up 3 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 8 — LEVEL 8B — ATHLETIC SHOCK (Weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Последние 5 reps: короткая range of motion.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (After каждого sets: 10 pulses.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 15 Hip Thrust 20 Frog Pumps 20 Abduction 15 Squat Pulses 30 sec static hold Rest:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY SHOCK', week_label_en = 'Month 8 — LEVEL 8B — ATHLETIC SHOCK (Weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–12 (Pause at the bottom: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 per arm'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '4 rounds Lateral Raise 12 Arnold Press 10 Reverse Fly 15 Rest: 60 sec'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Biceps 10 regular curls ↓ 10 молотковых ↓ 10 partial 3 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING + GLUTE SHOCK', week_label_en = 'Month 8 — LEVEL 8B — ATHLETIC SHOCK (Weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Pause: 3 sec from the top.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–10 (In completely вытянутом положении: 1 sec.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · LEVEL 8 — BOSS FIGHT', week_label_en = 'Month 8 — LEVEL 8B — ATHLETIC SHOCK (Weeks 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Dumbbell Thruster Squat Jump 4 × 8 Rest: 75–90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8 (Dumbbell Clean Reverse Lunge + Knee Drive 4 × 10 per leg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 (Renegade Row Push-Up 4 × max)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 40 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Максимальное amount quality rounds: 10 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '3 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec Glute…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Пользователь фиксирует: HIP THRUST Week 29: кг Week 30: кг Week 31: …'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'After 32 weeks пользователь переходит on/for:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'Month 9 — LEVEL 9A — POWER BUILD (Weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 2 sec up → 2 sec hold → 3 sec down Last set: 10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Pace: 3 sec down Последние 2 reps: Max контролируемые.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Pause in нижней точке: 1 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg (After последнего sets: 10 fast reps bodyweight per leg)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '12 (Последние 3 reps: 3-секундная негативная phase)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25 (Last set: 25 reps 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 15 Hip Thrust 15 Frog Pumps 15 Squat Pulses 20 Abduction 30 sec Glute Bridge…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — POWER', week_label_en = 'Month 9 — LEVEL 9A — POWER BUILD (Weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–12 (If тяжело: Regular push-up.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per arm (Последние 3 reps: Slow eccentric/lowering.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 (Pause: 2 sec in растянутом положении)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 reps Lateral Raise 12 reps Reverse Fly 15 reps…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '12 per arm (Alternating Dumbbell Curl Last set: 12 + 10 partial reps)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '12 (Overhead Dumbbell Extension Band Triceps Pushdown 3 × 20)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 8 Push-Ups 10 Knee Push-Ups 10 sec hold in нижней точке Rest: 45 sec'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING POWER', week_label_en = 'Month 9 — LEVEL 9A — POWER BUILD (Weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg (Pause from the top: 3 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Use полотенце/скользящую chain.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 steps in each side'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 10 Sliding Leg Curl 15 Glute Bridge 15 Frog Pumps 20 Band Abduction 30 sec…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · POWER CONDITIONING', week_label_en = 'Month 9 — LEVEL 9A — POWER BUILD (Weeks 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Dumbbell Squat Squat Jump 4 × 8 Rest: 90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Romanian Deadlift Skater Jump 4 × 10 per side If jumps…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Dumbbell Push Press Mountain Climbers 4 × 40 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8 per arm (Renegade Row Push-Up 3 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '3 rounds 20 Frog Pumps 15 Squat Pulses 20 Band Abduction 15 Glute Bridge 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE OVERLOAD', week_label_en = 'Month 9 — LEVEL 9B — GLUTE OVERLOAD (Weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Pause from the top: 3 sec)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12 per leg (Последние 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Pace: 3 sec down)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 (Last set: 25 + 20 pulses)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '25 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 10 Bulgarian Split Squats ↓ 15 Reverse Lunges ↓ 20 Bodyweight Squats ↓ 30 sec…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — CALISTHENICS LEVEL', week_label_en = 'Month 9 — LEVEL 9B — GLUTE OVERLOAD (Weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Pause at the bottom: 2 sec)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '6–8 per side (If сложно: делать with knee or with уменьшенной range of motion.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Raise Hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Hammer Curl 12 Band Triceps Extension 20 4 rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '3 rounds 10 Dumbbell Curl ↓ 10 Hammer Curl ↓ 10 partial reps'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN OVERLOAD', week_label_en = 'Month 9 — LEVEL 9B — GLUTE OVERLOAD (Weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause from the top: 3 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '30 (Последние 10: частичные.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 rounds 8 Sliding Leg Curl 12 Single-Leg Glute Bridge 15 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · LEVEL 9 — BOSS FIGHT', week_label_en = 'Month 9 — LEVEL 9B — GLUTE OVERLOAD (Weeks 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 per side)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Renegade Row Push-Up 4 × max)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 45 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Максимальное amount quality rounds: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'On/for каждой тренировке пользователь записывает working weight.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'After прохождения 9- month пользователь открывает:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE HYPERTROPHY', week_label_en = 'Month 10 — LEVEL 10A — HYPERTROPHY BUILD (Weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 2 sec up → 2 sec hold → 3 sec down Last set: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per leg (Rear leg elevated.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Pause in нижней точке: 2 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg (Последние 3 reps: медленная негативная phase.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '30 (Last set: 30 reps 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 12 Hip Thrust ↓ 15 Bodyweight Squats ↓ 20 Frog Pumps ↓ 20 Abduction ↓ 30 sec…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — STRENGTH', week_label_en = 'Month 10 — LEVEL 10A — HYPERTROPHY BUILD (Weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Last set: +3–5 partial reps.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per arm (Pause in верхней точке: 2 sec.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 (Pace: 3 sec down.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 reps Lateral Raise 15 reps Front Raise 12 reps…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Superset Dumbbell Curl 12 Overhead Triceps Extension 12 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Biceps 10 regular curls 10 молотковых 10 partial Triceps 15 extensions with resistance band 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN', week_label_en = 'Month 10 — LEVEL 10A — HYPERTROPHY BUILD (Weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Pause: 3 sec from the top.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12 (If слишком тяжело: Hamstring Walkout.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_en = '25 (Последние 10: частичная range of motion.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '3 rounds 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 20 Abduction 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER + DENSITY', week_label_en = 'Month 10 — LEVEL 10A — HYPERTROPHY BUILD (Weeks 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Dumbbell Thruster Squat Jump 4 × 8 Rest: 90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 per leg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 per arm (Renegade Row Push-Up 4 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 40 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '3 rounds 20 Frog Pumps 15 Squat Pulses 20 Abduction 15 Glute Bridge 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE DENSITY', week_label_en = 'Month 10 — LEVEL 10B — DENSITY SHOCK (Weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '15 (Pause from the top: 3 sec Last set: 15 + 10 pulses + 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '12 per leg (Последние 3 reps: 1,5 reps.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '15 (Pace: 4 sec down.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '15 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '30 (Last set: 30 + 20 pulses.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 rounds 15 Reverse Lunges 20 Frog Pumps 20 Squat Pulses 20 Abduction 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — CALISTHENICS SHOCK', week_label_en = 'Month 10 — LEVEL 10B — DENSITY SHOCK (Weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8 per side (If тяжело: делать with knee.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8 per side'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 ↓ Lateral Raise 12 ↓ Partial Lateral Raise 15 ↓ Reverse Fly 15…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Biceps 8 reps ↓ 20 sec rest ↓ 4 reps ↓ 20 sec rest ↓ 4 reps…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '3 rounds 10 Push-Ups 10 Knee Push-Ups 20 sec static hold in нижней точке Rest: 45 sec.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING + GLUTE DENSITY', week_label_en = 'Month 10 — LEVEL 10B — DENSITY SHOCK (Weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause: 3 sec from the top.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '14 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '30 per side'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · LEVEL 10 — FINAL BOSS', week_label_en = 'Month 10 — LEVEL 10B — DENSITY SHOCK (Weeks 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 per side If jumps выполнять небезопасно:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Renegade Row Push-Up 4 × max)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 45 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Максимальное amount quality rounds: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Пользователь фиксирует показатели each week.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'NEXT LEVEL'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE POWER', week_label_en = 'Month 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 2 sec up → 2 sec hold → 3 sec down Last set: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8–10 per leg (Передняя leg on/for small an elevated surface. Pace: 3 sec down Last set: +5 pulses)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Pause in нижней точке: 1 sec)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per leg (Последние 3 reps: Slow.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg (Pause from the top: 2 sec)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 (Last set: 25 regular 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 12 Hip Thrust 15 Bulgarian Pulses 20 Frog Pumps 20 Abduction 30 sec Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · UPPER BODY — STRENGTH', week_label_en = 'Month 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Last set: +5 partial reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10 per arm (Pause: 2 sec in верхней точке)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12 (If слишком тяжело: Regular push-up.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10–12 (Pace: 3 sec down)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Rest: 60 sec'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Superset Dumbbell Curl 10–12 Overhead Triceps Extension 10–12 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Biceps 10 regular 10 молотковых 10 partial Triceps 15 extensions 15 pulses 20 sec…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · HAMSTRING POWER', week_label_en = 'Month 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 3 sec down)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '25 per side (Последние 10: короткая range of motion.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FULL BODY — POWER', week_label_en = 'Month 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Weeks 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Dumbbell Thruster Squat Jump 4 × 8 Rest: 90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 per leg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 per side (Renegade Row Push-Up 4 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 40 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Each minute начинается новое exercise.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · GLUTE SHOCK', week_label_en = 'Month 11 — LEVEL 11B — MUSCLE SHOCK (Weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Pause: 3 sec from the top Last set: 12 10 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Последние 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Pace: 4 sec down)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '30 (Последние 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_en = '4 rounds 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · CALISTHENICS UPPER BODY', week_label_en = 'Month 11 — LEVEL 11B — MUSCLE SHOCK (Weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8 per side (If тяжело: делать облегченный вариант.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '8–10 per side'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '8 reps ↓ 20 sec rest ↓ 4 reps ↓ 20 sec rest ↓ 4 reps 3 rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '10 reps ↓ 20 sec rest ↓ 5 reps ↓ 20 sec rest ↓ 5 reps 3 rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '3 rounds 10 Push-Ups 10 Knee Push-Ups 20 sec hold Rest: 45 sec.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · POSTERIOR CHAIN SHOCK', week_label_en = 'Month 11 — LEVEL 11B — MUSCLE SHOCK (Weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause: 3 sec from the top)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '30 per side'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · LEVEL 11 — FINAL BOSS', week_label_en = 'Month 11 — LEVEL 11B — MUSCLE SHOCK (Weeks 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 per side If jumps not подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10 (Renegade Row Push-Up 4 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 45 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Максимальное amount quality rounds: 12 Goblet Squats 10 Reverse Lunges 8…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Each week фиксируем: HIP THRUST / GLUTE BRIDGE Week 41: кг Week 42: кг…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'After this пользователь переходит on/for:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · FINAL GLUTE STRENGTH', week_label_en = 'Month 12 — FINAL BUILD (weeks 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8 (Pace: 2 sec up → 2 sec hold → 3 sec down Last set: 8 reps ↓ снизить…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '8–10 per leg (Pace: 3 sec down Last set: +5 pulses)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '10–12 (Pause: 2 sec at the bottom)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10 per side'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg (Последние 3 reps: медленная негативная phase.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '25 (Last set: 25 regular 20 pulses 20 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '3 rounds 12 Hip Thrust 15 Bulgarian Lunges 20 Frog Pumps 20 Abduction 30 sec Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · FINAL UPPER BODY', week_label_en = 'Month 12 — FINAL BUILD (weeks 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Last set: +5 partial reps)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 per arm (Pause from the top: 2 sec)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–12 (If тяжело: Regular push-up.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 (Pace: 3 sec down)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = 'Superset Dumbbell Curl 12 Overhead Triceps Extension 12 4 rounds'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = 'Biceps 10 regular 10 молотковых 10 partial Triceps 15 extensions with resistance band 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · FINAL POSTERIOR CHAIN', week_label_en = 'Month 12 — FINAL BUILD (weeks 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '8–10 (Pace: 4 sec down)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Pause: 3 sec from the top)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '20 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '30 per side (Последние 10: короткая range of motion.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · FINAL POWER DAY', week_label_en = 'Month 12 — FINAL BUILD (weeks 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '10 (Dumbbell Thruster Squat Jump 4 × 8 Rest: 90 sec.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '10 (Dumbbell Sumo Deadlift Reverse Lunge + Knee Drive 4 × 10 per leg)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8 per side (Renegade Row Push-Up 4 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '20 (Dumbbell Swing Mountain Climbers 4 × 45 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = 'Минута 1 10 Goblet Squats Минута 2 12 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '4 rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '4 rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'Now completely change exercise and характер load.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Monday · FINAL GLUTE SHOCK', week_label_en = 'Month 12 — FINAL BOSS (weeks 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Pause from the top: 3 sec Last set: 12 15 pulses 30 sec static hold.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_en = '10 per leg (Последние 3 reps: 1,5 reps)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '12 (Pace: 4 sec down)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12 per leg'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25 per leg'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '25 per leg'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Tuesday · FINAL CALISTHENICS', week_label_en = 'Month 12 — FINAL BOSS (weeks 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '6–8 per side (At необходимости: облегченный вариант.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '8–10 per side'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '10 per arm'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_en = '4 rounds Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '8 reps ↓ 20 sec rest ↓ 4 reps ↓ 20 sec rest ↓ 4 reps 3 rounds'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = '10 reps ↓ 20 sec rest ↓ 5 reps ↓ 20 sec rest ↓ 5 reps 3 rounds'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '3 rounds 10 Push-Ups 10 Knee Push-Ups 20 sec hold Rest: 45 sec.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Thursday · FINAL HAMSTRING SHOCK', week_label_en = 'Month 12 — FINAL BOSS (weeks 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 per side'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_en = '15 (Pause: 3 sec from the top)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_en = '14 per leg'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_en = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_en = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_en = '25 per side'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_en = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_en = '4 rounds 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = '4 exercise per 60 sec, rest 15 sec between exercises., 60 sec between rounds'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_en = 'Saturday · 🏆 FINAL BOSS — YEAR 1', week_label_en = 'Month 12 — FINAL BOSS (weeks 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_en = '12 (Dumbbell Thruster Squat Jump 3 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_en = '15 (Dumbbell Sumo Deadlift Skater Jump 3 × 10 per side If jumps not подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_en = '10 per side (Renegade Row Push-Up 3 × max quality reps)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_en = '25 (Dumbbell Swing Mountain Climbers 3 × 60 sec)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_en = 'Выполнить максимальное amount quality rounds: 10 Goblet Squats 10 Reverse Lunges…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_en = '5 Rounds 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 sec static hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_en = '5 Rounds each exercise: 60 sec V-Ups Bicycle Mountain Climbers Hollow Hold Rest:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_en = 'In at the end 48- weeks пользователь сравнивает показатели with первым месяцем.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_en = 'Push-Ups Month 1: Month 12: AMRAP 20 MIN Month 1: Rounds Month 12: …'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_en = 'Compare: Weight; объем бедер; объем ягодиц; объем талии; photo спереди; photo сбоку; photo…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_en = 'Ты прошла:'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
