-- 0085: пересчёт калорий у тренировок, где таймер "сбился".
--
-- Калории за тренировку считаются от фактического времени в плеере. На
-- iPhone Safari перезагружает страницу, когда переключаешься в другое
-- приложение или телефон долго заблокирован, — и отсчёт начинался заново
-- (теперь прогресс тренировки сохраняется на телефоне, см. WorkoutPlayerPage).
-- В итоге часовая тренировка записывалась как 5–10 минут, а калорий было
-- в разы меньше реальных (у Гара: 28 тренировок = 1677 ккал).
--
-- Новое правило (то же в lib/calories.ts, estimateWorkoutCalories): если
-- тренировка заняла меньше половины расчётного времени — считаем по
-- расчётному. Сверху по-прежнему потолок 1.5 × расчётного.
--
-- Пересчитываются только такие "короткие" записи и записи без калорий.
-- Формула — как в 0066. Безопасно выполнять повторно.

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
  * (case
       when greatest(l.duration_minutes, 0) < coalesce(nullif(w.estimated_duration_minutes, 0), 60) * 0.5
         then coalesce(nullif(w.estimated_duration_minutes, 0), 60)
       else least(greatest(l.duration_minutes, 0), coalesce(nullif(w.estimated_duration_minutes, 0), 60) * 1.5)
     end)
)
from public.workouts w
join public.workout_programs p on p.id = w.program_id,
     public.user_profiles up
where w.id = l.workout_id
  and up.user_id = l.user_id
  and l.is_catch_up = false
  and up.weight_kg is not null
  and (
    l.calories_burned is null
    or coalesce(l.duration_minutes, 0) < coalesce(nullif(w.estimated_duration_minutes, 0), 60) * 0.5
  );

notify pgrst, 'reload schema';
