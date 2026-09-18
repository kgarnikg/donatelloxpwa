-- 0028_gym_rest_and_short_titles.sql
-- Два независимых, но мелких правки по обратной связи:
--
-- 1. Во всех ЗАЛЬНЫХ программах отдых между подходами внутри одного
--    упражнения приводится к единым 60 секундам (было местами 90 и другие
--    значения, унаследованные из исходных документов тренера). Домашние
--    программы НЕ трогаем — там сейчас разумные значения, менять не просили.
--    Отдых МЕЖДУ упражнениями (для зала, 3 минуты) считается на клиенте
--    отдельно, в WorkoutPlayerPage.tsx — не хранится в БД, это не то же
--    самое, что rest_seconds конкретного подхода.
--
-- 2. Короткие названия программ вместо громоздких "Похудение для женщин
--    (зал) — годовая программа". Старые полные формулировки при этом не
--    теряются — они остаются в description, title используется только
--    для компактного отображения в списках/карточках.
--
-- Безопасно выполнять повторно.

update public.workout_sets ws
set rest_seconds = 60
from public.workouts w
join public.workout_programs p on p.id = w.program_id
where ws.workout_id = w.id
  and p.training_format = 'gym'
  and ws.rest_seconds <> 60;

update public.workout_programs set title = 'Похудение · Женщины · Дома' where slug = 'pohudenie-zhenshchiny-doma';
update public.workout_programs set title = 'Похудение · Женщины · Зал' where slug = 'pohudenie-zhenshchiny-zal';
update public.workout_programs set title = 'Набор массы · Женщины · Дома' where slug = 'nabor-massy-zhenshchiny-doma';
update public.workout_programs set title = 'Набор массы · Женщины · Зал' where slug = 'nabor-massy-zhenshchiny-zal';
update public.workout_programs set title = 'Похудение · Мужчины · Дома' where slug = 'pohudenie-muzhchiny-doma';
update public.workout_programs set title = 'Похудение · Мужчины · Зал' where slug = 'pohudenie-muzhchiny-zal';
update public.workout_programs set title = 'Набор массы · Мужчины · Дома' where slug = 'nabor-massy-muzhchiny-doma';
update public.workout_programs set title = 'Набор массы · Мужчины · Зал' where slug = 'nabor-massy-muzhchiny-zal';
