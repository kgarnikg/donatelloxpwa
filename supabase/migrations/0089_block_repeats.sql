-- 0089: повторы недель в программах тренера.
--
-- Программы собраны блоками ("Месяц 2 — LEVEL 2", "Недели 1–2 — Фундамент"):
-- в блоке недельный набор из 3–4 тренировок, который нужно проходить всю
-- длину блока — месяц 4 недели подряд, "недели 1–2" две недели подряд.
-- Приложение проходило каждую тренировку ОДИН раз, и годовая программа
-- заканчивалась в 2–4 раза быстрее (у "Похудение · Женщины · Зал" — ~3 месяца).
--
-- workouts.block_repeats — сколько раз повторяется недельный набор блока
-- (одинаково у всех тренировок блока). Проставлено по названиям блоков:
-- "Месяц N" = 4, "недели 1–2" = 2, "неделя 3" = 1; если в блоке больше
-- тренировок, чем тренировок в неделю (блок уже расписан на несколько
-- недель), повторов меньше. Поменять можно в админке (Программы → блок).
-- Прогресс считается по числу выполнений каждой тренировки
-- (packages/types/src/programProgress.ts) — старые записи не теряются.
--
-- Безопасно выполнять повторно.

alter table public.workouts
  add column if not exists block_repeats smallint not null default 1;

do $$ begin
  alter table public.workouts
    add constraint workouts_block_repeats_range check (block_repeats between 1 and 12);
exception when duplicate_object then null; end $$;

comment on column public.workouts.block_repeats is
  'Сколько раз повторяется недельный набор блока (0089): месяц — 4, "недели 1–2" — 2. Одинаково у всех тренировок блока (week_order).';

