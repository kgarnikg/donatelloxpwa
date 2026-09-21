-- 0060_fix_armenian_tricep_bicep.sql
-- Исправление в армянском переводе: "трицепс"/"бицепс" переводились
-- транслитерацией ("տրիցեպս"/"բիցեպս"), а не настоящими армянскими
-- анатомическими терминами. Правильно:
--   трицепс → եռագլուխ մկան
--   бицепс  → բազկի երկգլուխ մկան
--
-- Через replace() — эти слова встречаются и как отдельные заголовки
-- (напр. день "ГРУДЬ + ТРИЦЕПС"), и внутри более длинных названий
-- упражнений/заметок, где полная замена по строке не подошла бы.
-- Оба варианта регистра (с заглавной — начало фразы, со строчной —
-- середина фразы) — сопоставление в translator_hy.py регистронезависимое
-- при поиске, но сама подстановка сохраняет регистр первой буквы слова.
--
-- Безопасно выполнять повторно (replace от уже исправленного текста —
-- no-op, если старой формы там больше нет).

-- exercises.title_hy
update public.exercises
set title_hy = replace(replace(title_hy, 'Տրիցեպս', 'Եռագլուխ մկան'), 'տրիցեպս', 'եռագլուխ մկան')
where title_hy ilike '%տրիցեպս%';

update public.exercises
set title_hy = replace(replace(title_hy, 'Բիցեպս', 'Բազկի երկգլուխ մկան'), 'բիցեպս', 'բազկի երկգլուխ մկան')
where title_hy ilike '%բիցեպս%';

-- workouts.title_hy (напр. заголовки дней "Երկուշաբթի · Կրծքավանդակ + Տրիցեպս")
update public.workouts
set title_hy = replace(replace(title_hy, 'Տրիցեպս', 'Եռագլուխ մկան'), 'տրիցեպս', 'եռագլուխ մկան')
where title_hy ilike '%տրիցեպս%';

update public.workouts
set title_hy = replace(replace(title_hy, 'Բիցեպս', 'Բազկի երկգլուխ մկան'), 'բիցեպս', 'բազկի երկգլուխ մկան')
where title_hy ilike '%բիցեպս%';

-- workouts.week_label_hy (на случай, если слово встречается и в подписях недельных блоков)
update public.workouts
set week_label_hy = replace(replace(week_label_hy, 'Տրիցեպս', 'Եռագլուխ մկան'), 'տրիցեպս', 'եռագլուխ մկան')
where week_label_hy ilike '%տրիցեպս%';

update public.workouts
set week_label_hy = replace(replace(week_label_hy, 'Բիցեպս', 'Բազկի երկգլուխ մկան'), 'բիցեպս', 'բազկի երկգլուխ մկան')
where week_label_hy ilike '%բիցեպս%';

-- workout_sets.notes_hy
update public.workout_sets
set notes_hy = replace(replace(notes_hy, 'Տրիցեպս', 'Եռագլուխ մկան'), 'տրիցեպս', 'եռագլուխ մկան')
where notes_hy ilike '%տրիցեպս%';

update public.workout_sets
set notes_hy = replace(replace(notes_hy, 'Բիցեպս', 'Բազկի երկգլուխ մկան'), 'բիցեպս', 'բազկի երկգլուխ մկան')
where notes_hy ilike '%բիցեպս%';
