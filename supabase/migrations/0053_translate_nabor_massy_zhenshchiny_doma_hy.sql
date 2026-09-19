-- 0053_translate_nabor_massy_zhenshchiny_doma_hy.sql
-- Армянский перевод: Набор массы — Женщины — Дома
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
  select id into v_program_id from public.workout_programs where slug = 'nabor-massy-zhenshchiny-doma';
  if v_program_id is null then
    raise exception 'Программа % не найдена — убедитесь, что 0014-0021 уже применены', 'nabor-massy-zhenshchiny-doma';
  end if;

  update public.workout_programs
  set title_hy = 'Հավաքում զանգվածի համար կանանց (տանը) — տարեկան ծրագիր', description_hy = 'Հավաքում զանգվածի համար կանանց (տանը) — տարեկան ծրագիր. Սարքավորում. Հանտելներ, առաձգական ժապավեն տարբեր կոշտության, գորգիկ, կայուն հարթակ/աստիճան'
  where id = v_program_id;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · Հետույք + Քառագլուխ', week_label_hy = 'Ամիս 1 — LEVEL 1A — Հարմարվողականություն (Շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15 (Հանտել առաջ կրծքով հենված. Վերջին 5 կրկնություն: դանդաղ իջեցում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '20 (Մեջ верхней точке: 2 վրկ сжатия ягодиц.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Корпус слегка наклонён առաջ. Толкаемся пяткой.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15 (Իջեցում: 3 վրկ. Ոչ округлять поясницу.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30 վրկ (Ծնկներ примерно տակ углом 90°.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 վարժություն × 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · Հետույք + Հետին Մակերես Ազդրեր', week_label_hy = 'Ամիս 1 — LEVEL 1A — Հարմարվողականություն (Շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15 (Широкая դիրք ոտքերի.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '3 մոտեցում 15 կրկնություն ↓ 30 վրկ պահում մեջ нижней точке'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20 (Վերջին 5: короткие пульсирующие շարժումներ.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 վարժություն × 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 1 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Ուրբաթ · Մեջք + Ուսեր + Ձեռքեր', week_label_hy = 'Ամիս 1 — LEVEL 1A — Հարմարվողականություն (Շաբաթներ 1–2)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15 (Контролируем շարժում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '20 (Շեշտ վրա հետին դելտա.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15 (Կողային բարձրացումներ հանտելներով մեջ կողմեր ↓ сразу Բարձրացում հանտելներ առաջ собой 3 × 12 Հանգիստ հետո երկու…)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն (Կարելի է կատարել հետ ծնկի. Главное — контролировать շարժում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն × 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'Ամիս 1 — LEVEL 1B — Առաջին Թռիչք (Շաբաթ 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Քաշ: +5–10% относительно շաբաթներ 1–2, եթե տեխնիկա позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Վերջին կրկնություն каждого մոտեցում: պահում 3 վրկ վերևից.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 (Դանդաղ իջեցում: 3 վրկ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '3 շրջաններ: 20 Frog Pumps 20 պուլսացիաների մեջ ягодичном мосте 20 վրկ статики վերևից Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Այժմ: 3 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ Dead Bug Reverse Crunch Mountain Climbers…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Չորեքշաբթի · GLUTE + HAMSTRING', week_label_hy = 'Ամիս 1 — LEVEL 1B — Առաջին Թռիչք (Շաբաթ 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '3 մոտեցում 12 կրկնություն 40 վրկ удержания'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 11;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20 (Վերջին մոտեցում: 20 կրկնություն + 20 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 2 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Ուրբաթ · BACK + SHOULDERS + ARMS', week_label_hy = 'Ամիս 1 — LEVEL 1B — Առաջին Թռիչք (Շաբաթ 3)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Վերջին 5: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Կատարել подряд: Կողային բարձրացումներ մեջ կողմեր 12 ↓ Բարձրացում առաջ собой 12 ↓ Հետին դելտա մեջ թեքված 15…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '3 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ Շրջան: Mountain Climbers ոտքերի բարձրացում Russian Twist…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE + QUAD', week_label_hy = 'Ամիս 2 — LEVEL 2A — BUILD (Շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Մեջ верхней точке: 2 վրկ удержания.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Վերջին մոտեցում: +5 коротких պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Толчок выполняется преимущественно рабочей ոտքով.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '45 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · BACK + SHOULDERS + ARMS', week_label_hy = 'Ամիս 2 — LEVEL 2A — BUILD (Շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15 (Имитируем вертикальную тягу.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Կողային բարձրացումներ հանտելներով մեջ կողմեր 15 Հետին դելտա մեջ թեքված 15 4 շրջաններ Հանգիստ: 60 վրկ.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Բիցեպսի ծալում հանտելներով 12 տրիցեպսի տարածում հետ ժապավենով 15 3 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '8–12 (Это առաջին элемент калистеники. Եթե тяжело: делать հետ более բարձր հենարանով.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · GLUTE + HAMSTRING', week_label_hy = 'Ամիս 2 — LEVEL 2A — BUILD (Շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Իջեցում: 3 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Քաշ չափավոր тяжелый.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12–15 (Եթե մակերես позволяет безопасно скользить. Альтернатива: ոտքերի ծալում հետ ժապավենով.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ: 20 Frog Pumps 15 առևանգումներ հետ каждой ոտքով 20 վրկ հետույքի կամուրջ Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 3 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY ATHLETIC', week_label_hy = 'Ամիս 2 — LEVEL 2A — BUILD (Շաբաթներ 5–6)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն (Կարելի է հետ ծնկի.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար (Եթե тяжело: կատարել հետ ծնկի.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '40 վրկ (Тяжелые հանտելներ. Корпус առավելագույնս стабильный.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 վրկ: Step-Up արագ 20 վրկ: Mountain Climbers 20 վրկ: հանգիստ Հետո…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHAPE', week_label_hy = 'Ամիս 2 — LEVEL 2B — NEW STIMULUS (Շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Քաշ: +5–10% относительно շաբաթներ 5–6, եթե տեխնիկա позволяет.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար (Մեկ ոտք выполняет основную աշխատանք.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար (Նոր խթան համար ոտքերի և ягодиц.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '40'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 62;
    update public.workout_sets set notes_hy = '3 շրջաններ 30 վրկ: հետույքի կամուրջ 20 պուլսացիաների 20 վրկ ստատիկ պահում վերևից Հանգիստ: 45 վրկ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · BACK + SHOULDERS', week_label_hy = 'Ամիս 2 — LEVEL 2B — NEW STIMULUS (Շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Դադար: 2 վրկ մեջ верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Կողային բարձրացումներ մեջ կողմեր 12 Arnold Press 10 Հետին դելտա 15 Ստատիկ պահում ձեռքերի մեջ կողմեր 20 վրկ 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '8–15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN', week_label_hy = 'Ամիս 2 — LEVEL 2B — NEW STIMULUS (Շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '10 (Դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = 'Հետույքի կամուրջ: 45 վրկ ստատիկ պահում 20 պուլսացիաների 30 վրկ ստատիկ պահում 2 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 4 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — ATHLETE LEVEL', week_label_hy = 'Ամիս 2 — LEVEL 2B — NEW STIMULUS (Շաբաթներ 7–8)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Կքանիստ + հանտելների մղում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '45 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'AMRAP — 8 ր Сделать որպես կարելի է ավելի շատ որակյալ շրջաններ: 8 կքանիստներ 8 հրումներ հատակից 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Mountain Climbers Russian Twist Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE + QUAD POWER', week_label_hy = 'Ամիս 3 — LEVEL 3A — SHAPE (Շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Վերջին 2 կրկնություն должны լինել тяжелыми.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → դանդաղ վար.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15 (Пятки слегка приподняты. Վերջին մոտեցում: +10 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 5 կրկնություն каждого մոտեցում — դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '25 (Վերջին 10 կրկնություն: короткие пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Օգտագործել կայուն հարթակ.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 30 վրկ: Glute Bridge 20 վրկ: пульсации 20 վրկ: ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · BACK + SHOULDERS + ARMS', week_label_hy = 'Ամիս 3 — LEVEL 3A — SHAPE (Շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Դանդաղ իջեցում: 3 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար (Մեջ верхней точке: 2 վրկ պահում.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 12 Կողային բարձրացումներ հանտելներով մեջ կողմեր 15 4 շրջաններ Հանգիստ: 60 վրկ.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Մուրճաձև ծալում 12 Տրիցեպս հետ ժապավենով վար 15 3 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '8–12 (Եթե тяжело — ձեռքեր վրա возвышенности.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '30 վրկ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · GLUTE + HAMSTRING', week_label_hy = 'Ամիս 3 — LEVEL 3A — SHAPE (Շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 3 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '12 (Стопы վրա կայուն опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12 (Եթե нет հնարավորության օգտագործել полотенце: ոտքերի ծալում հետ ժապավենով.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 ծալումներ ոտքերի 20 հետույքի կամուրջներ 20 պուլսացիաների 20 վրկ ստատիկ պահում Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 5 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY POWER', week_label_hy = 'Ամիս 3 — LEVEL 3A — SHAPE (Շաբաթներ 9–10)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '45 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Յուրաքանչյուր րոպե начать նոր мини-ռաունդ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'Ամիս 3 — LEVEL 3B — POWER & CONTROL (Շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Վերջին 5 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Передняя ոտք վրա небольшой կայուն опоре.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '2 շրջաններ 40 Frog Pumps 30 Abductions 20 Kickbacks каждой ոտքով 30 վրկ Glute Bridge Hold…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — CONTROL', week_label_hy = 'Ամիս 3 — LEVEL 3B — POWER & CONTROL (Շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Դադար: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Կողային բարձրացումներ մեջ կողմեր 15 Reverse Fly 15 Ստատիկ պահում մեջ положении «ձեռքեր մեջ կողմեր» 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Բիցեպսի ծալում հետ ժապավենով 15 Տրիցեպս վրայով գլխի հետ ժապավենով 15 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · GLUTE + POSTERIOR POWER', week_label_hy = 'Ամիս 3 — LEVEL 3B — POWER & CONTROL (Շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Good Morning 15 Hamstring Walkout 20 Glute Bridge 30 վրկ ստատիկ պահում Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 6 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — BOSS LEVEL', week_label_hy = 'Ամիս 3 — LEVEL 3B — POWER & CONTROL (Շաբաթներ 11–12)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 (Շարժում կատարել технически чисто.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'AMRAP — 10 ր Сделать максимальное քանակ որակյալ շրջաններ: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Մեջ վերջում ամսվա пользователь фиксирует: Hip Thrust Ամիս 1: кг Ամիս 2: кг Ամիս…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE + QUAD', week_label_hy = 'Ամիս 4 — LEVEL 4A — GLUTE BUILD (Շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Վերջին կրկնություն каждого մոտեցում: 2 վրկ պահում վերևից.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Передняя ոտք վրա небольшой կայուն опоре. Վերջին 3 կրկնություն: դանդաղ իջեցում.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Ամբողջական կքանիստ → подняться наполовину → снова վար → ամբողջությամբ վեր. Это одно կրկնություն.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '25 (Վերջին 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 20 հետույքի կամուրջներ 20 Frog Pumps 20 Abductions 20 վրկ ստատիկ պահում վերևից Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — SHAPE', week_label_hy = 'Ամիս 4 — LEVEL 4A — GLUTE BUILD (Շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար (Դադար: 2 վրկ վերևից.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Կողային բարձրացումներ մեջ կողմեր 15 Передние կողային բարձրացումներ 12 Հետին դելտա 15 4 շրջաններ Հանգիստ: 60…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Բիցեպս հանտելներով 12 Տրիցեպս հետ ժապավենով 15 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '40 վրկ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 72;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · GLUTE + HAMSTRING', week_label_hy = 'Ամիս 4 — LEVEL 4A — GLUTE BUILD (Շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 3 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Շեշտ: հետույք.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Hamstring Slides 20 Glute Bridge 20 Frog Pumps 30 վրկ պահում վերևից…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 7 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER', week_label_hy = 'Ամիս 4 — LEVEL 4A — GLUTE BUILD (Շաբաթներ 13–14)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Чередуем: Нечетная минута 10 Goblet Squats Четная минута 8 Push-Ups + 10 Mountain…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 4 — LEVEL 4B — GLUTE SHOCK (Շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Վերջին մոտեցում: +15 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Հետին ոտք уходит հետ հետ небольшой возвышенности տակ առաջային ոտքով.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 30 վրկ: Frog Pumps 20 վրկ: Glute Bridge Hold 20 պուլսացիաների 20 առևանգումներ ոտքերի…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — NEW ANGLES', week_label_hy = 'Ամիս 4 — LEVEL 4B — GLUTE SHOCK (Շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Это уменьшает помощь поясницы.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Կողային բարձրացումներ մեջ կողմեր 15 Reverse Fly 15 4 շրջաններ Հանգիստ: 60 վրկ.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Մուրճաձև ծալում 12 Տարածում հանտելներ վրայով գլխի 12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '30 վրկ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN SHOCK', week_label_hy = 'Ամիս 4 — LEVEL 4B — GLUTE SHOCK (Շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Hamstring Walkout 20 Glute Bridge 20 Kickbacks 30 վրկ ստատիկ պահում Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 8 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — BOSS LEVEL', week_label_hy = 'Ամիս 4 — LEVEL 4B — GLUTE SHOCK (Շաբաթներ 15–16)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'AMRAP — 12 ր Максимальное քանակ որակյալ շրջաններ: 10 Sumo Squats 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Пользователь фиксирует արդյունք: Hip Thrust Ամիս 1: кг Ամիս 2: кг Ամիս 3:…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_hy = 'Հետո 16- շաբաթներ пользователь должен получить ощущение перехода վրա նոր մակարդակ: 3…'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE STRENGTH', week_label_hy = 'Ամիս 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին մոտեցում: Rest-pause Հետո выполнения մոտեցում: 20 վրկ հանգստի → дополнительные…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 (Վերջին մոտեցում: +10 պուլսացիաների ներքևում.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր ոտքի համար (Քաշ: тяжелый, բայց տեխնիկա ամբողջությամբ контролируется.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Մեջ верхней точке: 1 վրկ удержания.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '20 (Վերջին մոտեցում: 20 սովորական 20 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '2 ռաունդներ 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 վրկ ստատիկ պահում Հանգիստ: 90…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY STRENGTH', week_label_hy = 'Ամիս 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար (Վերջին 2 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Կողային բարձրացումներ հանտելներով մեջ կողմեր 15 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Передние կողային բարձրացումներ 12 Հետին դելտա մեջ թեքված 15 3 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Մուրճաձև ծալում 12 Տրիցեպս հանտելով վրայով գլխի 12 3 շրջաններ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 73;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING + GLUTE STRENGTH', week_label_hy = 'Ամիս 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 3 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '10 (Դադար վերևից: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = 'Ոտքերի ծալում 12 կրկնություն 20 վրկ հանգստի 5 կրկնություն 20 վրկ հանգստի 5 կրկնություն'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 9 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — STRENGTH + ATHLETIC', week_label_hy = 'Ամիս 5 — LEVEL 5A — STRENGTH HYPERTROPHY (Շաբաթներ 17–18)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '16 քայլեր'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Нечетные րոպեներ 10 Goblet Squats Четные րոպեներ 8 Push-Ups 10 Mountain Climbers Оставшееся…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 5 — LEVEL 5B — MUSCLE SHOCK (Շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Վերջին մոտեցում: 1,5 կրկնություն × 8)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '30 (Վերջին մոտեցում: +20 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 20 Frog Pumps ↓ 20 Glute Bridge ↓ 20 վրկ ստատիկ պահում ↓ 20 պուլսացիաների Հանգիստ: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY SHOCK', week_label_hy = 'Ամիս 5 — LEVEL 5B — MUSCLE SHOCK (Շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Դադար: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Կողային բարձրացումներ մեջ կողմեր 15 Reverse Fly 15 Ստատիկ պահում մեջ կողմեր 20 վրկ 4 շրջաններ…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '3 ռաունդներ Մուրճաձև ծալում: 10 ↓ սովորական ծալում: 10 ↓ частичные կրկնություն: 10 Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR SHOCK', week_label_hy = 'Ամիս 5 — LEVEL 5B — MUSCLE SHOCK (Շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 վրկ ստատիկ պահում Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 10 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — LEVEL 5 BOSS', week_label_hy = 'Ամիս 5 — LEVEL 5B — MUSCLE SHOCK (Շաբաթներ 19–20)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '12 ր Максимальное քանակ որակյալ շրջաններ: 10 Sumo Squats 8 Push-Ups 10…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Пользователь фиксирует: Hip Thrust Ամիս 1: кг Ամիս 2: кг Ամիս 3: кг…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_hy = 'Հետո 20- շաբաթներ пользователь переходит վրա հաջորդ մակարդակ.'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'Ամիս 6 — LEVEL 6A — POWER HYPERTROPHY (Շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 (Վերջին մոտեցում: 8 կրկնություն + 20 վրկ հանգստի + 4–5 կրկնություն)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Հետին ոտք ոչ используется համար толчка.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 3 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 (Մեջ нижней точке: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20 (Վերջին մոտեցում: 20 սովորական 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30 (Վերջին 10: առավելագույնս короткая ամպլիտուդ.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 12 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 վրկ պահում վերևից…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ Reverse Crunch Mountain Climbers Dead Bug Պլանկա…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — STRENGTH', week_label_hy = 'Ամիս 6 — LEVEL 6A — POWER HYPERTROPHY (Շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար (Դադար մեջ верхней точке: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 ↓ Կողային բարձրացումներ մեջ կողմեր 12 ↓ Կողային բարձրացումներ вперед 12 ↓ Reverse Fly 15 Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Մուրճաձև ծալում 12 Տարածում հանտելներ վրայով գլխի 12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 շրջաններ V-Ups — 60 վրկ Bicycle — 60 վրկ Hollow Hold — 60 վրկ Leg Raise — 60 վրկ Հանգիստ: 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING + GLUTE', week_label_hy = 'Ամիս 6 — LEVEL 6A — POWER HYPERTROPHY (Շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին 2 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Դադար վերևից: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 (Եթե слишком легко: օգտագործել более медленную փուլ возвращения.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 30 վրկ պահում Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ Reverse Crunch — 60 վրկ Bicycle — 60 վրկ Mountain Climbers — 60 վրկ Պլանկա հետ…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 11 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER', week_label_hy = 'Ամիս 6 — LEVEL 6A — POWER HYPERTROPHY (Շաբաթներ 21–22)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '10 (մոտեցումների միջև: 60 վրկ)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 ռաունդներ 10 Goblet Squats 8 Push-Ups 10 Dumbbell Rows 10 Reverse Lunges 15 Dumbbell…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 շրջաններ V-Ups — 60 վրկ Mountain Climbers — 60 վրկ Russian Twist — 60 վրկ Hollow Hold — 60…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 6 — LEVEL 6B — ATHLETIC SHOCK (Շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Пятки слегка приподняты. Վերջին մոտեցում: +10 պուլսացիաների)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Մեջ верхней точке: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 վրկ ստատիկ պահում վերևից Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ Bicycle Reverse Crunch Mountain Climbers Plank…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY SHOCK', week_label_hy = 'Ամիս 6 — LEVEL 6B — ATHLETIC SHOCK (Շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 վրկ…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Բիցեպս 12 սովորական ծալումներ ↓ 10 молотковых ↓ 10 մասնակի 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 շրջաններ Leg Raise — 60 վրկ Bicycle — 60 վրկ Hollow Hold — 60 վրկ Mountain Climbers — 60…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN SHOCK', week_label_hy = 'Ամիս 6 — LEVEL 6B — ATHLETIC SHOCK (Շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '10 (Յուրաքանչյուր կրկնություն: ամբողջական վեր → половина վար → снова վեր → ամբողջական վար.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 վրկ Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '5 շրջաններ Dead Bug — 60 վրկ Reverse Crunch — 60 վրկ Mountain Climbers — 60 վրկ Hollow Hold…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 12 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ATHLETIC FULL BODY', week_label_hy = 'Ամիս 6 — LEVEL 6B — ATHLETIC SHOCK (Շաբաթներ 23–24)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '—'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 1;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 (Հանգիստ: 75 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Առավելագույն'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = 'Համար/հետևից 12 ր կատարել առավելագույնս качественное քանակ շրջաններ: 10 Goblet Squats 8…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Մեջ течение ամսվա фиксируются: HIP THRUST Շաբաթ 21: кг Շաբաթ 22: кг Շաբաթ 23:…'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Հետո 24- շաբաթներ пользователь получает: +1 LEVEL և переходит դեպի:'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE MASS', week_label_hy = 'Ամիս 7 — LEVEL 7A — GLUTE BUILD (Շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին մոտեցում: 10 կրկնություն + 20 վրկ հանգստի + 5 կրկնություն)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Շեշտ: ягодица.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Передняя ոտք стоит վրա небольшой կայուն հարթակ.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12 (Վերջին 3 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 կրկնություն 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30 (Վերջին 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 30 վրկ ստատիկ պահում Հանգիստ: 60…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY + SHOULDERS', week_label_hy = 'Ամիս 7 — LEVEL 7A — GLUTE BUILD (Շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Դադար: 2 վրկ մեջ верхней точке.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 կրկնություն ↓ Կողային բարձրացումներ հանտելներով մեջ կողմեր 15 կրկնություն ↓ Ստատիկ պահում մեջ կողմեր…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '12 (Մուրճաձև ծալում Տրիցեպս հանտելով վրայով գլխի 3 × 12 Выполняются суперсетом.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING + GLUTE', week_label_hy = 'Ամիս 7 — LEVEL 7A — GLUTE BUILD (Շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Դադար վերևից: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 վրկ Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 13 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · ATHLETIC — LOWER BODY POWER', week_label_hy = 'Ամիս 7 — LEVEL 7A — GLUTE BUILD (Շաբաթներ 25–26)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 (Հանգիստ: 60–75 վրկ.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = 'Առավելագույն որակյալ կրկնություն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '60 վրկ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 7 — LEVEL 7B — GLUTE SHOCK (Շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Վերջին մոտեցում: 12 կրկնություն + 10 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Մեջ верхней точке: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 վրկ ստատիկ պահում Հանգիստ: 45 վրկ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY SHOCK', week_label_hy = 'Ամիս 7 — LEVEL 7B — GLUTE SHOCK (Շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 4 շրջաններ Հանգիստ: 60 վրկ.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '3 ռաունդներ 12 սովորական ծալումներ ↓ 10 молотковых ↓ 10 մասնակի կրկնություն'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '15 (Տարածում հետ ժապավենով: Վերջին մոտեցում: +15 մասնակի կրկնություն.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · GLUTE + HAMSTRING SHOCK', week_label_hy = 'Ամիս 7 — LEVEL 7B — GLUTE SHOCK (Շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 12 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 վրկ ստատիկ պահում Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 14 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · LEVEL 7 — BOSS FIGHT', week_label_hy = 'Ամիս 7 — LEVEL 7B — GLUTE SHOCK (Շաբաթներ 27–28)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 (Dumbbell Clean Squat Jump 4 × 8 Հանգիստ: 75 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Thruster Reverse Lunge 4 × 10 յուրաքանչյուր ոտքի համար Հանգիստ: 75 վրկ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար (Renegade Row Push-Up 4 × առավելագույն Հանգիստ: 75 վրկ.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = 'Максимальное քանակ որակյալ շրջաններ: 10 Goblet Squats 10 Walking Lunges 8…'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 31;
    update public.workout_sets set notes_hy = '3 ռաունդներ 20 Frog Pumps 20 Abduction 20 վրկ Glute Bridge Hold 10 Squat Pulses Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Пользователь фиксирует лучшие ցուցանիշներ.'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '28 շաբաթներ пройдено.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE TENSION', week_label_hy = 'Ամիս 8 — LEVEL 8A — TENSION BUILD (Շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → դանդաղ վար.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Տեմպ: 3 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար (Դադար մեջ нижней точке: 1 վրկ.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 կրկնություն 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Glute Bridge 15 Frog Pumps 15 Abduction 30 վրկ Glute Bridge Hold Հանգիստ: 45…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — CALISTHENICS', week_label_hy = 'Ամիս 8 — LEVEL 8A — TENSION BUILD (Շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8–15 (Եթե սովորական слишком легкие: ոտքեր վրա կայուն возвышенности.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Վերջին 3 կրկնություն: медленная негативная փուլ.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 վրկ…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Hammer Curl 12 Overhead Triceps Extension 12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '2 ռաունդներ 10 սովորական ծալումներ 10 молотковых 10 մասնակի'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN', week_label_hy = 'Ամիս 8 — LEVEL 8A — TENSION BUILD (Շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Դադար վերևից: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '20 քայլեր'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Hamstring Walkouts ↓ 15 Glute Bridges ↓ 20 Frog Pumps ↓ 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 15 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER', week_label_hy = 'Ամիս 8 — LEVEL 8A — TENSION BUILD (Շաբաթներ 29–30)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Goblet Squat Squat Jump 4 × 8 Հանգիստ: 90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Romanian Deadlift Broad Jump 4 × 6 Եթե нет безопасного места համար ցատկեր:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Dumbbell Push Press Mountain Climbers 4 × 30 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար (Renegade Row Push-Up 3 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 8 — LEVEL 8B — ATHLETIC SHOCK (Շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Վերջին 5 կրկնություն: короткая ամպլիտուդ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Հետո каждого մոտեցում: 10 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Hip Thrust 20 Frog Pumps 20 Abduction 15 Squat Pulses 30 վրկ ստատիկ պահում Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY SHOCK', week_label_hy = 'Ամիս 8 — LEVEL 8B — ATHLETIC SHOCK (Շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–12 (Դադար ներքևում: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '4 շրջաններ Lateral Raise 12 Arnold Press 10 Reverse Fly 15 Հանգիստ: 60 վրկ'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Բիցեպս 10 սովորական ծալումներ ↓ 10 молотковых ↓ 10 մասնակի 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING + GLUTE SHOCK', week_label_hy = 'Ամիս 8 — LEVEL 8B — ATHLETIC SHOCK (Շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Դադար: 3 վրկ վերևից.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–10 (Մեջ ամբողջությամբ вытянутом положении: 1 վրկ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 16 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · LEVEL 8 — BOSS FIGHT', week_label_hy = 'Ամիս 8 — LEVEL 8B — ATHLETIC SHOCK (Շաբաթներ 31–32)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Dumbbell Thruster Squat Jump 4 × 8 Հանգիստ: 75–90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8 (Dumbbell Clean Reverse Lunge + Knee Drive 4 × 10 յուրաքանչյուր ոտքի համար)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 (Renegade Row Push-Up 4 × առավելագույն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 40 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Максимальное քանակ որակյալ շրջաններ: 10 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '3 ռաունդներ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ Glute…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Пользователь фиксирует: HIP THRUST Շաբաթ 29: кг Շաբաթ 30: кг Շաբաթ 31: …'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Հետո 32 շաբաթներ пользователь переходит վրա:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'Ամիս 9 — LEVEL 9A — POWER BUILD (Շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → 3 վրկ վար Վերջին մոտեցում: 10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Տեմպ: 3 վրկ վար Վերջին 2 կրկնություն: առավելագույնս контролируемые.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Դադար մեջ нижней точке: 1 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Հետո последнего մոտեցում: 10 արագ կրկնություն առանց քաշի յուրաքանչյուր ոտքի համար)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '12 (Վերջին 3 կրկնություն: 3-секундная негативная փուլ)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 կրկնություն 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 15 Hip Thrust 15 Frog Pumps 15 Squat Pulses 20 Abduction 30 վրկ Glute Bridge…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — POWER', week_label_hy = 'Ամիս 9 — LEVEL 9A — POWER BUILD (Շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–12 (Եթե тяжело: սովորական հրում հատակից.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար (Վերջին 3 կրկնություն: դանդաղ իջեցում.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 (Դադար: 2 վրկ մեջ растянутом положении)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 կրկնություն Lateral Raise 12 կրկնություն Reverse Fly 15 կրկնություն…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ձեռքի համար (Alternating Dumbbell Curl Վերջին մոտեցում: 12 + 10 մասնակի կրկնություն)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '12 (Overhead Dumbbell Extension Band Triceps Pushdown 3 × 20)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 8 Push-Ups 10 Knee Push-Ups 10 վրկ պահում մեջ нижней точке Հանգիստ: 45 վրկ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING POWER', week_label_hy = 'Ամիս 9 — LEVEL 9A — POWER BUILD (Շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Դադար վերևից: 3 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Օգտագործել полотенце/скользящую մակերես.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 քայլեր մեջ յուրաքանչյուր կողմ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Sliding Leg Curl 15 Glute Bridge 15 Frog Pumps 20 Band Abduction 30 վրկ…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 17 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · POWER CONDITIONING', week_label_hy = 'Ամիս 9 — LEVEL 9A — POWER BUILD (Շաբաթներ 33–34)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Dumbbell Squat Squat Jump 4 × 8 Հանգիստ: 90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Romanian Deadlift Skater Jump 4 × 10 յուրաքանչյուր կողմի համար Եթե ցատկեր…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Dumbbell Push Press Mountain Climbers 4 × 40 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար (Renegade Row Push-Up 3 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '3 շրջաններ 20 Frog Pumps 15 Squat Pulses 20 Band Abduction 15 Glute Bridge 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE OVERLOAD', week_label_hy = 'Ամիս 9 — LEVEL 9B — GLUTE OVERLOAD (Շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Դադար վերևից: 3 վրկ)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: 1,5 կրկնություն)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Տեմպ: 3 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 + 20 պուլսացիաների)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Bulgarian Split Squats ↓ 15 Reverse Lunges ↓ 20 Bodyweight Squats ↓ 30 վրկ…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — CALISTHENICS LEVEL', week_label_hy = 'Ամիս 9 — LEVEL 9B — GLUTE OVERLOAD (Շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Դադար ներքևում: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '6–8 կողմի համար (Եթե сложно: делать հետ ծնկի կամ հետ уменьшенной ամպլիտուդով.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Raise Hold…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Hammer Curl 12 Band Triceps Extension 20 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Dumbbell Curl ↓ 10 Hammer Curl ↓ 10 մասնակի կրկնություն'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN OVERLOAD', week_label_hy = 'Ամիս 9 — LEVEL 9B — GLUTE OVERLOAD (Շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար վերևից: 3 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '30 (Վերջին 10: частичные.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 շրջաններ 8 Sliding Leg Curl 12 Single-Leg Glute Bridge 15 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 18 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · LEVEL 9 — BOSS FIGHT', week_label_hy = 'Ամիս 9 — LEVEL 9B — GLUTE OVERLOAD (Շաբաթներ 35–36)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 կողմի համար)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Renegade Row Push-Up 4 × առավելագույն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 45 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Максимальное քանակ որակյալ շրջաններ: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Վրա каждой тренировке пользователь записывает աշխատանքային քաշ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Հետո прохождения 9- ամսվա пользователь открывает:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE HYPERTROPHY', week_label_hy = 'Ամիս 10 — LEVEL 10A — HYPERTROPHY BUILD (Շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → 3 վրկ վար Վերջին մոտեցում: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Հետին ոտք բարձրացված մակերեսի վրա.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Դադար մեջ нижней точке: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: медленная негативная փուլ.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '30 (Վերջին մոտեցում: 30 կրկնություն 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 12 Hip Thrust ↓ 15 Bodyweight Squats ↓ 20 Frog Pumps ↓ 20 Abduction ↓ 30 վրկ…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — STRENGTH', week_label_hy = 'Ամիս 10 — LEVEL 10A — HYPERTROPHY BUILD (Շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին մոտեցում: +3–5 մասնակի կրկնություն.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար (Դադար մեջ верхней точке: 2 վրկ.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 (Տեմպ: 3 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 կրկնություն Lateral Raise 15 կրկնություն Front Raise 12 կրկնություն…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Սուպերսեթ Dumbbell Curl 12 Overhead Triceps Extension 12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Բիցեպս 10 սովորական ծալումներ 10 молотковых 10 մասնակի Տրիցեպս 15 տարածումներ հետ ժապավենով 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN', week_label_hy = 'Ամիս 10 — LEVEL 10A — HYPERTROPHY BUILD (Շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Դադար: 3 վրկ վերևից.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12 (Եթե слишком тяжело: Hamstring Walkout.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 53;
    update public.workout_sets set notes_hy = '25 (Վերջին 10: частичная ամպլիտուդ.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 20 Abduction 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 19 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER + DENSITY', week_label_hy = 'Ամիս 10 — LEVEL 10A — HYPERTROPHY BUILD (Շաբաթներ 37–38)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Dumbbell Thruster Squat Jump 4 × 8 Հանգիստ: 90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 յուրաքանչյուր ոտքի համար)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր ձեռքի համար (Renegade Row Push-Up 4 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 40 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '3 շրջաններ 20 Frog Pumps 15 Squat Pulses 20 Abduction 15 Glute Bridge 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE DENSITY', week_label_hy = 'Ամիս 10 — LEVEL 10B — DENSITY SHOCK (Շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '15 (Դադար վերևից: 3 վրկ Վերջին մոտեցում: 15 + 10 պուլսացիաների + 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: 1,5 կրկնություն.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '15 (Տեմպ: 4 վրկ վար.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '15 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '30 (Վերջին մոտեցում: 30 + 20 պուլսացիաների.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 շրջաններ 15 Reverse Lunges 20 Frog Pumps 20 Squat Pulses 20 Abduction 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — CALISTHENICS SHOCK', week_label_hy = 'Ամիս 10 — LEVEL 10B — DENSITY SHOCK (Շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8 յուրաքանչյուր կողմի համար (Եթե тяжело: делать հետ ծնկի.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 ↓ Lateral Raise 12 ↓ Partial Lateral Raise 15 ↓ Reverse Fly 15…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Բիցեպս 8 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Push-Ups 10 Knee Push-Ups 20 վրկ ստատիկ պահում մեջ нижней точке Հանգիստ: 45 վրկ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING + GLUTE DENSITY', week_label_hy = 'Ամիս 10 — LEVEL 10B — DENSITY SHOCK (Շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար: 3 վրկ վերևից.)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '14 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '30 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 20 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · LEVEL 10 — FINAL BOSS', week_label_hy = 'Ամիս 10 — LEVEL 10B — DENSITY SHOCK (Շաբաթներ 39–40)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 կողմի համար Եթե ցատկեր կատարել небезопасно:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Renegade Row Push-Up 4 × առավելագույն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 45 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Максимальное քանակ որակյալ շրջաններ: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Пользователь фиксирует ցուցանիշներ յուրաքանչյուր շաբաթ.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'NEXT LEVEL'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE POWER', week_label_hy = 'Ամիս 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → 3 վրկ վար Վերջին մոտեցում: 8–10…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր ոտքի համար (Передняя ոտք վրա փոքր բարձրացված մակերես. Տեմպ: 3 վրկ վար Վերջին մոտեցում: +5 պուլսացիաների)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Դադար մեջ нижней точке: 1 վրկ)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: դանդաղ.)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Դադար վերևից: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 սովորական 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 12 Hip Thrust 15 Bulgarian Pulses 20 Frog Pumps 20 Abduction 30 վրկ Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · UPPER BODY — STRENGTH', week_label_hy = 'Ամիս 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին մոտեցում: +5 մասնակի կրկնություն)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր ձեռքի համար (Դադար: 2 վրկ մեջ верхней точке)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12 (Եթե слишком тяжело: սովորական հրում հատակից.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10–12 (Տեմպ: 3 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Հանգիստ: 60 վրկ'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Սուպերսեթ Dumbbell Curl 10–12 Overhead Triceps Extension 10–12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Բիցեպս 10 սովորական 10 молотковых 10 մասնակի Տրիցեպս 15 տարածումներ 15 պուլսացիաների 20 վրկ…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · HAMSTRING POWER', week_label_hy = 'Ամիս 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 3 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր կողմի համար (Վերջին 10: короткая ամպլիտուդ.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 21 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FULL BODY — POWER', week_label_hy = 'Ամիս 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (Շաբաթներ 41–42)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Dumbbell Thruster Squat Jump 4 × 8 Հանգիստ: 90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 յուրաքանչյուր ոտքի համար)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր կողմի համար (Renegade Row Push-Up 4 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 40 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Յուրաքանչյուր րոպե начинается новое վարժություն.'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · GLUTE SHOCK', week_label_hy = 'Ամիս 11 — LEVEL 11B — MUSCLE SHOCK (Շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Դադար: 3 վրկ վերևից Վերջին մոտեցում: 12 10 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: 1,5 կրկնություն)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Տեմպ: 4 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '30 (Վերջին 10: пульсации.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 64;
    update public.workout_sets set notes_hy = '4 շրջաններ 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · CALISTHENICS UPPER BODY', week_label_hy = 'Ամիս 11 — LEVEL 11B — MUSCLE SHOCK (Շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8 յուրաքանչյուր կողմի համար (Եթե тяжело: делать облегченный տարբերակ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '8 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '10 կրկնություն ↓ 20 վրկ հանգստի ↓ 5 կրկնություն ↓ 20 վրկ հանգստի ↓ 5 կրկնություն 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '3 շրջաններ 10 Push-Ups 10 Knee Push-Ups 20 վրկ պահում Հանգիստ: 45 վրկ.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · POSTERIOR CHAIN SHOCK', week_label_hy = 'Ամիս 11 — LEVEL 11B — MUSCLE SHOCK (Շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար: 3 վրկ վերևից)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '30 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 22 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · LEVEL 11 — FINAL BOSS', week_label_hy = 'Ամիս 11 — LEVEL 11B — MUSCLE SHOCK (Շաբաթներ 43–44)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Dumbbell Thruster Squat Jump 4 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 յուրաքանչյուր կողմի համար Եթե ցատկեր ոչ подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10 (Renegade Row Push-Up 4 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 45 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Максимальное քանակ որակյալ շրջաններ: 12 Goblet Squats 10 Reverse Lunges 8…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Յուրաքանչյուր շաբաթ фиксируем: HIP THRUST / GLUTE BRIDGE Շաբաթ 41: кг Շաբաթ 42: кг…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Հետո այս пользователь переходит վրա:'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · FINAL GLUTE STRENGTH', week_label_hy = 'Ամիս 12 — FINAL BUILD (շաբաթներ 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8 (Տեմպ: 2 վրկ վեր → 2 վրկ պահում → 3 վրկ վար Վերջին մոտեցում: 8 կրկնություն ↓ снизить…)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր ոտքի համար (Տեմպ: 3 վրկ վար Վերջին մոտեցում: +5 պուլսացիաների)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '10–12 (Դադար: 2 վրկ ներքևում)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: медленная негативная փուլ.)'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '25 (Վերջին մոտեցում: 25 սովորական 20 պուլսացիաների 20 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '3 շրջաններ 12 Hip Thrust 15 Bulgarian Lunges 20 Frog Pumps 20 Abduction 30 վրկ Glute…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · FINAL UPPER BODY', week_label_hy = 'Ամիս 12 — FINAL BUILD (շաբաթներ 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Վերջին մոտեցում: +5 մասնակի կրկնություն)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար (Դադար վերևից: 2 վրկ)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–12 (Եթե тяжело: սովորական հրում հատակից.)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 (Տեմպ: 3 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = 'Սուպերսեթ Dumbbell Curl 12 Overhead Triceps Extension 12 4 շրջաններ'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = 'Բիցեպս 10 սովորական 10 молотковых 10 մասնակի Տրիցեպս 15 տարածումներ հետ ժապավենով 15…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · FINAL POSTERIOR CHAIN', week_label_hy = 'Ամիս 12 — FINAL BUILD (շաբաթներ 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '8–10 (Տեմպ: 4 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Դադար: 3 վրկ վերևից)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '8–12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '20 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '30 յուրաքանչյուր կողմի համար (Վերջին 10: короткая ամպլիտուդ.)'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 23 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · FINAL POWER DAY', week_label_hy = 'Ամիս 12 — FINAL BUILD (շաբաթներ 45–46)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '10 (Dumbbell Thruster Squat Jump 4 × 8 Հանգիստ: 90 վրկ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '10 (Dumbbell Sumo Deadlift Reverse Lunge + Knee Drive 4 × 10 յուրաքանչյուր ոտքի համար)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8 յուրաքանչյուր կողմի համար (Renegade Row Push-Up 4 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '20 (Dumbbell Swing Mountain Climbers 4 × 45 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = 'Минута 1 10 Goblet Squats Минута 2 12 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '4 շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '4 շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Այժմ ամբողջությամբ փոխում ենք վարժություն և характер բեռի.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 1;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երկուշաբթի · FINAL GLUTE SHOCK', week_label_hy = 'Ամիս 12 — FINAL BOSS (շաբաթներ 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Դադար վերևից: 3 վրկ Վերջին մոտեցում: 12 15 պուլսացիաների 30 վրկ ստատիկ պահում.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 5;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ոտքի համար (Վերջին 3 կրկնություն: 1,5 կրկնություն)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '12 (Տեմպ: 4 վրկ վար)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '25'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 2;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Երեքշաբթի · FINAL CALISTHENICS', week_label_hy = 'Ամիս 12 — FINAL BOSS (շաբաթներ 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '6–8 յուրաքանչյուր կողմի համար (Ժամանակ необходимости: облегченный տարբերակ.)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '8–10 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '8–15'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '12'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր ձեռքի համար'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 43;
    update public.workout_sets set notes_hy = '4 շրջաններ Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '8 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն ↓ 20 վրկ հանգստի ↓ 4 կրկնություն 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = '10 կրկնություն ↓ 20 վրկ հանգստի ↓ 5 կրկնություն ↓ 20 վրկ հանգստի ↓ 5 կրկնություն 3 ռաունդներ'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '3 ռաունդներ 10 Push-Ups 10 Knee Push-Ups 20 վրկ պահում Հանգիստ: 45 վրկ.'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 3;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Հինգշաբթի · FINAL HAMSTRING SHOCK', week_label_hy = 'Ամիս 12 — FINAL BOSS (շաբաթներ 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 4;
    update public.workout_sets set notes_hy = '15 (Դադար: 3 վրկ վերևից)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 14;
    update public.workout_sets set notes_hy = '14 յուրաքանչյուր ոտքի համար'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 24;
    update public.workout_sets set notes_hy = '10'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 34;
    update public.workout_sets set notes_hy = '20'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 44;
    update public.workout_sets set notes_hy = '25 յուրաքանչյուր կողմի համար'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 54;
    update public.workout_sets set notes_hy = '30'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 63;
    update public.workout_sets set notes_hy = '4 շրջաններ 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = '4 վարժություն ըստ 60 վրկ, հանգիստ 15 վրկ միջև վարժ.., 60 վրկ շրջանների միջև'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
  end if;

  select id into v_workout_id from public.workouts
  where program_id = v_program_id and week_order = 24 and "order" = 4;
  if v_workout_id is not null then
    v_updated_workouts := v_updated_workouts + 1;
    update public.workouts set title_hy = 'Շաբաթ · 🏆 FINAL BOSS — YEAR 1', week_label_hy = 'Ամիս 12 — FINAL BOSS (շաբաթներ 47–48)'
    where id = v_workout_id;
    update public.workout_sets set notes_hy = '12 (Dumbbell Thruster Squat Jump 3 × 10)'
    where workout_id = v_workout_id and "order" >= 0 and "order" < 3;
    update public.workout_sets set notes_hy = '15 (Dumbbell Sumo Deadlift Skater Jump 3 × 10 յուրաքանչյուր կողմի համար Եթե ցատկեր ոչ подходят:…)'
    where workout_id = v_workout_id and "order" >= 10 and "order" < 13;
    update public.workout_sets set notes_hy = '10 յուրաքանչյուր կողմի համար (Renegade Row Push-Up 3 × առավելագույն որակյալ կրկնություն)'
    where workout_id = v_workout_id and "order" >= 20 and "order" < 23;
    update public.workout_sets set notes_hy = '25 (Dumbbell Swing Mountain Climbers 3 × 60 վրկ)'
    where workout_id = v_workout_id and "order" >= 30 and "order" < 33;
    update public.workout_sets set notes_hy = 'Կատարել максимальное քանակ որակյալ շրջաններ: 10 Goblet Squats 10 Reverse Lunges…'
    where workout_id = v_workout_id and "order" >= 40 and "order" < 41;
    update public.workout_sets set notes_hy = '5 Շրջաններ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 վրկ ստատիկ պահում…'
    where workout_id = v_workout_id and "order" >= 50 and "order" < 51;
    update public.workout_sets set notes_hy = '5 Շրջաններ յուրաքանչյուր վարժություն: 60 վրկ V-Ups Bicycle Mountain Climbers Hollow Hold Հանգիստ:…'
    where workout_id = v_workout_id and "order" >= 60 and "order" < 61;
    update public.workout_sets set notes_hy = 'Մեջ վերջում 48- շաբաթներ пользователь сравнивает ցուցանիշներ հետ первым ամսվա.'
    where workout_id = v_workout_id and "order" >= 70 and "order" < 71;
    update public.workout_sets set notes_hy = 'Push-Ups Ամիս 1: Ամիս 12: AMRAP 20 MIN Ամիս 1: շրջաններ Ամիս 12: …'
    where workout_id = v_workout_id and "order" >= 80 and "order" < 81;
    update public.workout_sets set notes_hy = 'Համեմատել: քաշ; объем бедер; объем ягодиц; объем талии; լուսանկար спереди; լուսանկար сбоку; լուսանկար…'
    where workout_id = v_workout_id and "order" >= 90 and "order" < 91;
    update public.workout_sets set notes_hy = 'Ты прошла:'
    where workout_id = v_workout_id and "order" >= 100 and "order" < 101;
  end if;

  if v_updated_workouts <> 94 then
    raise exception 'Ожидалось % переведённых тренировок для nabor-massy-zhenshchiny-doma, найдено % — проверьте, что RU-контент (0014-0021) не менялся после генерации перевода', 94, v_updated_workouts;
  end if;
end $$;