update public.workouts w
set block_repeats = v.repeats
from (values
  ('pohudenie-zhenshchiny-doma', 1, 2),
  ('pohudenie-zhenshchiny-doma', 2, 2),
  ('pohudenie-zhenshchiny-doma', 3, 2),
  ('pohudenie-zhenshchiny-doma', 4, 2),
  ('pohudenie-zhenshchiny-doma', 5, 2),
  ('pohudenie-zhenshchiny-doma', 6, 2),
  ('pohudenie-zhenshchiny-doma', 7, 2),
  ('pohudenie-zhenshchiny-doma', 8, 2),
  ('pohudenie-zhenshchiny-doma', 9, 2),
  ('pohudenie-zhenshchiny-doma', 10, 2),
  ('pohudenie-zhenshchiny-doma', 11, 2),
  ('pohudenie-zhenshchiny-doma', 12, 2),
  ('pohudenie-zhenshchiny-doma', 13, 2),
  ('pohudenie-zhenshchiny-doma', 14, 2),
  ('pohudenie-zhenshchiny-doma', 15, 2),
  ('pohudenie-zhenshchiny-doma', 16, 2),
  ('pohudenie-zhenshchiny-doma', 17, 2),
  ('pohudenie-zhenshchiny-doma', 18, 2),
  ('pohudenie-zhenshchiny-doma', 19, 2),
  ('pohudenie-zhenshchiny-doma', 20, 2),
  ('pohudenie-zhenshchiny-doma', 21, 2),
  ('pohudenie-zhenshchiny-doma', 22, 2),
  ('pohudenie-zhenshchiny-doma', 23, 2),
  ('pohudenie-zhenshchiny-doma', 24, 2),
  ('pohudenie-zhenshchiny-zal', 1, 4),
  ('pohudenie-zhenshchiny-zal', 2, 4),
  ('pohudenie-zhenshchiny-zal', 3, 4),
  ('pohudenie-zhenshchiny-zal', 4, 4),
  ('pohudenie-zhenshchiny-zal', 5, 4),
  ('pohudenie-zhenshchiny-zal', 6, 4),
  ('pohudenie-zhenshchiny-zal', 7, 4),
  ('pohudenie-zhenshchiny-zal', 8, 4),
  ('pohudenie-zhenshchiny-zal', 9, 4),
  ('pohudenie-zhenshchiny-zal', 10, 4),
  ('pohudenie-zhenshchiny-zal', 11, 4),
  ('pohudenie-zhenshchiny-zal', 12, 4),
  ('nabor-massy-zhenshchiny-doma', 1, 2),
  ('nabor-massy-zhenshchiny-doma', 3, 2),
  ('nabor-massy-zhenshchiny-doma', 4, 2),
  ('nabor-massy-zhenshchiny-doma', 5, 2),
  ('nabor-massy-zhenshchiny-doma', 6, 2),
  ('nabor-massy-zhenshchiny-doma', 7, 2),
  ('nabor-massy-zhenshchiny-doma', 8, 2),
  ('nabor-massy-zhenshchiny-doma', 9, 2),
  ('nabor-massy-zhenshchiny-doma', 10, 2),
  ('nabor-massy-zhenshchiny-doma', 11, 2),
  ('nabor-massy-zhenshchiny-doma', 12, 2),
  ('nabor-massy-zhenshchiny-doma', 13, 2),
  ('nabor-massy-zhenshchiny-doma', 14, 2),
  ('nabor-massy-zhenshchiny-doma', 15, 2),
  ('nabor-massy-zhenshchiny-doma', 16, 2),
  ('nabor-massy-zhenshchiny-doma', 17, 2),
  ('nabor-massy-zhenshchiny-doma', 18, 2),
  ('nabor-massy-zhenshchiny-doma', 19, 2),
  ('nabor-massy-zhenshchiny-doma', 20, 2),
  ('nabor-massy-zhenshchiny-doma', 21, 2),
  ('nabor-massy-zhenshchiny-doma', 22, 2),
  ('nabor-massy-zhenshchiny-doma', 23, 2),
  ('nabor-massy-zhenshchiny-doma', 24, 2),
  ('nabor-massy-zhenshchiny-zal', 1, 2),
  ('nabor-massy-zhenshchiny-zal', 2, 2),
  ('nabor-massy-zhenshchiny-zal', 3, 2),
  ('nabor-massy-zhenshchiny-zal', 4, 2),
  ('nabor-massy-zhenshchiny-zal', 5, 2),
  ('nabor-massy-zhenshchiny-zal', 6, 2),
  ('nabor-massy-zhenshchiny-zal', 7, 2),
  ('nabor-massy-zhenshchiny-zal', 8, 2),
  ('nabor-massy-zhenshchiny-zal', 9, 2),
  ('nabor-massy-zhenshchiny-zal', 10, 2),
  ('nabor-massy-zhenshchiny-zal', 11, 2),
  ('nabor-massy-zhenshchiny-zal', 12, 2),
  ('nabor-massy-zhenshchiny-zal', 13, 2),
  ('nabor-massy-zhenshchiny-zal', 14, 2),
  ('nabor-massy-zhenshchiny-zal', 15, 2),
  ('nabor-massy-zhenshchiny-zal', 16, 2),
  ('nabor-massy-zhenshchiny-zal', 17, 2),
  ('nabor-massy-zhenshchiny-zal', 18, 2),
  ('nabor-massy-zhenshchiny-zal', 19, 2),
  ('nabor-massy-zhenshchiny-zal', 20, 2),
  ('nabor-massy-zhenshchiny-zal', 21, 2),
  ('nabor-massy-zhenshchiny-zal', 22, 2),
  ('nabor-massy-zhenshchiny-zal', 23, 2),
  ('nabor-massy-zhenshchiny-zal', 24, 2),
  ('pohudenie-muzhchiny-doma', 1, 4),
  ('pohudenie-muzhchiny-doma', 2, 4),
  ('pohudenie-muzhchiny-doma', 3, 4),
  ('pohudenie-muzhchiny-doma', 4, 4),
  ('pohudenie-muzhchiny-doma', 5, 4),
  ('pohudenie-muzhchiny-doma', 6, 4),
  ('pohudenie-muzhchiny-doma', 7, 4),
  ('pohudenie-muzhchiny-doma', 8, 4),
  ('pohudenie-muzhchiny-doma', 9, 4),
  ('pohudenie-muzhchiny-doma', 10, 4),
  ('pohudenie-muzhchiny-doma', 11, 4),
  ('pohudenie-muzhchiny-doma', 12, 4),
  ('pohudenie-muzhchiny-zal', 1, 2),
  ('pohudenie-muzhchiny-zal', 4, 2),
  ('pohudenie-muzhchiny-zal', 7, 2),
  ('pohudenie-muzhchiny-zal', 10, 2),
  ('pohudenie-muzhchiny-zal', 13, 2),
  ('pohudenie-muzhchiny-zal', 16, 2),
  ('pohudenie-muzhchiny-zal', 19, 2),
  ('pohudenie-muzhchiny-zal', 22, 2),
  ('pohudenie-muzhchiny-zal', 25, 2),
  ('pohudenie-muzhchiny-zal', 28, 2),
  ('pohudenie-muzhchiny-zal', 31, 2),
  ('pohudenie-muzhchiny-zal', 34, 2),
  ('nabor-massy-muzhchiny-doma', 1, 2),
  ('nabor-massy-muzhchiny-doma', 3, 2),
  ('nabor-massy-muzhchiny-doma', 4, 2),
  ('nabor-massy-muzhchiny-doma', 5, 2),
  ('nabor-massy-muzhchiny-doma', 6, 2),
  ('nabor-massy-muzhchiny-doma', 7, 2),
  ('nabor-massy-muzhchiny-doma', 8, 2),
  ('nabor-massy-muzhchiny-doma', 9, 2),
  ('nabor-massy-muzhchiny-doma', 10, 2),
  ('nabor-massy-muzhchiny-doma', 11, 2),
  ('nabor-massy-muzhchiny-doma', 12, 2),
  ('nabor-massy-muzhchiny-doma', 13, 2),
  ('nabor-massy-muzhchiny-doma', 14, 2),
  ('nabor-massy-muzhchiny-doma', 15, 2),
  ('nabor-massy-muzhchiny-doma', 16, 2),
  ('nabor-massy-muzhchiny-doma', 17, 2),
  ('nabor-massy-muzhchiny-doma', 18, 2),
  ('nabor-massy-muzhchiny-doma', 19, 2),
  ('nabor-massy-muzhchiny-doma', 20, 2),
  ('nabor-massy-muzhchiny-doma', 21, 2),
  ('nabor-massy-muzhchiny-doma', 22, 2),
  ('nabor-massy-muzhchiny-doma', 23, 2),
  ('nabor-massy-muzhchiny-doma', 24, 2),
  ('nabor-massy-muzhchiny-zal', 1, 2),
  ('nabor-massy-muzhchiny-zal', 2, 2),
  ('nabor-massy-muzhchiny-zal', 3, 2),
  ('nabor-massy-muzhchiny-zal', 4, 2),
  ('nabor-massy-muzhchiny-zal', 5, 2),
  ('nabor-massy-muzhchiny-zal', 6, 2),
  ('nabor-massy-muzhchiny-zal', 7, 2),
  ('nabor-massy-muzhchiny-zal', 8, 2),
  ('nabor-massy-muzhchiny-zal', 9, 2),
  ('nabor-massy-muzhchiny-zal', 10, 2),
  ('nabor-massy-muzhchiny-zal', 11, 2),
  ('nabor-massy-muzhchiny-zal', 12, 2),
  ('nabor-massy-muzhchiny-zal', 13, 2),
  ('nabor-massy-muzhchiny-zal', 14, 2),
  ('nabor-massy-muzhchiny-zal', 15, 2),
  ('nabor-massy-muzhchiny-zal', 16, 2),
  ('nabor-massy-muzhchiny-zal', 17, 2),
  ('nabor-massy-muzhchiny-zal', 18, 2),
  ('nabor-massy-muzhchiny-zal', 19, 2),
  ('nabor-massy-muzhchiny-zal', 20, 2),
  ('nabor-massy-muzhchiny-zal', 21, 2),
  ('nabor-massy-muzhchiny-zal', 22, 2),
  ('nabor-massy-muzhchiny-zal', 23, 2),
  ('nabor-massy-muzhchiny-zal', 24, 2)
) as v(slug, week_order, repeats)
join public.workout_programs p on p.slug = v.slug
where w.program_id = p.id
  and w.week_order = v.week_order;

-- Длительность годовых программ в каталоге ("24 недели" было неверно)
update public.workout_programs
set duration_weeks = 48, updated_at = now()
where slug in (
  'pohudenie-zhenshchiny-doma', 'pohudenie-zhenshchiny-zal', 'nabor-massy-zhenshchiny-doma',
  'nabor-massy-zhenshchiny-zal', 'pohudenie-muzhchiny-doma', 'pohudenie-muzhchiny-zal',
  'nabor-massy-muzhchiny-doma', 'nabor-massy-muzhchiny-zal'
);

-- Админка: поменять число недель блока одним вызовом
create or replace function public.admin_set_block_repeats(p_program_id uuid, p_week_order integer, p_repeats integer)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Недостаточно прав' using errcode = '42501';
  end if;
  update public.workouts
  set block_repeats = greatest(1, least(12, p_repeats))
  where program_id = p_program_id and week_order = p_week_order;
end;
$$;

revoke all on function public.admin_set_block_repeats(uuid, integer, integer) from public, anon;
grant execute on function public.admin_set_block_repeats(uuid, integer, integer) to authenticated;

notify pgrst, 'reload schema';
