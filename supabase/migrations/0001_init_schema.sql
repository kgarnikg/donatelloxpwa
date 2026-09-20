-- 0001_init_schema.sql
-- Базовая схема DonatelleX: пользователи, подписки, платежи, программы тренировок.
-- Выполнить один раз в Supabase → SQL Editor (или через `supabase db push`).

-- ---------------------------------------------------------------------------
-- Расширения
-- ---------------------------------------------------------------------------
create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------------
-- Пользователи (расширяет auth.users данными профиля из @donatellox/types)
-- ---------------------------------------------------------------------------
create table if not exists public.users (
  id uuid primary key references auth.users (id) on delete cascade,
  email text not null,
  phone text,
  full_name text not null default '',
  avatar_url text,
  locale text not null default 'ru' check (locale in ('ru', 'en', 'es')),
  role text not null default 'athlete' check (role in ('athlete', 'coach', 'admin', 'superadmin')),
  auth_provider text not null default 'email' check (auth_provider in ('email', 'google', 'apple', 'telegram')),
  email_verified boolean not null default false,
  onboarding_completed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  last_seen_at timestamptz
);

-- Анкета — заполняется на онбординге
create table if not exists public.user_profiles (
  user_id uuid primary key references public.users (id) on delete cascade,
  gender text not null default 'unspecified' check (gender in ('male', 'female', 'unspecified')),
  birth_date date,
  height_cm numeric,
  weight_kg numeric,
  activity_level text not null default 'moderate'
    check (activity_level in ('sedentary', 'light', 'moderate', 'active', 'very_active')),
  goals text[] not null default '{}',
  health_notes text,
  preferred_language text not null default 'ru' check (preferred_language in ('ru', 'en', 'es')),
  updated_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Упражнения и программы тренировок
-- ---------------------------------------------------------------------------
create table if not exists public.exercises (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  description text,
  muscle_groups text[] not null default '{}',
  difficulty text not null default 'beginner' check (difficulty in ('beginner', 'intermediate', 'advanced')),
  video_url text,
  thumbnail_url text,
  duration_seconds integer,
  equipment text[] not null default '{}',
  created_at timestamptz not null default now()
);

create table if not exists public.workout_programs (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  description text not null default '',
  cover_url text,
  goal text not null default 'general_fitness'
    check (goal in ('lose_weight', 'build_muscle', 'improve_endurance', 'general_fitness', 'rehabilitation')),
  difficulty text not null default 'beginner' check (difficulty in ('beginner', 'intermediate', 'advanced')),
  duration_weeks integer not null default 4,
  workouts_per_week integer not null default 3,
  is_premium boolean not null default true,
  locale text not null default 'ru' check (locale in ('ru', 'en', 'es')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.workouts (
  id uuid primary key default gen_random_uuid(),
  program_id uuid not null references public.workout_programs (id) on delete cascade,
  title text not null,
  "order" integer not null default 0,
  estimated_duration_minutes integer not null default 45,
  created_at timestamptz not null default now()
);

create table if not exists public.workout_sets (
  id uuid primary key default gen_random_uuid(),
  workout_id uuid not null references public.workouts (id) on delete cascade,
  exercise_id uuid not null references public.exercises (id) on delete restrict,
  "order" integer not null default 0,
  reps integer,
  duration_seconds integer,
  rest_seconds integer not null default 60,
  weight_kg numeric,
  notes text
);

create index if not exists workouts_program_id_idx on public.workouts (program_id);
create index if not exists workout_sets_workout_id_idx on public.workout_sets (workout_id);

-- ---------------------------------------------------------------------------
-- Дневник тренировок и прогресс пользователя
-- ---------------------------------------------------------------------------
create table if not exists public.workout_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  workout_id uuid not null references public.workouts (id) on delete cascade,
  completed_at timestamptz not null default now(),
  duration_minutes integer not null default 0,
  perceived_effort smallint check (perceived_effort between 1 and 5),
  notes text,
  completed_sets jsonb not null default '[]'
);

create table if not exists public.progress_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  recorded_at timestamptz not null default now(),
  weight_kg numeric,
  body_fat_percent numeric,
  measurements jsonb,
  photo_urls text[] not null default '{}'
);

-- ---------------------------------------------------------------------------
-- Подписки и платежи
-- ---------------------------------------------------------------------------
create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  plan text not null check (plan in ('monthly', 'quarterly', 'semiannual', 'annual')),
  status text not null default 'incomplete'
    check (status in ('trialing', 'active', 'past_due', 'canceled', 'expired', 'incomplete')),
  current_period_start timestamptz not null default now(),
  current_period_end timestamptz not null default now(),
  cancel_at_period_end boolean not null default false,
  provider text not null check (provider in ('stripe', 'paypal', 'yookassa', 'usdt')),
  provider_subscription_id text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.users (id) on delete set null,
  subscription_id uuid references public.subscriptions (id) on delete set null,
  provider text not null check (provider in ('stripe', 'paypal', 'yookassa', 'usdt')),
  provider_payment_id text not null,
  amount numeric not null,
  currency text not null check (currency in ('EUR', 'USD', 'RUB', 'USDT')),
  status text not null default 'pending'
    check (status in ('pending', 'confirmed', 'failed', 'refunded', 'expired')),
  crypto_tx_hash text,
  crypto_network text check (crypto_network in ('TRC20', 'ERC20', 'BEP20')),
  raw_payload jsonb,
  created_at timestamptz not null default now(),
  confirmed_at timestamptz,
  unique (provider, provider_payment_id)
);

