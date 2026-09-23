-- 0067_fix_workout_logs_workout_fkey.sql
-- Ещё один остаток старого черновика схемы (см. PROJECT_PLAN.md, раздел 8
-- и миграции 0009/0010): у таблицы workout_logs в реальной базе нет
-- внешнего ключа workout_id → workouts(id). В 0001 он объявлен, но
-- таблица уже существовала раньше, и `create table if not exists` её не
-- пересоздал. 0009 починил только FK на user_id.
--
-- Симптом: "Could not find a relationship between 'workout_logs' and
-- 'workouts' in the schema cache" — PostgREST не может делать вложенные
-- выборки workout_logs → workouts (калории на странице "Питание",
-- история тренировок на странице "Прогресс"). Плюс без FK при удалении
-- тренировки в конструкторе её записи в истории не удаляются каскадом.
--
-- Что делает:
-- 1. Удаляет любой существующий FK на workout_logs.workout_id (если он
--    вдруг указывает не туда — на таблицу из старого черновика).
-- 2. Создаёт правильный FK → public.workouts(id) on delete cascade.
--    NOT VALID — существующие строки не проверяются, поэтому миграция не
--    упадёт, даже если в истории есть записи на уже удалённые тренировки
--    (ничего не удаляем молча). Новые записи проверяются как обычно.
-- 3. Обновляет кэш схемы PostgREST.
--
-- Безопасно выполнять повторно. Данные не меняет.

do $$
declare
  r record;
begin
  for r in
    select c.conname
    from pg_constraint c
    join pg_attribute a
      on a.attrelid = c.conrelid and a.attnum = any (c.conkey)
    where c.conrelid = 'public.workout_logs'::regclass
      and c.contype = 'f'
      and a.attname = 'workout_id'
  loop
    execute format('alter table public.workout_logs drop constraint %I', r.conname);
  end loop;
end;
$$;

alter table public.workout_logs
  add constraint workout_logs_workout_id_fkey
  foreign key (workout_id) references public.workouts (id) on delete cascade
  not valid;

create index if not exists workout_logs_workout_id_idx on public.workout_logs (workout_id);

notify pgrst, 'reload schema';

-- Проверка (по желанию): сколько записей истории ссылаются на
-- несуществующие тренировки. 0 — всё чисто.
-- select count(*) from public.workout_logs l
-- where not exists (select 1 from public.workouts w where w.id = l.workout_id);
