-- 0009_fix_workout_logs_fkey.sql
-- Обнаружена точная причина ошибки "violates foreign key constraint
-- workout_logs_user_id_fkey": сам constraint ссылался на таблицу `profiles`
-- (остаток какого-то раннего черновика схемы), а не на `public.users`,
-- как задумано в 0001. Таблица workout_logs уже существовала в базе с
-- этой неправильной ссылкой ещё до первого полного запуска 0001, поэтому
-- `create table if not exists` каждый раз её пропускала.
--
-- Безопасно выполнять повторно.

alter table public.workout_logs
  drop constraint if exists workout_logs_user_id_fkey;

alter table public.workout_logs
  add constraint workout_logs_user_id_fkey
  foreign key (user_id) references public.users (id) on delete cascade;
