-- 0020_seed_nabor_massy_muzhchiny_doma.sql
-- Программа: Набор массы — Мужчины — Дома
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0020), по одной на каждую комбинацию
-- пол × цель × формат — см. 0019..0021 и журнал в PROJECT_PLAN.md.
--
-- 97 тренировок, 277 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Набор массы — Мужчины — Дома)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('razminka-2-legkie-pryzhki-2-min-krugi-rukami-30-sek-otzhimaniya-ot-b32b51', 'Разминка ×2: лёгкие прыжки 2 мин, круги руками 30 сек, отжимания от стены/скамьи 15, приседания без веса 15'),
  ('otzhimaniya-ot-pola-posl-podhod-maksimum-kachestvennyh', 'Отжимания от пола (посл. подход — максимум качественных)'),
  ('zhim-ganteley-lezha-na-polu-posl-3-povt-medlenno', 'Жим гантелей лёжа на полу (посл. 3 повт. медленно)'),
  ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 'Отжимания с узкой постановкой рук'),
  ('razvedenie-ganteley-lezha-na-polu-opuskanie-3-sek', 'Разведение гантелей лёжа на полу (опускание 3 сек)'),
  ('razgibanie-ruki-s-gantelyu-iz-za-golovy', 'Разгибание руки с гантелью из-за головы'),
  ('mahi-gantelyami-v-storony', 'Махи гантелями в стороны'),
  ('podem-ganteley-pered-soboy', 'Подъём гантелей перед собой'),
  ('finisher-otzhimaniya-20-sek-rabota-20-sek-otdyh-5', 'Финишер: отжимания — 20 сек работа/20 сек отдых ×5'),
  ('podtyagivaniya-obychnym-hvatom-ili-negativnye-5-8-povt-opuskanie-3-5-021435', 'Подтягивания обычным хватом (или негативные 5–8 повт., опускание 3–5 сек)'),
  ('tyaga-ganteley-v-naklone', 'Тяга гантелей в наклоне'),
  ('tyaga-odnoy-ganteli-k-poyasu', 'Тяга одной гантели к поясу'),
  ('tyaga-rezinki-k-zhivotu', 'Тяга резинки к животу'),
  ('razvedenie-rezinki-pered-soboy-zadnyaya-delta-verh-spiny', 'Разведение резинки перед собой (задняя дельта + верх спины)'),
  ('podem-ganteley-na-bitseps', 'Подъём гантелей на бицепс'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('finisher-tyaga-rezinki-k-poyasu-30-sek-rabota-20-sek-otdyh-5', 'Финишер: тяга резинки к поясу — 30 сек работа/20 сек отдых ×5'),
  ('prisedaniya-s-gantelyu', 'Приседания с гантелью'),
  ('vypady-nazad', 'Выпады назад'),
  ('rumynskaya-tyaga-s-gantelyami-opuskanie-3-sek', 'Румынская тяга с гантелями (опускание 3 сек)'),
  ('yagodichnyy-most-s-gantelyu-fiksatsiya-2-sek-vverhu', 'Ягодичный мост с гантелью (фиксация 2 сек вверху)'),
  ('podemy-na-noski-s-gantelyami-posl-podhod-do-zhzheniya', 'Подъёмы на носки с гантелями (посл. подход до жжения)'),
  ('zhim-ganteley-vverh', 'Жим гантелей вверх'),
  ('finisher-nog-3-20-prisedaniy-10-vyprygivaniy-20-sek-otdyh', 'Финишер ног ×3: 20 приседаний, 10 выпрыгиваний, 20 сек отдых'),
  ('otzhimaniya-s-nogami-na-vozvyshenii', 'Отжимания с ногами на возвышении'),
  ('zhim-ganteley-na-polu-posl-2-povt-medlenno', 'Жим гантелей на полу (посл. 2 повт. медленно)'),
  ('otzhimaniya-s-shirokoy-postanovkoy', 'Отжимания с широкой постановкой'),
  ('razvedenie-ganteley', 'Разведение гантелей'),
  ('zhim-ganteley-uzkim-hvatom-lezha', 'Жим гантелей узким хватом лёжа'),
  ('frantsuzskiy-zhim-s-odnoy-gantelyu', 'Французский жим с одной гантелью'),
  ('mahi-gantelyami-v-storony-drop-set-na-posl-podhode-snizit-ves-10-povt', 'Махи гантелями в стороны + дроп-сет на посл. подходе (снизить вес +10 повт.)'),
  ('podtyagivaniya-obratnym-hvatom', 'Подтягивания обратным хватом'),
  ('tyaga-dvuh-ganteley-k-poyasu', 'Тяга двух гантелей к поясу'),
  ('tyaga-ganteli-odnoy-rukoy', 'Тяга гантели одной рукой'),
  ('tyaga-rezinki-sverhu-vniz', 'Тяга резинки сверху вниз'),
  ('staticheskoe-uderzhanie-ganteley-v-polozhenii-tyagi', 'Статическое удержание гантелей в положении тяги'),
  ('podem-ganteley-na-bitseps-s-supinatsiey', 'Подъём гантелей на бицепс с супинацией'),
  ('molotki-posl-podhod-10-chastichnyh-povtoreniy', 'Молотки (посл. подход +10 частичных повторений)'),
  ('bolgarskie-vypady', 'Болгарские выпады'),
  ('goblet-squat', 'Goblet Squat'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('yagodichnyy-most-posl-povt-kazhdogo-podhoda-10-sek-uderzhanie-sverhu', 'Ягодичный мост (посл. повт. каждого подхода — 10 сек удержание сверху)'),
  ('podem-na-noski', 'Подъём на носки'),
  ('zhim-ganteley-sidya', 'Жим гантелей сидя'),
  ('mahi-v-storony', 'Махи в стороны'),
  ('zadnyaya-delta-v-naklone', 'Задняя дельта в наклоне'),
  ('otzhimaniya-s-pauzoy-vnizu-2-sek', 'Отжимания с паузой внизу 2 сек'),
  ('zhim-ganteley-neytralnym-hvatom', 'Жим гантелей нейтральным хватом'),
  ('otzhimaniya-almaz', 'Отжимания «алмаз»'),
  ('pulover-s-gantelyu-lezha', 'Пуловер с гантелью лёжа'),
  ('razgibanie-ruk-s-rezinkoy', 'Разгибание рук с резинкой'),
  ('zhim-ganteley-arnolda', 'Жим гантелей Арнольда'),
  ('podtyagivaniya-shirokim-hvatom', 'Подтягивания широким хватом'),
  ('negativnye-podtyagivaniya-opuskanie-5-sek', 'Негативные подтягивания (опускание 5 сек)'),
  ('tyaga-ganteley-s-uporom-grudyu', 'Тяга гантелей с упором грудью'),
  ('tyaga-rezinki-k-grudi', 'Тяга резинки к груди'),
  ('face-pull-s-rezinkoy', 'Face Pull с резинкой'),
  ('kontsentrirovannyy-podem-ganteli', 'Концентрированный подъём гантели'),
  ('vypady-v-hodbe', 'Выпады в ходьбе'),
  ('rumynskaya-tyaga-na-odnoy-noge', 'Румынская тяга на одной ноге'),
  ('yagodichnyy-most', 'Ягодичный мост'),
  ('ikry', 'Икры'),
  ('athletic-finisher-3-10-prisedaniy-s-vyprygivaniem-10-otzhimaniy-20-31a24a', 'Athletic Finisher ×3: 10 приседаний с выпрыгиванием, 10 отжиманий, 20 Mountain Climbers, 20 сек отдых'),
  ('otzhimaniya-s-nogami-na-vozvyshenii-posl-podhod-do-otkaza', 'Отжимания с ногами на возвышении (посл. подход до отказа)'),
  ('zhim-ganteley-lezha-na-polu-posl-2-povt-medlenno', 'Жим гантелей лёжа на полу (посл. 2 повт. медленно)'),
  ('zhim-ganteley-lezha-uzkim-hvatom', 'Жим гантелей лёжа узким хватом'),
  ('pulover-s-gantelyu', 'Пуловер с гантелью'),
  ('mahi-gantelyami-v-storony-drop-set-na-posl-podhode', 'Махи гантелями в стороны + дроп-сет на посл. подходе'),
  ('razgibanie-ruk-s-rezinkoy-vniz', 'Разгибание рук с резинкой вниз'),
  ('frantsuzskiy-zhim-s-gantelyu', 'Французский жим с гантелью'),
  ('finisher-otzhimaniya-30-sek-rabota-30-sek-otdyh-4', 'Финишер: отжимания — 30 сек работа/30 сек отдых ×4'),
  ('podtyagivaniya-obratnym-hvatom-ili-negativnye-5-5', 'Подтягивания обратным хватом (или негативные 5×5)'),
  ('tyaga-dvuh-ganteley-v-naklone', 'Тяга двух гантелей в наклоне'),
  ('tyaga-ganteli-odnoy-rukoy-s-oporoy', 'Тяга гантели одной рукой с опорой'),
  ('finisher-tyaga-rezinki-40-sek-rabota-20-sek-otdyh-4', 'Финишер: тяга резинки — 40 сек работа/20 сек отдых ×4'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('yagodichnyy-most-s-vesom-fiksatsiya-2-sek-vverhu', 'Ягодичный мост с весом (фиксация 2 сек вверху)'),
  ('vypady-nazad-s-gantelyami', 'Выпады назад с гантелями'),
  ('sgibanie-nog-lezha-s-rezinkoy', 'Сгибание ног лёжа с резинкой'),
  ('podem-na-noski-s-vesom', 'Подъём на носки с весом'),
  ('finisher-3-15-prisedaniy-10-vypadov-na-nogu-20-podemov-na-noski-otdyh-5462ab', 'Финишер ×3: 15 приседаний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 60 сек'),
  ('otzhimaniya', 'Отжимания'),
  ('athletic-circuit-4-10-prisedaniy-s-vyprygivaniem-10-otzhimaniy-20-69cca1', 'Athletic Circuit ×4: 10 приседаний с выпрыгиванием, 10 отжиманий, 20 Mountain Climbers, 10 выпадов, 30 сек отдых'),
  ('otzhimaniya-s-uzkoy-postanovkoy', 'Отжимания с узкой постановкой'),
  ('zhim-ganteley-s-pola-neytralnym-hvatom-5-k-nedelyam-5-6', 'Жим гантелей с пола нейтральным хватом (+5% к неделям 5–6)'),
  ('razvedenie-ganteley-lezha', 'Разведение гантелей лёжа'),
  ('zhim-arnolda', 'Жим Арнольда'),
  ('razgibanie-ganteli-iz-za-golovy', 'Разгибание гантели из-за головы'),
  ('otzhimaniya-ot-skami-nazad', 'Отжимания от скамьи назад'),
  ('finisher-mechanical-drop-set-bez-otdyha-otzhimaniya-s-nogami-na-435578', 'Финишер — Mechanical Drop Set (без отдыха): отжимания с ногами на возвышении → обычные → с колен, по 1 подходу'),
  ('podtyagivaniya-neytralnym-hvatom', 'Подтягивания нейтральным хватом'),
  ('tyaga-odnoy-ganteli-k-tazu', 'Тяга одной гантели к тазу'),
  ('bitseps-s-rezinkoy', 'Бицепс с резинкой'),
  ('finisher-staticheskoe-uderzhanie-ganteley-v-polozhenii-sgibaniya-30-781e15', 'Финишер: статическое удержание гантелей в положении сгибания — 30 сек ×3, отдых 30 сек'),
  ('prisedaniya-s-dvumya-gantelyami', 'Приседания с двумя гантелями'),
  ('sumo-prised-s-gantelyu', 'Сумо-присед с гантелью'),
  ('yagodichnyy-most-s-pauzoy-3-sek-sverhu', 'Ягодичный мост с паузой (3 сек сверху)'),
  ('ikry-stoya-na-odnoy-noge', 'Икры стоя на одной ноге'),
  ('finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-otdyh-45-345ce3', 'Финишер ×3: 15 приседаний, 10 выпрыгиваний, 10 выпадов на ногу, отдых 45 сек'),
  ('pike-push-ups', 'Pike Push-Ups'),
  ('podtyagivaniya', 'Подтягивания'),
  ('avstraliyskie-podtyagivaniya-ili-tyaga-rezinki-bez-turnika', 'Австралийские подтягивания (или тяга резинки без турника)'),
  ('finisher-5-10-otzhimaniy-10-prisedaniy-10-mountain-climbers-na-dfe318', 'Finisher ×5: 10 отжиманий, 10 приседаний, 10 Mountain Climbers на сторону, 10 выпадов, отдых 45 сек'),
  ('zhim-ganteley-lezha-na-polu-tyazhelyy-rabochiy-ves', 'Жим гантелей лёжа на полу (тяжёлый рабочий вес)'),
  ('zhim-ganteley-s-neytralnym-hvatom', 'Жим гантелей с нейтральным хватом'),
  ('razvedenie-ganteley-lezha-opuskanie-3-sek', 'Разведение гантелей лёжа (опускание 3 сек)'),
  ('mahi-gantelyami-v-storony-drop-set', 'Махи гантелями в стороны + дроп-сет'),
  ('razgibanie-ganteli-iz-za-golovy-dvumya-rukami', 'Разгибание гантели из-за головы двумя руками'),
  ('finisher-otzhimaniya-20-sek-rabota-10-sek-otdyh-6', 'Финишер: отжимания — 20 сек работа/10 сек отдых ×6'),
  ('tyaga-ganteley-k-poyasu-s-pauzoy-2-sek', 'Тяга гантелей к поясу с паузой 2 сек'),
  ('finisher-uderzhanie-ganteley-na-bitseps-3-30-sek-otdyh-30-sek', 'Финишер: удержание гантелей на бицепс — 3×30 сек, отдых 30 сек'),
  ('frontalnyy-goblet-squat', 'Фронтальный Goblet Squat'),
  ('bolgarskie-vypady-s-gantelyami', 'Болгарские выпады с гантелями'),
  ('yagodichnyy-most-s-vesom-pauza-3-sek-sverhu', 'Ягодичный мост с весом (пауза 3 сек сверху)'),
  ('ikry-na-odnoy-noge', 'Икры на одной ноге'),
  ('finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-sek-5cf187', 'Финишер ×3: 15 приседаний, 10 выпрыгиваний, 10 выпадов на ногу, 20 сек отдыха'),
  ('avstraliyskie-podtyagivaniya', 'Австралийские подтягивания'),
  ('level-3-circuit-4-10-podtyagivaniy-15-otzhimaniy-20-prisedaniy-10-744af7', 'Level 3 Circuit ×4: 10 подтягиваний, 15 отжиманий, 20 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 60 сек'),
  ('zhim-ganteley-lezha-na-polu-5-k-nedelyam-9-10', 'Жим гантелей лёжа на полу (+5% к неделям 9–10)'),
  ('mehanicheskiy-drop-set-1-podhod-bez-otdyha-otzhimaniya-s-nogami-na-d760a4', 'Механический дроп-сет (1 подход без отдыха): отжимания с ногами на возвышении → обычные → с колен'),
  ('tyaga-dvuh-ganteley-s-uporom-grudyu', 'Тяга двух гантелей с упором грудью'),
  ('tyaga-odnoy-ganteli', 'Тяга одной гантели'),
  ('face-pull', 'Face Pull'),
  ('bitseps-s-gantelyami-s-supinatsiey', 'Бицепс с гантелями с супинацией'),
  ('finisher-statika-na-bitseps-3-40-sek-otdyh-30-sek', 'Финишер: статика на бицепс 3×40 сек, отдых 30 сек'),
  ('goblet-squat-posl-podhod-drop-set', 'Goblet Squat (посл. подход — дроп-сет)'),
  ('sumo-prised', 'Сумо-присед'),
  ('yagodichnyy-most-posl-10-sek-statika', 'Ягодичный мост (посл. 10 сек — статика)'),
  ('finisher-3-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-30-sek-90a9a5', 'Finisher ×3: 10 выпрыгиваний, 15 приседаний, 10 выпадов на ногу, 30 сек отдых'),
  ('athletic-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-ac10e7', 'Athletic Circuit ×5: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 Mountain Climbers на сторону, отдых 45 сек'),
  ('otzhimaniya-s-dop-vesom-ili-medlennoe-opuskanie-4-sek', 'Отжимания с доп. весом (или медленное опускание 4 сек)'),
  ('zhim-ganteley-lezha-na-polu-tyazhelyy-rabochiy', 'Жим гантелей лёжа на полу (тяжёлый рабочий)'),
  ('zhim-ganteley-lezha-s-pauzoy-2-sek-vnizu', 'Жим гантелей лёжа с паузой 2 сек внизу'),
  ('zhim-ganteley-stoya', 'Жим гантелей стоя'),
  ('frantsuzskiy-zhim-odnoy-gantelyu', 'Французский жим одной гантелью'),
  ('finisher-mechanical-drop-set-1-krug-bez-otdyha-otzhimaniya-s-vesom-fbf53c', 'Финишер — Mechanical Drop Set (1 круг без отдыха): отжимания с весом → обычные → с колен'),
  ('tyaga-ganteley-k-poyasu-pauza-2-sek-sverhu', 'Тяга гантелей к поясу (пауза 2 сек сверху)'),
  ('tyaga-odnoy-ganteli-s-oporoy', 'Тяга одной гантели с опорой'),
  ('tyaga-rezinki-k-poyasu-sidya', 'Тяга резинки к поясу сидя'),
  ('pulover-s-rezinkoy', 'Пуловер с резинкой'),
  ('bitseps-s-gantelyami-na-naklonnoy-poverhnosti', 'Бицепс с гантелями на наклонной поверхности'),
  ('finisher-staticheskoe-uderzhanie-ganteley-na-bitseps-3-40-sek-otdyh-89af7e', 'Финишер: статическое удержание гантелей на бицепс — 3×40 сек, отдых 30 сек'),
  ('bolgarskie-vypady-tyazhelyy-ves', 'Болгарские выпады (тяжёлый вес)'),
  ('yagodichnyy-most-s-dop-vesom-pauza-3-sek', 'Ягодичный мост с доп. весом (пауза 3 сек)'),
  ('sgibanie-nog-s-rezinkoy-lezha', 'Сгибание ног с резинкой лёжа'),
  ('podemy-na-noski-stoya-s-vesom-posl-do-zhzheniya', 'Подъёмы на носки стоя с весом (посл. до жжения)'),
  ('power-circuit-4-8-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-eda379', 'Power Circuit ×4: 8 подтягиваний, 12 отжиманий, 15 Goblet Squat, 10 Mountain Climbers на сторону, отдых 60 сек'),
  ('otzhimaniya-s-uzkoy-postanovkoy-ves', 'Отжимания с узкой постановкой + вес'),
  ('zhim-ganteley-s-pola-poperemenno', 'Жим гантелей с пола попеременно'),
  ('mahi-gantelyami-v-storony-sidya', 'Махи гантелями в стороны сидя'),
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('finisher-otzhimaniya-15-sek-rabota-15-sek-otdyh-8', 'Финишер: отжимания — 15 сек работа/15 сек отдых ×8'),
  ('tyaga-ganteli-k-tazu', 'Тяга гантели к тазу'),
  ('finisher-bitseps-20-sek-rabota-10-sek-otdyh-6', 'Финишер: бицепс — 20 сек работа/10 сек отдых ×6'),
  ('goblet-squat-s-pauzoy-2-sek-vnizu', 'Goblet Squat с паузой 2 сек внизу'),
  ('yagodichnyy-most-na-odnoy-noge', 'Ягодичный мост на одной ноге'),
  ('finisher-4-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-otdyh-45-02520c', 'Finisher ×4: 10 выпрыгиваний, 15 приседаний, 10 выпадов на ногу, отдых 45 сек'),
  ('podtyagivaniya-s-pauzoy-2-sek-sverhu', 'Подтягивания с паузой 2 сек сверху'),
  ('prisedaniya-na-odnoy-noge-do-vysokoy-opory-ne-teryat-kontrol', 'Приседания на одной ноге до высокой опоры (не терять контроль)'),
  ('planka-s-perenosom-vesa', 'Планка с переносом веса'),
  ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-967088', 'Boss Circuit ×5: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 Mountain Climbers на сторону, 20 сек отдых'),
  ('otzhimaniya-s-dop-vesom-posl-podhod-do-otkaza', 'Отжимания с доп. весом (посл. подход до отказа)'),
  ('zhim-ganteley-s-pauzoy-2-sek-vnizu', 'Жим гантелей с паузой 2 сек внизу'),
  ('zhim-ganteley-nad-golovoy-stoya', 'Жим гантелей над головой стоя'),
  ('finisher-chest-burn-otzhimaniya-15-sek-rabota-15-sek-otdyh-8', 'Финишер Chest Burn: отжимания — 15 сек работа/15 сек отдых ×8'),
  ('tyaga-ganteley-v-naklone-pauza-2-sek', 'Тяга гантелей в наклоне (пауза 2 сек)'),
  ('finisher-biceps-hold-sgibanie-ruk-s-gantelyami-30-sek-rabota-20-sek-3543e8', 'Финишер Biceps Hold: сгибание рук с гантелями — 30 сек работа/20 сек отдых ×4'),
  ('yagodichnyy-most-s-vesom-pauza-3-sek', 'Ягодичный мост с весом (пауза 3 сек)'),
  ('ikry-stoya-s-vesom-posl-20-sek-statiki', 'Икры стоя с весом (посл. 20 сек статики)'),
  ('leg-finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-3be6dd', 'Leg Finisher ×3: 15 приседаний, 10 выпрыгиваний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 45 сек'),
  ('tyaga-ganteley-k-poyasu', 'Тяга гантелей к поясу'),
  ('athletic-circuit-4-8-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-33401c', 'Athletic Circuit ×4: 8 подтягиваний, 12 отжиманий, 15 Goblet Squat, 10 Mountain Climbers на сторону, 10 выпадов, отдых 45–60 сек'),
  ('otzhimaniya-s-nogami-na-vozvyshenii-ves', 'Отжимания с ногами на возвышении + вес'),
  ('mechanical-drop-set-1-krug-bez-otdyha-do-otkaza-v-kazhdom-variante-eba21d', 'Mechanical Drop Set (1 круг без отдыха, до отказа в каждом варианте): отжимания с ногами на возвышении → обычные → с колен'),
  ('podtyagivaniya-s-pauzoy-sverhu-2-sek', 'Подтягивания с паузой сверху 2 сек'),
  ('tyaga-odnoy-ganteli-k-protivopolozhnomu-tazu', 'Тяга одной гантели к противоположному тазу'),
  ('finisher-bitseps-s-rezinkoy-20-sek-rabota-10-sek-otdyh-8', 'Финишер: бицепс с резинкой — 20 сек работа/10 сек отдых ×8'),
  ('bolgarskiy-split-prised-s-peredney-nogoy-na-vozvyshenii', 'Болгарский сплит-присед с передней ногой на возвышении'),
  ('goblet-squat-s-pauzoy-3-sek-vnizu', 'Goblet Squat с паузой 3 сек внизу'),
  ('sumo-prised-s-pauzoy', 'Сумо-присед с паузой'),
  ('yagodichnyy-most-na-odnoy-noge-3-sek-verhnyaya-tochka', 'Ягодичный мост на одной ноге (3 сек верхняя точка)'),
  ('leg-boss-4-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-20-12be6c', 'Leg Boss ×4: 10 выпрыгиваний, 15 приседаний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 30–45 сек'),
  ('mahi-gantelyami', 'Махи гантелями'),
  ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-e58302', 'Boss Circuit ×5: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 Mountain Climbers на сторону, 10 выпадов, отдых 30–45 сек'),
  ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 'Жим гантелей лёжа на полу (опускание 3 сек)'),
  ('zhim-ganteley-neytralnym-hvatom-pauza-1-sek-vnizu', 'Жим гантелей нейтральным хватом (пауза 1 сек внизу)'),
  ('finisher-push-burn-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-f1afee', 'Финишер Push Burn ×3 раунда без отдыха между упр. (60 сек между раундами): 10 отжиманий с весом, 10 обычных, 10 с колен'),
  ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 'Тяга двух гантелей в наклоне (пауза 2 сек)'),
  ('finisher-biceps-shock-sgibanie-s-rezinkoy-30-sek-rabota-15-sek-otdyh-6', 'Финишер Biceps Shock: сгибание с резинкой — 30 сек работа/15 сек отдых ×6'),
  ('goblet-squat-posl-drop-set', 'Goblet Squat (посл. — дроп-сет)'),
  ('sgibanie-nog-s-rezinkoy', 'Сгибание ног с резинкой'),
  ('ikry-stoya-s-vesom', 'Икры стоя с весом'),
  ('leg-finisher-3-12-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-fd102b', 'Leg Finisher ×3: 12 приседаний, 10 выпрыгиваний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 45 сек'),
  ('full-body-circuit-4-6-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-f93972', 'Full Body Circuit ×4: 6 подтягиваний, 12 отжиманий, 15 Goblet Squat, 10 выпадов на ногу, 20 Mountain Climbers, отдых 60 сек'),
  ('otzhimaniya-s-vesom', 'Отжимания с весом'),
  ('zhim-ganteley-na-polu', 'Жим гантелей на полу'),
  ('superset-3-mahi-v-storony-12-15-otzhimaniya-do-tehnicheskogo-otkaza', 'Суперсет ×3: Махи в стороны 12–15 + Отжимания до технического отказа'),
  ('tyaga-ganteley-s-pauzoy', 'Тяга гантелей с паузой'),
  ('superset-3-bitseps-s-gantelyami-10-bitseps-s-rezinkoy-15-20', 'Суперсет ×3: Бицепс с гантелями 10 + Бицепс с резинкой 15–20'),
  ('bolgarskiy-split-prised', 'Болгарский сплит-присед')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('goblet-squat-s-pauzoy-2-3-sek', 'Goblet Squat с паузой 2–3 сек'),
  ('yagodichnyy-most-posl-do-tehnicheskogo-otkaza', 'Ягодичный мост (посл. до технического отказа)'),
  ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 'Leg Drop Set (без отдыха): Goblet Squat — 10 тяжёлых → 10 средних → 10 без веса'),
  ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-vypadov-1c081b', 'Boss Circuit ×5: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 30–45 сек'),
  ('otzhimaniya-s-vesom-na-spine-posl-podhod-do-otkaza', 'Отжимания с весом на спине (посл. подход до отказа)'),
  ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-raundami-d9ed68', 'Push Finisher ×3 раунда без отдыха между упр. (60 сек между раундами): 10 отжиманий с весом, 10 обычных, 10 узких'),
  ('podtyagivaniya-s-dop-vesom', 'Подтягивания с доп. весом'),
  ('tyaga-rezinki-k-litsu', 'Тяга резинки к лицу'),
  ('podem-ganteley-na-bitseps-stoya', 'Подъём гантелей на бицепс стоя'),
  ('biceps-finisher-sgibanie-s-rezinkoy-30-sek-rabota-15-sek-otdyh-6', 'Biceps Finisher: сгибание с резинкой — 30 сек работа/15 сек отдых ×6'),
  ('goblet-squat-s-tyazheloy-gantelyu-posl-drop-set', 'Goblet Squat с тяжёлой гантелью (посл. — дроп-сет)'),
  ('ikry-stoya-s-vesom-posl-20-sek-statiki-2', 'Икры стоя с весом (посл. — 20 сек статики)'),
  ('leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-nogu-20-2f0ce1', 'Leg Finisher ×3: 10 Goblet Squat, 10 выпрыгиваний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 45 сек'),
  ('full-body-boss-4-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-a65dee', 'Full Body Boss ×4: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45–60 сек'),
  ('otzhimaniya-s-pauzoy-v-nizhney-tochke-2-sek', 'Отжимания с паузой в нижней точке 2 сек'),
  ('razgibanie-odnoy-ruki-s-rezinkoy', 'Разгибание одной руки с резинкой'),
  ('otzhimaniya-uzkim-hvatom', 'Отжимания узким хватом'),
  ('mechanical-drop-set-3-raunda-bez-otdyha-otzhimaniya-s-nogami-na-d5d3e7', 'Mechanical Drop Set ×3 раунда без отдыха: отжимания с ногами на возвышении → обычные → с колен'),
  ('molotkovye-sgibaniya-s-pauzoy', 'Молотковые сгибания с паузой'),
  ('biceps-shock-3-bitseps-s-gantelyu-10-bitseps-s-rezinkoy-15-statika-20-f0c375', 'Biceps Shock ×3: Бицепс с гантелью 10 → Бицепс с резинкой 15 → Статика 20 сек'),
  ('yagodichnyy-most-na-odnoy-noge-pauza-3-sek', 'Ягодичный мост на одной ноге (пауза 3 сек)'),
  ('vzryvnye-otzhimaniya', 'Взрывные отжимания'),
  ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-goblet-squat-42c583', 'Boss Circuit ×5: 5 подтягиваний, 10 взрывных отжиманий, 15 Goblet Squat, 10 выпадов на ногу, 20 Mountain Climbers, отдых 30–45 сек'),
  ('otzhimaniya-s-dop-vesom-posl-do-otkaza', 'Отжимания с доп. весом (посл. до отказа)'),
  ('superset-3-otdyh-60-sek-mahi-v-storony-15-otzhimaniya-do-3bed3a', 'Суперсет ×3 (отдых 60 сек): Махи в стороны 15 + Отжимания до технического отказа'),
  ('superset-3-podem-na-bitseps-10-molotkovye-sgibaniya-10-statika-90-20-56e504', 'Суперсет ×3: Подъём на бицепс 10 + Молотковые сгибания 10 + Статика 90° 20 сек'),
  ('goblet-squat-tyazhelyy-ves', 'Goblet Squat (тяжёлый вес)'),
  ('ikry-s-vesom', 'Икры с весом'),
  ('leg-superset-3-otdyh-60-sek-goblet-squat-12-vyprygivaniya-10', 'Leg Superset ×3 (отдых 60 сек): Goblet Squat 12 + Выпрыгивания 10'),
  ('full-body-density-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-goblet-222fa0', 'Full Body Density Circuit ×5: 5 подтягиваний, 10 отжиманий, 15 Goblet Squat, 10 выпадов на ногу, 15 Mountain Climbers на сторону, отдых 45 сек'),
  ('otzhimaniya-s-pauzoy-2-sek-vnizu', 'Отжимания с паузой 2 сек внизу'),
  ('frantsuzskiy-zhim', 'Французский жим'),
  ('push-drop-set-1-krug-bez-otdyha-3-raunda-otzhimaniya-s-nogami-na-8ae836', 'Push Drop Set (1 круг без отдыха) ×3 раунда: отжимания с ногами на возвышении → обычные → с колен'),
  ('pulover', 'Пуловер'),
  ('biceps-drop-set-3-gantel-10-rezinka-15-20-statika-20-sek', 'Biceps Drop Set ×3: Гантель 10 → Резинка 15–20 → Статика 20 сек'),
  ('goblet-squat-s-pauzoy-3-sek', 'Goblet Squat с паузой 3 сек'),
  ('yagodichnyy-most-s-vesom', 'Ягодичный мост с весом'),
  ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-prisedaniy-84c10b', 'Boss Circuit ×5: 5 подтягиваний, 10 взрывных отжиманий, 15 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 30–45 сек'),
  ('otzhimaniya-s-dop-vesom', 'Отжимания с доп. весом'),
  ('zhim-ganteley-uzkim-hvatom', 'Жим гантелей узким хватом'),
  ('zhim-ganteley-nad-golovoy', 'Жим гантелей над головой'),
  ('superset-3-mahi-v-storony-15-otzhimaniya-do-tehnicheskogo-otkaza', 'Суперсет ×3: Махи в стороны 15 + Отжимания до технического отказа'),
  ('podtyagivaniya-s-vesom', 'Подтягивания с весом'),
  ('biceps-superset-3-bitseps-s-gantelyami-10-bitseps-s-rezinkoy-15-165b50', 'Biceps Superset ×3: Бицепс с гантелями 10 + Бицепс с резинкой 15 + Статика 90° 20 сек'),
  ('leg-superset-3-goblet-squat-12-vyprygivaniya-10', 'Leg Superset ×3: Goblet Squat 12 + Выпрыгивания 10'),
  ('tyaga-ganteley', 'Тяга гантелей'),
  ('full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-0e7428', 'Full Body Circuit ×4: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45 сек'),
  ('otzhimaniya-s-pauzoy-3-sek', 'Отжимания с паузой 3 сек'),
  ('razvedenie-v-naklone', 'Разведение в наклоне'),
  ('mechanical-drop-set-3-otzhimaniya-s-nogami-vyshe-obychnye-s-kolen', 'Mechanical Drop Set ×3: Отжимания с ногами выше → обычные → с колен'),
  ('kontsentrirovannyy-podem', 'Концентрированный подъём'),
  ('molotki', 'Молотки'),
  ('goblet-squat-s-pauzoy', 'Goblet Squat с паузой'),
  ('otzhimaniya-s-dop-vesom-tyazhelyy-rabochiy', 'Отжимания с доп. весом (тяжёлый рабочий)'),
  ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-raundami-8-7f1fe6', 'Push Finisher ×3 раунда без отдыха между упр. (60 сек между раундами): 8 отжиманий с весом, 10 обычных, 10 узких'),
  ('biceps-finisher-3-ganteli-10-rezinka-15-20-statika-na-90-20-sek', 'Biceps Finisher ×3: Гантели 10 → Резинка 15–20 → Статика на 90° 20 сек'),
  ('goblet-squat-tyazhelyy', 'Goblet Squat (тяжёлый)'),
  ('yagodichnyy-most-s-tyazhelym-vesom-pauza-3-sek', 'Ягодичный мост с тяжёлым весом (пауза 3 сек)'),
  ('full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-goblet-squat-10-ef247b', 'Full Body Circuit ×4: 5 подтягиваний, 10 отжиманий, 15 Goblet Squat, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45 сек'),
  ('otzhimaniya-s-pauzoy-3-sek-vnizu', 'Отжимания с паузой 3 сек внизу'),
  ('mechanical-drop-set-3-bez-otdyha-mezhdu-variantami-otzhimaniya-s-e3a9da', 'Mechanical Drop Set ×3 без отдыха между вариантами: отжимания с ногами на возвышении → обычные → с колен'),
  ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-10-664246', 'Push Finisher ×3 раунда без отдыха между упр. (60 сек между): 10 отжиманий с весом, 10 обычных, 10 узких'),
  ('biceps-finisher-3-ganteli-10-rezinka-15-20-statika-20-sek', 'Biceps Finisher ×3: Гантели 10 → Резинка 15–20 → Статика 20 сек'),
  ('mechanical-drop-set-3-otzhimaniya-s-nogami-na-vozvyshenii-obychnye-s-ca5f16', 'Mechanical Drop Set ×3: отжимания с ногами на возвышении → обычные → с колен'),
  ('final-push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-10-9be91f', 'Final Push Finisher ×3 раунда без отдыха между упр. (60 сек между): 10 отжиманий с весом, 10 обычных, 10 узких'),
  ('final-biceps-finisher-3-podem-ganteley-10-bitseps-s-rezinkoy-15-20-d1fcec', 'Final Biceps Finisher ×3: Подъём гантелей 10 → Бицепс с резинкой 15–20 → Статика 20 сек'),
  ('final-leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-e3c240', 'Final Leg Finisher ×3: 10 Goblet Squat, 10 выпрыгиваний, 10 выпадов на ногу, 20 подъёмов на носки, отдых 45 сек'),
  ('final-full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-goblet-af9965', 'Final Full Body Circuit ×4: 5 подтягиваний, 10 отжиманий, 15 Goblet Squat, 10 выпадов на ногу, 20 Mountain Climbers, отдых 45–60 сек'),
  ('otzhimaniya-s-pauzoy-2-3-sek', 'Отжимания с паузой 2–3 сек'),
  ('final-drop-set-1-2-raunda-ne-dovodya-do-razrusheniya-tehniki-dc6295', 'Final Drop Set (1–2 раунда, не доводя до разрушения техники): отжимания с ногами на возвышении → обычные → с колен'),
  ('final-biceps-set-2-10-podemov-s-gantelyami-15-s-rezinkoy-20-sek-e700b6', 'Final Biceps Set ×2: 10 подъёмов с гантелями → 15 с резинкой → 20 сек статики'),
  ('final-leg-circuit-3-10-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-f2ab06', 'Final Leg Circuit ×3: 10 приседаний, 10 выпадов на ногу, 15 ягодичных мостов, 20 подъёмов на носки, отдых 60 сек'),
  ('zhim-ganteley', 'Жим гантелей'),
  ('bitseps', 'Бицепс'),
  ('tritseps-s-rezinkoy', 'Трицепс с резинкой'),
  ('final-circuit-3-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-6723d9', 'Final Circuit ×3: 5 подтягиваний, 10 отжиманий, 15 приседаний, 10 выпадов на ногу, 20 Mountain Climbers, отдых 60 сек'),
  ('finalnyy-test-goda-polnye-zamery-tela-ves-taliya-grud-plechi-bitseps-2130e6', '🏆 ФИНАЛЬНЫЙ ТЕСТ ГОДА: полные замеры тела (вес/талия/грудь/плечи/бицепс/предплечье/бедро/икры) + фото + силовые показатели, сравнить с месяцем 1 и месяцем 6')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Набор массы — Мужчины — Дома)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('nabor-massy-muzhchiny-doma', 'Набор массы для мужчин (дома) — годовая программа', 'Набор массы для мужчин (дома) — годовая программа. Оборудование: Гантели, резинки, турник (по возможности), стул/скамья, коврик', 'build_muscle', 'male', 'home', 'intermediate', 48, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + ПЛЕЧИ', 1, 'LEVEL 1 — START (недели 1–2)', 1, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-2-legkie-pryzhki-2-min-krugi-rukami-30-sek-otzhimaniya-ot-b32b51', 0, null::int, null::int, 60, 2, 'круг'),
    ('otzhimaniya-ot-pola-posl-podhod-maksimum-kachestvennyh', 10, 12, null::int, 90, 4, '12–20'),
    ('zhim-ganteley-lezha-na-polu-posl-3-povt-medlenno', 20, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 30, 10, null::int, 90, 3, '10–15'),
    ('razvedenie-ganteley-lezha-na-polu-opuskanie-3-sek', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-s-gantelyu-iz-za-golovy', 50, 12, null::int, 90, 3, '12–15'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('podem-ganteley-pered-soboy', 70, 15, null::int, 90, 2, '15'),
    ('finisher-otzhimaniya-20-sek-rabota-20-sek-otdyh-5', 80, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 2, 'LEVEL 1 — START (недели 1–2)', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-obychnym-hvatom-ili-negativnye-5-8-povt-opuskanie-3-5-021435', 0, 6, null::int, 90, 4, '6–10'),
    ('tyaga-ganteley-v-naklone', 10, 12, null::int, 90, 4, '12'),
    ('tyaga-odnoy-ganteli-k-poyasu', 20, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-rezinki-k-zhivotu', 30, 15, null::int, 90, 3, '15'),
    ('razvedenie-rezinki-pered-soboy-zadnyaya-delta-verh-spiny', 40, 15, null::int, 90, 3, '15'),
    ('podem-ganteley-na-bitseps', 50, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 90, 3, '12'),
    ('finisher-tyaga-rezinki-k-poyasu-30-sek-rabota-20-sek-otdyh-5', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · НОГИ + ПЛЕЧИ', 3, 'LEVEL 1 — START (недели 1–2)', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-s-gantelyu', 0, 15, null::int, 90, 4, '15'),
    ('vypady-nazad', 10, 12, null::int, 90, 3, '12 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami-opuskanie-3-sek', 20, 12, null::int, 90, 4, '12'),
    ('yagodichnyy-most-s-gantelyu-fiksatsiya-2-sek-vverhu', 30, 15, null::int, 90, 4, '15'),
    ('podemy-na-noski-s-gantelyami-posl-podhod-do-zhzheniya', 40, 20, null::int, 90, 4, '20'),
    ('zhim-ganteley-vverh', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('finisher-nog-3-20-prisedaniy-10-vyprygivaniy-20-sek-otdyh', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 3, День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii', 0, 10, null::int, 90, 4, '10–15'),
    ('zhim-ganteley-na-polu-posl-2-povt-medlenno', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-s-shirokoy-postanovkoy', 20, 15, null::int, 90, 3, '15'),
    ('razvedenie-ganteley', 30, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-uzkim-hvatom-lezha', 40, 12, null::int, 90, 3, '12'),
    ('frantsuzskiy-zhim-s-odnoy-gantelyu', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony-drop-set-na-posl-podhode-snizit-ves-10-povt', 60, 12, null::int, 90, 4, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 3, День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-obratnym-hvatom', 0, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-k-poyasu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-ganteli-odnoy-rukoy', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-rezinki-sverhu-vniz', 30, 15, null::int, 90, 3, '15'),
    ('staticheskoe-uderzhanie-ganteley-v-polozhenii-tyagi', 40, null::int, 30, 90, 3, '30 сек'),
    ('podem-ganteley-na-bitseps-s-supinatsiey', 50, 10, null::int, 90, 3, '10'),
    ('molotki-posl-podhod-10-chastichnyh-povtoreniy', 60, 12, null::int, 90, 3, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 3, День 3 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskie-vypady', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('yagodichnyy-most-posl-povt-kazhdogo-podhoda-10-sek-uderzhanie-sverhu', 30, 12, null::int, 90, 4, '12'),
    ('podem-na-noski', 40, 20, null::int, 90, 4, '20'),
    ('zhim-ganteley-sidya', 50, 10, null::int, 90, 4, '10'),
    ('mahi-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('zadnyaya-delta-v-naklone', 70, 15, null::int, 90, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 1 — PUSH · PUSH (полная смена упражнений)', 4, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-pauzoy-vnizu-2-sek', 0, 10, null::int, 90, 4, '10–15'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-almaz', 20, 8, null::int, 90, 3, '8–12'),
    ('pulover-s-gantelyu-lezha', 30, 12, null::int, 90, 3, '12'),
    ('razgibanie-ruk-s-rezinkoy', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-arnolda', 50, 10, null::int, 90, 3, '10'),
    ('mahi-v-storony', 60, 15, null::int, 90, 3, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 2 — PULL · PULL', 5, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-rezinki-k-grudi', 30, 15, null::int, 90, 3, '15'),
    ('face-pull-s-rezinkoy', 40, 15, null::int, 90, 3, '15'),
    ('kontsentrirovannyy-podem-ganteli', 50, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 90, 3, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 3 — НОГИ + ATHLETIC · НОГИ + ATHLETIC', 6, 'LEVEL UP — Неделя 3 (новая механика) + LEVEL 1 BOSS — Неделя 4', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-s-gantelyu', 0, 15, null::int, 90, 4, '15'),
    ('vypady-v-hodbe', 10, 12, null::int, 90, 3, '12+12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 3, '10+10'),
    ('yagodichnyy-most', 30, 15, null::int, 90, 4, '15'),
    ('bolgarskie-vypady', 40, 10, null::int, 90, 3, '10+10'),
    ('ikry', 50, 20, null::int, 90, 4, '20'),
    ('athletic-finisher-3-10-prisedaniy-s-vyprygivaniem-10-otzhimaniy-20-31a24a', 60, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 2 — OVERLOAD, недели 5–6', 3, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii-posl-podhod-do-otkaza', 0, 12, null::int, 90, 4, '12–15'),
    ('zhim-ganteley-lezha-na-polu-posl-2-povt-medlenno', 10, 10, null::int, 90, 4, '10–12'),
    ('zhim-ganteley-lezha-uzkim-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('pulover-s-gantelyu', 30, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-sidya', 40, 10, null::int, 90, 4, '10–12'),
    ('mahi-gantelyami-v-storony-drop-set-na-posl-podhode', 50, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-ruk-s-rezinkoy-vniz', 60, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-s-gantelyu', 70, 12, null::int, 90, 3, '12'),
    ('finisher-otzhimaniya-30-sek-rabota-30-sek-otdyh-4', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 2 — OVERLOAD, недели 5–6', 3, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-obratnym-hvatom-ili-negativnye-5-5', 0, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-v-naklone', 10, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteli-odnoy-rukoy-s-oporoy', 20, 10, null::int, 90, 4, '10–12 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 30, 15, null::int, 90, 3, '15'),
    ('face-pull-s-rezinkoy', 40, 15, null::int, 90, 3, '15'),
    ('podem-ganteley-na-bitseps-s-supinatsiey', 50, 10, null::int, 90, 4, '10–12'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 90, 3, '12'),
    ('kontsentrirovannyy-podem-ganteli', 70, 15, null::int, 90, 2, '15'),
    ('finisher-tyaga-rezinki-40-sek-rabota-20-sek-otdyh-4', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 2 — OVERLOAD, недели 5–6', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 12, null::int, 90, 4, '12–15'),
    ('bolgarskie-vypady', 10, 10, null::int, 90, 4, '10–12 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10–12'),
    ('yagodichnyy-most-s-vesom-fiksatsiya-2-sek-vverhu', 30, 12, null::int, 90, 4, '12–15'),
    ('vypady-nazad-s-gantelyami', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-lezha-s-rezinkoy', 50, 15, null::int, 90, 3, '15'),
    ('podem-na-noski-s-vesom', 60, 20, null::int, 90, 4, '20'),
    ('finisher-3-15-prisedaniy-10-vypadov-na-nogu-20-podemov-na-noski-otdyh-5462ab', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + ATHLETIC', 4, 'LEVEL 2 — OVERLOAD, недели 5–6', 3, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya', 0, 15, null::int, 90, 3, '15–20'),
    ('tyaga-ganteley-v-naklone', 10, 12, null::int, 90, 3, '12'),
    ('prisedaniya-s-gantelyu', 20, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-vverh', 30, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 40, 12, null::int, 90, 3, '12'),
    ('razgibanie-ruk-s-rezinkoy', 50, 15, null::int, 90, 3, '15'),
    ('athletic-circuit-4-10-prisedaniy-s-vyprygivaniem-10-otzhimaniy-20-69cca1', 60, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL UP — недели 7–8', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-uzkoy-postanovkoy', 0, 12, null::int, 90, 4, '12–15'),
    ('otzhimaniya-s-shirokoy-postanovkoy', 10, 15, null::int, 90, 3, '15–20'),
    ('zhim-ganteley-s-pola-neytralnym-hvatom-5-k-nedelyam-5-6', 20, 8, null::int, 90, 4, '8–12'),
    ('razvedenie-ganteley-lezha', 30, 12, null::int, 90, 3, '12'),
    ('zhim-arnolda', 40, 10, null::int, 90, 4, '10'),
    ('mahi-gantelyami-v-storony', 50, 15, null::int, 90, 3, '15'),
    ('razgibanie-ganteli-iz-za-golovy', 60, 12, null::int, 90, 3, '12'),
    ('otzhimaniya-ot-skami-nazad', 70, 12, null::int, 90, 3, '12–15'),
    ('finisher-mechanical-drop-set-bez-otdyha-otzhimaniya-s-nogami-na-435578', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL UP — недели 7–8', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('podtyagivaniya-neytralnym-hvatom', 10, 6, null::int, 90, 3, '6–10'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-odnoy-ganteli-k-tazu', 30, 12, null::int, 90, 3, '12'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15'),
    ('bitseps-s-rezinkoy', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-staticheskoe-uderzhanie-ganteley-v-polozhenii-sgibaniya-30-781e15', 80, null::int, null::int, 30, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ', 3, 'LEVEL UP — недели 7–8', 4, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-s-dvumya-gantelyami', 0, 12, null::int, 90, 4, '12'),
    ('bolgarskie-vypady', 10, 12, null::int, 90, 3, '12 на ногу'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('sumo-prised-s-gantelyu', 30, 15, null::int, 90, 4, '15'),
    ('yagodichnyy-most-s-pauzoy-3-sek-sverhu', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('ikry-stoya-na-odnoy-noge', 60, 15, null::int, 90, 4, '15 на ногу'),
    ('finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-otdyh-45-345ce3', 70, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · CALISTHENICS + FULL BODY', 4, 'LEVEL UP — недели 7–8', 4, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii', 0, 10, null::int, 90, 4, '10–15'),
    ('pike-push-ups', 10, 8, null::int, 90, 4, '8–12'),
    ('podtyagivaniya', 20, null::int, null::int, 90, 4, 'макс.'),
    ('avstraliyskie-podtyagivaniya-ili-tyaga-rezinki-bez-turnika', 30, 12, null::int, 90, 4, '12–15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('finisher-5-10-otzhimaniy-10-prisedaniy-10-mountain-climbers-na-dfe318', 60, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 3 — MUSCLE SHOCK, недели 9–10', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-pauzoy-vnizu-2-sek', 0, 10, null::int, 90, 4, '10–15'),
    ('zhim-ganteley-lezha-na-polu-tyazhelyy-rabochiy-ves', 10, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-s-neytralnym-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha-opuskanie-3-sek', 30, 12, null::int, 90, 3, '12–15'),
    ('pike-push-ups', 40, 8, null::int, 90, 4, '8–12'),
    ('mahi-gantelyami-v-storony-drop-set', 50, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-ganteli-iz-za-golovy-dvumya-rukami', 60, 10, null::int, 90, 3, '10–12'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('finisher-otzhimaniya-20-sek-rabota-10-sek-otdyh-6', 80, null::int, null::int, 60, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 3 — MUSCLE SHOCK, недели 9–10', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, 6, null::int, 90, 4, '6–10'),
    ('podtyagivaniya-obratnym-hvatom', 10, 6, null::int, 90, 3, '6–10'),
    ('tyaga-ganteley-k-poyasu-s-pauzoy-2-sek', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-odnoy-ganteli-k-tazu', 30, 12, null::int, 90, 3, '12 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 3, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 10, null::int, 90, 4, '10–12'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-uderzhanie-ganteley-na-bitseps-3-30-sek-otdyh-30-sek', 80, null::int, null::int, 30, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 3 — MUSCLE SHOCK, недели 9–10', 5, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-goblet-squat', 0, 12, null::int, 90, 4, '12'),
    ('bolgarskie-vypady-s-gantelyami', 10, 10, null::int, 90, 4, '10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised-s-gantelyu', 30, 15, null::int, 90, 3, '15'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek-sverhu', 40, 12, null::int, 90, 4, '12'),
    ('vypady-nazad', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('ikry-na-odnoy-noge', 60, 15, null::int, 90, 4, '15–20'),
    ('finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-sek-5cf187', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + CALISTHENICS', 4, 'LEVEL 3 — MUSCLE SHOCK, недели 9–10', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 10, null::int, 90, 4, '10–15'),
    ('pike-push-ups', 20, 10, null::int, 90, 3, '10'),
    ('avstraliyskie-podtyagivaniya', 30, 12, null::int, 90, 4, '12–15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('level-3-circuit-4-10-podtyagivaniy-15-otzhimaniy-20-prisedaniy-10-744af7', 60, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · PUSH SHOCK', 1, 'LEVEL UP — недели 11–12', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii', 0, 8, null::int, 90, 5, '8–12'),
    ('zhim-ganteley-lezha-na-polu-5-k-nedelyam-9-10', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-uzkoy-postanovkoy', 20, 10, null::int, 90, 3, '10–15'),
    ('pulover-s-gantelyu', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-sidya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 50, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-s-gantelyu-iz-za-golovy', 60, 12, null::int, 90, 3, '12'),
    ('mehanicheskiy-drop-set-1-podhod-bez-otdyha-otzhimaniya-s-nogami-na-d760a4', 70, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · PULL SHOCK', 2, 'LEVEL UP — недели 11–12', 6, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-obratnym-hvatom', 0, 6, null::int, 90, 5, '6–10'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-dvuh-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 40, 15, null::int, 90, 3, '15'),
    ('face-pull', 50, 15, null::int, 90, 3, '15'),
    ('bitseps-s-gantelyami-s-supinatsiey', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10'),
    ('finisher-statika-na-bitseps-3-40-sek-otdyh-30-sek', 80, null::int, null::int, 30, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG SHOCK', 3, 'LEVEL UP — недели 11–12', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskie-vypady', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-posl-podhod-drop-set', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga', 20, 8, null::int, 90, 4, '8–10'),
    ('sumo-prised', 30, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most-posl-10-sek-statika', 40, 15, null::int, 90, 4, '15'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('ikry', 60, 20, null::int, 90, 4, '20'),
    ('finisher-3-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-30-sek-90a9a5', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · CALISTHENICS + FULL BODY', 4, 'LEVEL UP — недели 11–12', 6, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 10, null::int, 90, 4, '10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('prisedaniya-s-gantelyu', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('athletic-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-ac10e7', 60, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + ПЛЕЧИ', 1, 'LEVEL 4 — STRENGTH & MASS, недели 13–14', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom-ili-medlennoe-opuskanie-4-sek', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-lezha-na-polu-tyazhelyy-rabochiy', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-uzkoy-postanovkoy', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-lezha-s-pauzoy-2-sek-vnizu', 30, 10, null::int, 90, 3, '10'),
    ('zhim-ganteley-stoya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-drop-set', 50, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-ruk-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-mechanical-drop-set-1-krug-bez-otdyha-otzhimaniya-s-vesom-fbf53c', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 4 — STRENGTH & MASS, недели 13–14', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-neytralnym-hvatom', 0, 6, null::int, 90, 5, '6–10'),
    ('tyaga-ganteley-k-poyasu-pauza-2-sek-sverhu', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-s-oporoy', 20, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-rezinki-k-poyasu-sidya', 30, 12, null::int, 90, 4, '12–15'),
    ('pulover-s-rezinkoy', 40, 15, null::int, 90, 3, '15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 3, '15–20'),
    ('bitseps-s-gantelyami-na-naklonnoy-poverhnosti', 60, 10, null::int, 90, 4, '10–12'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10'),
    ('finisher-staticheskoe-uderzhanie-ganteley-na-bitseps-3-40-sek-otdyh-89af7e', 80, null::int, null::int, 30, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 4 — STRENGTH & MASS, недели 13–14', 7, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-s-dvumya-gantelyami', 0, 10, null::int, 90, 4, '10–12'),
    ('bolgarskie-vypady-tyazhelyy-ves', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 4, '8–10'),
    ('yagodichnyy-most-s-dop-vesom-pauza-3-sek', 30, 12, null::int, 90, 4, '12'),
    ('vypady-nazad', 40, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-s-rezinkoy-lezha', 50, 15, null::int, 90, 3, '15'),
    ('podemy-na-noski-stoya-s-vesom-posl-do-zhzheniya', 60, 15, null::int, 90, 4, '15–20'),
    ('finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-otdyh-45-345ce3', 70, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY POWER', 4, 'LEVEL 4 — STRENGTH & MASS, недели 13–14', 7, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('goblet-squat', 20, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 30, 10, null::int, 90, 3, '10'),
    ('pike-push-ups', 40, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 50, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 90, 3, '12'),
    ('power-circuit-4-8-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-eda379', 70, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · CHEST & SHOULDERS SHOCK', 1, 'LEVEL UP — недели 15–16', 8, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-uzkoy-postanovkoy-ves', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-ganteley-s-pola-poperemenno', 10, 8, null::int, 90, 4, '8+8 на руку'),
    ('otzhimaniya-s-shirokoy-postanovkoy', 20, 15, null::int, 90, 3, '15'),
    ('pulover-s-gantelyu', 30, 10, null::int, 90, 4, '10–12'),
    ('zhim-arnolda', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-sidya', 50, 15, null::int, 90, 3, '15'),
    ('razvedenie-ganteley-v-naklone', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-s-gantelyu-iz-za-golovy', 70, 12, null::int, 90, 3, '12'),
    ('finisher-otzhimaniya-15-sek-rabota-15-sek-otdyh-8', 80, null::int, null::int, 60, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK & ARMS SHOCK', 2, 'LEVEL UP — недели 15–16', 8, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, 6, null::int, 90, 5, '6–10'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-ganteli-k-tazu', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 40, 15, null::int, 90, 4, '15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem-ganteli', 60, 10, null::int, 90, 3, '10 на руку'),
    ('bitseps-s-rezinkoy', 70, 15, null::int, 90, 3, '15'),
    ('finisher-bitseps-20-sek-rabota-10-sek-otdyh-6', 80, null::int, null::int, 60, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG MASS', 3, 'LEVEL UP — недели 15–16', 8, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-s-pauzoy-2-sek-vnizu', 0, 10, null::int, 90, 5, '10'),
    ('rumynskaya-tyaga-na-odnoy-noge', 10, 10, null::int, 90, 4, '10 на ногу'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised-s-gantelyu', 30, 12, null::int, 90, 4, '12'),
    ('yagodichnyy-most-na-odnoy-noge', 40, 12, null::int, 90, 3, '12 на ногу'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('ikry-na-odnoy-noge', 60, 15, null::int, 90, 4, '15'),
    ('finisher-4-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-otdyh-45-02520c', 70, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · CALISTHENICS LEVEL', 4, 'LEVEL UP — недели 15–16', 8, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-pauzoy-2-sek-sverhu', 0, 5, null::int, 90, 5, '5–8'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('prisedaniya-na-odnoy-noge-do-vysokoy-opory-ne-teryat-kontrol', 40, 8, null::int, 90, 3, '8 на ногу'),
    ('rumynskaya-tyaga-na-odnoy-noge', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('planka-s-perenosom-vesa', 60, null::int, 45, 90, 3, '45 сек'),
    ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-967088', 70, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + ПЛЕЧИ', 1, 'LEVEL 5 — MUSCLE OVERLOAD, недели 17–18', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom-posl-podhod-do-otkaza', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-lezha-na-polu-posl-2-povt-medlenno', 10, 8, null::int, 90, 5, '8–10'),
    ('zhim-ganteley-s-pauzoy-2-sek-vnizu', 20, 10, null::int, 90, 3, '10'),
    ('razvedenie-ganteley-lezha-opuskanie-3-sek', 30, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-nad-golovoy-stoya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-drop-set', 50, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-ruk-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim-s-odnoy-gantelyu', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-chest-burn-otzhimaniya-15-sek-rabota-15-sek-otdyh-8', 80, null::int, null::int, 60, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 5 — MUSCLE OVERLOAD, недели 17–18', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, 6, null::int, 90, 5, '6–10'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-tazu', 30, 10, null::int, 90, 4, '10 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps-s-supinatsiey', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-biceps-hold-sgibanie-ruk-s-gantelyami-30-sek-rabota-20-sek-3543e8', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 5 — MUSCLE OVERLOAD, недели 17–18', 9, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-posl-podhod-drop-set', 0, 10, null::int, 90, 5, '10–12'),
    ('bolgarskie-vypady-tyazhelyy-ves', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 4, '8–10'),
    ('sumo-prised-s-gantelyu', 30, 12, null::int, 90, 3, '12–15'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 12, null::int, 90, 4, '12'),
    ('vypady-nazad', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('ikry-stoya-s-vesom-posl-20-sek-statiki', 60, 15, null::int, 90, 4, '15–20'),
    ('leg-finisher-3-15-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-3be6dd', 70, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY + ATHLETIC', 4, 'LEVEL 5 — MUSCLE OVERLOAD, недели 17–18', 9, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 10, null::int, 90, 4, '10–12'),
    ('goblet-squat', 20, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 30, 10, null::int, 90, 3, '10'),
    ('pike-push-ups', 40, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-k-poyasu', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('athletic-circuit-4-8-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-33401c', 70, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · PUSH SHOCK', 1, 'LEVEL UP — недели 19–20', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii-ves', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-shirokoy-postanovkoy', 20, 12, null::int, 90, 3, '12–15'),
    ('pulover-s-gantelyu', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-arnolda', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-sidya', 50, 15, null::int, 90, 3, '15'),
    ('razvedenie-ganteley-v-naklone', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-s-gantelyu-iz-za-golovy', 70, 12, null::int, 90, 3, '12'),
    ('mechanical-drop-set-1-krug-bez-otdyha-do-otkaza-v-kazhdom-variante-eba21d', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · PULL SHOCK', 2, 'LEVEL UP — недели 19–20', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-pauzoy-sverhu-2-sek', 0, 5, null::int, 90, 5, '5–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-protivopolozhnomu-tazu', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 40, 15, null::int, 90, 4, '15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem-ganteli', 60, 10, null::int, 90, 3, '10 на руку'),
    ('bitseps-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('finisher-bitseps-s-rezinkoy-20-sek-rabota-10-sek-otdyh-8', 80, null::int, null::int, 60, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG SHOCK', 3, 'LEVEL UP — недели 19–20', 10, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised-s-peredney-nogoy-na-vozvyshenii', 0, 8, null::int, 90, 4, '8–10 на ногу'),
    ('goblet-squat-s-pauzoy-3-sek-vnizu', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised-s-pauzoy', 30, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most-na-odnoy-noge-3-sek-verhnyaya-tochka', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('ikry-na-odnoy-noge', 60, 15, null::int, 90, 4, '15–20'),
    ('leg-boss-4-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-20-12be6c', 70, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · CALISTHENICS + FULL BODY', 4, 'LEVEL UP — недели 19–20', 10, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga-na-odnoy-noge', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-e58302', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 6 — HYPERTROPHY SHOCK, недели 21–22', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom-posl-podhod-do-otkaza', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-neytralnym-hvatom-pauza-1-sek-vnizu', 20, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 30, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-stoya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-drop-set', 50, 12, null::int, 90, 4, '12–15'),
    ('razgibanie-ruk-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-push-burn-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-f1afee', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 6 — HYPERTROPHY SHOCK, недели 21–22', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 5, '6–10'),
    ('podtyagivaniya-obratnym-hvatom', 10, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-poyasu', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 40, 12, null::int, 90, 4, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 3, '15–20'),
    ('podem-ganteley-na-bitseps-s-supinatsiey', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('finisher-biceps-shock-sgibanie-s-rezinkoy-30-sek-rabota-15-sek-otdyh-6', 80, null::int, null::int, 60, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 6 — HYPERTROPHY SHOCK, недели 21–22', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-posl-drop-set', 0, 10, null::int, 90, 5, '10–12'),
    ('bolgarskie-vypady', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 4, '8–10'),
    ('sumo-prised-s-gantelyu', 30, 10, null::int, 90, 4, '10–12'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('vypady-nazad-s-gantelyami', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-stoya-s-vesom', 70, 15, null::int, 90, 4, '15–20'),
    ('leg-finisher-3-12-prisedaniy-10-vyprygivaniy-10-vypadov-na-nogu-20-fd102b', 80, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY MASS', 4, 'LEVEL 6 — HYPERTROPHY SHOCK, недели 21–22', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('goblet-squat', 20, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 30, 10, null::int, 90, 4, '10'),
    ('pike-push-ups', 40, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-4-6-podtyagivaniy-12-otzhimaniy-15-goblet-squat-10-f93972', 80, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · CHEST & SHOULDERS OVERLOAD', 1, 'HYPERTROPHY OVERLOAD — недели 23–24', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley', 30, 15, null::int, 90, 3, '15'),
    ('zhim-arnolda', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 50, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('superset-3-mahi-v-storony-12-15-otzhimaniya-do-tehnicheskogo-otkaza', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK & BICEPS OVERLOAD', 2, 'HYPERTROPHY OVERLOAD — недели 23–24', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, 6, null::int, 90, 5, '6–10'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-ganteley-s-pauzoy', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 10, null::int, 90, 4, '10'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('superset-3-bitseps-s-gantelyami-10-bitseps-s-rezinkoy-15-20', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG MASS OVERLOAD', 3, 'HYPERTROPHY OVERLOAD — недели 23–24', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-s-pauzoy-2-3-sek', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised', 30, 12, null::int, 90, 4, '12–15'),
    ('yagodichnyy-most-posl-do-tehnicheskogo-otkaza', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry', 70, 20, null::int, 90, 4, '20'),
    ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY SHOCK', 4, 'HYPERTROPHY OVERLOAD — недели 23–24', 12, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 10, null::int, 90, 4, '10'),
    ('pike-push-ups', 20, 10, null::int, 90, 4, '10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-vypadov-1c081b', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 7 — STRENGTH + MASS, недели 25–26', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom-na-spine-posl-podhod-do-otkaza', 0, 6, null::int, 90, 5, '6–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 20, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-sidya', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-drop-set', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 60, 10, null::int, 90, 4, '10–12'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-raundami-d9ed68', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 7 — STRENGTH + MASS, недели 25–26', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-shirokim-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-ganteley-k-poyasu-s-pauzoy-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-poyasu', 30, 10, null::int, 90, 4, '10 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12'),
    ('tyaga-rezinki-k-litsu', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps-stoya', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('biceps-finisher-sgibanie-s-rezinkoy-30-sek-rabota-15-sek-otdyh-6', 80, null::int, null::int, 60, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 7 — STRENGTH + MASS, недели 25–26', 13, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-s-tyazheloy-gantelyu-posl-drop-set', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised-s-gantelyu', 50, 12, null::int, 90, 3, '12'),
    ('ikry-stoya-s-vesom-posl-20-sek-statiki-2', 60, 15, null::int, 90, 5, '15–20'),
    ('leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-nogu-20-2f0ce1', 70, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · CALISTHENICS + FULL BODY', 4, 'LEVEL 7 — STRENGTH + MASS, недели 25–26', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('avstraliyskie-podtyagivaniya', 30, 12, null::int, 90, 4, '12–15'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 50, 10, null::int, 90, 3, '10 на ногу'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-boss-4-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-a65dee', 80, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · PUSH POWER', 1, 'LEVEL UP — POWER + HYPERTROPHY, недели 27–28', 14, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-nogami-na-vozvyshenii-ves', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-s-neytralnym-hvatom', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-v-nizhney-tochke-2-sek', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-arnolda', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony-sidya', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-lezha', 50, 12, null::int, 90, 3, '12–15'),
    ('razgibanie-odnoy-ruki-s-rezinkoy', 60, 12, null::int, 90, 3, '12–15 на руку'),
    ('otzhimaniya-uzkim-hvatom', 70, null::int, null::int, 90, 3, 'максимум'),
    ('mechanical-drop-set-3-raunda-bez-otdyha-otzhimaniya-s-nogami-na-d5d3e7', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · PULL POWER', 2, 'LEVEL UP — POWER + HYPERTROPHY, недели 27–28', 14, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-pauzoy-sverhu-2-sek', 0, 5, null::int, 90, 5, '5–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-protivopolozhnomu-tazu', 30, 10, null::int, 90, 3, '10 на руку'),
    ('tyaga-rezinki-sverhu-vniz', 40, 15, null::int, 90, 4, '15'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('kontsentrirovannyy-podem-ganteli', 60, 10, null::int, 90, 3, '10 на руку'),
    ('molotkovye-sgibaniya-s-pauzoy', 70, 10, null::int, 90, 3, '10–12'),
    ('biceps-shock-3-bitseps-s-gantelyu-10-bitseps-s-rezinkoy-15-statika-20-f0c375', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG POWER', 3, 'LEVEL UP — POWER + HYPERTROPHY, недели 27–28', 14, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised-s-peredney-nogoy-na-vozvyshenii', 0, 8, null::int, 90, 4, '8–10 на ногу'),
    ('goblet-squat-s-pauzoy-3-sek-vnizu', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 8, null::int, 90, 4, '8–10 на ногу'),
    ('sumo-prised-s-pauzoy', 30, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most-na-odnoy-noge-pauza-3-sek', 40, 10, null::int, 90, 4, '10 на ногу'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-na-odnoy-noge', 70, 15, null::int, 90, 4, '15–20'),
    ('leg-boss-4-10-vyprygivaniy-15-prisedaniy-10-vypadov-na-nogu-20-12be6c', 80, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ATHLETIC FULL BODY', 4, 'LEVEL UP — POWER + HYPERTROPHY, недели 27–28', 14, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('vzryvnye-otzhimaniya', 10, 6, null::int, 90, 4, '6–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-goblet-squat-42c583', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 8 — MUSCLE DENSITY, недели 29–30', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom-posl-do-otkaza', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, 10, null::int, 90, 3, '10–12'),
    ('razvedenie-ganteley-lezha', 30, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-sidya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 50, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 60, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 70, 10, null::int, 90, 3, '10–12'),
    ('superset-3-otdyh-60-sek-mahi-v-storony-15-otzhimaniya-do-3bed3a', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 8 — MUSCLE DENSITY, недели 29–30', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-poyasu', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('superset-3-podem-na-bitseps-10-molotkovye-sgibaniya-10-statika-90-20-56e504', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 8 — MUSCLE DENSITY, недели 29–30', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-tyazhelyy-ves', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-vesom', 70, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-otdyh-60-sek-goblet-squat-12-vyprygivaniya-10', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY MASS', 4, 'LEVEL 8 — MUSCLE DENSITY, недели 29–30', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 50, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-density-circuit-5-5-podtyagivaniy-10-otzhimaniy-15-goblet-222fa0', 80, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · PUSH OVERLOAD', 1, 'DENSITY OVERLOAD — недели 31–32', 16, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-2-sek-vnizu', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-arnolda', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim', 60, 10, null::int, 90, 3, '10–12'),
    ('push-drop-set-1-krug-bez-otdyha-3-raunda-otzhimaniya-s-nogami-na-8ae836', 70, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · PULL OVERLOAD', 2, 'DENSITY OVERLOAD — недели 31–32', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 5, '6–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('pulover', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem-ganteli', 60, 10, null::int, 90, 3, '10 на руку'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('biceps-drop-set-3-gantel-10-rezinka-15-20-statika-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG OVERLOAD', 3, 'DENSITY OVERLOAD — недели 31–32', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-s-pauzoy-3-sek', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised', 30, 12, null::int, 90, 4, '12'),
    ('yagodichnyy-most-s-vesom', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry', 70, 20, null::int, 90, 4, '20'),
    ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ATHLETIC MASS', 4, 'DENSITY OVERLOAD — недели 31–32', 16, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('vzryvnye-otzhimaniya', 10, 6, null::int, 90, 4, '6–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-prisedaniy-84c10b', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 9 — ADVANCED HYPERTROPHY, недели 33–34', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom', 0, 6, null::int, 90, 5, '6–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-uzkim-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-nad-golovoy', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 50, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 60, 15, null::int, 90, 3, '15'),
    ('frantsuzskiy-zhim', 70, 10, null::int, 90, 3, '10–12'),
    ('superset-3-mahi-v-storony-15-otzhimaniya-do-tehnicheskogo-otkaza', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 9 — ADVANCED HYPERTROPHY, недели 33–34', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli-k-poyasu', 30, 10, null::int, 90, 4, '10 на руку'),
    ('pulover', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('biceps-superset-3-bitseps-s-gantelyami-10-bitseps-s-rezinkoy-15-165b50', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 9 — ADVANCED HYPERTROPHY, недели 33–34', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga', 20, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12–15'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-vesom', 70, 15, null::int, 90, 4, '15–20'),
    ('leg-superset-3-goblet-squat-12-vyprygivaniya-10', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY POWER', 4, 'LEVEL 9 — ADVANCED HYPERTROPHY, недели 33–34', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 10, 8, null::int, 90, 4, '8–12'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley', 30, 10, null::int, 90, 4, '10'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 50, 10, null::int, 90, 3, '10'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-0e7428', 80, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · CHEST SHOCK', 1, 'ADVANCED OVERLOAD — недели 35–36', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-3-sek', 20, 10, null::int, 90, 3, '10'),
    ('razvedenie-ganteley', 30, 15, null::int, 90, 3, '15'),
    ('zhim-arnolda', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 50, 15, null::int, 90, 4, '15'),
    ('razvedenie-v-naklone', 60, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim', 70, 12, null::int, 90, 3, '12'),
    ('mechanical-drop-set-3-otzhimaniya-s-nogami-vyshe-obychnye-s-kolen', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK SHOCK', 2, 'ADVANCED OVERLOAD — недели 35–36', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 5, '6–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10–12'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem', 60, 10, null::int, 90, 3, '10'),
    ('molotki', 70, 12, null::int, 90, 3, '12'),
    ('biceps-drop-set-3-gantel-10-rezinka-15-20-statika-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG SHOCK', 3, 'ADVANCED OVERLOAD — недели 35–36', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-s-pauzoy', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised', 30, 12, null::int, 90, 4, '12'),
    ('yagodichnyy-most', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry', 70, 20, null::int, 90, 4, '20'),
    ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY SHOCK', 4, 'ADVANCED OVERLOAD — недели 35–36', 18, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('vzryvnye-otzhimaniya', 10, 6, null::int, 90, 4, '6–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-prisedaniy-84c10b', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 10 — PEAK MASS, недели 37–38', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom-tyazhelyy-rabochiy', 0, 6, null::int, 90, 5, '6–8'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 6, null::int, 90, 5, '6–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, 8, null::int, 90, 3, '8–12'),
    ('zhim-ganteley-nad-golovoy', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 60, 10, null::int, 90, 4, '10–12'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-raundami-8-7f1fe6', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 10 — PEAK MASS, недели 37–38', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-obratnym-hvatom', 10, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 8, null::int, 90, 4, '8–10 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('biceps-finisher-3-ganteli-10-rezinka-15-20-statika-na-90-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 10 — PEAK MASS, недели 37–38', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-tyazhelyy', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-tyazhelym-vesom-pauza-3-sek', 40, 8, null::int, 90, 4, '8–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-vesom', 70, 15, null::int, 90, 5, '15–20'),
    ('leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-nogu-20-2f0ce1', 80, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY MASS', 4, 'LEVEL 10 — PEAK MASS, недели 37–38', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 4, '8–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 50, 10, null::int, 90, 3, '10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-goblet-squat-10-ef247b', 80, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · CHEST & SHOULDERS SHOCK', 1, 'PEAK HYPERTROPHY — недели 39–40', 20, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-3-sek-vnizu', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-arnolda', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim', 60, 10, null::int, 90, 3, '10–12'),
    ('mechanical-drop-set-3-bez-otdyha-mezhdu-variantami-otzhimaniya-s-e3a9da', 70, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK & BICEPS SHOCK', 2, 'PEAK HYPERTROPHY — недели 39–40', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 5, '6–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10–12 на руку'),
    ('pulover', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem-ganteli', 60, 10, null::int, 90, 3, '10 на руку'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('biceps-drop-set-3-gantel-10-rezinka-15-20-statika-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG MASS SHOCK', 3, 'PEAK HYPERTROPHY — недели 39–40', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-s-pauzoy-3-sek', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised', 30, 12, null::int, 90, 4, '12–15'),
    ('yagodichnyy-most-posl-do-tehnicheskogo-otkaza', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry', 70, 20, null::int, 90, 4, '20'),
    ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY PEAK', 4, 'PEAK HYPERTROPHY — недели 39–40', 20, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('vzryvnye-otzhimaniya', 10, 6, null::int, 90, 4, '6–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-prisedaniy-84c10b', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 11 — MAXIMUM MUSCLE, недели 41–42', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom', 0, 6, null::int, 90, 5, '6–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-nad-golovoy', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim-odnoy-gantelyu', 60, 10, null::int, 90, 4, '10–12'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-10-664246', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 11 — MAXIMUM MUSCLE, недели 41–42', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-obratnym-hvatom', 10, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('biceps-finisher-3-ganteli-10-rezinka-15-20-statika-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 11 — MAXIMUM MUSCLE, недели 41–42', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-vesom', 70, 15, null::int, 90, 5, '15–20'),
    ('leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-nogu-20-2f0ce1', 80, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY MASS', 4, 'LEVEL 11 — MAXIMUM MUSCLE, недели 41–42', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 4, '8–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 50, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-goblet-squat-10-ef247b', 80, null::int, null::int, 45, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · CHEST SHOCK', 1, 'MAXIMUM OVERLOAD — недели 43–44', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 8, null::int, 90, 4, '8–12'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-3-sek', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-arnolda', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-v-naklone', 50, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim', 60, 10, null::int, 90, 3, '10–12'),
    ('mechanical-drop-set-3-otzhimaniya-s-nogami-na-vozvyshenii-obychnye-s-ca5f16', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK SHOCK', 2, 'MAXIMUM OVERLOAD — недели 43–44', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 5, '6–8'),
    ('negativnye-podtyagivaniya-opuskanie-5-sek', 10, 5, null::int, 90, 3, '5'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10–12'),
    ('pulover', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 20, null::int, 90, 3, '20'),
    ('kontsentrirovannyy-podem', 60, 10, null::int, 90, 3, '10 на руку'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('biceps-drop-set-3-gantel-10-rezinka-15-20-statika-20-sek', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEG SHOCK', 3, 'MAXIMUM OVERLOAD — недели 43–44', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bolgarskiy-split-prised', 0, 10, null::int, 90, 4, '10 на ногу'),
    ('goblet-squat-s-pauzoy-3-sek', 10, 10, null::int, 90, 4, '10–12'),
    ('rumynskaya-tyaga-na-odnoy-noge', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('sumo-prised', 30, 12, null::int, 90, 4, '12–15'),
    ('yagodichnyy-most', 40, 12, null::int, 90, 4, '12'),
    ('vypady-v-hodbe', 50, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry', 70, 20, null::int, 90, 4, '20'),
    ('leg-drop-set-bez-otdyha-goblet-squat-10-tyazhelyh-10-srednih-10-bez-ccb2f9', 80, null::int, null::int, 60, 1, 'дропсет')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY SHOCK', 4, 'MAXIMUM OVERLOAD — недели 43–44', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('vzryvnye-otzhimaniya', 10, 6, null::int, 90, 4, '6–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–10'),
    ('avstraliyskie-podtyagivaniya', 30, 15, null::int, 90, 4, '15'),
    ('goblet-squat', 40, 15, null::int, 90, 4, '15'),
    ('rumynskaya-tyaga', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('boss-circuit-5-5-podtyagivaniy-10-vzryvnyh-otzhimaniy-15-prisedaniy-84c10b', 70, null::int, null::int, 45, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL 12 — FINAL TRANSFORMATION, недели 45–46', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-dop-vesom', 0, 6, null::int, 90, 5, '6–10'),
    ('zhim-ganteley-lezha-na-polu-opuskanie-3-sek', 10, 8, null::int, 90, 5, '8–10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-nad-golovoy', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-gantelyami-v-storony', 40, 12, null::int, 90, 4, '12–15'),
    ('razvedenie-ganteley-v-naklone', 50, 15, null::int, 90, 3, '15–20'),
    ('frantsuzskiy-zhim', 60, 10, null::int, 90, 4, '10–12'),
    ('razgibanie-ruk-s-rezinkoy', 70, 15, null::int, 90, 3, '15–20'),
    ('final-push-finisher-3-raunda-bez-otdyha-mezhdu-upr-60-sek-mezhdu-10-9be91f', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · СПИНА + БИЦЕПС', 2, 'LEVEL 12 — FINAL TRANSFORMATION, недели 45–46', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('podtyagivaniya-obratnym-hvatom', 10, 6, null::int, 90, 4, '6–10'),
    ('tyaga-dvuh-ganteley-v-naklone-pauza-2-sek', 20, 8, null::int, 90, 5, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 4, '10 на руку'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull-s-rezinkoy', 50, 15, null::int, 90, 4, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 4, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('final-biceps-finisher-3-podem-ganteley-10-bitseps-s-rezinkoy-15-20-d1fcec', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL 12 — FINAL TRANSFORMATION, недели 45–46', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 8, null::int, 90, 5, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8–10 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 8, null::int, 90, 5, '8–10'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-3-sek', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15–20'),
    ('ikry-s-vesom', 70, 15, null::int, 90, 5, '15–20'),
    ('final-leg-finisher-3-10-goblet-squat-10-vyprygivaniy-10-vypadov-na-e3c240', 80, null::int, null::int, 45, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY FINAL', 4, 'LEVEL 12 — FINAL TRANSFORMATION, недели 45–46', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('otzhimaniya-s-dop-vesom', 10, 8, null::int, 90, 4, '8–10'),
    ('pike-push-ups', 20, 8, null::int, 90, 4, '8–12'),
    ('tyaga-ganteley-v-naklone', 30, 10, null::int, 90, 4, '10–12'),
    ('goblet-squat', 40, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 50, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('final-full-body-circuit-4-5-podtyagivaniy-10-otzhimaniy-15-goblet-af9965', 80, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · FINAL PUSH', 1, 'FINAL BOSS, недели 47–48 + ФИНАЛЬНЫЙ ТЕСТ ГОДА', 24, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-vesom', 0, 6, null::int, 90, 4, '6–10'),
    ('zhim-ganteley-na-polu', 10, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-s-pauzoy-2-3-sek', 20, 10, null::int, 90, 3, '10'),
    ('zhim-ganteley-nad-golovoy', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 40, 15, null::int, 90, 3, '15'),
    ('razvedenie-v-naklone', 50, 15, null::int, 90, 3, '15'),
    ('frantsuzskiy-zhim', 60, 10, null::int, 90, 3, '10–12'),
    ('final-drop-set-1-2-raunda-ne-dovodya-do-razrusheniya-tehniki-dc6295', 70, null::int, null::int, 60, 2, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · FINAL PULL', 2, 'FINAL BOSS, недели 47–48 + ФИНАЛЬНЫЙ ТЕСТ ГОДА', 24, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('podtyagivaniya-obratnym-hvatom', 10, 8, null::int, 90, 3, '8–10'),
    ('tyaga-ganteley-v-naklone', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-odnoy-ganteli', 30, 10, null::int, 90, 3, '10 на руку'),
    ('pulover', 40, 12, null::int, 90, 3, '12–15'),
    ('face-pull', 50, 15, null::int, 90, 3, '15–20'),
    ('podem-ganteley-na-bitseps', 60, 8, null::int, 90, 3, '8–10'),
    ('molotkovye-sgibaniya', 70, 10, null::int, 90, 3, '10–12'),
    ('final-biceps-set-2-10-podemov-s-gantelyami-15-s-rezinkoy-20-sek-e700b6', 80, null::int, null::int, 60, 2, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · FINAL LEGS', 3, 'FINAL BOSS, недели 47–48 + ФИНАЛЬНЫЙ ТЕСТ ГОДА', 24, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 8, null::int, 90, 4, '8–10'),
    ('bolgarskiy-split-prised', 10, 8, null::int, 90, 4, '8 на ногу'),
    ('rumynskaya-tyaga', 20, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('yagodichnyy-most', 40, 10, null::int, 90, 4, '10–12'),
    ('sumo-prised', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-s-rezinkoy', 60, 15, null::int, 90, 3, '15'),
    ('ikry', 70, 15, null::int, 90, 4, '15–20'),
    ('final-leg-circuit-3-10-prisedaniy-10-vypadov-na-nogu-15-yagodichnyh-f2ab06', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 FINAL TEST', 4, 'FINAL BOSS, недели 47–48 + ФИНАЛЬНЫЙ ТЕСТ ГОДА', 24, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 3, 'макс.'),
    ('otzhimaniya', 10, null::int, null::int, 90, 3, 'макс.'),
    ('goblet-squat', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-ganteley', 30, 10, null::int, 90, 3, '10'),
    ('zhim-ganteley', 40, 10, null::int, 90, 3, '10'),
    ('mahi-gantelyami', 50, 15, null::int, 90, 3, '15'),
    ('bitseps', 60, 10, null::int, 90, 3, '10'),
    ('tritseps-s-rezinkoy', 70, 15, null::int, 90, 3, '15'),
    ('final-circuit-3-5-podtyagivaniy-10-otzhimaniy-15-prisedaniy-10-6723d9', 80, null::int, null::int, 60, 3, 'круг'),
    ('finalnyy-test-goda-polnye-zamery-tela-ves-taliya-grud-plechi-bitseps-2130e6', 90, null::int, null::int, 60, 1, 'тест')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
