-- 0012_add_program_targeting.sql
-- Добавляет прицеливание программ по полу и формату тренировок.
--
-- Контекст: сейчас useRecommendedProgram() в apps/web подбирает программу
-- только по полю goal, полностью игнорируя пол пользователя и формат
-- (зал/дома). Это было незаметно, пока в базе существовала только одна
-- программа. С добавлением 8 полных годовых программ (мужчины/женщины ×
-- похудение/набор массы × дом/зал) подбор обязан учитывать все три
-- измерения анкеты, иначе, например, мужчине с целью "похудение" в зале
-- может достаться женская домашняя программа — просто потому что у неё
-- совпадает goal.
--
-- Оставляем goal и duration_weeks/workouts_per_week как есть — они уже
-- корректно описывают программу, просто добавляем два новых измерения.
-- Безопасно выполнять повторно.

alter table public.workout_programs
  add column if not exists gender text
    check (gender in ('male', 'female', 'unspecified')) default 'unspecified',
  add column if not exists training_format text
    check (training_format in ('gym', 'home', 'any')) default 'any';

comment on column public.workout_programs.gender is
  'Целевой пол программы. ''unspecified'' — подходит любому полу (fallback-программы).';
comment on column public.workout_programs.training_format is
  'Целевой формат тренировок. ''any'' — подходит и залу, и дому (fallback-программы).';

-- Индекс под основной паттерн подбора: точное совпадение по трём полям.
create index if not exists workout_programs_targeting_idx
  on public.workout_programs (gender, goal, training_format);

-- Существующая программа-заглушка ("Набор массы для начинающих") была
-- задумана как мужская, для зала — проставляем это явно, чтобы она не
-- обгоняла в подборе более точные новые программы после Шага 3.
update public.workout_programs
set gender = 'male', training_format = 'gym'
where slug = 'nabor-massy-nachinayushchim';
