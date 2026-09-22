-- 0062_admin_write_workout_logs.sql
-- Новая функция в админке ("Уже занимался раньше" — форс-мажорное
-- обновление прогресса клиента тренером) требует, чтобы админ мог
-- вставлять записи в workout_logs ЗА другого пользователя. Текущая
-- политика ("workout_logs_own") разрешает только user_id = auth.uid() —
-- то есть каждый пишет только за себя, включая админа. Добавляем
-- отдельную политику для админа, по тому же паттерну, что уже
-- используется для других таблиц (is_admin()).
--
-- Безопасно выполнять повторно.

drop policy if exists "workout_logs_admin_write" on public.workout_logs;
create policy "workout_logs_admin_write" on public.workout_logs
  for all using (public.is_admin()) with check (public.is_admin());
