-- 0068_remove_weekdays_from_workout_titles.sql
-- Убираем дни недели из названий тренировок: "Среда · СПИНА + БИЦЕПС" →
-- "СПИНА + БИЦЕПС". День недели в названии читался как предписание
-- ("в среду — спина"), а клиент сам решает, когда заниматься: порядок
-- задаётся номером тренировки в блоке, дни — только отметки в календаре.
-- Путаница была реальной: в среду сделал тренировку, а следующая —
-- снова "Среда · ...".
--
-- Во всех 8 программах и во всех переводах (ru / en / es / hy).
-- Убирается только префикс "<день недели> · " в начале — остальное
-- название не трогается. Админка (конструктор программ) больше не
-- предлагает выбирать день недели.
--
-- Безопасно выполнять повторно (второй запуск ничего не находит).

update public.workouts
set title = regexp_replace(title,
  '^\s*(Понедельник|Вторник|Среда|Четверг|Пятница|Суббота|Воскресенье)\s*·\s*', '')
where title ~ '^\s*(Понедельник|Вторник|Среда|Четверг|Пятница|Суббота|Воскресенье)\s*·';

update public.workouts
set title_en = regexp_replace(title_en,
  '^\s*(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\s*·\s*', '')
where title_en ~ '^\s*(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\s*·';

update public.workouts
set title_es = regexp_replace(title_es,
  '^\s*(Lunes|Martes|Miércoles|Jueves|Viernes|Sábado|Domingo)\s*·\s*', '')
where title_es ~ '^\s*(Lunes|Martes|Miércoles|Jueves|Viernes|Sábado|Domingo)\s*·';

update public.workouts
set title_hy = regexp_replace(title_hy,
  '^\s*(Երկուշաբթի|Երեքշաբթի|Չորեքշաբթի|Հինգշաբթի|Ուրբաթ|Շաբաթ|Կիրակի)\s*·\s*', '')
where title_hy ~ '^\s*(Երկուշաբթի|Երեքշաբթի|Չորեքշաբթի|Հինգշաբթի|Ուրբաթ|Շաբաթ|Կիրակի)\s*·';

-- Проверка (по желанию): должно вернуть 0
-- select count(*) from public.workouts
-- where title ~ '^(Понедельник|Вторник|Среда|Четверг|Пятница|Суббота|Воскресенье) ·';
