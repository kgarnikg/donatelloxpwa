-- 0010_fix_subscriptions_table.sql
-- Таблица public.subscriptions оказалась тем же самым старым черновиком
-- (FK на несуществующую profiles(id), и, вероятно, вообще другой набор
-- колонок), что и workout_logs/workouts ранее. Так как ни один реальный
-- платёж ещё не обрабатывался, безопасно пересоздать её с нуля по схеме
-- из 0001.
--
-- Безопасно выполнять повторно.

-- Сначала снимаем зависящий FK с payments, иначе DROP TABLE ... CASCADE
-- заодно снесёт и его.
alter table public.payments drop constraint if exists payments_subscription_id_fkey;

drop table if exists public.subscriptions cascade;

create table public.subscriptions (
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

create index subscriptions_user_id_idx on public.subscriptions (user_id);

alter table public.payments
  add constraint payments_subscription_id_fkey
  foreign key (subscription_id) references public.subscriptions (id) on delete set null;

alter table public.subscriptions enable row level security;

create policy "subscriptions_select_own_or_admin" on public.subscriptions
  for select using (user_id = auth.uid() or public.is_admin());
