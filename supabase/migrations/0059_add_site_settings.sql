-- 0059_add_site_settings.sql
-- Общая key-value таблица под настройки сайта, редактируемые из админки
-- без редеплоя (в отличие от переменных окружения). Первое применение —
-- ссылка на видео-ролик для кнопки "Узнать больше" на лендинге, но
-- таблица намеренно универсальная — под любые будущие настройки того же
-- рода (не плодить отдельную миграцию/колонку на каждую новую настройку).
--
-- Публично читаемо (лендинг обращается без авторизации — у него нет
-- логина вообще), пишет только админ.
--
-- Безопасно выполнять повторно.

create table if not exists public.site_settings (
  key text primary key,
  value text,
  updated_at timestamptz not null default now()
);

alter table public.site_settings enable row level security;

drop policy if exists "site_settings_read_all" on public.site_settings;
create policy "site_settings_read_all" on public.site_settings
  for select using (true);

drop policy if exists "site_settings_write_admin" on public.site_settings;
create policy "site_settings_write_admin" on public.site_settings
  for all using (is_admin()) with check (is_admin());

comment on table public.site_settings is
  'Настройки сайта, редактируемые из админки в рантайме (без редеплоя). key — уникальный идентификатор настройки, value — произвольный текст.';
