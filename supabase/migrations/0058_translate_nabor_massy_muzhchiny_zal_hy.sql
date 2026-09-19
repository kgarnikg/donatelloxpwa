-- 0058_translate_nabor_massy_muzhchiny_zal_hy.sql
-- Армянский перевод: Набор массы — Мужчины — Зал
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
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-muzhchiny-zal';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-muzhchiny-zal';
  end if;

  update public.workout_programs
  set title_hy = 'Հավաքում զանգվածի համար տղամարդկանց (մարզասրահ) — տարեկան ծրագիր', description_hy = 'Հավաքում զանգվածի համար տղամարդկանց (մարզասրահ) — տարեկան ծրագիր. Սարքավորում. Ամբողջական հավաքում зала: մարզամխաթ, հանտելներ, тренажёры, турник, канаты, TRX, գիրեւ'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 1–2 — Հիմք'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Մինչև ձախողում'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Մինչև ձախողում'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 1–2 — Հիմք'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 52;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 1–2 — Հիմք'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 1–2 — Հիմք'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 3–4 — Հիմք (նոր բլոկ)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 3–4 — Հիմք (նոր բլոկ)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 3–4 — Հիմք (նոր բլոկ)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Մինչև ձախողում'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 3–4 — Հիմք (նոր բլոկ)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 5–6 — Աճեցում զանգվածի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 5–6 — Աճեցում զանգվածի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 5–6 — Աճեցում զանգվածի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Մինչև ձախողում'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 5–6 — Աճեցում զանգվածի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 7–8 — Կալիստենիկա և ֆունկցիոնալ մարզում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 7–8 — Կալիստենիկա և ֆունկցիոնալ մարզում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 7–8 — Կալիստենիկա և ֆունկցիոնալ մարզում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 7–8 — Կալիստենիկա և ֆունկցիոնալ մարզում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 9–10 — Նոր սթրես: ուժ + ձգում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12–15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + Ֆունկցիոնալ մարզում', week_label_hy = 'Շաբաթներ 9–10 — Նոր սթրես: ուժ + ձգում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 9–10 — Նոր սթրես: ուժ + ձգում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 9–10 — Նոր սթրես: ուժ + ձգում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '30 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 11–12 — Նոր սթրես: ամբողջությամբ նոր ծրագիր'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 11–12 — Նոր սթրես: ամբողջությամբ նոր ծրագիր'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 11–12 — Նոր սթրես: ամբողջությամբ նոր ծրագիր'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = 'Մինչև ձախողում'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 11–12 — Նոր սթրես: ամբողջությամբ նոր ծրագիր'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 13–14 — Ուժ + զանգված: ծանր մղում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 13–14 — Ուժ + զանգված: ծանր մղում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = '90 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 13–14 — Ուժ + զանգված: ծանր մղում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 13–14 — Ուժ + զանգված: ծանր մղում'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 15–16 — Ուժ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 15–16 — Ուժ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 15–16 — Ուժ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 15–16 — Ուժ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս + ФУНКЦ. Ավարտիչ', week_label_hy = 'Շաբաթներ 17–18 — Հիպերտրոֆիա 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + АТЛЕТИКА', week_label_hy = 'Շաբաթներ 17–18 — Հիպերտրոֆիա 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 17–18 — Հիպերտրոֆիա 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 17–18 — Հիպերտրոֆիա 2.0'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 19–20 — Մկանային տոկունություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 19–20 — Մկանային տոկունություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 19–20 — Մկանային տոկունություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 19–20 — Մկանային տոկունություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 21–22 — Ցնցող հարմարվողականություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '12 կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + ВЗРЫВНАЯ Աշխատանք', week_label_hy = 'Շաբաթներ 21–22 — Ցնցող հարմարվողականություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 21–22 — Ցնցող հարմարվողականություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 21–22 — Ցնցող հարմարվողականություն'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '40 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 23–24 — Ատլետիզմ: մկաններ որպես մոտ մարզիկի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 23–24 — Ատլետիզմ: մկաններ որպես մոտ մարզիկի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '24 шага'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 23–24 — Ատլետիզմ: մկաններ որպես մոտ մարզիկի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 23–24 — Ատլետիզմ: մկաններ որպես մոտ մարզիկի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 25–26 — Պիկային հիպերտրոֆիա: առավելագույն ծավալ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 67;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 25–26 — Պիկային հիպերտրոֆիա: առավելագույն ծավալ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 25–26 — Պիկային հիպերտրոֆիա: առավելագույն ծավալ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 25–26 — Պիկային հիպերտրոֆիա: առավելագույն ծավալ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 27–28 — Բոդիբիլդինգ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 27–28 — Բոդիբիլդինգ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 27–28 — Բոդիբիլդինգ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 27–28 — Բոդիբիլդինգ + ատլետիզմ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 29–30 — Մասնագիտացում: վերին մարմին կրծքավանդակի + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + ФУНКЦ. Ուժ', week_label_hy = 'Շաբաթներ 29–30 — Մասնագիտացում: վերին մարմին կրծքավանդակի + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 29–30 — Մասնագիտացում: վերին մարմին կրծքավանդակի + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 29–30 — Մասնագիտացում: վերին մարմին կրծքավանդակի + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '45 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 31–32 — Մկաններ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 31–32 — Մկաններ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '30 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 31–32 — Մկաններ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 31–32 — Մկաններ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '30 метров'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 33–34 — Ուժային պիկ: ծանր քաշ + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 33–34 — Ուժային պիկ: ծանր քաշ + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 33–34 — Ուժային պիկ: ծանր քաշ + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5–8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '6–8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '50 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 76;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 33–34 — Ուժային պիկ: ծանր քաշ + ծավալ'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 35–36 — Ուժ + մարմին ատլետի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 35–36 — Ուժ + մարմին ատլետի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '30 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 35–36 — Ուժ + մարմին ատլետի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 72;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր', week_label_hy = 'Շաբաթներ 35–36 — Ուժ + մարմին ատլետի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'Շաբաթներ 37–38 — Վերին մարմին մարմնի 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + Միջուկ', week_label_hy = 'Շաբաթներ 37–38 — Վերին մարմին մարմնի 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 37–38 — Վերին մարմին մարմնի 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 77;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Ձեռքեր + Որովայնամկաններ', week_label_hy = 'Շաբաթներ 37–38 — Վերին մարմին մարմնի 3D'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 16;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 39–40 — Փամփ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 68;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 39–40 — Փամփ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '30 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 39–40 — Փամփ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '50 метров'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 66;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Ձեռքեր', week_label_hy = 'Շաբաթներ 39–40 — Փամփ + հսկողություն մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 41–42 — PRO ATHLETE: առավելագույն ուժ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 41–42 — PRO ATHLETE: առավելագույն ուժ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '4'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 58;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 41–42 — PRO ATHLETE: առավելագույն ուժ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 74;
    update public.workout_sets set notes_hy = '60 метров'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 86;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Ձեռքեր', week_label_hy = 'Շաբաթներ 41–42 — PRO ATHLETE: առավելագույն ուժ կրծքավանդակի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 6;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 28;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Տրիցեպս', week_label_hy = 'Շաբաթներ 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 80;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Ձեռքեր', week_label_hy = 'Շաբաթներ 43–44 — FINAL MASS SHOCK'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ուսեր + Տրիցեպս', week_label_hy = 'Շաբաթներ 45–46 — 3D վերին մարմին մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 70;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր + Ատլետիզմ', week_label_hy = 'Շաբաթներ 45–46 — 3D վերին մարմին մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 56;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 45–46 — 3D վերին մարմին մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 15;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '40 метров'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 78;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Ձեռքեր + Միջուկ', week_label_hy = 'Շաբաթներ 45–46 — 3D վերին մարմին մարմնի'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 27;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Կրծքավանդակ + Ձեռքեր', week_label_hy = 'Շաբաթներ 47–48 — FINAL BOSS: փամփ, ռելիեֆ, ձև'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Առավելագույն.'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 46;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · Ոտքեր', week_label_hy = 'Շաբաթներ 47–48 — FINAL BOSS: փամփ, ռելիեֆ, ձև'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '40 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 48;
    update public.workout_sets set notes_hy = 'AMRAP'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Մեջք + Բիցեպս', week_label_hy = 'Շաբաթներ 47–48 — FINAL BOSS: փամփ, ռելիեֆ, ձև'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '100'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · Ուսեր + Եզրափակիչ Փամփ', week_label_hy = 'Շաբաթներ 47–48 — FINAL BOSS: փամփ, ռելիեֆ, ձև'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 20;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  if v_updated_workouts <> 96 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-muzhchiny-zal, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 96, v_updated_workouts;
  end if;
end $$;
