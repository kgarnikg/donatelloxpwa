-- 0015_seed_pohudenie_zhenshchiny_zal.sql
-- Программа: Похудение — Женщины — Зал
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0015), по одной на каждую комбинацию
-- пол × цель × формат — см. 0014..0021 и журнал в PROJECT_PLAN.md.
--
-- 47 тренировок, 161 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Похудение — Женщины — Зал)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('razminka-dorozhka-5-min-spokoynaya-hodba-5-min-podem-v-goru-naklon-5-289a05', 'Разминка: дорожка — 5 мин спокойная ходьба + 5 мин подъём в гору (наклон 5–8°, умеренный темп)'),
  ('prisedanie-na-skamyu-sest-kontroliruemo-vstat', 'Приседание на скамью (сесть контролируемо → встать)'),
  ('zhim-nogami', 'Жим ногами'),
  ('vypady-nazad', 'Выпады назад'),
  ('podem-na-skameyku-step-ap', 'Подъём на скамейку (степ-ап)'),
  ('yagodichnyy-most-fiksatsiya-1-2-sek-vverhu', 'Ягодичный мост (фиксация 1–2 сек вверху)'),
  ('otvedenie-nog-naruzhu-trenazher', 'Отведение ног наружу (тренажёр)'),
  ('privedenie-nog-trenazher', 'Приведение ног (тренажёр)'),
  ('kardio-finisher-dorozhka-1-min-naklon-5-6-umerenno-1-min-naklon-8-10-528fa4', 'Кардио-финишер: дорожка — 1 мин наклон 5–6° умеренно / 1 мин наклон 8–10° быстрее ×5'),
  ('press-3-kruga-15-reverse-crunch-15-skruchivaniy-20-kasaniy-pyatok-30-5a1f5b', 'Пресс — 3 круга: 15 Reverse Crunch, 15 скручиваний, 20 касаний пяток, 30 сек планка'),
  ('razminka-dorozhka-5-min-hodba-5-min-naklon-5-8', 'Разминка: дорожка — 5 мин ходьба + 5 мин наклон 5–8°'),
  ('tyaga-verhnego-bloka-k-grudi', 'Тяга верхнего блока к груди'),
  ('tyaga-gorizontalnogo-bloka-svesti-lopatki-v-kontse', 'Тяга горизонтального блока (свести лопатки в конце)'),
  ('tyaga-verhnego-bloka-obratnym-hvatom', 'Тяга верхнего блока обратным хватом'),
  ('obratnaya-babochka-zadnyaya-delta-verh-spiny', 'Обратная бабочка (задняя дельта + верх спины)'),
  ('zhim-ganteley-nad-golovoy', 'Жим гантелей над головой'),
  ('mahi-gantelyami-v-storony', 'Махи гантелями в стороны'),
  ('razgibanie-ruk-na-trose', 'Разгибание рук на тросе'),
  ('sgibanie-ruk-s-gantelyami', 'Сгибание рук с гантелями'),
  ('superset-3-mahi-v-storony-15-razgibanie-ruk-15-sgibanie-ruk-12-otdyh-9e40dc', 'Суперсет ×3: Махи в стороны 15 + Разгибание рук 15 + Сгибание рук 12, отдых 45 сек'),
  ('kardio-ellips-lyzhi-30-sek-bystree-60-sek-spokoyno-7', 'Кардио: эллипс/лыжи — 30 сек быстрее / 60 сек спокойно ×7'),
  ('press-3-kruga-15-reverse-crunch-15-skruchivaniy-20-russian-twist-30-600db4', 'Пресс — 3 круга: 15 Reverse Crunch, 15 скручиваний, 20 Russian Twist, 30 сек планка'),
  ('razminka-dorozhka-5-min-hodba-5-min-postepenno-uvelichivaem-temp', 'Разминка: дорожка — 5 мин ходьба + 5 мин постепенно увеличиваем темп'),
  ('prisedanie-na-skamyu', 'Приседание на скамью'),
  ('tyaga-verhnego-bloka', 'Тяга верхнего блока'),
  ('tyaga-gorizontalnogo-bloka', 'Тяга горизонтального блока'),
  ('zhim-ganteley-lezha', 'Жим гантелей лёжа'),
  ('yagodichnyy-most', 'Ягодичный мост'),
  ('otvedenie-nogi-nazad', 'Отведение ноги назад'),
  ('full-body-circuit-3-15-prisedaniy-na-skamyu-12-tyag-verhnego-bloka-12-45e450', 'Full Body Circuit ×3: 15 приседаний на скамью, 12 тяг верхнего блока, 12 жимов гантелей, 15 ягодичных мостов, 10 подъёмов на ногу, 20 Mountain Climbers, отдых 60 сек'),
  ('kardio-lyzhi-30-sek-bystro-60-sek-spokoyno', 'Кардио лыжи — 30 сек быстро / 60 сек спокойно'),
  ('dorozhka-naklon-6-10-temp-menyaem-kazhdye-2-min', 'Дорожка — наклон 6–10°, темп меняем каждые 2 мин'),
  ('razminka-dorozhka-3-min-hodba-5-min-naklon-5-8-menyaem-temp-kazhduyu-426469', 'Разминка: дорожка — 3 мин ходьба + 5 мин наклон 5–8° (меняем темп каждую минуту)'),
  ('prisedanie-s-gantelyu', 'Приседание с гантелью'),
  ('zhim-nogami-posl-podhod-12-obychnyh-5-chastichnyh-vnizu', 'Жим ногами (посл. подход: 12 обычных + 5 частичных внизу)'),
  ('vypady-nazad-s-gantelyami', 'Выпады назад с гантелями'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('yagodichnyy-most-s-vesom-fiksatsiya-2-sek', 'Ягодичный мост с весом (фиксация 2 сек)'),
  ('otvedenie-nogi-nazad-tros', 'Отведение ноги назад (трос)'),
  ('superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-nazad-d73775', 'Суперсет ×3: Отведение ног 20 + Ягодичный мост 15 + Отведение ноги назад 12 на каждую, отдых 45 сек'),
  ('kardio-finisher-dorozhka-1-min-naklon-6-umerenno-1-min-naklon-10-87d349', 'Кардио-финишер: дорожка — 1 мин наклон 6° умеренно / 1 мин наклон 10° быстро ×5'),
  ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-30-c30abc', 'Пресс — 3 круга: 15 Reverse Crunch, 20 скручиваний, 20 касаний пяток, 30–40 сек планка'),
  ('razminka-dorozhka-naklon-5-8-temp-postepenno-vyshe', 'Разминка: дорожка, наклон 5–8°, темп постепенно выше'),
  ('tyaga-odnoy-rukoy-trenazher-blok', 'Тяга одной рукой (тренажёр/блок)'),
  ('obratnaya-babochka', 'Обратная бабочка'),
  ('kardio-lyzhi-ellips-30-sek-bystro-60-sek-spokoyno', 'Кардио: лыжи/эллипс — 30 сек быстро / 60 сек спокойно'),
  ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-40-b86686', 'Пресс — 3 круга: 15 Reverse Crunch, 20 Bicycle Crunch, 20 Russian Twist, 40 сек планка'),
  ('razminka-dorozhka-naklon-6-10-postoyanno-menyaem-temp', 'Разминка: дорожка, наклон 6–10°, постоянно меняем темп'),
  ('prisedanie-v-smite', 'Приседание в Смите'),
  ('vypady-s-hodboy', 'Выпады с ходьбой'),
  ('sgibanie-nog-v-trenazhere', 'Сгибание ног в тренажёре'),
  ('razgibanie-nog', 'Разгибание ног'),
  ('otvedenie-nog-naruzhu', 'Отведение ног наружу'),
  ('superset-3-sgibanie-nog-12-15-yagodichnyy-most-15-otvedenie-nog-20', 'Суперсет ×3: Сгибание ног 12–15 + Ягодичный мост 15 + Отведение ног 20'),
  ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-10', 'Кардио лыжи — 20 сек быстро / 40 сек спокойно ×10'),
  ('dorozhka-naklon-8-10-umerennyy-temp', 'Дорожка — наклон 8–10°, умеренный темп'),
  ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-40-5869ce', 'Пресс — 3 круга: 15 Reverse Crunch, 20 скручиваний, 20 касаний пяток, 40 сек планка'),
  ('razminka-dorozhka-postepennoe-uvelichenie-tempa', 'Разминка: дорожка, постепенное увеличение темпа'),
  ('full-body-circuit-3-4-15-prisedaniy-12-tyag-verhnego-bloka-12-zhimov-f7eff1', 'Full Body Circuit ×3–4: 15 приседаний, 12 тяг верхнего блока, 12 жимов гантелей, 15 ягодичных мостов, 10 выпадов на ногу, 20 Mountain Climbers, отдых 60 сек'),
  ('kardio-finisher-30-sek-vysokiy-temp-60-sek-spokoyno-7', 'Кардио-финишер: 30 сек высокий темп / 60 сек спокойно ×7'),
  ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-40-sek-e783a2', 'Пресс — 3 круга: 15 V-Ups, 15 Reverse Crunch, 20 Russian Twist, 40 сек планка'),
  ('razminka-dorozhka-3-min-hodba-5-min-naklon-6-10-postepenno-bystree', 'Разминка: дорожка — 3 мин ходьба + 5 мин наклон 6–10°, постепенно быстрее'),
  ('yagodichnyy-most-hip-thrust-fiksatsiya-2-sek-vverhu', 'Ягодичный мост / Hip Thrust (фиксация 2 сек вверху)'),
  ('rumynskaya-tyaga-opuskanie-3-sek', 'Румынская тяга (опускание 3 сек)'),
  ('zhim-nogami-postanovka-chut-vyshe-tsentra-platformy-aktsent-yagoditsy', 'Жим ногами (постановка чуть выше центра платформы — акцент ягодицы)'),
  ('bolgarskiy-split-prised', 'Болгарский сплит-присед'),
  ('sgibanie-nog', 'Сгибание ног'),
  ('otvedenie-nog-naruzhu-posl-podhod-15-obychnyh-10-chastichnyh', 'Отведение ног наружу (посл. подход: 15 обычных + 10 частичных)'),
  ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 'Glute Superset ×3: Отведение ног 20 + Ягодичный мост 15 + Отведение ноги назад 12 на каждую, отдых 45 сек'),
  ('kardio-finisher-dorozhka-1-min-naklon-7-umerenno-1-min-naklon-10-12-bd6a94', 'Кардио-финишер: дорожка — 1 мин наклон 7° умеренно / 1 мин наклон 10–12° быстро ×6'),
  ('razminka-na-dorozhke', 'Разминка на дорожке'),
  ('tyaga-odnoy-rukoy', 'Тяга одной рукой'),
  ('face-pull', 'Face Pull'),
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('superset-plechi-ruki-3-mahi-v-storony-15-face-pull-15-razgibanie-ruk-13a5e9', 'Суперсет плечи+руки ×3: Махи в стороны 15 + Face Pull 15 + Разгибание рук 15 + Сгибание рук 12, отдых 45 сек'),
  ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 'Кардио эллипс — 30 сек быстро / 60 сек спокойно ×10'),
  ('ikry', 'Икры'),
  ('leg-superset-3-razgibanie-nog-15-prisedanie-s-gantelyu-12-otvedenie-c37558', 'Leg Superset ×3: Разгибание ног 15 + Приседание с гантелью 12 + Отведение ног 20'),
  ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-12', 'Кардио лыжи — 20 сек быстро / 40 сек спокойно ×12'),
  ('dorozhka-naklon-8-12-umerennyy-temp', 'Дорожка — наклон 8–12°, умеренный темп'),
  ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 'Пресс — 3 круга: 15 Reverse Crunch, 20 скручиваний, 20 касаний пяток, 45 сек планка'),
  ('razminka', 'Разминка'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-e1a530', 'Full Body Circuit ×4: 12 Goblet Squat, 12 тяг верхнего блока, 12 жимов гантелей, 15 ягодичных мостов, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45–60 сек'),
  ('metabolic-finisher-3-15-prisedaniy-10-vypadov-na-nogu-12-tyag-e9bf07', 'Metabolic Finisher ×3: 15 приседаний, 10 выпадов на ногу, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, отдых 45 сек'),
  ('kardio-30-sek-bystro-60-sek-spokoyno-7', 'Кардио — 30 сек быстро / 60 сек спокойно ×7'),
  ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 'Пресс — 3 круга: 15 V-Ups, 15 Reverse Crunch, 20 Russian Twist, 45 сек планка'),
  ('razminka-5-min-hodba-5-min-naklon-6-10', 'Разминка: 5 мин ходьба + 5 мин наклон 6–10°'),
  ('hip-thrust-fiksatsiya-2-sek-vverhu', 'Hip Thrust (фиксация 2 сек вверху)'),
  ('zhim-nogami-posl-podhod-10-12-obychnyh-5-chastichnyh', 'Жим ногами (посл. подход: 10–12 обычных + 5 частичных)'),
  ('otvedenie-nogi-nazad-v-krossovere', 'Отведение ноги назад в кроссовере'),
  ('glute-finisher-3-15-yagodichnyh-mostov-15-otvedeniy-pravoy-15-dee08e', 'Glute Finisher ×3: 15 ягодичных мостов, 15 отведений правой, 15 отведений левой, 20 отведений наружу, отдых 30–45 сек'),
  ('kardio-dorozhka-1-min-naklon-7-umerenno-1-min-naklon-10-12-bystro-6', 'Кардио: дорожка — 1 мин наклон 7% умеренно / 1 мин наклон 10–12% быстро ×6'),
  ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 'Суперсет плечи ×3: Махи 15 + Face Pull 15 + Разведение в наклоне 15, отдых 45 сек'),
  ('superset-ruki-3-razgibanie-ruk-15-sgibanie-ruk-12', 'Суперсет руки ×3: Разгибание рук 15 + Сгибание рук 12'),
  ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 'Пресс — 3 круга: 15 Reverse Crunch, 20 Bicycle Crunch, 20 Russian Twist, 45 сек планка'),
  ('razgibanie-nog-posl-podhod-12-obychnyh-5-chastichnyh', 'Разгибание ног (посл. подход: 12 обычных + 5 частичных)'),
  ('leg-superset-3-razgibanie-nog-15-prisedanie-s-gantelyu-12-otvedenie-dd5ccd', 'Leg Superset ×3: Разгибание ног 15 + Приседание с гантелью 12 + Отведение ног 20, отдых 45–60 сек'),
  ('leg-finisher-3-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-204f19', 'Leg Finisher ×3: 12 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 отведений ног, отдых 45 сек'),
  ('dorozhka-naklon-8-12-umerennyy-temp-2', 'Дорожка — наклон 8–12%, умеренный темп'),
  ('goblet-squat', 'Goblet Squat'),
  ('hip-thrust', 'Hip Thrust'),
  ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-49b3f4', 'Full Body Circuit ×4: 12 Goblet Squat, 12 тяг верхнего блока, 12 жимов гантелей, 12 румынских тяг, 15 ягодичных мостов, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45–60 сек'),
  ('metabolic-finisher-3-15-prisedaniy-10-vypadov-na-nogu-12-tyag-7ebe7f', 'Metabolic Finisher ×3: 15 приседаний, 10 выпадов на ногу, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 45 сек'),
  ('kardio-30-sek-vysokiy-temp-60-sek-spokoyno-8', 'Кардио — 30 сек высокий темп / 60 сек спокойно ×8'),
  ('razminka-5-min-hodba-5-min-naklon-6-10-2', 'Разминка: 5 мин ходьба + 5 мин наклон 6–10%'),
  ('hip-thrust-fiksatsiya-2-sek', 'Hip Thrust (фиксация 2 сек)'),
  ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-154ba2', 'Glute Finisher ×3: 15 ягодичных мостов, 15+15 отведений, 20 отведений наружу, отдых 30–45 сек'),
  ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 'Кардио: дорожка — 1 мин наклон 7% / 1 мин наклон 10–12% ×7–8'),
  ('tyaga-obratnym-hvatom', 'Тяга обратным хватом'),
  ('razvedenie-v-naklone', 'Разведение в наклоне'),
  ('superset-ruki-3-razgibanie-15-sgibanie-12', 'Суперсет руки ×3: Разгибание 15 + Сгибание 12'),
  ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20', 'Leg Superset ×3: Разгибание ног 15 + Goblet Squat 12 + Отведение ног 20'),
  ('leg-finisher-3-12-prisedaniy-10-vypadov-na-kazhduyu-15-yagodichnyh-c6db54', 'Leg Finisher ×3: 12 приседаний, 10 выпадов на каждую, 15 ягодичных мостов, 20 отведений ног, отдых 45 сек'),
  ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 'Кардио лыжи — 20 сек быстро / 40 сек спокойно ×15'),
  ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-40d2c0', 'Full Body Circuit ×4: 12 Goblet Squat, 12 тяг верхнего блока, 12 жимов гантелей, 12 румынских тяг, 15 ягодичных мостов, 10 выпадов, 20 Mountain Climbers, отдых 45 сек'),
  ('fat-burn-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-32cd0d', 'Fat Burn Finisher ×4: 15 приседаний, 10 выпадов, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 30–45 сек'),
  ('kardio-30-sek-vysokiy-temp-60-sek-vosstanovlenie-8', 'Кардио — 30 сек высокий темп / 60 сек восстановление ×8'),
  ('hip-thrust-posl-1-2-povt-tyazhelye-fiksatsiya-2-sek', 'Hip Thrust (посл. 1–2 повт. тяжёлые, фиксация 2 сек)'),
  ('glute-superset-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-ca312a', 'Glute Superset ×3: Ягодичный мост 15 + Отведение ног наружу 20 + Отведение ноги назад 12 на каждую, отдых 45 сек'),
  ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 'Суперсет руки ×3: Разгибание 15 + Сгибание 12, отдых 45 сек'),
  ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-c09f5d', 'Leg Superset ×3: Разгибание ног 15 + Goblet Squat 12 + Отведение ног 20, отдых 45–60 сек'),
  ('leg-finisher-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-70e5a1', 'Leg Finisher ×3: 12 приседаний, 10 выпадов, 15 ягодичных мостов, 20 отведений ног, отдых 45 сек'),
  ('hiit-finisher-lyzhi-ellips-velotrenazher-20-sek-vysokiy-temp-40-sek-4cb300', 'HIIT-финишер (лыжи/эллипс/велотренажёр): 20 сек высокий темп / 40 сек восстановление ×10'),
  ('dorozhka-naklon-6-10-umerennyy-temp', 'Дорожка — наклон 6–10%, умеренный темп'),
  ('zhim-nogami-posl-podhod-10-12-5-chastichnyh', 'Жим ногами (посл. подход: 10–12 + 5 частичных)'),
  ('glute-burnout-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-68303c', 'Glute Burnout ×3: 15 ягодичных мостов, 15+15 отведений, 20 отведений наружу, отдых 30–45 сек'),
  ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10-11', 'Кардио эллипс — 30 сек быстро / 60 сек спокойно ×10–11'),
  ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 'Разгибание ног (посл. подход: 12+5 частичных)'),
  ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 'Leg Superset ×3: Разгибание ног 15 + Goblet Squat 12 + Отведение ног 20, отдых 45 сек'),
  ('leg-burnout-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-8b703f', 'Leg Burnout ×3: 12 приседаний, 10 выпадов, 15 ягодичных мостов, 20 отведений ног, отдых 45 сек'),
  ('conditioning-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-e5bd77', 'Conditioning Finisher ×4: 15 приседаний, 10 выпадов, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 30–45 сек'),
  ('kardio-20-sek-vysokiy-temp-40-sek-vosstanovlenie-12', 'Кардио — 20 сек высокий темп / 40 сек восстановление ×12'),
  ('superset-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-otvedenie-c4475e', 'Суперсет ×3: Ягодичный мост 15 + Отведение ног наружу 20 + Отведение ноги назад 12 на каждую, отдых 45 сек'),
  ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-0b20c3', 'Full Body Circuit ×4: 12 Goblet Squat, 12 тяг верхнего блока, 12 жимов гантелей, 12 румынских тяг, 15 ягодичных мостов, 10 выпадов, 20 Mountain Climbers, отдых 45–60 сек'),
  ('hiit-velotrenazher-ellips-lyzhi-20-sek-vysokiy-temp-40-sek-1297bc', 'HIIT (велотренажёр/эллипс/лыжи): 20 сек высокий темп / 40 сек восстановление ×12'),
  ('hip-thrust-fiksatsiya-2-sek-bez-poteri-tehniki', 'Hip Thrust (фиксация 2 сек, без потери техники)'),
  ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-289062', 'Пресс — 3 круга: 15 Reverse Crunch, 20 Bicycle Crunch, 20 касаний пяток, 45 сек планка'),
  ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10-12', 'Кардио эллипс — 30 сек быстро / 60 сек спокойно ×10–12'),
  ('metabolic-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-bc7a49', 'Metabolic Finisher ×4: 15 приседаний, 10 выпадов, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 30–45 сек'),
  ('razminka-5-min-hodba-5-min-naklon-7-10', 'Разминка: 5 мин ходьба + 5 мин наклон 7–10%'),
  ('hip-thrust-posl-podhod-8-10-5-chastichnyh-10-sek-fiksatsiya', 'Hip Thrust (посл. подход: 8–10 + 5 частичных + 10 сек фиксация)'),
  ('rumynskaya-tyaga-3-sek-vniz-1-sek-vverh', 'Румынская тяга (3 сек вниз, 1 сек вверх)'),
  ('zhim-nogami-posl-podhod-ne-dovodit-do-otkaza', 'Жим ногами (посл. подход не доводить до отказа)'),
  ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-ce77cb', 'Glute Finisher ×3: 15 ягодичных мостов, 15+15 отведений, 20 отведений наружу, отдых 30 сек'),
  ('kardio-dorozhka-1-min-naklon-8-1-min-naklon-10-12-7-8', 'Кардио: дорожка — 1 мин наклон 8% / 1 мин наклон 10–12% ×7–8'),
  ('giant-set-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-mahi-72645d', 'Giant Set плечи ×3: Махи 15 + Face Pull 15 + Разведение в наклоне 15 + Махи 10, отдых 60 сек'),
  ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-12', 'Кардио эллипс — 30 сек быстро / 60 сек спокойно ×12'),
  ('razgibanie-nog-posl-podhod-12-5-10-sek-fiksatsiya', 'Разгибание ног (посл. подход: 12+5+10 сек фиксация)'),
  ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-16', 'Кардио лыжи — 20 сек быстро / 40 сек спокойно ×16'),
  ('hiit-predpochtitelno-nizkoudarnoe-velotrenazher-ellips-lyzhi-20-sek-be3efb', 'HIIT — предпочтительно низкоударное (велотренажёр/эллипс/лыжи): 20 сек высокий темп / 40 сек восстановление ×12'),
  ('hip-thrust-fiksatsiya-2-sek-posl-podhod-8-10-5-chastichnyh', 'Hip Thrust (фиксация 2 сек, посл. подход: 8–10 + 5 частичных)'),
  ('glute-giant-set-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-8696b1', 'Glute Giant Set ×3: Ягодичный мост 15 + Отведение ног наружу 20 + Отведение правой 12 + Отведение левой 12, отдых 45 сек'),
  ('glute-burnout-3-20-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-743a1e', 'Glute Burnout ×3: 20 ягодичных мостов, 15+15 отведений, 20 отведений наружу, отдых 30–45 сек'),
  ('final-conditioning-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-4786b8', 'Final Conditioning ×4: 15 приседаний, 10 выпадов, 12 тяг гантелей, 15 ягодичных мостов, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 30–45 сек'),
  ('glute-finisher-3-20-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-ce097a', 'Glute Finisher ×3: 20 ягодичных мостов, 15+15 отведений, 20 отведений наружу, отдых 30–45 сек'),
  ('kardio-dorozhka-1-min-naklon-7-8-1-min-naklon-10-12-7-8', 'Кардио: дорожка — 1 мин наклон 7–8% / 1 мин наклон 10–12% ×7–8'),
  ('final-full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-27a804', 'Final Full Body Circuit ×4: 12 Goblet Squat, 12 тяг верхнего блока, 12 жимов гантелей, 12 румынских тяг, 15 ягодичных мостов, 10 выпадов, 20 Mountain Climbers, отдых 45–60 сек'),
  ('final-finisher-3-15-prisedaniy-10-vypadov-15-yagodichnyh-mostov-15-59fbb8', 'Final Finisher ×3: 15 приседаний, 10 выпадов, 15 ягодичных мостов, 15 тяг гантелей, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 45 сек'),
  ('kardio-velotrenazher-ellips-lyzhi-30-sek-vysokiy-temp-60-sek-c26f0f', 'Кардио (велотренажёр/эллипс/лыжи) — 30 сек высокий темп / 60 сек восстановление ×8'),
  ('finalnyy-press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-282fdf', 'Финальный пресс — 3 круга: 15 V-Ups, 15 Reverse Crunch, 20 Russian Twist, 45 сек планка')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Похудение — Женщины — Зал)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('pohudenie-zhenshchiny-zal', 'Похудение для женщин (зал) — годовая программа', 'Похудение для женщин (зал) — годовая программа. Оборудование: Беговая дорожка, эллипс/лыжи, тренажёры, гантели, тросы, коврик', 'lose_weight', 'female', 'gym', 'intermediate', 24, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · НОГИ + ЯГОДИЦЫ + ПРЕСС', 1, 'Месяц 1 — LEVEL 1: START + ADAPTATION', 1, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-5-min-spokoynaya-hodba-5-min-podem-v-goru-naklon-5-289a05', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-na-skamyu-sest-kontroliruemo-vstat', 10, 15, null::int, 90, 4, '15'),
    ('zhim-nogami', 20, 12, null::int, 90, 4, '12–15'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('podem-na-skameyku-step-ap', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-fiksatsiya-1-2-sek-vverhu', 50, 15, null::int, 90, 4, '15'),
    ('otvedenie-nog-naruzhu-trenazher', 60, 15, null::int, 90, 3, '15–20'),
    ('privedenie-nog-trenazher', 70, 15, null::int, 90, 3, '15–20'),
    ('kardio-finisher-dorozhka-1-min-naklon-5-6-umerenno-1-min-naklon-8-10-528fa4', 80, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-15-skruchivaniy-20-kasaniy-pyatok-30-5a1f5b', 90, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 1 — LEVEL 1: START + ADAPTATION', 1, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-5-min-hodba-5-min-naklon-5-8', 0, null::int, 600, 60, 1, '10 мин'),
    ('tyaga-verhnego-bloka-k-grudi', 10, 12, null::int, 90, 4, '12–15'),
    ('tyaga-gorizontalnogo-bloka-svesti-lopatki-v-kontse', 20, 12, null::int, 90, 4, '12–15'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 30, 12, null::int, 90, 3, '12'),
    ('obratnaya-babochka-zadnyaya-delta-verh-spiny', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-nad-golovoy', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 70, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 80, 12, null::int, 90, 3, '12–15'),
    ('superset-3-mahi-v-storony-15-razgibanie-ruk-15-sgibanie-ruk-12-otdyh-9e40dc', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-lyzhi-30-sek-bystree-60-sek-spokoyno-7', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-15-skruchivaniy-20-russian-twist-30-600db4', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · FULL BODY + КАРДИО', 3, 'Месяц 1 — LEVEL 1: START + ADAPTATION', 1, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-5-min-hodba-5-min-postepenno-uvelichivaem-temp', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-na-skamyu', 10, 15, null::int, 90, 3, '15'),
    ('zhim-nogami', 20, 15, null::int, 90, 3, '15'),
    ('tyaga-verhnego-bloka', 30, 12, null::int, 90, 3, '12–15'),
    ('tyaga-gorizontalnogo-bloka', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-lezha', 50, 12, null::int, 90, 3, '12–15'),
    ('yagodichnyy-most', 60, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('mahi-gantelyami-v-storony', 80, 15, null::int, 90, 3, '15'),
    ('full-body-circuit-3-15-prisedaniy-na-skamyu-12-tyag-verhnego-bloka-12-45e450', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-30-sek-bystro-60-sek-spokoyno', 100, null::int, 600, 60, 1, '10 мин'),
    ('dorozhka-naklon-6-10-temp-menyaem-kazhdye-2-min', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-15-skruchivaniy-20-kasaniy-pyatok-30-5a1f5b', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · НОГИ + ЯГОДИЦЫ', 1, 'Месяц 2 — LEVEL 2: PROGRESSIVE FAT LOSS', 2, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-3-min-hodba-5-min-naklon-5-8-menyaem-temp-kazhduyu-426469', 0, null::int, 480, 60, 1, '8 мин'),
    ('prisedanie-s-gantelyu', 10, 12, null::int, 90, 4, '12–15'),
    ('zhim-nogami-posl-podhod-12-obychnyh-5-chastichnyh-vnizu', 20, 12, null::int, 90, 4, '12'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 40, 10, null::int, 90, 4, '10–12'),
    ('yagodichnyy-most-s-vesom-fiksatsiya-2-sek', 50, 12, null::int, 90, 4, '12–15'),
    ('otvedenie-nog-naruzhu-trenazher', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-tros', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-nazad-d73775', 80, null::int, null::int, 90, 3, 'круг'),
    ('kardio-finisher-dorozhka-1-min-naklon-6-umerenno-1-min-naklon-10-87d349', 90, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-30-c30abc', 100, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 2 — LEVEL 2: PROGRESSIVE FAT LOSS', 2, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-naklon-5-8-temp-postepenno-vyshe', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-k-grudi', 10, 10, null::int, 90, 4, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 30, 12, null::int, 90, 3, '12'),
    ('tyaga-odnoy-rukoy-trenazher-blok', 40, 12, null::int, 90, 3, '12 на руку'),
    ('obratnaya-babochka', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 10, null::int, 90, 4, '10–12'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 4, '15'),
    ('razgibanie-ruk-na-trose', 80, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 90, 12, null::int, 90, 3, '12–15'),
    ('superset-3-mahi-v-storony-15-razgibanie-ruk-15-sgibanie-ruk-12-otdyh-9e40dc', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-ellips-30-sek-bystro-60-sek-spokoyno', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-40-b86686', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ + КАРДИО', 3, 'Месяц 2 — LEVEL 2: PROGRESSIVE FAT LOSS', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-naklon-6-10-postoyanno-menyaem-temp', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 10, null::int, 90, 4, '10–12'),
    ('vypady-s-hodboy', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami', 30, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-nog-v-trenazhere', 40, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('yagodichnyy-most', 60, 15, null::int, 90, 4, '15'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('superset-3-sgibanie-nog-12-15-yagodichnyy-most-15-otvedenie-nog-20', 80, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-10', 90, null::int, 600, 60, 1, '10 мин'),
    ('dorozhka-naklon-8-10-umerennyy-temp', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-40-5869ce', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + CONDITIONING', 4, 'Месяц 2 — LEVEL 2: PROGRESSIVE FAT LOSS', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-postepennoe-uvelichenie-tempa', 0, null::int, 480, 60, 1, '8 мин'),
    ('prisedanie-s-gantelyu', 10, 15, null::int, 90, 3, '15'),
    ('zhim-nogami', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-verhnego-bloka', 30, 12, null::int, 90, 3, '12'),
    ('tyaga-gorizontalnogo-bloka', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-lezha', 50, 12, null::int, 90, 3, '12'),
    ('rumynskaya-tyaga-s-gantelyami', 60, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most', 70, 15, null::int, 90, 3, '15'),
    ('mahi-gantelyami-v-storony', 80, 15, null::int, 90, 3, '15'),
    ('full-body-circuit-3-4-15-prisedaniy-12-tyag-verhnego-bloka-12-zhimov-f7eff1', 90, null::int, null::int, 90, 4, 'круг'),
    ('kardio-finisher-30-sek-vysokiy-temp-60-sek-spokoyno-7', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-40-sek-e783a2', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 3 — LEVEL 3: SHAPE + FAT LOSS', 3, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-3-min-hodba-5-min-naklon-6-10-postepenno-bystree', 0, null::int, 480, 60, 1, '8 мин'),
    ('yagodichnyy-most-hip-thrust-fiksatsiya-2-sek-vverhu', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 10, null::int, 90, 4, '10–12'),
    ('zhim-nogami-postanovka-chut-vyshe-tsentra-platformy-aktsent-yagoditsy', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 12, null::int, 90, 4, '12–15'),
    ('otvedenie-nog-naruzhu-posl-podhod-15-obychnyh-10-chastichnyh', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-tros', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 80, null::int, null::int, 90, 3, 'круг'),
    ('kardio-finisher-dorozhka-1-min-naklon-7-umerenno-1-min-naklon-10-12-bd6a94', 90, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-40-5869ce', 100, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 3 — LEVEL 3: SHAPE + FAT LOSS', 3, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-na-dorozhke', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-k-grudi', 10, 10, null::int, 90, 4, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 40, 12, null::int, 90, 3, '12'),
    ('face-pull', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 10, null::int, 90, 4, '10–12'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 12, null::int, 90, 3, '12–15'),
    ('superset-plechi-ruki-3-mahi-v-storony-15-face-pull-15-razgibanie-ruk-13a5e9', 110, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 120, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-40-b86686', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 3 — LEVEL 3: SHAPE + FAT LOSS', 3, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-na-dorozhke', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('prisedanie-v-smite', 10, 10, null::int, 90, 4, '10–12'),
    ('zhim-nogami', 20, 12, null::int, 90, 4, '12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('yagodichnyy-most', 60, 12, null::int, 90, 4, '12–15'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-prisedanie-s-gantelyu-12-otvedenie-c37558', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-12', 100, null::int, 720, 60, 1, '12 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + METABOLIC', 4, 'Месяц 3 — LEVEL 3: SHAPE + FAT LOSS', 3, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 480, 60, 1, '8 мин'),
    ('prisedanie-s-gantelyu', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-verhnego-bloka', 30, 12, null::int, 90, 3, '12'),
    ('tyaga-gorizontalnogo-bloka', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-lezha', 50, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most', 60, 15, null::int, 90, 3, '15'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-e1a530', 90, null::int, null::int, 90, 4, 'круг'),
    ('metabolic-finisher-3-15-prisedaniy-10-vypadov-na-nogu-12-tyag-e9bf07', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-30-sek-bystro-60-sek-spokoyno-7', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 4 — LEVEL 4: BODY SCULPT', 4, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('hip-thrust-fiksatsiya-2-sek-vverhu', 10, 8, null::int, 90, 5, '8–12'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami-posl-podhod-10-12-obychnyh-5-chastichnyh', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–15'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-v-krossovere', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-15-yagodichnyh-mostov-15-otvedeniy-pravoy-15-dee08e', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-umerenno-1-min-naklon-10-12-bystro-6', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 4 — LEVEL 4: BODY SCULPT', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-na-dorozhke', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-k-grudi', 10, 8, null::int, 90, 4, '8–12'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 40, 12, null::int, 90, 3, '12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 10, null::int, 90, 4, '10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 12, null::int, 90, 3, '12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-ruk-15-sgibanie-ruk-12', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 130, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 4 — LEVEL 4: BODY SCULPT', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–12'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('razgibanie-nog-posl-podhod-12-obychnyh-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('yagodichnyy-most', 60, 12, null::int, 90, 4, '12–15'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-prisedanie-s-gantelyu-12-otvedenie-dd5ccd', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-204f19', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + METABOLIC CONDITIONING', 4, 'Месяц 4 — LEVEL 4: BODY SCULPT', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 3, '10–12'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-lezha', 50, 10, null::int, 90, 3, '10–12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-49b3f4', 90, null::int, null::int, 90, 4, 'круг'),
    ('metabolic-finisher-3-15-prisedaniy-10-vypadov-na-nogu-12-tyag-7ebe7f', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-30-sek-vysokiy-temp-60-sek-spokoyno-8', 110, 10, null::int, 60, 1, '10–12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION', 5, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('hip-thrust-fiksatsiya-2-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-154ba2', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–12'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-obratnym-hvatom', 40, 12, null::int, 90, 3, '12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 130, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-obychnyh-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-na-kazhduyu-15-yagodichnyh-c6db54', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + FAT BURN', 4, 'Месяц 5 — LEVEL 5: FAT LOSS + MUSCLE DEFINITION', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-40d2c0', 90, null::int, null::int, 90, 4, 'круг'),
    ('fat-burn-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-32cd0d', 100, null::int, null::int, 90, 4, 'круг'),
    ('kardio-30-sek-vysokiy-temp-60-sek-vosstanovlenie-8', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 6 — LEVEL 6: INTENSIVE FAT LOSS', 6, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('hip-thrust-posl-1-2-povt-tyazhelye-fiksatsiya-2-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 8, null::int, 90, 3, '8–10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-v-krossovere', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-ca312a', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-154ba2', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 6 — LEVEL 6: INTENSIVE FAT LOSS', 6, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-k-grudi', 10, 8, null::int, 90, 4, '8–12'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 130, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 6 — LEVEL 6: INTENSIVE FAT LOSS', 6, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('razgibanie-nog-posl-podhod-12-obychnyh-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-c09f5d', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-70e5a1', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + HIIT', 4, 'Месяц 6 — LEVEL 6: INTENSIVE FAT LOSS', 6, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-40d2c0', 90, null::int, null::int, 90, 4, 'круг'),
    ('hiit-finisher-lyzhi-ellips-velotrenazher-20-sek-vysokiy-temp-40-sek-4cb300', 100, null::int, 600, 60, 1, '10 мин'),
    ('dorozhka-naklon-6-10-umerennyy-temp', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 7 — LEVEL 7: ADVANCED SHAPE', 7, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-fiksatsiya-2-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami-posl-podhod-10-12-5-chastichnyh', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-v-krossovere', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-burnout-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-68303c', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 7 — LEVEL 7: ADVANCED SHAPE', 7, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10-11', 130, null::int, 960, 60, 1, '16 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'Месяц 7 — LEVEL 7: ADVANCED SHAPE', 7, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-burnout-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-8b703f', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + CONDITIONING', 4, 'Месяц 7 — LEVEL 7: ADVANCED SHAPE', 7, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-40d2c0', 90, null::int, null::int, 90, 4, 'круг'),
    ('conditioning-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-e5bd77', 100, null::int, null::int, 90, 4, 'круг'),
    ('kardio-20-sek-vysokiy-temp-40-sek-vosstanovlenie-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 8 — LEVEL 8: DEFINITION & CONDITIONING', 8, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-fiksatsiya-2-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('superset-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-otvedenie-c4475e', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-burnout-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-68303c', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 8 — LEVEL 8: DEFINITION & CONDITIONING', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10-11', 130, null::int, 960, 60, 1, '16 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'Месяц 8 — LEVEL 8: DEFINITION & CONDITIONING', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-c09f5d', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-burnout-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-8b703f', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + CONDITIONING', 4, 'Месяц 8 — LEVEL 8: DEFINITION & CONDITIONING', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-0b20c3', 90, null::int, null::int, 90, 4, 'круг'),
    ('conditioning-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-e5bd77', 100, null::int, null::int, 90, 4, 'круг'),
    ('hiit-velotrenazher-ellips-lyzhi-20-sek-vysokiy-temp-40-sek-1297bc', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 9 — LEVEL 9: ADVANCED FAT LOSS', 9, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-fiksatsiya-2-sek-bez-poteri-tehniki', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-ca312a', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-154ba2', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-289062', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 9 — LEVEL 9: ADVANCED FAT LOSS', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('superset-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-otdyh-166536', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10-12', 130, 16, null::int, 60, 1, '16–18 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 9 — LEVEL 9: ADVANCED FAT LOSS', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-70e5a1', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + METABOLIC CONDITIONING', 4, 'Месяц 9 — LEVEL 9: ADVANCED FAT LOSS', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-0b20c3', 90, null::int, null::int, 90, 4, 'круг'),
    ('metabolic-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-bc7a49', 100, null::int, null::int, 90, 4, 'круг'),
    ('hiit-velotrenazher-ellips-lyzhi-20-sek-vysokiy-temp-40-sek-1297bc', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 10 — LEVEL 10: PEAK DEFINITION', 10, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-7-10', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-posl-podhod-8-10-5-chastichnyh-10-sek-fiksatsiya', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-3-sek-vniz-1-sek-vverh', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami-posl-podhod-ne-dovodit-do-otkaza', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-superset-3-otvedenie-nog-20-yagodichnyy-most-15-otvedenie-nogi-af8ea7', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-15-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-ce77cb', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-8-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-289062', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 10 — LEVEL 10: PEAK DEFINITION', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('giant-set-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-mahi-72645d', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-12', 130, null::int, 1080, 60, 1, '18 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · КВАДРИЦЕПС + ЯГОДИЦЫ', 3, 'Месяц 10 — LEVEL 10: PEAK DEFINITION', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-10-sek-fiksatsiya', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-70e5a1', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-16', 110, null::int, 960, 60, 1, '16 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + METABOLIC CONDITIONING', 4, 'Месяц 10 — LEVEL 10: PEAK DEFINITION', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-40d2c0', 90, null::int, null::int, 90, 4, 'круг'),
    ('metabolic-finisher-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-bc7a49', 100, null::int, null::int, 90, 4, 'круг'),
    ('hiit-predpochtitelno-nizkoudarnoe-velotrenazher-ellips-lyzhi-20-sek-be3efb', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 11 — LEVEL 11: FINAL CUT', 11, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-7-10', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-fiksatsiya-2-sek-posl-podhod-8-10-5-chastichnyh', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-3-sek-vniz-1-sek-vverh', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad-v-krossovere', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-giant-set-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-8696b1', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-burnout-3-20-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-743a1e', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-8-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-289062', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 11 — LEVEL 11: FINAL CUT', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('giant-set-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-mahi-72645d', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-12', 130, null::int, 1080, 60, 1, '18 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'Месяц 11 — LEVEL 11: FINAL CUT', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10–12 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-burnout-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-8b703f', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-16', 110, null::int, 960, 60, 1, '16 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + FINAL CONDITIONING', 4, 'Месяц 11 — LEVEL 11: FINAL CUT', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-zhimov-0b20c3', 90, null::int, null::int, 90, 4, 'круг'),
    ('final-conditioning-4-15-prisedaniy-10-vypadov-12-tyag-ganteley-15-4786b8', 100, null::int, null::int, 90, 4, 'круг'),
    ('hiit-velotrenazher-ellips-lyzhi-20-sek-vysokiy-temp-40-sek-1297bc', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-sek-265478', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 1, 'Месяц 12 — LEVEL 12: FINAL TRANSFORMATION', 12, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-min-hodba-5-min-naklon-6-10-2', 0, null::int, 600, 60, 1, '10 мин'),
    ('hip-thrust-fiksatsiya-2-sek-posl-podhod-8-10-5-chastichnyh', 10, 8, null::int, 90, 5, '8–10'),
    ('rumynskaya-tyaga-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 30, 10, null::int, 90, 4, '10–12'),
    ('bolgarskiy-split-prised', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog', 50, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 60, 15, null::int, 90, 4, '15–20'),
    ('otvedenie-nogi-nazad', 70, 15, null::int, 90, 3, '15 на ногу'),
    ('glute-giant-set-3-yagodichnyy-most-15-otvedenie-nog-naruzhu-20-8696b1', 80, null::int, null::int, 90, 3, 'круг'),
    ('glute-finisher-3-20-yagodichnyh-mostov-15-15-otvedeniy-20-otvedeniy-ce097a', 90, null::int, null::int, 90, 3, 'круг'),
    ('kardio-dorozhka-1-min-naklon-7-8-1-min-naklon-10-12-7-8', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-289062', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + ПЛЕЧИ + РУКИ', 2, 'Месяц 12 — LEVEL 12: FINAL TRANSFORMATION', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-gorizontalnogo-bloka', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-obratnym-hvatom', 40, 10, null::int, 90, 3, '10–12'),
    ('face-pull', 50, 15, null::int, 90, 4, '15'),
    ('zhim-ganteley-nad-golovoy', 60, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 70, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 80, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-trose', 90, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-ruk-s-gantelyami', 100, 10, null::int, 90, 3, '10–12'),
    ('giant-set-plechi-3-mahi-15-face-pull-15-razvedenie-v-naklone-15-mahi-72645d', 110, null::int, null::int, 90, 3, 'круг'),
    ('superset-ruki-3-razgibanie-15-sgibanie-12-otdyh-45-sek', 120, null::int, null::int, 90, 3, 'круг'),
    ('kardio-ellips-30-sek-bystro-60-sek-spokoyno-10', 130, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-15-reverse-crunch-20-bicycle-crunch-20-russian-twist-45-9772f2', 140, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'Месяц 12 — LEVEL 12: FINAL TRANSFORMATION', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 600, 60, 1, '10 мин'),
    ('prisedanie-v-smite', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('razgibanie-nog-posl-podhod-12-5-chastichnyh', 40, 12, null::int, 90, 4, '12–15'),
    ('sgibanie-nog', 50, 12, null::int, 90, 3, '12–15'),
    ('hip-thrust', 60, 10, null::int, 90, 4, '10–12'),
    ('otvedenie-nog-naruzhu', 70, 15, null::int, 90, 4, '15–20'),
    ('ikry', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-razgibanie-nog-15-goblet-squat-12-otvedenie-nog-20-6733d2', 90, null::int, null::int, 90, 3, 'круг'),
    ('leg-finisher-3-12-prisedaniy-10-vypadov-15-yagodichnyh-mostov-20-70e5a1', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-lyzhi-20-sek-bystro-40-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('dorozhka-naklon-8-12-umerennyy-temp-2', 120, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-15-reverse-crunch-20-skruchivaniy-20-kasaniy-pyatok-45-a202a3', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + FINAL CHALLENGE', 4, 'Месяц 12 — LEVEL 12: FINAL TRANSFORMATION', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, 8, null::int, 60, 1, '8–10 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha', 40, 10, null::int, 90, 3, '10–12'),
    ('tyaga-gorizontalnogo-bloka', 50, 12, null::int, 90, 3, '12'),
    ('hip-thrust', 60, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 70, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 80, 10, null::int, 90, 3, '10 на ногу'),
    ('final-full-body-circuit-4-12-goblet-squat-12-tyag-verhnego-bloka-12-27a804', 90, null::int, null::int, 90, 4, 'круг'),
    ('final-finisher-3-15-prisedaniy-10-vypadov-15-yagodichnyh-mostov-15-59fbb8', 100, null::int, null::int, 90, 3, 'круг'),
    ('kardio-velotrenazher-ellips-lyzhi-30-sek-vysokiy-temp-60-sek-c26f0f', 110, 10, null::int, 60, 1, '10–12 мин'),
    ('finalnyy-press-3-kruga-15-v-ups-15-reverse-crunch-20-russian-twist-45-282fdf', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
