-- 0063_support_requests.sql
-- "Помощь" в приложении — клиент пишет о проблеме, может прикрепить
-- скриншот, тренер получает это на почту, но сам email тренера нигде
-- не виден клиенту (только ждёт ответа). Заводим и таблицу (durable-
-- запись, видна админу даже если письмо не дойдёт), и хранилище под
-- скриншоты (первое использование Supabase Storage в проекте).
--
-- Безопасно выполнять повторно.

create table if not exists public.support_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  message text not null,
  screenshot_path text,
  status text not null default 'new' check (status in ('new', 'replied', 'closed')),
  created_at timestamptz not null default now()
);

alter table public.support_requests enable row level security;

drop policy if exists "support_requests_own_insert" on public.support_requests;
create policy "support_requests_own_insert" on public.support_requests
  for insert with check (user_id = auth.uid());

drop policy if exists "support_requests_own_read" on public.support_requests;
create policy "support_requests_own_read" on public.support_requests
  for select using (user_id = auth.uid() or public.is_admin());

drop policy if exists "support_requests_admin_write" on public.support_requests;
create policy "support_requests_admin_write" on public.support_requests
  for update using (public.is_admin()) with check (public.is_admin());

comment on table public.support_requests is
  'Обращения в поддержку из приложения ("Помощь" в профиле) — текст + опциональный скриншот. Письмо на почту тренера отправляется отдельной Edge Function (send-support-request), эта таблица — durable-копия на случай сбоя письма и для просмотра админом.';

-- Хранилище под скриншоты — приватный бакет, не публичный (могут быть
-- личные данные на скрине). Каждый пользователь пишет только в свою
-- собственную папку ({user_id}/...); читает файлы только Edge Function
-- через service_role (обходит RLS полностью, отдельной read-политики
-- для клиентов не нужно — они прикрепляют и сразу забывают об этом).
insert into storage.buckets (id, name, public)
values ('support-attachments', 'support-attachments', false)
on conflict (id) do nothing;

drop policy if exists "support_attachments_own_upload" on storage.objects;
create policy "support_attachments_own_upload" on storage.objects
  for insert with check (
    bucket_id = 'support-attachments'
    and (storage.foldername(name))[1] = auth.uid()::text
  );
