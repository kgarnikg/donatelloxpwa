-- 0025_add_calorie_tracking.sql
-- Замена ручного дневника питания (0024) на автоматический расчёт
-- расхода калорий.
--
-- Контекст решения: у нас уже есть рост/вес/возраст/пол (user_profiles)
-- и фактические тренировки (workout_logs) — этого достаточно, чтобы
-- автоматически ОЦЕНИВАТЬ расход калорий (формула Миффлина-Сан Жеора +
-- коэффициент активности + бонус за тренировку), не требуя от
-- пользователя ничего вводить руками. Это именно РАСХОД (как считают
-- умные часы), а не съеденные калории — введённый вручную дневник еды
-- из 0024 этой задаче не соответствовал, поэтому она заменяется, а не
-- дополняется.
--
-- 0024 (`nutrition_logs`) была создана в той же рабочей сессии и ещё не
-- вышла "в жизнь" как отдельная фича — поэтому здесь она безопасно
-- удаляется, а не оставляется мёртвым весом рядом с новой таблицей.
-- Правило "не редактируем старые миграции" при этом не нарушено: сама
-- 0024 не редактируется, откат оформлен новой миграцией.
--
-- Ручной ввод НЕ убран — пользователь может переопределить наш расчёт на
-- конкретный день (например, данными со своих умных часов). Пока
-- переопределения на день нет — используется автоматическая оценка,
-- целиком считается на клиенте (formula в apps/web/src/lib/calories.ts),
-- в БД ничего лишнего не хранится.
--
-- Безопасно выполнять повторно.

drop table if exists public.nutrition_logs;

create table if not exists public.calorie_overrides (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  logged_at date not null,
  calories integer not null check (calories >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, logged_at)
);

create index if not exists calorie_overrides_user_date_idx
  on public.calorie_overrides (user_id, logged_at);

alter table public.calorie_overrides enable row level security;

drop policy if exists "calorie_overrides_own" on public.calorie_overrides;
create policy "calorie_overrides_own" on public.calorie_overrides
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
