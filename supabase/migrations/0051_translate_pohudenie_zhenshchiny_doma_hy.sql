-- 0051_translate_pohudenie_zhenshchiny_doma_hy.sql
-- Армянский перевод: Похудение — Женщины — Дома
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
  select id into v_program_id from public.workout_programs where slug = 'pohudenie-zhenshchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'pohudenie-zhenshchiny-doma';
  end if;

  update public.workout_programs
  set title_hy = 'Քաշի նվազեցում համար կանանց (տանը) — DonatelleX, տարեկան ծրագիր', description_hy = 'Քաշի նվազեցում համար կանանց (տանը) — DonatelleX, տարեկան ծրագիր. Սարքավորում. Հանտելներ, առաձգական ժապավեն տարբեր կոշտության, գորգիկ, կայուն հարթակ/աստիճան (ըստ հնարավորության)'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · LOWER BODY + GLUTES', week_label_hy = 'LEVEL 1.1 — ADAPTATION (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · UPPER BODY + FAT BURN', week_label_hy = 'LEVEL 1.1 — ADAPTATION (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Ուրբաթ · FULL BODY FAT BURN', week_label_hy = 'LEVEL 1.1 — ADAPTATION (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · LOWER BODY BOOST', week_label_hy = 'LEVEL 1.2 — BOOST (շաբաթներ 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · UPPER BODY BOOST', week_label_hy = 'LEVEL 1.2 — BOOST (շաբաթներ 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Ուրբաթ · FULL BODY — LEVEL BOOST', week_label_hy = 'LEVEL 1.2 — BOOST (շաբաթներ 3–4)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'AMRAP 10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTES + LEGS', week_label_hy = 'LEVEL 2.1 — BUILD (շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY + CARDIO', week_label_hy = 'LEVEL 2.1 — BUILD (շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY + METABOLIC', week_label_hy = 'LEVEL 2.1 — BUILD (շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — LEVEL 2', week_label_hy = 'LEVEL 2.1 — BUILD (շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'LEVEL 2.2 — SHOCK (շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '14 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY SHOCK', week_label_hy = 'LEVEL 2.2 — SHOCK (շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LEGS + METABOLIC SHOCK', week_label_hy = 'LEVEL 2.2 — SHOCK (շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 🏆 LEVEL 2 — BOSS TRAINING', week_label_hy = 'LEVEL 2.2 — SHOCK (շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'LEVEL 3.1 — IGNITION 🔥 (շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY + CONDITIONING', week_label_hy = 'LEVEL 3.1 — IGNITION 🔥 (շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY — POWER + METABOLIC', week_label_hy = 'LEVEL 3.1 — IGNITION 🔥 (շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — IGNITION', week_label_hy = 'LEVEL 3.1 — IGNITION 🔥 (շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE OVERDRIVE', week_label_hy = 'LEVEL 3.2 — OVERDRIVE ⚡ (շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY OVERDRIVE', week_label_hy = 'LEVEL 3.2 — OVERDRIVE ⚡ (շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY — SHOCK', week_label_hy = 'LEVEL 3.2 — OVERDRIVE ⚡ (շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 👑 BOSS FIGHT — LEVEL 3', week_label_hy = 'LEVEL 3.2 — OVERDRIVE ⚡ (շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '5 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'LEVEL 4.1 — POWER ⚡ (շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '16 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY POWER', week_label_hy = 'LEVEL 4.1 — POWER ⚡ (շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY — STRENGTH + CONDITIONING', week_label_hy = 'LEVEL 4.1 — POWER ⚡ (շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER CHALLENGE', week_label_hy = 'LEVEL 4.1 — POWER ⚡ (շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'AMRAP 8 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE CHAOS', week_label_hy = 'LEVEL 4.2 — CHAOS 🔥 (շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '18 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY CHAOS', week_label_hy = 'LEVEL 4.2 — CHAOS 🔥 (շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY — CHAOS', week_label_hy = 'LEVEL 4.2 — CHAOS 🔥 (շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 👑 BOSS FIGHT — LEVEL 4', week_label_hy = 'LEVEL 4.2 — CHAOS 🔥 (շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE OVERLOAD', week_label_hy = 'LEVEL 5.1 — OVERLOAD 🔥 (շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY OVERLOAD', week_label_hy = 'LEVEL 5.1 — OVERLOAD 🔥 (շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY OVERLOAD', week_label_hy = 'LEVEL 5.1 — OVERLOAD 🔥 (շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — OVERLOAD CHALLENGE', week_label_hy = 'LEVEL 5.1 — OVERLOAD 🔥 (շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'AMRAP 10 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE TURBO', week_label_hy = 'LEVEL 5.2 — TURBO ⚡ (շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '18 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY TURBO', week_label_hy = 'LEVEL 5.2 — TURBO ⚡ (շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · LOWER BODY TURBO', week_label_hy = 'LEVEL 5.2 — TURBO ⚡ (շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 👑 BOSS FIGHT — LEVEL 5', week_label_hy = 'LEVEL 5.2 — TURBO ⚡ (շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 LOWER BODY CONTROL', week_label_hy = 'LEVEL 6.1 — STRENGTH + CONTROL (շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY + CONDITIONING', week_label_hy = 'LEVEL 6.1 — STRENGTH + CONTROL (շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LOWER BODY + METABOLIC', week_label_hy = 'LEVEL 6.1 — STRENGTH + CONTROL (շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 🏆 FULL BODY TRANSFORMATION', week_label_hy = 'LEVEL 6.1 — STRENGTH + CONTROL (շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'AMRAP 10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE SPEED', week_label_hy = 'LEVEL 6.2 — SPEED + CONDITIONING (շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 🔥 UPPER BODY CONDITIONING', week_label_hy = 'LEVEL 6.2 — SPEED + CONDITIONING (շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LEG CONDITIONING', week_label_hy = 'LEVEL 6.2 — SPEED + CONDITIONING (շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 👑 BOSS FIGHT — LEVEL 6', week_label_hy = 'LEVEL 6.2 — SPEED + CONDITIONING (շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 ATHLETE GLUTES', week_label_hy = 'LEVEL 7.1 — ATHLETE STRENGTH (շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 ATHLETE UPPER BODY', week_label_hy = 'LEVEL 7.1 — ATHLETE STRENGTH (շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 ATHLETE LEGS', week_label_hy = 'LEVEL 7.1 — ATHLETE STRENGTH (շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 🏆 ATHLETE BOSS FIGHT', week_label_hy = 'LEVEL 7.1 — ATHLETE STRENGTH (շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE POWER', week_label_hy = 'LEVEL 7.2 — ATHLETE SPEED (շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 🔥 UPPER BODY SPEED', week_label_hy = 'LEVEL 7.2 — ATHLETE SPEED (շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LOWER BODY SPEED', week_label_hy = 'LEVEL 7.2 — ATHLETE SPEED (շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 👑 LEVEL 7 BOSS FIGHT', week_label_hy = 'LEVEL 7.2 — ATHLETE SPEED (շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 METABOLIC GLUTES', week_label_hy = 'LEVEL 8.1 — METABOLIC CONTROL (շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 METABOLIC UPPER BODY', week_label_hy = 'LEVEL 8.1 — METABOLIC CONTROL (շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🔥 LOWER BODY METABOLIC', week_label_hy = 'LEVEL 8.1 — METABOLIC CONTROL (շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ METABOLIC BOSS FIGHT', week_label_hy = 'LEVEL 8.1 — METABOLIC CONTROL (շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 12 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE CHAOS', week_label_hy = 'LEVEL 8.2 — METABOLIC CHAOS (շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · ⚡ UPPER BODY CHAOS', week_label_hy = 'LEVEL 8.2 — METABOLIC CHAOS (շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LOWER BODY CHAOS', week_label_hy = 'LEVEL 8.2 — METABOLIC CHAOS (շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 42;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ LEVEL 8 BOSS FIGHT', week_label_hy = 'LEVEL 8.2 — METABOLIC CHAOS (շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE ARENA', week_label_hy = 'LEVEL 9.1 — TIME ATTACK (շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY ARENA', week_label_hy = 'LEVEL 9.1 — TIME ATTACK (շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LOWER BODY SPEED', week_label_hy = 'LEVEL 9.1 — TIME ATTACK (շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ FAT BURNER BOSS FIGHT', week_label_hy = 'LEVEL 9.1 — TIME ATTACK (շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE POWER ARENA', week_label_hy = 'LEVEL 9.2 — ARENA CHAOS (շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY CHAOS', week_label_hy = 'LEVEL 9.2 — ARENA CHAOS (շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 LEG CHAOS', week_label_hy = 'LEVEL 9.2 — ARENA CHAOS (շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ LEVEL 9 FINAL BOSS', week_label_hy = 'LEVEL 9.2 — ARENA CHAOS (շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 LOWER BODY POWER', week_label_hy = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '6 ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 75;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY CONDITIONING', week_label_hy = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 ATHLETIC LEGS', week_label_hy = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 26;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ CONDITIONING BEAST', week_label_hy = 'LEVEL 10.1 — POWER CONDITIONING ⚡ (շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE BEAST', week_label_hy = 'LEVEL 10.2 — BEAST MODE 🐺 (շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 45;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 BEAST UPPER BODY', week_label_hy = 'LEVEL 10.2 — BEAST MODE 🐺 (շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 BEAST LEGS', week_label_hy = 'LEVEL 10.2 — BEAST MODE 🐺 (շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ LEVEL 10 FINAL BOSS', week_label_hy = 'LEVEL 10.2 — BEAST MODE 🐺 (շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE SCULPT', week_label_hy = 'LEVEL 11.1 — SCULPT & POWER ⚡ (շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '7 ր'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY PEAK', week_label_hy = 'LEVEL 11.1 — SCULPT & POWER ⚡ (շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 ATHLETIC LEGS', week_label_hy = 'LEVEL 11.1 — SCULPT & POWER ⚡ (շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ PEAK SHAPE BOSS', week_label_hy = 'LEVEL 11.1 — SCULPT & POWER ⚡ (շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · 🍑 GLUTE POWER', week_label_hy = 'LEVEL 11.2 — PEAK PERFORMANCE (շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · 💪 UPPER BODY BEAST', week_label_hy = 'LEVEL 11.2 — PEAK PERFORMANCE (շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 35;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 65;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · 🦵 PEAK LEGS', week_label_hy = 'LEVEL 11.2 — PEAK PERFORMANCE (շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 25;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Սանդուղք'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ☠️ PEAK PERFORMANCE FINAL BOSS', week_label_hy = 'LEVEL 11.2 — PEAK PERFORMANCE (շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = 'AMRAP 15 ր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
    update public.workout_sets set notes_hy = 'TIME CAP'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = '10 ր'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 55;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Օր 1 · Ոտքեր + Հետույք', week_label_hy = '🔥 Ամիս 12 — Եզրափակիչ Մակարդակ (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '40 վրկ'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Օր 2 · Վերին մարմին Մարմնի + Կարդիո', week_label_hy = '🔥 Ամիս 12 — Եզրափակիչ Մակարդակ (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15 կողմի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '8 ր'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 83;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Օր 4 · Հետույք + Ոտքեր', week_label_hy = '🔥 Ամիս 12 — Եզրափակիչ Մակարդակ (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '4 ր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Օր 6 · FULL BODY 🔥', week_label_hy = '🔥 Ամիս 12 — Եզրափակիչ Մակարդակ (շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ 4, Օր 1 · Ոտքեր + Հետույք (նոր մակարդակ)', week_label_hy = '🔴 Ամիս 12 — Շաբաթ 3 (UP) + 🟠 Շաբաթ 4 (Նոր Մակարդակ) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '30 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Ռաունդ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ 4, Օր 2 · Վերին մարմին + Կարդիո (նոր մակարդակ)', week_label_hy = '🔴 Ամիս 12 — Շաբաթ 3 (UP) + 🟠 Շաբաթ 4 (Նոր Մակարդակ) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10–15'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '12 ր'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 84;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ 4, Օր 4 · GLUTE ATTACK 🍑', week_label_hy = '🔴 Ամիս 12 — Շաբաթ 3 (UP) + 🟠 Շաբաթ 4 (Նոր Մակարդակ) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '45 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ 4, Օր 6 · 🔥 FINAL BOSS — Եզրափակիչ Տարվա', week_label_hy = '🔴 Ամիս 12 — Շաբաթ 3 (UP) + 🟠 Շաբաթ 4 (Նոր Մակարդակ) + 🏆 FINAL BOSS'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = 'Շրջան'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '3 ր'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_hy = '—'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 21;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для pohudenie-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
