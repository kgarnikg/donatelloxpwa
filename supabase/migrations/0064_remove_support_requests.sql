-- 0064_remove_support_requests.sql
-- Отмена 0063 — "Помощь" переделана на простую mailto-ссылку (открывает
-- обычную почту пользователя с готовым письмом), без бэкенда вообще.
-- Пользователю не критично было скрывать почту тренера и не критична
-- автоматика со скриншотом — а ради этих двух удобств и был весь
-- бэкенд (Vercel-функция, таблица, приватное хранилище). Раз это не
-- нужно — убираем лишнее, а не оставляем неиспользуемым мёртвым весом.
--
-- Безопасно выполнять повторно (DROP ... IF EXISTS).

drop policy if exists "support_attachments_own_upload" on storage.objects;
delete from storage.buckets where id = 'support-attachments';

drop table if exists public.support_requests;
