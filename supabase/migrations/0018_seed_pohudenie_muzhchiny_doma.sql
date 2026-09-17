-- 0018_seed_pohudenie_muzhchiny_doma.sql
-- Программа: Похудение — Мужчины — Дома
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0018), по одной на каждую комбинацию
-- пол × цель × формат — см. 0017..0021 и журнал в PROJECT_PLAN.md.
--
-- 47 тренировок, 137 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Похудение — Мужчины — Дома)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('razminka-hodba-na-meste-legkie-pryzhki-vrascheniya-plechami-i-rukami-ac7085', 'Разминка: ходьба на месте, лёгкие прыжки, вращения плечами и руками, приседания без веса'),
  ('otzhimaniya', 'Отжимания'),
  ('otzhimaniya-s-nogami-na-vozvyshenii-ili-obychnye-esli-tyazhelo', 'Отжимания с ногами на возвышении (или обычные, если тяжело)'),
  ('zhim-ganteley-lezha-na-polu', 'Жим гантелей лёжа на полу'),
  ('razvedenie-ganteley-lezha', 'Разведение гантелей лёжа'),
  ('zhim-ganteley-nad-golovoy', 'Жим гантелей над головой'),
  ('mahi-gantelyami-v-storony', 'Махи гантелями в стороны'),
  ('razgibanie-ruk-s-rezinkoy', 'Разгибание рук с резинкой'),
  ('finisher-3-10-otzhimaniy-15-prisedaniy-20-mountain-climbers-30-sek-cc1c24', 'Финишер ×3: 10 отжиманий, 15 приседаний, 20 Mountain Climbers, 30 сек быстрых шагов, отдых 30–45 сек'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-planka-20-c6f0a6', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 30 сек планка, 20 касаний пяток, отдых 30 сек'),
  ('razminka', 'Разминка'),
  ('podtyagivaniya-ili-negativnye-4-3-5-opuskanie-3-5-sek', 'Подтягивания (или негативные 4×3–5, опускание 3–5 сек)'),
  ('tyaga-ganteley-v-naklone', 'Тяга гантелей в наклоне'),
  ('tyaga-odnoy-ganteli', 'Тяга одной гантели'),
  ('tyaga-rezinki-k-zhivotu', 'Тяга резинки к животу'),
  ('face-pull-s-rezinkoy', 'Face Pull с резинкой'),
  ('podem-ganteley-na-bitseps', 'Подъём гантелей на бицепс'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('kardio-finisher-10-min-30-sek-bystro-30-sek-spokoyno-10-bystraya-b83676', 'Кардио-финишер 10 мин (30 сек быстро/30 сек спокойно ×10): быстрая ходьба на месте, степ, jumping jacks, подъёмы коленей'),
  ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-30-sek-planka-20-2c82f8', 'Пресс ×3 круга: 20 скручиваний, 15 Reverse Crunch, 30 сек планка, 20 Russian Twist, отдых 30–45 сек'),
  ('prisedaniya-s-gantelyu', 'Приседания с гантелью'),
  ('vypady-nazad', 'Выпады назад'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('podem-na-ustoychivuyu-platformu', 'Подъём на устойчивую платформу'),
  ('yagodichnyy-most', 'Ягодичный мост'),
  ('ikry-s-gantelyami', 'Икры с гантелями'),
  ('full-body-circuit-4-10-prisedaniy-10-otzhimaniy-10-vypadov-na-nogu-15-0cd800', 'Full Body Circuit ×4: 10 приседаний, 10 отжиманий, 10 выпадов на ногу, 15 тяг гантелей в наклоне, 20 Mountain Climbers, отдых 45 сек'),
  ('kardio-10-min-1-min-bystro-1-min-spokoyno-5', 'Кардио 10 мин (1 мин быстро/1 мин спокойно ×5)'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-86ee19', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 30 сек Hollow Hold, 30–45 сек планка'),
  ('razminka-5-7-min-bystraya-hodba-jumping-jacks-vrascheniya-plech-b1b5e5', 'Разминка 5–7 мин: быстрая ходьба, jumping jacks, вращения плеч, приседания, лёгкие отжимания'),
  ('otzhimaniya-s-nogami-na-vozvyshenii', 'Отжимания с ногами на возвышении'),
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('superset-3-mahi-v-storony-15-otzhimaniya-do-otkaza-otdyh-45-sek', 'Суперсет ×3: Махи в стороны 15 + Отжимания до отказа, отдых 45 сек'),
  ('kardio-finisher-10-min-40-sek-bystro-20-sek-spokoyno-10-bystrye-shagi-5a2638', 'Кардио-финишер 10 мин (40 сек быстро/20 сек спокойно ×10): быстрые шаги, степ, подъёмы коленей, jumping jacks'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-fee370', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 20 касаний пяток, 40 сек планка, отдых 30 сек'),
  ('podtyagivaniya-ili-negativnye-4-4-5-opuskanie-4-5-sek', 'Подтягивания (или негативные 4×4–5, опускание 4–5 сек)'),
  ('tyaga-dvuh-ganteley-v-naklone', 'Тяга двух гантелей в наклоне'),
  ('face-pull', 'Face Pull'),
  ('pulover-s-gantelyu', 'Пуловер с гантелью'),
  ('superset-3-bitseps-s-gantelyami-12-molotkovye-sgibaniya-12', 'Суперсет ×3: Бицепс с гантелями 12 + Молотковые сгибания 12'),
  ('kardio-12-min-1-min-bystro-1-min-spokoyno-6', 'Кардио 12 мин (1 мин быстро/1 мин спокойно ×6)'),
  ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-40-2d6f16', 'Пресс ×3 круга: 20 скручиваний, 15 Reverse Crunch, 20 Russian Twist, 40 сек планка'),
  ('razminka-5-7-min', 'Разминка 5–7 мин'),
  ('goblet-squat', 'Goblet Squat'),
  ('bolgarskiy-split-prised', 'Болгарский сплит-присед'),
  ('sumo-prised', 'Сумо-присед'),
  ('leg-circuit-3-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-6e2f31', 'Leg Circuit ×3: 15 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 подъёмов на носки, отдых 45 сек'),
  ('kardio-10-min-30-sek-bystro-30-sek-spokoyno-10', 'Кардио 10 мин (30 сек быстро/30 сек спокойно ×10)'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-4e8f4d', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 30 сек Hollow Hold, 40 сек планка'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-10-tyag-ganteley-10-3398e1', 'Full Body Circuit ×5: 10 Goblet Squat, 10 отжиманий, 10 тяг гантелей, 10 выпадов на ногу, 20 Mountain Climbers, отдых 30–45 сек'),
  ('kardio-finisher-10-min-40-sek-intensivno-20-sek-vosstanovlenie-10', 'Кардио-финишер 10 мин (40 сек интенсивно/20 сек восстановление ×10)'),
  ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-40-sek-23fe5f', 'Пресс ×3 круга: 20 V-Ups, 20 Reverse Crunch, 20 Russian Twist, 40 сек планка'),
  ('razminka-7-min-bystraya-hodba-vrascheniya-plech-legkie-prisedaniya-981963', 'Разминка 7 мин: быстрая ходьба, вращения плеч, лёгкие приседания, jumping jacks, лёгкие отжимания'),
  ('otzhimaniya-s-dop-vesom-ili-obychnye', 'Отжимания с доп. весом (или обычные)'),
  ('push-superset-3-mahi-v-storony-15-otzhimaniya-do-tehnicheskogo-otkaza-4ca529', 'Push Superset ×3: Махи в стороны 15 + Отжимания до технического отказа, отдых 45 сек'),
  ('cardio-finisher-12-min-40-sek-bystro-20-sek-vosstanovlenie-12', 'Cardio Finisher 12 мин (40 сек быстро/20 сек восстановление ×12)'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 20 касаний пяток, 45 сек планка'),
  ('podtyagivaniya-ili-negativnye-5-3-5-opuskanie-4-5-sek', 'Подтягивания (или негативные 5×3–5, опускание 4–5 сек)'),
  ('pulover', 'Пуловер'),
  ('biceps-superset-3-bitseps-s-gantelyami-12-molotkovye-sgibaniya-12-a953bf', 'Biceps Superset ×3: Бицепс с гантелями 12 + Молотковые сгибания 12 + Статика 90° 20 сек'),
  ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 'Пресс ×3 круга: 20 скручиваний, 15 Reverse Crunch, 20 Russian Twist, 45 сек планка'),
  ('razminka-7-min', 'Разминка 7 мин'),
  ('yagodichnyy-most-s-vesom', 'Ягодичный мост с весом'),
  ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-08401d', 'Leg Superset ×3: Goblet Squat 12 + Выпады назад 10 на ногу + Ягодичный мост 15'),
  ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 'Кардио 12 мин (30 сек быстро/30 сек спокойно ×12)'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 30 сек Hollow Hold, 45 сек планка'),
  ('mahi-gantelyami', 'Махи гантелями'),
  ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-10-tyag-ganteley-10-4a6f4a', 'Full Body Circuit ×5: 10 Goblet Squat, 10 отжиманий, 10 тяг гантелей, 10 выпадов на ногу, 20 Mountain Climbers, 20 быстрых шагов, отдых 30–45 сек'),
  ('final-cardio-15-min-1-min-umerenno-30-sek-vysokiy-temp-10', 'Final Cardio 15 мин (1 мин умеренно/30 сек высокий темп ×10)'),
  ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 'Пресс ×3 круга: 20 V-Ups, 20 Reverse Crunch, 20 Russian Twist, 45 сек планка'),
  ('razminka-7-min-hodba-vrascheniya-ruk-plech-prisedaniya-jumping-jacks-fac985', 'Разминка 7 мин: ходьба, вращения рук/плеч, приседания, jumping jacks, 10 лёгких отжиманий'),
  ('otzhimaniya-s-dop-vesom', 'Отжимания с доп. весом'),
  ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 'Жим гантелей лёжа на полу (опускание 3 сек)'),
  ('superset-1-3-zhim-ganteley-10-12-otzhimaniya-10-15-otdyh-45-sek', 'Суперсет 1 ×3: Жим гантелей 10–12 + Отжимания 10–15, отдых 45 сек'),
  ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 'Суперсет 2 ×3: Махи в стороны 15–20 + Разгибание рук с резинкой 15–20'),
  ('cardio-finisher-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 'Cardio Finisher 12 мин (30 сек высокий темп/30 сек спокойно ×12)'),
  ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-5db481', 'Пресс ×3 круга: 20 Reverse Crunch, 20 Bicycle Crunch, 20 касаний пяток, 45 сек планка, отдых 30 сек'),
  ('podtyagivaniya-ili-negativnye-5-4-opuskanie-4-5-sek', 'Подтягивания (или негативные 5×4, опускание 4–5 сек)'),
  ('superset-1-3-tyaga-ganteley-12-podem-na-bitseps-12', 'Суперсет 1 ×3: Тяга гантелей 12 + Подъём на бицепс 12'),
  ('superset-2-3-molotkovye-sgibaniya-12-statika-bitsepsa-90-20-sek', 'Суперсет 2 ×3: Молотковые сгибания 12 + Статика бицепса 90° 20 сек'),
  ('kardio-15-min-1-min-bystro-1-min-umerenno-7-1-min-spokoyno', 'Кардио 15 мин (1 мин быстро/1 мин умеренно ×7 + 1 мин спокойно)'),
  ('ikry-s-vesom', 'Икры с весом'),
  ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 'Leg Superset ×3: Goblet Squat 12 + Выпады назад 10 на ногу + Ягодичный мост 15, отдых 60 сек'),
  ('leg-finisher-3-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-b1c817', 'Leg Finisher ×3: 15 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 подъёмов на носки, 20 Mountain Climbers, отдых 45 сек'),
  ('kardio-10-min-40-sek-bystro-20-sek-spokoyno-10', 'Кардио 10 мин (40 сек быстро/20 сек спокойно ×10)'),
  ('metabolic-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-ddae71', 'Metabolic Circuit ×5: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 15 жимов над головой, 20 Mountain Climbers, отдых 45 сек'),
  ('cardio-finisher-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 'Cardio Finisher 15 мин (30 сек высокий темп/30 сек умеренно ×15)'),
  ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 'Суперсет 1 ×3: Жим гантелей 10 + Отжимания 10–15, отдых 45 сек'),
  ('cardio-finisher-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 'Cardio Finisher 15 мин (40 сек высокий темп/20 сек восстановление ×15)'),
  ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 'Подтягивания (или негативные 5×4–5, опускание 5 сек)'),
  ('superset-1-3-tyaga-ganteley-12-podem-na-bitseps-10-12', 'Суперсет 1 ×3: Тяга гантелей 12 + Подъём на бицепс 10–12'),
  ('kardio-15-min-1-min-vysokiy-temp-1-min-umerenno-7-1-min-spokoyno', 'Кардио 15 мин (1 мин высокий темп/1 мин умеренно ×7 + 1 мин спокойно)'),
  ('kardio-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 'Кардио 12 мин (30 сек высокий темп/30 сек спокойно ×12)'),
  ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d05fd5', 'Full Body Circuit ×5: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 12 жимов над головой, 20 Mountain Climbers, отдых 45 сек'),
  ('final-cardio-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 'Final Cardio 15 мин (30 сек высокий темп/30 сек умеренно ×15)'),
  ('superset-3-mahi-v-storony-15-20-otzhimaniya-do-tehnicheskogo-otkaza-929181', 'Суперсет ×3: Махи в стороны 15–20 + Отжимания до технического отказа, отдых 45 сек'),
  ('hiit-12-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-12-bystrye-7a3161', 'HIIT 12 мин (40 сек высокий темп/20 сек восстановление ×12): быстрые шаги, подъёмы коленей, степ, jumping jacks'),
  ('podtyagivaniya-ili-negativnye-5-4-opuskanie-5-sek', 'Подтягивания (или негативные 5×4, опускание 5 сек)'),
  ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 'Суперсет ×3: Подъём на бицепс 10–12 + Молотковые сгибания 10–12 + Статика на 90° 20 сек'),
  ('hiit-15-min-1-min-umerenno-vysokiy-temp-30-sek-vysokiy-temp-10-5cfbec', 'HIIT 15 мин (1 мин умеренно-высокий темп/30 сек высокий темп ×10): быстрые шаги, подъёмы коленей, степ, jumping jacks'),
  ('leg-hiit-4-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-20-207c6f', 'Leg HIIT ×4: 15 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 Mountain Climbers, отдых 45 сек'),
  ('full-body-hiit-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-1f64b7', 'Full Body HIIT Circuit ×5: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 10 жимов над головой, 20 Mountain Climbers, отдых 45 сек'),
  ('final-hiit-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 'Final HIIT 10 мин (30 сек высокий темп/30 сек спокойно ×10)'),
  ('superset-1-3-tyaga-ganteley-10-12-podem-na-bitseps-10-12', 'Суперсет 1 ×3: Тяга гантелей 10–12 + Подъём на бицепс 10–12'),
  ('kardio-15-min-45-sek-bystro-15-sek-spokoyno-15', 'Кардио 15 мин (45 сек быстро/15 сек спокойно ×15)'),
  ('leg-finisher-4-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-364878', 'Leg Finisher ×4: 15 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 Mountain Climbers, 20 подъёмов на носки, отдых 45 сек'),
  ('advanced-full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-dc4f10', 'Advanced Full Body Circuit ×5: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 10 жимов над головой, 20 Mountain Climbers, отдых 30–45 сек'),
  ('chest-finisher-4-10-otzhimaniy-15-mahov-v-storony-10-razgibaniy-ruk-s-af079f', 'Chest Finisher ×4: 10 отжиманий, 15 махов в стороны, 10 разгибаний рук с резинкой, 20 Mountain Climbers, отдых 30–45 сек'),
  ('kardio-12-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-12', 'Кардио 12 мин (40 сек высокий темп/20 сек восстановление ×12)'),
  ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-82403d', 'Back Finisher ×4: 10 тяг гантелей, 10 сгибаний на бицепс, 15 Face Pull, 20 быстрых шагов, отдых 45 сек'),
  ('kardio-15-min-45-sek-bystro-15-sek-vosstanovlenie-15', 'Кардио 15 мин (45 сек быстро/15 сек восстановление ×15)'),
  ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 'Кардио 10 мин (30 сек высокий темп/30 сек спокойно ×10)'),
  ('otzhimaniya-s-vesom', 'Отжимания с весом'),
  ('full-body-circuit-6-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d758ce', 'Full Body Circuit ×6: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 10 жимов над головой, 20 Mountain Climbers, отдых 30–45 сек'),
  ('chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-storony-c3d07a', 'Chest Finisher ×3: 10 отжиманий, 10 узких отжиманий, 15 махов в стороны, 20 Mountain Climbers, отдых 45 сек'),
  ('kardio-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 'Кардио 15 мин (40 сек высокий темп/20 сек восстановление ×15)'),
  ('superset-3-tyaga-ganteley-10-12-podem-na-bitseps-10-12-molotkovye-42eeff', 'Суперсет ×3: Тяга гантелей 10–12 + Подъём на бицепс 10–12 + Молотковые сгибания 10'),
  ('finisher-3-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-20-b8566c', 'Финишер ×3: 10 тяг гантелей, 10 сгибаний на бицепс, 15 Face Pull, 20 быстрых шагов, отдых 45 сек'),
  ('leg-finisher-4-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-d2773c', 'Leg Finisher ×4: 12 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 Mountain Climbers, 20 подъёмов на носки, отдых 45 сек'),
  ('metabolic-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-20-88f66e', 'Metabolic Finisher ×4: 10 приседаний, 10 отжиманий, 10 тяг гантелей, 20 быстрых шагов, 20 Mountain Climbers, отдых 30 сек'),
  ('kardio-10-min-20-sek-vysokiy-temp-40-sek-spokoyno-10', 'Кардио 10 мин (20 сек высокий темп/40 сек спокойно ×10)'),
  ('chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-storony-3cc4a8', 'Chest Finisher ×3: 10 отжиманий, 10 узких отжиманий, 15 махов в стороны, 20 Mountain Climbers, отдых 30–45 сек'),
  ('interval-cardio-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 'Interval Cardio 12 мин (30 сек высокий темп/30 сек спокойно ×12)'),
  ('interval-cardio-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 'Interval Cardio 15 мин (40 сек высокий темп/20 сек восстановление ×15)'),
  ('interval-cardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 'Interval Cardio 10 мин (30 сек высокий темп/30 сек спокойно ×10)'),
  ('peak-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-a43190', 'Peak Finisher ×4: 10 приседаний, 10 отжиманий, 10 тяг гантелей, 10 жимов над головой, 20 Mountain Climbers, 20 быстрых шагов, отдых 30 сек'),
  ('interval-cardio-10-min-20-sek-vysokiy-temp-40-sek-spokoyno-10', 'Interval Cardio 10 мин (20 сек высокий темп/40 сек спокойно ×10)'),
  ('final-chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-3100c1', 'Final Chest Finisher ×3: 10 отжиманий, 10 узких отжиманий, 15 махов в стороны, 15 разгибаний рук, 20 Mountain Climbers, отдых 45 сек'),
  ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-749012', 'Back Finisher ×4: 10 тяг гантелей, 10 сгибаний на бицепс, 15 Face Pull, 20 Mountain Climbers, отдых 45 сек'),
  ('final-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-881fe7', 'Final Finisher ×4: 10 приседаний, 10 отжиманий, 10 тяг гантелей, 10 жимов над головой, 20 Mountain Climbers, 20 быстрых шагов, отдых 30–45 сек'),
  ('superset-3-zhim-ganteley-10-otzhimaniya-10-15-mahi-v-storony-15-20-fde56c', 'Суперсет ×3: Жим гантелей 10 + Отжимания 10–15 + Махи в стороны 15–20, отдых 45 сек'),
  ('final-full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-95290a', 'Final Full Body Circuit ×5: 10 Goblet Squat, 10 отжиманий, 12 тяг гантелей, 10 выпадов на ногу, 10 жимов над головой, 20 Mountain Climbers, отдых 30–45 сек'),
  ('final-finisher-3-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-c9a5dc', 'Final Finisher ×3: 10 приседаний, 10 отжиманий, 10 тяг гантелей, 10 жимов над головой, 20 Mountain Climbers, 20 быстрых шагов, отдых 45 сек'),
  ('kardio-10-min-30-sek-vysokiy-temp-30-sek-vosstanovlenie-10', 'Кардио 10 мин (30 сек высокий темп/30 сек восстановление ×10)'),
  ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-60-sek-9ce201', 'Пресс ×3 круга: 20 V-Ups, 20 Reverse Crunch, 20 Russian Twist, 60 сек планка'),
  ('finalnyy-test-posle-12-mesyatsev-vypolnit-posle-vosstanovleniya-maks-6d0fd8', '🏆 ФИНАЛЬНЫЙ ТЕСТ ПОСЛЕ 12 МЕСЯЦЕВ (выполнить после восстановления): макс. отжиманий за 1 подход, макс. подтягиваний за 1 подход, планка на максимальное время, Goblet Squat — максимум качественных повторений с контрольным весом, Full Body Circuit 5 кругов на время')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Похудение — Мужчины — Дома)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('pohudenie-muzhchiny-doma', 'Похудение для мужчин (дома) — годовая программа', 'Похудение для мужчин (дома) — годовая программа. Оборудование: Гантели, резинки, турник (по возможности), стул/скамья, коврик', 'lose_weight', 'male', 'home', 'intermediate', 24, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 1 — START (Месяц 1, недели 1–4)', 1, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-hodba-na-meste-legkie-pryzhki-vrascheniya-plechami-i-rukami-ac7085', 0, null::int, 300, 60, 1, '5 мин'),
    ('otzhimaniya', 10, 10, null::int, 90, 4, '10–15'),
    ('otzhimaniya-s-nogami-na-vozvyshenii-ili-obychnye-esli-tyazhelo', 20, 8, null::int, 90, 3, '8–12'),
    ('zhim-ganteley-lezha-na-polu', 30, 12, null::int, 90, 3, '12–15'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('finisher-3-10-otzhimaniy-15-prisedaniy-20-mountain-climbers-30-sek-cc1c24', 80, null::int, null::int, 60, 3, 'круг'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-planka-20-c6f0a6', 90, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС + КАРДИО', 2, 'LEVEL 1 — START (Месяц 1, недели 1–4)', 1, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('podtyagivaniya-ili-negativnye-4-3-5-opuskanie-3-5-sek', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-ganteley-v-naklone', 20, 10, null::int, 90, 4, '10–15'),
    ('tyaga-odnoy-ganteli', 30, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 3, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 10, null::int, 90, 3, '10–15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12–15'),
    ('kardio-finisher-10-min-30-sek-bystro-30-sek-spokoyno-10-bystraya-b83676', 80, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-30-sek-planka-20-2c82f8', 90, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · НОГИ + FULL BODY', 3, 'LEVEL 1 — START (Месяц 1, недели 1–4)', 1, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('prisedaniya-s-gantelyu', 10, 12, null::int, 90, 4, '12–15'),
    ('vypady-nazad', 20, 10, null::int, 90, 3, '10–12 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 10, null::int, 90, 4, '10–12'),
    ('podem-na-ustoychivuyu-platformu', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most', 50, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-gantelyami', 60, 15, null::int, 90, 4, '15–20'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('full-body-circuit-4-10-prisedaniy-10-otzhimaniy-10-vypadov-na-nogu-15-0cd800', 80, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-1-min-bystro-1-min-spokoyno-5', 90, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-86ee19', 100, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 2 — FAT BURN + STRENGTH (Месяц 2, недели 5–8)', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-7-min-bystraya-hodba-jumping-jacks-vrascheniya-plech-b1b5e5', 0, 5, null::int, 60, 1, '5–7 мин'),
    ('otzhimaniya', 10, 12, null::int, 90, 4, '12–20'),
    ('zhim-ganteley-lezha-na-polu', 20, 10, null::int, 90, 4, '10–15'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 8, null::int, 90, 3, '8–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 4, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 3, '15–20'),
    ('superset-3-mahi-v-storony-15-otzhimaniya-do-otkaza-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('kardio-finisher-10-min-40-sek-bystro-20-sek-spokoyno-10-bystrye-shagi-5a2638', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-fee370', 110, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 2 — FAT BURN + STRENGTH (Месяц 2, недели 5–8)', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('podtyagivaniya-ili-negativnye-4-4-5-opuskanie-4-5-sek', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 10, null::int, 90, 4, '10–15'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 10, null::int, 90, 3, '10–15'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12–15'),
    ('superset-3-bitseps-s-gantelyami-12-molotkovye-sgibaniya-12', 90, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-1-min-bystro-1-min-spokoyno-6', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-40-2d6f16', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 2 — FAT BURN + STRENGTH (Месяц 2, недели 5–8)', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-7-min', 0, 5, null::int, 60, 1, '5–7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12–15'),
    ('bolgarskiy-split-prised', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 10, null::int, 90, 4, '10–15'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most', 60, 15, null::int, 90, 4, '15–20'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-gantelyami', 80, 15, null::int, 90, 4, '15–20'),
    ('leg-circuit-3-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-6e2f31', 90, null::int, null::int, 45, 3, 'круг'),
    ('kardio-10-min-30-sek-bystro-30-sek-spokoyno-10', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-4e8f4d', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + FAT BURN', 4, 'LEVEL 2 — FAT BURN + STRENGTH (Месяц 2, недели 5–8)', 2, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya', 20, 10, null::int, 90, 4, '10–15'),
    ('tyaga-ganteley-v-naklone', 30, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-nad-golovoy', 50, 12, null::int, 90, 3, '12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-10-tyag-ganteley-10-3398e1', 90, null::int, null::int, 45, 5, 'круг'),
    ('kardio-finisher-10-min-40-sek-intensivno-20-sek-vosstanovlenie-10', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-40-sek-23fe5f', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Месяц 3, недели 9–12)', 3, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-bystraya-hodba-vrascheniya-plech-legkie-prisedaniya-981963', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom-ili-obychnye', 10, 10, null::int, 90, 4, '10–15'),
    ('zhim-ganteley-lezha-na-polu', 20, 10, null::int, 90, 4, '10–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 8, null::int, 90, 3, '8–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 4, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 3, '15–20'),
    ('push-superset-3-mahi-v-storony-15-otzhimaniya-do-tehnicheskogo-otkaza-4ca529', 90, null::int, null::int, 45, 3, 'круг'),
    ('cardio-finisher-12-min-40-sek-bystro-20-sek-vosstanovlenie-12', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Месяц 3, недели 9–12)', 3, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-7-min', 0, 5, null::int, 60, 1, '5–7 мин'),
    ('podtyagivaniya-ili-negativnye-5-3-5-opuskanie-4-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('pulover', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 10, null::int, 90, 4, '10–12'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12–15'),
    ('biceps-superset-3-bitseps-s-gantelyami-12-molotkovye-sgibaniya-12-a953bf', 90, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-1-min-bystro-1-min-spokoyno-6', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Месяц 3, недели 9–12)', 3, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–15'),
    ('bolgarskiy-split-prised', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 15, null::int, 90, 4, '15'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-gantelyami', 80, 20, null::int, 90, 4, '20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-08401d', 90, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY FAT BURN', 4, 'LEVEL 3 — FAT LOSS + MUSCLE PRESERVATION (Месяц 3, недели 9–12)', 3, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-5-7-min', 0, 5, null::int, 60, 1, '5–7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya', 20, 10, null::int, 90, 4, '10–15'),
    ('tyaga-ganteley-v-naklone', 30, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-nad-golovoy', 50, 12, null::int, 90, 3, '12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami', 70, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-10-tyag-ganteley-10-4a6f4a', 90, null::int, null::int, 45, 5, 'круг'),
    ('final-cardio-15-min-1-min-umerenno-30-sek-vysokiy-temp-10', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 4 — METABOLIC STRENGTH (Месяц 4, недели 13–16)', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-hodba-vrascheniya-ruk-plech-prisedaniya-jumping-jacks-fac985', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 10, null::int, 90, 4, '10–15'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 3, '15–20'),
    ('superset-1-3-zhim-ganteley-10-12-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('cardio-finisher-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-5db481', 120, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 4 — METABOLIC STRENGTH (Месяц 4, недели 13–16)', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-opuskanie-4-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 10, null::int, 90, 4, '10–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 3, '10–15'),
    ('superset-1-3-tyaga-ganteley-12-podem-na-bitseps-12', 90, null::int, null::int, 60, 3, 'круг'),
    ('superset-2-3-molotkovye-sgibaniya-12-statika-bitsepsa-90-20-sek', 100, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-1-min-bystro-1-min-umerenno-7-1-min-spokoyno', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 4 — METABOLIC STRENGTH (Месяц 4, недели 13–16)', 4, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–15'),
    ('bolgarskiy-split-prised', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 15, null::int, 90, 4, '15–20'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-vesom', 80, 20, null::int, 90, 4, '20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-3-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-b1c817', 100, null::int, null::int, 45, 3, 'круг'),
    ('kardio-10-min-40-sek-bystro-20-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY METABOLIC', 4, 'LEVEL 4 — METABOLIC STRENGTH (Месяц 4, недели 13–16)', 4, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya', 20, 12, null::int, 90, 4, '12–15'),
    ('tyaga-ganteley-v-naklone', 30, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('metabolic-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-ddae71', 90, null::int, null::int, 45, 5, 'круг'),
    ('cardio-finisher-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Месяц 5, недели 17–20)', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 4, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('cardio-finisher-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-5db481', 120, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Месяц 5, недели 17–20)', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–12'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 3, '10–15'),
    ('superset-1-3-tyaga-ganteley-12-podem-na-bitseps-10-12', 90, null::int, null::int, 60, 3, 'круг'),
    ('superset-2-3-molotkovye-sgibaniya-12-statika-bitsepsa-90-20-sek', 100, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-1-min-vysokiy-temp-1-min-umerenno-7-1-min-spokoyno', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Месяц 5, недели 17–20)', 5, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 5, '10–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–12'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-3-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-b1c817', 100, null::int, null::int, 45, 3, 'круг'),
    ('kardio-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY DEFINITION', 4, 'LEVEL 5 — FAT BURN + MUSCLE DEFINITION (Месяц 5, недели 17–20)', 5, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-s-dop-vesom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d05fd5', 90, null::int, null::int, 45, 5, 'круг'),
    ('final-cardio-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Месяц 6, недели 21–24)', 6, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-3-mahi-v-storony-15-20-otzhimaniya-do-tehnicheskogo-otkaza-929181', 90, null::int, null::int, 45, 3, 'круг'),
    ('hiit-12-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-12-bystrye-7a3161', 100, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-5db481', 110, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Месяц 6, недели 21–24)', 6, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–12'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 3, '10–15'),
    ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 90, null::int, null::int, 60, 3, 'круг'),
    ('hiit-15-min-1-min-umerenno-vysokiy-temp-30-sek-vysokiy-temp-10-5cfbec', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Месяц 6, недели 21–24)', 6, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 5, '10–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–12'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-hiit-4-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-20-207c6f', 100, null::int, null::int, 45, 4, 'круг'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + HIIT', 4, 'LEVEL 6 — MUSCLE PRESERVATION + HIIT (Месяц 6, недели 21–24)', 6, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-s-dop-vesom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-hiit-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-1f64b7', 90, null::int, null::int, 45, 5, 'круг'),
    ('final-hiit-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 100, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 7 — ADVANCED FAT LOSS (Месяц 7, недели 25–28)', 7, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('cardio-finisher-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-5db481', 120, null::int, null::int, 30, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 7 — ADVANCED FAT LOSS (Месяц 7, недели 25–28)', 7, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 3, '10–12'),
    ('superset-1-3-tyaga-ganteley-10-12-podem-na-bitseps-10-12', 90, null::int, null::int, 60, 3, 'круг'),
    ('superset-2-3-molotkovye-sgibaniya-12-statika-bitsepsa-90-20-sek', 100, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-45-sek-bystro-15-sek-spokoyno-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 7 — ADVANCED FAT LOSS (Месяц 7, недели 25–28)', 7, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 5, '10–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-364878', 100, null::int, null::int, 45, 4, 'круг'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY ADVANCED', 4, 'LEVEL 7 — ADVANCED FAT LOSS (Месяц 7, недели 25–28)', 7, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-s-dop-vesom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('advanced-full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-dc4f10', 90, null::int, null::int, 45, 5, 'круг'),
    ('final-cardio-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 8 — DEFINITION + CONDITIONING (Месяц 8, недели 29–32)', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 4, '8–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 4, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-3-mahi-v-storony-15-20-otzhimaniya-do-tehnicheskogo-otkaza-929181', 90, null::int, null::int, 45, 3, 'круг'),
    ('chest-finisher-4-10-otzhimaniy-15-mahov-v-storony-10-razgibaniy-ruk-s-af079f', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-12-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 8 — DEFINITION + CONDITIONING (Месяц 8, недели 29–32)', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–12'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 3, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 3, '10–15'),
    ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 90, null::int, null::int, 60, 3, 'круг'),
    ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-82403d', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-15-min-45-sek-bystro-15-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 8 — DEFINITION + CONDITIONING (Месяц 8, недели 29–32)', 8, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 5, '10–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–12'),
    ('vypady-nazad', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 15, null::int, 90, 3, '15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-15-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-364878', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY CONDITIONING', 4, 'LEVEL 8 — DEFINITION + CONDITIONING (Месяц 8, недели 29–32)', 8, 88)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-s-vesom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10–12'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10–12'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-6-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d758ce', 90, null::int, null::int, 45, 6, 'круг'),
    ('final-cardio-15-min-30-sek-vysokiy-temp-30-sek-umerenno-15', 100, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 110, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 9 — ADVANCED DEFINITION (Месяц 9, недели 33–36)', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 8, null::int, 90, 4, '8–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 4, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-storony-c3d07a', 110, null::int, null::int, 45, 3, 'круг'),
    ('kardio-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 120, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 9 — ADVANCED DEFINITION (Месяц 9, недели 33–36)', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 4, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 4, '10–12'),
    ('superset-3-tyaga-ganteley-10-12-podem-na-bitseps-10-12-molotkovye-42eeff', 90, null::int, null::int, 60, 3, 'круг'),
    ('finisher-3-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-20-b8566c', 100, null::int, null::int, 45, 3, 'круг'),
    ('kardio-15-min-45-sek-bystro-15-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 9 — ADVANCED DEFINITION (Месяц 9, недели 33–36)', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 8, null::int, 90, 5, '8–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 12, null::int, 90, 3, '12–15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-d2773c', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY ADVANCED', 4, 'LEVEL 9 — ADVANCED DEFINITION (Месяц 9, недели 33–36)', 9, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('otzhimaniya-s-dop-vesom', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-6-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d758ce', 90, null::int, null::int, 45, 6, 'круг'),
    ('metabolic-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-20-88f66e', 100, null::int, null::int, 30, 4, 'круг'),
    ('kardio-10-min-20-sek-vysokiy-temp-40-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 10 — PEAK FAT LOSS (Месяц 10, недели 37–40)', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 8, null::int, 90, 4, '8–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 4, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-storony-3cc4a8', 110, null::int, null::int, 45, 3, 'круг'),
    ('interval-cardio-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 120, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 10 — PEAK FAT LOSS (Месяц 10, недели 37–40)', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 4, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 4, '10–12'),
    ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 90, null::int, null::int, 60, 3, 'круг'),
    ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-82403d', 100, null::int, null::int, 45, 4, 'круг'),
    ('interval-cardio-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 10 — PEAK FAT LOSS (Месяц 10, недели 37–40)', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 8, null::int, 90, 5, '8–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 12, null::int, 90, 3, '12–15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-d2773c', 100, null::int, null::int, 45, 4, 'круг'),
    ('interval-cardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY PEAK', 4, 'LEVEL 10 — PEAK FAT LOSS (Месяц 10, недели 37–40)', 10, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('otzhimaniya-s-dop-vesom', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-6-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d758ce', 90, null::int, null::int, 45, 6, 'круг'),
    ('peak-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-a43190', 100, null::int, null::int, 30, 4, 'круг'),
    ('interval-cardio-10-min-20-sek-vysokiy-temp-40-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 11 — FINAL CUT (Месяц 11, недели 41–44)', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-1-3-zhim-ganteley-10-otzhimaniya-10-15-otdyh-45-sek', 90, null::int, null::int, 45, 3, 'круг'),
    ('superset-2-3-mahi-v-storony-15-20-razgibanie-ruk-s-rezinkoy-15-20', 100, null::int, null::int, 60, 3, 'круг'),
    ('final-chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-3100c1', 110, null::int, null::int, 45, 3, 'круг'),
    ('kardio-12-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-12', 120, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 130, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 11 — FINAL CUT (Месяц 11, недели 41–44)', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 4, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 4, '10–12'),
    ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 90, null::int, null::int, 60, 3, 'круг'),
    ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-749012', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-15-min-45-sek-bystro-15-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 11 — FINAL CUT (Месяц 11, недели 41–44)', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 8, null::int, 90, 5, '8–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 12, null::int, 90, 3, '12–15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-d2773c', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY FINAL CUT', 4, 'LEVEL 11 — FINAL CUT (Месяц 11, недели 41–44)', 11, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10–12'),
    ('otzhimaniya-s-dop-vesom', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-6-10-goblet-squat-10-otzhimaniy-12-tyag-ganteley-10-d758ce', 90, null::int, null::int, 45, 6, 'круг'),
    ('final-finisher-4-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-881fe7', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-45-sek-4b6b23', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 12 — FINAL TRANSFORMATION (Месяц 12, недели 45–48)', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 8, null::int, 90, 4, '8–12'),
    ('razvedenie-ganteley-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy', 50, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 4, '15–20'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15–20'),
    ('razgibanie-ruk-s-rezinkoy', 80, 15, null::int, 90, 4, '15–20'),
    ('superset-3-zhim-ganteley-10-otzhimaniya-10-15-mahi-v-storony-15-20-fde56c', 90, null::int, null::int, 45, 3, 'круг'),
    ('final-chest-finisher-3-10-otzhimaniy-10-uzkih-otzhimaniy-15-mahov-v-3100c1', 100, null::int, null::int, 45, 3, 'круг'),
    ('kardio-12-min-30-sek-vysokiy-temp-30-sek-spokoyno-12', 110, null::int, 720, 60, 1, '12 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-20-kasaniy-pyatok-b54d0f', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 12 — FINAL TRANSFORMATION (Месяц 12, недели 45–48)', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('podtyagivaniya-ili-negativnye-5-4-5-opuskanie-5-sek', 10, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-dvuh-ganteley-v-naklone', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 40, 15, null::int, 90, 4, '15–20'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('pulover-s-gantelyu', 60, 12, null::int, 90, 3, '12–15'),
    ('podem-ganteley-na-bitseps', 70, 8, null::int, 90, 4, '8–12'),
    ('molotkovye-sgibaniya', 80, 10, null::int, 90, 4, '10–12'),
    ('superset-3-podem-na-bitseps-10-12-molotkovye-sgibaniya-10-12-statika-12f062', 90, null::int, null::int, 60, 3, 'круг'),
    ('back-finisher-4-10-tyag-ganteley-10-sgibaniy-na-bitseps-15-face-pull-749012', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-15-min-40-sek-vysokiy-temp-20-sek-vosstanovlenie-15', 110, null::int, 900, 60, 1, '15 мин'),
    ('press-3-kruga-20-skruchivaniy-15-reverse-crunch-20-russian-twist-45-4d9e75', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 12 — FINAL TRANSFORMATION (Месяц 12, недели 45–48)', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 8, null::int, 90, 5, '8–12'),
    ('bolgarskiy-split-prised', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('podem-na-ustoychivuyu-platformu', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom', 60, 12, null::int, 90, 4, '12–15'),
    ('sumo-prised', 70, 12, null::int, 90, 3, '12–15'),
    ('ikry-s-vesom', 80, 15, null::int, 90, 5, '15–20'),
    ('leg-superset-3-goblet-squat-12-vypady-nazad-10-na-nogu-yagodichnyy-06dd99', 90, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-12-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-mostov-d2773c', 100, null::int, null::int, 45, 4, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-spokoyno-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-reverse-crunch-20-bicycle-crunch-30-sek-hollow-hold-2d0ec4', 120, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 FINAL FULL BODY TEST', 4, 'LEVEL 12 — FINAL TRANSFORMATION (Месяц 12, недели 45–48)', 12, 90)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('goblet-squat', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-s-dop-vesom', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 40, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-nad-golovoy', 50, 10, null::int, 90, 3, '10'),
    ('vypady-nazad', 60, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15–20'),
    ('molotkovye-sgibaniya', 80, 12, null::int, 90, 3, '12'),
    ('final-full-body-circuit-5-10-goblet-squat-10-otzhimaniy-12-tyag-95290a', 90, null::int, null::int, 45, 5, 'круг'),
    ('final-finisher-3-10-prisedaniy-10-otzhimaniy-10-tyag-ganteley-10-c9a5dc', 100, null::int, null::int, 45, 3, 'круг'),
    ('kardio-10-min-30-sek-vysokiy-temp-30-sek-vosstanovlenie-10', 110, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-20-v-ups-20-reverse-crunch-20-russian-twist-60-sek-9ce201', 120, null::int, null::int, 60, 3, 'круг'),
    ('finalnyy-test-posle-12-mesyatsev-vypolnit-posle-vosstanovleniya-maks-6d0fd8', 130, null::int, null::int, 60, 1, 'тест')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
