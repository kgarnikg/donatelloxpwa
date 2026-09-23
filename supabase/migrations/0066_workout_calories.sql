-- 0066_workout_calories.sql
-- Калории за тренировки: чиним завышенный расход и сохраняем сожжённые
-- калории по каждой тренировке.
--
-- БАГ, который это чинит (пример из жизни: "сегодняшняя тренировка
-- +11394 ккал"): расход за день считался по сумме duration_minutes всех
-- записей workout_logs за сегодня. Но "Догнать прогресс" в админке
-- (0062, CatchUpProgressPage) вставляет пачку записей сразу за все
-- пропущенные тренировки — с completed_at = сейчас и duration_minutes =
-- расчётной длительностью каждой. 20 тренировок по 70 минут "сегодня" =
-- ~1400 минут тренировок за день → десятки тысяч ккал. Вторая, меньшая
-- причина: длительность в плеере считалась от открытия страницы до
-- нажатия "Завершить" — если оставить плеер открытым на полдня, это
-- тоже шло в калории целиком.
--
-- Что делает миграция:
-- 1. workout_logs.is_catch_up — отметка "проставлено вручную, не
--    тренировка в приложении". Такие записи открывают следующие
--    тренировки, но в калории не идут. Существующие записи догоняния
--    находятся надёжно: плеер ВСЕГДА пишет непустой completed_sets
--    (по элементу на каждое упражнение), а догоняние — пустой массив.
-- 2. workout_logs.calories_burned — ккал, сожжённые на этой тренировке.
--    Считаются в приложении при завершении тренировки (lib/calories.ts,
--    estimateWorkoutCalories) и сохраняются — чтобы общий счётчик не
--    "плавал", если потом поменяется вес в профиле.
-- 3. Пересчёт calories_burned для уже сохранённых тренировок по той же
--    формуле, что и в приложении (см. комментарий к формуле ниже).
--
-- Безопасно выполнять повторно.

alter table public.workout_logs add column if not exists is_catch_up boolean not null default false;
alter table public.workout_logs add column if not exists calories_burned integer;

alter table public.workout_logs drop constraint if exists workout_logs_calories_burned_check;
alter table public.workout_logs add constraint workout_logs_calories_burned_check
  check (calories_burned is null or calories_burned between 0 and 3000);

-- 1. Отмечаем уже существующие записи догоняния
update public.workout_logs
set is_catch_up = true
where completed_sets = '[]'::jsonb
  and is_catch_up = false;

update public.workout_logs
set calories_burned = 0
where is_catch_up = true;

-- 3. Пересчёт для реальных тренировок.
--
-- Формула ("скорректированный MET"): ккал = MET × (BMR / 1440) × минуты
--   BMR — базовый обмен по Миффлину-Сан Жеору (вес, рост, возраст, пол),
--         делённый на 1440 = расход в покое за минуту именно этого человека
--   MET — интенсивность: 6.0 для программ на похудение (круговые/
--         высокий темп), 5.0 для набора массы (силовые с отдыхом)
--   минуты — фактическая длительность, но не больше 1.5 × расчётной
--         длительности тренировки (защита от "забыл закрыть плеер")
-- Если рост/возраст не указаны — подставляем 170 см / 30 лет, если нет
-- веса — калории не считаем (null).
update public.workout_logs l
set calories_burned = round(
  (case when p.goal = 'lose_weight' then 6.0 else 5.0 end)
  * (
      (10 * up.weight_kg
       + 6.25 * coalesce(up.height_cm, 170)
       - 5 * coalesce(extract(year from age(l.completed_at, up.birth_date)), 30)
       + case up.gender when 'male' then 5 when 'female' then -161 else -78 end
      ) / 1440.0
    )
  * least(
      greatest(l.duration_minutes, 0),
      coalesce(nullif(w.estimated_duration_minutes, 0), 60) * 1.5
    )
)
from public.workouts w
join public.workout_programs p on p.id = w.program_id,
     public.user_profiles up
where w.id = l.workout_id
  and up.user_id = l.user_id
  and l.is_catch_up = false
  and up.weight_kg is not null;

create index if not exists workout_logs_user_completed_idx
  on public.workout_logs (user_id, completed_at desc);

notify pgrst, 'reload schema';
