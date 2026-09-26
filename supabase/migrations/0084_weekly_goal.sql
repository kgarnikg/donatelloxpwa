-- 0084: цель "тренировок в неделю" — понятнее и сама подстраивается.
--
-- Раньше цель на неделю = days_per_week из анкеты (по умолчанию там стояло 3),
-- и если программа рассчитана на другое число (обычно 4), на главной
-- получалось "4 из 3" и длинное объяснение. Теперь:
--   • goal_program_id — для какой программы человек уже ответил на вопрос
--     "Программа рассчитана на N тренировок в неделю. Как будешь заниматься?"
--     (спрашиваем один раз на программу, только если числа расходятся);
--   • goal_updated_at — когда цель последний раз меняли (подсказку
--     "Ты тренируешься по N раз — поставить цель N?" показываем, только если
--     цель не трогали минимум 2 недели);
--   • goal_suggest_dismissed_at — нажал "Нет" на этой подсказке: молчим 4 недели.
-- Всё хранится в базе, а не в браузере: на iPhone у Safari и у приложения
-- с главного экрана разные хранилища.

alter table public.user_profiles
  add column if not exists goal_program_id uuid references public.workout_programs (id) on delete set null,
  add column if not exists goal_updated_at timestamptz,
  add column if not exists goal_suggest_dismissed_at timestamptz;

notify pgrst, 'reload schema';
