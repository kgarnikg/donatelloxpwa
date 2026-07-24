-- 0005_grants.sql
-- Явно выдаёт права на таблицы схемы public ролям anon/authenticated.
--
-- Почему это нужно: RLS-политики (created in 0001) определяют, КАКИЕ строки
-- видны/доступны, но это работает только поверх базовых прав PostgreSQL
-- (GRANT). Если таблицы создаются через SQL Editor, а не через Table Editor
-- в интерфейсе Supabase, базовые права на INSERT/UPDATE/DELETE для ролей
-- anon/authenticated иногда не выдаются автоматически — из-за этого запись
-- (например, сохранение завершённой тренировки) молча ничего не делает,
-- хотя RLS-политика на это разрешает.
--
-- Безопасно выполнять повторно.

grant usage on schema public to anon, authenticated;

grant select, insert, update, delete on all tables in schema public to authenticated;
grant select on all tables in schema public to anon;

grant usage, select on all sequences in schema public to authenticated;

-- Чтобы будущие таблицы (созданные позже через SQL Editor) тоже получали
-- эти права автоматически, без необходимости повторять этот скрипт.
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema public
  grant select on tables to anon;
alter default privileges in schema public
  grant usage, select on sequences to authenticated;
