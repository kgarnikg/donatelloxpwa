-- 0026_add_volume_tracking.sql
-- «Сколько веса поднято» — за тренировку/неделю/месяц/год/всё время, плюс
-- мотивационные достижения за суммарный поднятый вес.
--
-- total_volume_kg на workout_logs — это вес × повторения, просуммированные
-- по всем подходам тренировки. Считается и записывается ОДИН раз на
-- клиенте в момент завершения тренировки (WorkoutPlayerPage уже держит в
-- памяти все веса и повторения по каждому подходу в этот момент — это
-- самый надёжный источник) — а не пересчитывается на лету из
-- completed_sets, потому что там хранится только вес на упражнение, без
-- фактических повторений по каждому подходу.
--
-- Разбивка по периодам (неделя/месяц/год/всё время) считается на клиенте
-- из workout_logs.completed_at + total_volume_kg — отдельная агрегирующая
-- таблица не нужна при разумных объёмах данных на пользователя.
--
-- Безопасно выполнять повторно.

alter table public.workout_logs
  add column if not exists total_volume_kg numeric not null default 0;

comment on column public.workout_logs.total_volume_kg is
  'Суммарный поднятый вес за тренировку (вес × повторения по всем подходам). Считается на клиенте при завершении тренировки, см. WorkoutPlayerPage.tsx.';

-- Расширяем категории каталога достижений (0023) новой — 'volume'.
alter table public.achievements drop constraint if exists achievements_category_check;
alter table public.achievements add constraint achievements_category_check
  check (category in ('workouts', 'streak', 'special', 'volume'));

insert into public.achievements (slug, title, description, icon, category, threshold, sort_order) values
  ('volume_1000',   'Первая тонна',      'Суммарно поднято 1 000 кг',       '🪨', 'volume', 1000,    20),
  ('volume_5000',   'Пять тонн',         'Суммарно поднято 5 000 кг',       '🏋️', 'volume', 5000,    21),
  ('volume_10000',  'Десять тонн',       'Суммарно поднято 10 000 кг',      '🏋️‍♂️', 'volume', 10000,   22),
  ('volume_25000',  'Четверть автобуса', 'Суммарно поднято 25 000 кг',      '🚌', 'volume', 25000,   23),
  ('volume_50000',  'Полсотни тонн',     'Суммарно поднято 50 000 кг',      '🐘', 'volume', 50000,   24),
  ('volume_100000', 'Сто тонн',          'Суммарно поднято 100 000 кг',     '🚀', 'volume', 100000,  25),
  ('volume_250000', 'Четверть миллиона', 'Суммарно поднято 250 000 кг',     '👑', 'volume', 250000,  26),
  ('volume_500000', 'Полмиллиона',       'Суммарно поднято 500 000 кг',     '💎', 'volume', 500000,  27)
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Переопределяем триггерную функцию из 0023: добавляем проверку по
-- суммарному поднятому весу за всё время. Остальная логика (тренировки,
-- серии дней) не меняется.
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
  v_total_volume numeric;
begin
  select count(*) into v_total_workouts
  from public.workout_logs
  where user_id = new.user_id;

  select coalesce(sum(total_volume_kg), 0) into v_total_volume
  from public.workout_logs
  where user_id = new.user_id;

  v_streak := public.calculate_streak_days(new.user_id);

  insert into public.user_achievements (user_id, achievement_id)
  select new.user_id, a.id
  from public.achievements a
  where (a.category = 'workouts' and a.threshold <= v_total_workouts)
     or (a.category = 'streak' and a.threshold <= v_streak)
     or (a.category = 'volume' and a.threshold <= v_total_volume)
  on conflict (user_id, achievement_id) do nothing;

  return new;
end;
$$;
