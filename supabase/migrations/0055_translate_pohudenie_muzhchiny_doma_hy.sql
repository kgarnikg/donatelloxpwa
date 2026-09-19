-- 0055_translate_pohudenie_muzhchiny_doma_hy.sql
-- Армянский перевод: Похудение — Мужчины — Дома
-- Часть Фазы 6 (Локализация контента), армянский заход — см. PROJECT_PLAN.md.
-- Зеркалирует 0031-0038 (EN) / 0041-0048 (ES). Сопоставление — по (slug,
-- week_order, "order") для тренировок, с проверкой количества в конце.
--
-- Первый автоматический проход, рекомендуется вычитка носителем языка.
-- Безопасно выполнять повторно.

do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
  v_updated_workouts int := 0;
begin
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-muzhchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-muzhchiny-doma';
  end if;

  update public.workout_programs
  set title_hy = 'Քաշի նվազեցում համար տղամարդկանց (տանը) — տարեկան ծրագիր', description_hy = 'Քաշի նվազեցում համար տղամարդկանց (տանը) — տարեկան ծրագիր. Սարքավորում. Հանտելներ, առաձգական ժապավեն, турник (ըստ հնարավորության), стул/նստարան, գորգիկ'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 1 — START (Ամիս 1, շաբաթներ 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս + Կարդիո', week_label_hy = 'LEVEL 1 — START (Ամիս 1, շաբաթներ 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Ուրբաթ · Ոտքեր + FULL BODY', week_label_hy = 'LEVEL 1 — START (Ամիս 1, շաբաթներ 1–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 2 — FAT BURN + STRENGTH (Ամիս 2, շաբաթներ 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5–7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12–20'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 2 — FAT BURN + STRENGTH (Ամիս 2, շաբաթներ 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 2 — FAT BURN + STRENGTH (Ամիս 2, շաբաթներ 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5–7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY + FAT BURN', week_label_hy = 'LEVEL 2 — FAT BURN + STRENGTH (Ամիս 2, շաբաթներ 5–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Ամիս 3, շաբաթներ 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Ամիս 3, շաբաթներ 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5–7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Ամիս 3, շաբաթներ 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY FAT BURN', week_label_hy = 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Ամիս 3, շաբաթներ 9–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5–7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 4 — METABOLIC STRENGTH (Ամիս 4, շաբաթներ 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 4 — METABOLIC STRENGTH (Ամիս 4, շաբաթներ 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 4 — METABOLIC STRENGTH (Ամիս 4, շաբաթներ 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY METABOLIC', week_label_hy = 'LEVEL 4 — METABOLIC STRENGTH (Ամիս 4, շաբաթներ 13–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Ամիս 5, շաբաթներ 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Ամիս 5, շաբաթներ 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Ամիս 5, շաբաթներ 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY DEFINITION', week_label_hy = 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Ամիս 5, շաբաթներ 17–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Ամիս 6, շաբաթներ 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Ամիս 6, շաբաթներ 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Ամիս 6, շաբաթներ 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY + HIIT', week_label_hy = 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Ամիս 6, շաբաթներ 21–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 7 — ADVANCED FAT LOSS (Ամիս 7, շաբաթներ 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 7 — ADVANCED FAT LOSS (Ամիս 7, շաբաթներ 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 7 — ADVANCED FAT LOSS (Ամիս 7, շաբաթներ 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY ADVANCED', week_label_hy = 'LEVEL 7 — ADVANCED FAT LOSS (Ամիս 7, շաբաթներ 25–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 8 — DEFINITION + CONDITIONING (Ամիս 8, շաբաթներ 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 8 — DEFINITION + CONDITIONING (Ամիս 8, շաբաթներ 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 8 — DEFINITION + CONDITIONING (Ամիս 8, շաբաթներ 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY CONDITIONING', week_label_hy = 'LEVEL 8 — DEFINITION + CONDITIONING (Ամիս 8, շաբաթներ 29–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 9 — ADVANCED DEFINITION (Ամիս 9, շաբաթներ 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 9 — ADVANCED DEFINITION (Ամիս 9, շաբաթներ 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 9 — ADVANCED DEFINITION (Ամիս 9, շաբաթներ 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY ADVANCED', week_label_hy = 'LEVEL 9 — ADVANCED DEFINITION (Ամիս 9, շաբաթներ 33–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 10 — PEAK FAT LOSS (Ամիս 10, շաբաթներ 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 10 — PEAK FAT LOSS (Ամիս 10, շաբաթներ 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 10 — PEAK FAT LOSS (Ամիս 10, շաբաթներ 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY PEAK', week_label_hy = 'LEVEL 10 — PEAK FAT LOSS (Ամիս 10, շաբաթներ 37–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 11 — FINAL CUT (Ամիս 11, շաբաթներ 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 113;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 121;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 133;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 11 — FINAL CUT (Ամիս 11, շաբաթներ 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 11 — FINAL CUT (Ամիս 11, շաբաթներ 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY FINAL CUT', week_label_hy = 'LEVEL 11 — FINAL CUT (Ամիս 11, շաբաթներ 41–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 96;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'LEVEL 12 — FINAL TRANSFORMATION (Ամիս 12, շաբաթներ 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'LEVEL 12 — FINAL TRANSFORMATION (Ամիս 12, շաբաթներ 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10–12 ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ոտքեր + Հետույք', week_label_hy = 'LEVEL 12 — FINAL TRANSFORMATION (Ամիս 12, շաբաթներ 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8–10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 85;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 93;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 104;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 🏆 FINAL FULL BODY TEST', week_label_hy = 'LEVEL 12 — FINAL TRANSFORMATION (Ամիս 12, շաբաթներ 45–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15–20'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 95;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 103;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 110 and "order" < 111;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 120 and "order" < 123;
    update public.workout_sets set notes_hy = 'Թեստ'
    where workout_id = v_workout_id and "order" >= 130 and "order" < 131;
  end if;

  if v_updated_workouts <> 47 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-muzhchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 47, v_updated_workouts;
  end if;
end $$;