create index if not exists payments_user_id_idx on public.payments (user_id);
create index if not exists subscriptions_user_id_idx on public.subscriptions (user_id);

-- Активирует/продлевает подписку после подтверждённого платежа.
-- Вызывается из Edge Function `payment-webhook`.
create or replace function public.activate_subscription_from_payment(
  p_subscription_id uuid,
  p_payment_id uuid
) returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_plan text;
  v_interval interval;
begin
  select plan into v_plan from public.subscriptions where id = p_subscription_id;

  v_interval := case v_plan
    when 'monthly' then interval '1 month'
    when 'quarterly' then interval '3 months'
    when 'semiannual' then interval '6 months'
    when 'annual' then interval '1 year'
    else interval '1 month'
  end;

  update public.subscriptions
  set status = 'active',
      current_period_start = now(),
      current_period_end = greatest(current_period_end, now()) + v_interval,
      updated_at = now()
  where id = p_subscription_id;
end;
$$;

-- ---------------------------------------------------------------------------
-- Уведомления
-- ---------------------------------------------------------------------------
create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  type text not null check (type in ('workout_reminder', 'subscription_expiring', 'payment_failed', 'new_program', 'system')),
  title text not null,
  body text not null,
  read boolean not null default false,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Автосоздание строки в public.users при регистрации через Supabase Auth
-- ---------------------------------------------------------------------------
create or replace function public.handle_new_auth_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.users (id, email, full_name, auth_provider, email_verified)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'full_name', ''),
    coalesce(new.raw_app_meta_data ->> 'provider', 'email'),
    new.email_confirmed_at is not null
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_auth_user();

-- ---------------------------------------------------------------------------
-- Row Level Security
-- ---------------------------------------------------------------------------
alter table public.users enable row level security;
alter table public.user_profiles enable row level security;
alter table public.exercises enable row level security;
alter table public.workout_programs enable row level security;
alter table public.workouts enable row level security;
alter table public.workout_sets enable row level security;
alter table public.workout_logs enable row level security;
alter table public.progress_entries enable row level security;
alter table public.subscriptions enable row level security;
alter table public.payments enable row level security;
alter table public.notifications enable row level security;

-- Вспомогательная функция: текущий пользователь — admin/superadmin?
create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from public.users
    where id = auth.uid() and role in ('admin', 'superadmin')
  );
$$;

-- users: видеть/менять можно только свою строку; админы видят всех
create policy "users_select_own_or_admin" on public.users
  for select using (id = auth.uid() or public.is_admin());
create policy "users_update_own_or_admin" on public.users
  for update using (id = auth.uid() or public.is_admin());

-- user_profiles: только свой профиль
create policy "profiles_select_own_or_admin" on public.user_profiles
  for select using (user_id = auth.uid() or public.is_admin());
create policy "profiles_upsert_own" on public.user_profiles
  for insert with check (user_id = auth.uid());
create policy "profiles_update_own" on public.user_profiles
  for update using (user_id = auth.uid());

-- exercises / programs / workouts / sets: читать может любой авторизованный
-- пользователь (пейволл — на уровне UI по полю is_premium + подписке),
-- писать — только админы.
create policy "exercises_read_all" on public.exercises
  for select using (auth.role() = 'authenticated');
create policy "exercises_write_admin" on public.exercises
  for all using (public.is_admin()) with check (public.is_admin());

create policy "programs_read_all" on public.workout_programs
  for select using (auth.role() = 'authenticated');
create policy "programs_write_admin" on public.workout_programs
  for all using (public.is_admin()) with check (public.is_admin());

create policy "workouts_read_all" on public.workouts
  for select using (auth.role() = 'authenticated');
create policy "workouts_write_admin" on public.workouts
  for all using (public.is_admin()) with check (public.is_admin());

create policy "workout_sets_read_all" on public.workout_sets
  for select using (auth.role() = 'authenticated');
create policy "workout_sets_write_admin" on public.workout_sets
  for all using (public.is_admin()) with check (public.is_admin());

-- workout_logs / progress_entries: только свои записи
create policy "workout_logs_own" on public.workout_logs
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "progress_entries_own" on public.progress_entries
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- subscriptions / payments: пользователь видит только своё; изменяют —
-- только сервис (service_role, из Edge Function) и админы через CMS.
create policy "subscriptions_select_own_or_admin" on public.subscriptions
  for select using (user_id = auth.uid() or public.is_admin());
create policy "payments_select_own_or_admin" on public.payments
  for select using (user_id = auth.uid() or public.is_admin());

-- notifications: только свои
create policy "notifications_own" on public.notifications
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
