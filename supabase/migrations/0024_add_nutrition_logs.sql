-- 0024_add_nutrition_logs.sql
-- Ручной учёт калорий и приёмов пищи.
--
-- Ручной ввод — осознанное решение, не заглушка: PWA (веб-приложение в
-- браузере) не имеет доступа к Apple HealthKit / Google Health Connect —
-- это API только для нативных приложений. Автосинхронизация с часами и
-- телефоном потребует нативной обёртки (Capacitor/React Native) — это
-- отдельная задача на будущее, отмечена в разделе 9 PROJECT_PLAN.md.
--
-- Безопасно выполнять повторно.

create table if not exists public.nutrition_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  logged_at date not null default current_date,
  meal_type text not null default 'other'
    check (meal_type in ('breakfast', 'lunch', 'dinner', 'snack', 'other')),
  title text not null,
  calories integer not null check (calories >= 0),
  protein_g numeric check (protein_g >= 0),
  carbs_g numeric check (carbs_g >= 0),
  fat_g numeric check (fat_g >= 0),
  created_at timestamptz not null default now()
);

create index if not exists nutrition_logs_user_date_idx
  on public.nutrition_logs (user_id, logged_at);

alter table public.nutrition_logs enable row level security;

drop policy if exists "nutrition_logs_own" on public.nutrition_logs;
create policy "nutrition_logs_own" on public.nutrition_logs
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
