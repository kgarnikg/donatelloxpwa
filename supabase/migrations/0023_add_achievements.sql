-- 0023_add_achievements.sql
-- Система наград и достижений.
--
-- Архитектурное решение: разблокировка достижений считается на СЕРВЕРЕ,
-- триггером после каждой записи в workout_logs — а не на клиенте. Это
-- специально для надёжности (по просьбе: "очень надёжно чтобы работало"):
-- даже если клиентский код изменится/сломается, разблокировка не зависит
-- от него, и timestamp разблокировки (unlocked_at) фиксируется один раз
-- и не пересчитывается заново при каждой загрузке экрана.
--
-- Личные рекорды (макс. вес по упражнению) НЕ хранятся отдельной таблицей —
-- они уже полностью выводимы из workout_logs.completed_sets (там уже
-- пишется exerciseId + weightKg на каждую завершённую тренировку), поэтому
-- считаются на клиенте из существующих данных без дублирования состояния.
--
-- Безопасно выполнять повторно.

-- ---------------------------------------------------------------------------
-- Каталог достижений (справочник, редактируется только миграциями/CMS)
-- ---------------------------------------------------------------------------
create table if not exists public.achievements (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  description text not null,
  icon text not null default '🏆',
  category text not null check (category in ('workouts', 'streak', 'special')),
  threshold integer not null default 1,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Разблокированные достижения пользователей
-- ---------------------------------------------------------------------------
create table if not exists public.user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users (id) on delete cascade,
  achievement_id uuid not null references public.achievements (id) on delete cascade,
  unlocked_at timestamptz not null default now(),
  unique (user_id, achievement_id)
);

create index if not exists user_achievements_user_id_idx on public.user_achievements (user_id);

alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;

drop policy if exists "achievements_select_all" on public.achievements;
create policy "achievements_select_all" on public.achievements
  for select using (auth.role() = 'authenticated');

drop policy if exists "user_achievements_own" on public.user_achievements;
create policy "user_achievements_own" on public.user_achievements
  for select using (auth.uid() = user_id);
-- Намеренно нет insert/update/delete policy для authenticated — записи
-- создаёт только триггер (security definer, ниже), пользователь не может
-- выдать себе достижение напрямую через API.

-- ---------------------------------------------------------------------------
-- Каталог: пороги по количеству тренировок и по серии дней подряд.
-- ---------------------------------------------------------------------------
insert into public.achievements (slug, title, description, icon, category, threshold, sort_order) values
  ('first_workout',   'Первый шаг',        'Завершите свою первую тренировку',            '🎯', 'workouts', 1,   1),
  ('workouts_10',      'Разгон',            'Завершите 10 тренировок',                      '💪', 'workouts', 10,  2),
  ('workouts_25',      'В ритме',           'Завершите 25 тренировок',                      '🔥', 'workouts', 25,  3),
  ('workouts_50',      'Полсотни',          'Завершите 50 тренировок',                      '⚡', 'workouts', 50,  4),
  ('workouts_100',     'Сотня',             'Завершите 100 тренировок',                     '🏅', 'workouts', 100, 5),
  ('workouts_200',     'Железная воля',     'Завершите 200 тренировок',                     '🏆', 'workouts', 200, 6),
  ('streak_3',         'Разогрев',          'Тренируйтесь 3 дня подряд',                    '🔥', 'streak',   3,   7),
  ('streak_7',         'Неделя силы',       'Тренируйтесь 7 дней подряд',                   '🔥', 'streak',   7,   8),
  ('streak_14',        'Две недели',        'Тренируйтесь 14 дней подряд',                  '🔥', 'streak',   14,  9),
  ('streak_30',        'Месяц без пропусков','Тренируйтесь 30 дней подряд',                 '👑', 'streak',   30,  10),
  ('streak_60',        'Несокрушимый',      'Тренируйтесь 60 дней подряд',                  '💎', 'streak',   60,  11)
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Функция подсчёта текущей серии дней подряд (та же логика, что на
-- клиенте в useWorkoutStats, но на сервере — источник истины для триггера).
-- ---------------------------------------------------------------------------
create or replace function public.calculate_streak_days(p_user_id uuid)
returns integer
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_streak integer := 0;
  v_cursor date := current_date;
  v_has_today boolean;
begin
  select exists (
    select 1 from public.workout_logs
    where user_id = p_user_id and completed_at::date = current_date
  ) into v_has_today;

  if not v_has_today then
    v_cursor := current_date - 1;
  end if;

  while exists (
    select 1 from public.workout_logs
    where user_id = p_user_id and completed_at::date = v_cursor
  ) loop
    v_streak := v_streak + 1;
    v_cursor := v_cursor - 1;
  end loop;

  return v_streak;
end;
$$;

-- ---------------------------------------------------------------------------
-- Триггер: после каждой записи в workout_logs проверяем и разблокируем
-- все достижения, порог которых уже достигнут. ON CONFLICT DO NOTHING —
-- безопасно при повторном срабатывании, дублей не будет.
-- ---------------------------------------------------------------------------
create or replace function public.check_and_unlock_achievements()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_total_workouts integer;
  v_streak integer;
begin
  select count(*) into v_total_workouts
  from public.workout_logs
  where user_id = new.user_id;

  v_streak := public.calculate_streak_days(new.user_id);

  insert into public.user_achievements (user_id, achievement_id)
  select new.user_id, a.id
  from public.achievements a
  where (a.category = 'workouts' and a.threshold <= v_total_workouts)
     or (a.category = 'streak' and a.threshold <= v_streak)
  on conflict (user_id, achievement_id) do nothing;

  return new;
end;
$$;

drop trigger if exists trg_check_achievements on public.workout_logs;
create trigger trg_check_achievements
  after insert on public.workout_logs
  for each row
  execute function public.check_and_unlock_achievements();

grant execute on function public.calculate_streak_days(uuid) to authenticated;
