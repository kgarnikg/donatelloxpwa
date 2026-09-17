-- 0019_seed_pohudenie_muzhchiny_zal.sql
-- Программа: Похудение — Мужчины — Зал
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0019), по одной на каждую комбинацию
-- пол × цель × формат — см. 0018..0021 и журнал в PROJECT_PLAN.md.
--
-- 141 тренировок, 432 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Похудение — Мужчины — Зал)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('razminka-dorozhka-7-min-2-min-spokoyno-2-min-sredniy-temp-1-min-308a55', 'Разминка: дорожка 7 мин (2 мин спокойно, 2 мин средний темп, 1 мин быстро, 2 мин средний темп)'),
  ('zhim-lezha-ves-umerennyy-ne-do-otkaza', 'Жим лёжа (вес умеренный, не до отказа)'),
  ('zhim-ganteley-na-naklonnoy-skame-posl-2-povt-tyazhelye', 'Жим гантелей на наклонной скамье (посл. 2 повт. тяжёлые)'),
  ('svedenie-ruk-v-trenazhere-babochka-posl-povt-2-sek-uderzhanie', 'Сведение рук в тренажёре «бабочка» (посл. повт. — 2 сек удержание)'),
  ('krossover-sverhu-vniz-posl-podhod-15-10-chastichnyh', 'Кроссовер сверху вниз (посл. подход: 15+10 частичных)'),
  ('razgibanie-ruk-na-bloke-s-kanatom', 'Разгибание рук на блоке с канатом'),
  ('razgibanie-ganteli-iz-za-golovy', 'Разгибание гантели из-за головы'),
  ('kardio-dorozhka-s-naklonom-5-8-1-min-spokoyno-1-min-bystro-5-10-min', 'Кардио: дорожка с наклоном 5–8° — 1 мин спокойно/1 мин быстро ×5 (10 мин)'),
  ('razminka-ellips-7-min', 'Разминка: эллипс 7 мин'),
  ('tyaga-verhnego-bloka-shirokim-hvatom', 'Тяга верхнего блока широким хватом'),
  ('tyaga-verhnego-bloka-obratnym-hvatom', 'Тяга верхнего блока обратным хватом'),
  ('tyaga-gorizontalnogo-bloka-1-sek-uderzhanie-v-kontse', 'Тяга горизонтального блока (1 сек удержание в конце)'),
  ('tyaga-ganteli-odnoy-rukoy', 'Тяга гантели одной рукой'),
  ('tyaga-verhnego-bloka-pryamymi-rukami', 'Тяга верхнего блока прямыми руками'),
  ('sgibanie-ruk-s-gantelyami', 'Сгибание рук с гантелями'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('kardio-lyzhi-skierg-20-sek-bystro-40-sek-spokoyno-8-8-min', 'Кардио: лыжи/SkiErg — 20 сек быстро/40 сек спокойно ×8 (8 мин)'),
  ('razminka-dorozhka-7-min-naklon-5-8', 'Разминка: дорожка 7 мин, наклон 5–8°'),
  ('prisedaniya-so-shtangoy-tehnika-vazhnee-vesa', 'Приседания со штангой (техника важнее веса)'),
  ('zhim-nogami', 'Жим ногами'),
  ('vypady-nazad-s-gantelyami', 'Выпады назад с гантелями'),
  ('sgibanie-nog-lezha', 'Сгибание ног лёжа'),
  ('razgibanie-nog-posl-podhod-10-korotkih-povt', 'Разгибание ног (посл. подход +10 коротких повт.)'),
  ('podemy-ganteley-v-storony', 'Подъёмы гантелей в стороны'),
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('finisher-dorozhka-30-sek-bystro-30-sek-spokoyno-kazhduyu-minutu-5-min', 'Финишер: дорожка — 30 сек быстро/30 сек спокойно каждую минуту (5 мин)'),
  ('zhim-lezha-5-vesa-diapazon-10-12', 'Жим лёжа (+5% веса, диапазон 10–12)'),
  ('zhim-ganteley-na-naklonnoy-skame', 'Жим гантелей на наклонной скамье'),
  ('svedenie-ruk-v-trenazhere-babochka', 'Сведение рук в тренажёре «бабочка»'),
  ('superset-3-otdyh-posle-pary-60-sek-krossover-sverhu-vniz-15-ecd7f4', 'Суперсет ×3 (отдых после пары 60 сек): Кроссовер сверху вниз 15 + Разгибание рук на блоке с канатом 15'),
  ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 'Кардио 12 мин (30 сек быстро/30 сек спокойно ×12)'),
  ('tyaga-verhnego-bloka-shirokim-hvatom-5-vesa', 'Тяга верхнего блока широким хватом (+5% веса)'),
  ('tyaga-gorizontalnogo-bloka', 'Тяга горизонтального блока'),
  ('superset-3-sgibanie-ruk-s-gantelyami-molotkovye-sgibaniya', 'Суперсет ×3: Сгибание рук с гантелями + Молотковые сгибания'),
  ('prisedaniya-so-shtangoy-5-vesa', 'Приседания со штангой (+5% веса)'),
  ('razgibanie-nog', 'Разгибание ног'),
  ('superset-3-mahi-gantelyami-v-storony-zadnyaya-delta', 'Суперсет ×3: Махи гантелями в стороны + Задняя дельта'),
  ('razminka-velotrenazher-8-min', 'Разминка: велотренажёр 8 мин'),
  ('zhim-ganteley-lezha', 'Жим гантелей лёжа'),
  ('zhim-v-trenazhere-sidya', 'Жим в тренажёре сидя'),
  ('krossover-snizu-vverh-aktsent-verh-grudi', 'Кроссовер снизу вверх (акцент верх груди)'),
  ('otzhimaniya-ot-pola-maksimum-kachestvennyh-ne-do-polnogo-razrusheniya-e5fe91', 'Отжимания от пола (максимум качественных, не до полного разрушения техники)'),
  ('razgibanie-ruk-na-bloke-obratnym-hvatom', 'Разгибание рук на блоке обратным хватом'),
  ('sgibanie-ruk-na-nizhnem-bloke', 'Сгибание рук на нижнем блоке'),
  ('metabolicheskiy-finisher-3-kruga-20-sek-battle-rope-20-sek-otdyh-20-6b94c1', 'Метаболический финишер ×3 круга: 20 сек Battle Rope/20 сек отдых, 20 сек быстрые step-up/20 сек отдых, 20 сек SkiErg/40 сек отдых'),
  ('podtyagivaniya-ili-s-trenazherom-pomoschnikom', 'Подтягивания (или с тренажёром-помощником)'),
  ('tyaga-verhnego-bloka-neytralnym-hvatom', 'Тяга верхнего блока нейтральным хватом'),
  ('tyaga-t-grifa', 'Тяга Т-грифа'),
  ('tyaga-bloka-odnoy-rukoy', 'Тяга блока одной рукой'),
  ('face-pull', 'Face Pull'),
  ('sgibanie-ruk-na-skame-skotta', 'Сгибание рук на скамье Скотта'),
  ('molotkovye-sgibaniya-s-kanatom', 'Молотковые сгибания с канатом'),
  ('kardio-skierg-10-min-30-sek-bystro-30-sek-spokoyno', 'Кардио SkiErg 10 мин (30 сек быстро/30 сек спокойно)'),
  ('gakk-prised', 'Гакк-присед'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('step-up-na-platformu', 'Step-up на платформу'),
  ('yagodichnyy-most-v-trenazhere', 'Ягодичный мост в тренажёре'),
  ('sgibanie-nog', 'Сгибание ног'),
  ('zhim-ganteley-sidya', 'Жим гантелей сидя'),
  ('mahi-gantelyami-v-storony', 'Махи гантелями в стороны'),
  ('final-cardio-12-min-kazhdye-2-min-30-sek-bystro-30-sek-spokoyno-30-7c1bd5', 'Final Cardio 12 мин: каждые 2 мин — 30 сек быстро/30 сек спокойно/30 сек быстро/30 сек спокойно'),
  ('razminka-dorozhka-s-naklonom-8-min-temp-postepenno-vyshe', 'Разминка: дорожка с наклоном 8 мин, темп постепенно выше'),
  ('zhim-shtangi-na-naklonnoy-skame-posl-podhod-25-30-vesa-5-povt', 'Жим штанги на наклонной скамье (посл. подход: -25–30% веса +5 повт.)'),
  ('zhim-ganteley-lezha-opuskanie-3-sek', 'Жим гантелей лёжа (опускание 3 сек)'),
  ('zhim-v-trenazhere-posl-5-povt-maks-kontroliruemo', 'Жим в тренажёре (посл. 5 повт. макс. контролируемо)'),
  ('svedenie-ruk-v-krossovere-snizu-vverh-pauza-1-2-sek', 'Сведение рук в кроссовере снизу вверх (пауза 1–2 сек)'),
  ('otzhimaniya-pervye-2-podhoda-ne-do-otkaza', 'Отжимания (первые 2 подхода не до отказа)'),
  ('razgibanie-ruk-s-kanatom', 'Разгибание рук с канатом'),
  ('razgibanie-odnoy-ruki-na-bloke', 'Разгибание одной руки на блоке'),
  ('finisher-6-min-3-30-sek-battle-rope-30-sek-otdyh-30-sek-bystrye-step-c0c991', 'Финишер 6 мин ×3: 30 сек Battle Rope/30 сек отдых, 30 сек быстрые Step-Up/30 сек отдых'),
  ('razminka-ellips-8-min', 'Разминка: эллипс 8 мин'),
  ('podtyagivaniya-ili-gravitron', 'Подтягивания (или гравитрон)'),
  ('tyaga-nizhnego-bloka-uzkim-hvatom', 'Тяга нижнего блока узким хватом'),
  ('pulover-na-verhnem-bloke', 'Пуловер на верхнем блоке'),
  ('finisher-skierg-8-min-20-sek-bystro-40-sek-spokoyno-8', 'Финишер SkiErg 8 мин: 20 сек быстро/40 сек спокойно ×8'),
  ('gakk-prised-ves-postepenno-uvelichivaem', 'Гакк-присед (вес постепенно увеличиваем)'),
  ('bolgarskie-vypady', 'Болгарские выпады'),
  ('sgibanie-nog-posl-podhod-10-chastichnyh-povt', 'Сгибание ног (посл. подход +10 частичных повт.)'),
  ('zadnyaya-delta-v-trenazhere', 'Задняя дельта в тренажёре'),
  ('kardio-dorozhka-naklon-7-10-1-min-sredniy-temp-30-sek-bystryy-10-min', 'Кардио: дорожка, наклон 7–10° — 1 мин средний темп/30 сек быстрый (10 мин)'),
  ('krug-n1-3-kruga-n2-4-kruga-otdyh-90-sek-goblet-squat-15-tyaga-8c4452', 'Круг (Н1 — 3 круга, Н2 — 4 круга, отдых 90 сек): Goblet Squat 15 + Тяга гантелей в наклоне 12 + Жим гантелей 12 + Выпады назад 10+10 + Жим гантелей над головой 12 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-shtangi-na-naklonnoy-skame', 'Жим штанги на наклонной скамье'),
  ('zhim-v-trenazhere', 'Жим в тренажёре'),
  ('superset-3-krossover-otzhimaniya', 'Суперсет ×3: Кроссовер + Отжимания'),
  ('kardio-15-min-30-sek-bystro-30-sek-spokoyno-15', 'Кардио 15 мин (30 сек быстро/30 сек спокойно ×15)'),
  ('podtyagivaniya', 'Подтягивания'),
  ('superset-3-pulover-tyaga-nizhnego-bloka-uzkim-hvatom', 'Суперсет ×3: Пуловер + Тяга нижнего блока узким хватом'),
  ('superset-3-mahi-v-storony-zadnyaya-delta', 'Суперсет ×3: Махи в стороны + Задняя дельта'),
  ('krug-4-bez-otdyha-mezhdu-uprazhneniyami-otdyh-60-90-sek-tolko-posle-712f1f', 'Круг ×4 (без отдыха между упражнениями, отдых 60–90 сек только после круга): Goblet Squat 15 + Тяга гантелей в наклоне 12 + Жим гантелей 12 + Выпады назад 10+10 + Жим гантелей над головой 12 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-v-smite-na-naklonnoy', 'Жим в Смите на наклонной'),
  ('zhim-ganteley-neytralnym-hvatom', 'Жим гантелей нейтральным хватом'),
  ('pec-deck-posl-podhod-drop-set', 'Pec Deck (посл. подход — дроп-сет)'),
  ('krossover-sverhu-vniz', 'Кроссовер сверху вниз'),
  ('otzhimaniya-na-brusyah-s-pomoschyu', 'Отжимания на брусьях с помощью'),
  ('frantsuzskiy-zhim-s-ez-shtangoy', 'Французский жим с EZ-штангой'),
  ('sgibanie-ruk-s-ez-shtangoy', 'Сгибание рук с EZ-штангой'),
  ('finisher-10-min-30-sek-skierg-30-sek-otdyh-30-sek-battle-rope-30-sek-5fff94', 'Финишер 10 мин: 30 сек SkiErg/30 сек отдых, 30 сек Battle Rope/30 сек отдых'),
  ('podtyagivaniya-neytralnym-hvatom', 'Подтягивания нейтральным хватом'),
  ('tyaga-verhnego-bloka-odnoy-rukoy', 'Тяга верхнего блока одной рукой'),
  ('tyaga-ganteley-grudyu-na-naklonnoy-skame', 'Тяга гантелей грудью на наклонной скамье'),
  ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 'Тяга горизонтального блока широким хватом'),
  ('sgibanie-ruk-na-naklonnoy-skame', 'Сгибание рук на наклонной скамье'),
  ('molotki-s-kanatom', 'Молотки с канатом'),
  ('kardio-12-min-40-sek-rabota-20-sek-spokoyno-skierg-ellips-velosiped-ce1c4d', 'Кардио 12 мин (40 сек работа/20 сек спокойно): SkiErg/эллипс/велосипед/дорожка'),
  ('frontalnye-prisedaniya-ili-goblet-squat-pri-slaboy-tehnike', 'Фронтальные приседания (или Goblet Squat при слабой технике)'),
  ('giperekstenziya', 'Гиперэкстензия'),
  ('hodba-vypadami', 'Ходьба выпадами'),
  ('zhim-nogami-uzkoy-postanovkoy', 'Жим ногами узкой постановкой'),
  ('sgibanie-nog-sidya', 'Сгибание ног сидя'),
  ('arnold-zhim', 'Арнольд-жим'),
  ('mahi-v-storony-na-nizhnem-bloke', 'Махи в стороны на нижнем блоке'),
  ('finisher-nog-4-raunda-20-sek-bystrye-step-up-20-sek-prisedaniya-s-c967b7', 'Финишер ног 4 раунда: 20 сек быстрые Step-Up, 20 сек приседания с собственным весом, 20 сек отдых'),
  ('4-kruga-otdyh-90-sek-kettlebell-swing-15-goblet-squat-15-tyaga-8ed7cb', '4 круга (отдых 90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Тяга гантелей 12 + Жим гантелей 12 + Выпады 10+10 + Mountain Climbers 30 сек + Burpee 8–10 + Battle Rope 30 сек'),
  ('razminka-dorozhka-s-naklonom-8-min', 'Разминка: дорожка с наклоном 8 мин'),
  ('zhim-shtangi-lezha', 'Жим штанги лёжа'),
  ('zhim-v-trenazhere-hammer', 'Жим в тренажёре Hammer'),
  ('svedenie-ruk-v-pec-deck', 'Сведение рук в Pec Deck'),
  ('krossover-snizu-vverh', 'Кроссовер снизу вверх'),
  ('frantsuzskiy-zhim-s-gantelyu-sidya', 'Французский жим с гантелью сидя'),
  ('finisher-2-podhoda-otzhimaniy-do-otkaza-zatem-battle-rope-30-sek-d5a4ee', 'Финишер: 2 подхода отжиманий до отказа, затем Battle Rope 30 сек/отдых 30 сек ×4'),
  ('podtyagivaniya-obratnym-hvatom', 'Подтягивания обратным хватом'),
  ('tyaga-gorizontalnogo-bloka-k-zhivotu', 'Тяга горизонтального блока к животу'),
  ('pulover-s-kanatom', 'Пуловер с канатом'),
  ('sgibanie-ruk-so-shtangoy', 'Сгибание рук со штангой'),
  ('finisher-skierg-10-min-20-sek-bystro-40-sek-spokoyno-10', 'Финишер SkiErg 10 мин: 20 сек быстро/40 сек спокойно ×10'),
  ('razminka-velosiped-8-min', 'Разминка: велосипед 8 мин'),
  ('prisedaniya-so-shtangoy', 'Приседания со штангой'),
  ('razvedenie-ruk-na-zadnyuyu-deltu', 'Разведение рук на заднюю дельту'),
  ('finisher-step-up-30-sek-rabota-30-sek-otdyh-6', 'Финишер Step-Up: 30 сек работа/30 сек отдых ×6'),
  ('krug-n1-4-kruga-n2-4-kruga-na-2-y-nedele-2-5-5-vesa-pri-sohranenii-547002', 'Круг (Н1 — 4 круга, Н2 — 4 круга + на 2-й неделе +2.5–5% веса при сохранении техники, отдых 75–90 сек): Goblet Squat 15 + Жим гантелей 12 + Тяга гантелей в наклоне 12 + Выпады назад 10+10 + Жим гантелей над головой 12 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-ganteley-na-naklonnoy', 'Жим гантелей на наклонной'),
  ('hammer', 'Hammer'),
  ('pec-deck-otzhimaniya-superset', 'Pec Deck → Отжимания (суперсет)'),
  ('razgibanie-ruki-iz-za-golovy-na-bloke-posl-podhod-tritsepsa-drop-set', 'Разгибание руки из-за головы на блоке (посл. подход трицепса — дроп-сет)'),
  ('kardio-15-min-30-sek-vysokaya-intensivnost-30-sek-umerenno-15', 'Кардио 15 мин (30 сек высокая интенсивность/30 сек умеренно ×15)'),
  ('tyaga-verhnego-bloka', 'Тяга верхнего блока'),
  ('podtyagivaniya-maksimum-kachestvennyh-povt', 'Подтягивания (максимум качественных повт.)'),
  ('gorizontalnaya-tyaga', 'Горизонтальная тяга'),
  ('pulover', 'Пуловер'),
  ('sgibanie-so-shtangoy', 'Сгибание со штангой'),
  ('molotki-posl-podhod-bitsepsa-snizhenie-vesa-10-povt', 'Молотки (посл. подход бицепса: снижение веса +10 повт.)'),
  ('prisedaniya', 'Приседания'),
  ('vypady', 'Выпады'),
  ('zhim-ganteley', 'Жим гантелей'),
  ('superset-3-mahi-v-storony-15-zadnyaya-delta-15', 'Суперсет ×3: Махи в стороны 15 + Задняя дельта 15'),
  ('5-krugov-otdyh-60-sek-zadacha-ne-maks-ves-a-maksimalnaya-13766b', '5 кругов (отдых 60 сек; задача — не макс. вес, а максимальная качественная плотность): Kettlebell Swing 15 + Goblet Squat 15 + Тяга гантелей 12 + Жим гантелей 12 + Выпады 10+10 + Mountain Climbers 30 сек + Burpee 8 + Battle Rope 30 сек'),
  ('zhim-v-smite-lezha', 'Жим в Смите лёжа'),
  ('zhim-ganteley-na-gorizontalnoy-skame-neytralnym-hvatom', 'Жим гантелей на горизонтальной скамье нейтральным хватом'),
  ('zhim-v-trenazhere-pod-nebolshim-naklonom', 'Жим в тренажёре под небольшим наклоном'),
  ('razgibanie-ruk-s-ez-shtangoy-lezha', 'Разгибание рук с EZ-штангой лёжа'),
  ('finisher-battle-rope-20-sek-rabota-40-sek-otdyh-8', 'Финишер Battle Rope: 20 сек работа/40 сек отдых ×8'),
  ('podtyagivaniya-shirokim-hvatom', 'Подтягивания широким хватом'),
  ('tyaga-t-grifa-s-uporom-grudyu', 'Тяга Т-грифа с упором грудью'),
  ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 'Финишер SkiErg: 30 сек быстро/30 сек спокойно ×10'),
  ('zhim-nogami-shirokoy-postanovkoy', 'Жим ногами широкой постановкой'),
  ('mahi-na-nizhnem-bloke', 'Махи на нижнем блоке'),
  ('finisher-nog-5-raundov-30-sek-step-up-30-sek-prisedaniya-bez-vesa-30-21eca5', 'Финишер ног 5 раундов: 30 сек Step-Up/30 сек приседания без веса/30 сек отдых'),
  ('4-kruga-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-30be00', '4 круга (отдых 60–90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12 + Тяга гантелей 12 + Выпады с гантелями 10+10 + Burpee 8 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-ganteley-na-naklonnoy-skame-posl-podhod-10-povt-25-vesa-8-10-povt', 'Жим гантелей на наклонной скамье (посл. подход: 10 повт. → -25% веса → 8–10 повт.)'),
  ('zhim-shtangi-lezha-uzkim-hvatom', 'Жим штанги лёжа узким хватом'),
  ('zhim-v-trenazhere-sidya-posl-3-povt-medlenno', 'Жим в тренажёре сидя (посл. 3 повт. медленно)'),
  ('krossover-sverhu-vniz-pauza-1-sek', 'Кроссовер сверху вниз (пауза 1 сек)'),
  ('razgibanie-ruk-s-kanatom-posl-podhod-drop-set', 'Разгибание рук с канатом (посл. подход — дроп-сет)'),
  ('razgibanie-odnoy-ruki-iz-za-golovy-na-bloke', 'Разгибание одной руки из-за головы на блоке'),
  ('finisher-8-min-8-20-sek-battle-rope-40-sek-otdyh-20-sek-bystrye-step-062345', 'Финишер 8 мин ×8: 20 сек Battle Rope/40 сек отдых, 20 сек быстрые Step-Up/40 сек отдых'),
  ('podtyagivaniya-neytralnym-hvatom-ili-gravitron', 'Подтягивания нейтральным хватом (или гравитрон)'),
  ('tyaga-gorizontalnogo-bloka-odnoy-rukoy', 'Тяга горизонтального блока одной рукой'),
  ('molotkovye-sgibaniya-posl-podhod-snizit-ves-10-povt', 'Молотковые сгибания (посл. подход: снизить вес +10 повт.)'),
  ('kardio-finisher-skierg-10-min-30-sek-bystro-30-sek-spokoyno-10', 'Кардио-финишер SkiErg 10 мин: 30 сек быстро/30 сек спокойно ×10'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('vypady-nazad', 'Выпады назад'),
  ('sgibanie-nog-sidya-posl-podhod-10-sek-uderzhanie-v-sokraschenii', 'Сгибание ног сидя (посл. подход — 10 сек удержание в сокращении)'),
  ('razvedenie-na-zadnyuyu-deltu', 'Разведение на заднюю дельту'),
  ('finisher-4-raunda-30-sek-step-up-30-sek-prisedaniya-s-sobstvennym-c61f50', 'Финишер 4 раунда: 30 сек Step-Up/30 сек приседания с собственным весом/30 сек отдых'),
  ('krug-kettlebell-swing-15-goblet-squat-15-zhim-ganteley-na-naklonnoy-bba38d', 'Круг: Kettlebell Swing 15 + Goblet Squat 15 + Жим гантелей на наклонной 12 + Тяга гантелей в наклоне 12 + Выпады назад 10+10 + Жим гантелей стоя 10 + Mountain Climbers 30 сек + Battle Rope 30 сек, отдых 90 сек (Н1 — 4 круга, Н2 — 5 кругов)'),
  ('krossover', 'Кроссовер'),
  ('otzhimaniya', 'Отжимания'),
  ('superset-3-posl-do-tehnicheskogo-otkaza-razgibanie-kanatom-otzhimaniya', 'Суперсет ×3 (посл. до технического отказа): Разгибание канатом → Отжимания'),
  ('razgibanie-odnoy-ruki', 'Разгибание одной руки'),
  ('kardio-15-min-30-sek-bystro-30-sek-umerenno-15', 'Кардио 15 мин (30 сек быстро/30 сек умеренно ×15)'),
  ('superset-3-ez-bitseps-10-molotki-12', 'Суперсет ×3: EZ-бицепс 10 + Молотки 12'),
  ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-zhim-76b690', '5 кругов (отдых 60 сек): Kettlebell Swing 15 + Goblet Squat 15 + Жим гантелей 12 + Тяга гантелей 12 + Выпады 10+10 + Burpee 8 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-shtangi-v-smite', 'Жим штанги в Смите'),
  ('finisher-10-min-10-20-sek-battle-rope-40-sek-otdyh-20-sek-step-up-40-f90955', 'Финишер 10 мин ×10: 20 сек Battle Rope/40 сек отдых, 20 сек Step-Up/40 сек отдых'),
  ('gorizontalnaya-tyaga-shirokim-hvatom', 'Горизонтальная тяга широким хватом'),
  ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 'Финишер SkiErg: 40 сек быстро/20 сек спокойно ×10'),
  ('frontalnyy-prised-ili-goblet-squat-4-12-pri-slaboy-tehnike', 'Фронтальный присед (или Goblet Squat 4×12 при слабой технике)'),
  ('zadnyaya-delta', 'Задняя дельта'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-pryzhkovye-prisedaniya-ili-00e88c', 'Финишер 5 раундов: 30 сек Step-Up/20 сек прыжковые приседания (или быстрые обычные, если прыжки нестабильны)/30 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-a02ea9', '5 кругов (отдых 60–90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12 + Тяга гантелей 12 + Выпады 10+10 + Burpee 8 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-shtangi-na-naklonnoy-skame-posl-podhod-10-25-vesa-8-10-povt', 'Жим штанги на наклонной скамье (посл. подход: 10 → -25% веса → +8–10 повт.)'),
  ('zhim-v-trenazhere-hammer-posl-3-povt-medlenno', 'Жим в тренажёре Hammer (посл. 3 повт. медленно)'),
  ('krossover-snizu-vverh-pauza-1-2-sek', 'Кроссовер снизу вверх (пауза 1–2 сек)'),
  ('superset-bez-otdyha-otzhimaniya-s-uzkoy-postanovkoy-maks-razgibanie-0c0deb', 'Суперсет (без отдыха): Отжимания с узкой постановкой макс. + Разгибание рук на блоке обратным хватом 12–15 + Разгибание рук с канатом над головой 12'),
  ('finisher-8-min-2-20-sek-battle-rope-20-sek-otdyh-20-sek-bystrye-590e2c', 'Финишер 8 мин ×2: 20 сек Battle Rope/20 сек отдых, 20 сек быстрые отжимания от скамьи/20 сек отдых, 20 сек Battle Rope/20 сек отдых, 20 сек Step-Up/20 сек отдых'),
  ('razminka-grebnoy-trenazher-8-min', 'Разминка: гребной тренажёр 8 мин'),
  ('tyaga-gorizontalnogo-bloka-uzkim-hvatom', 'Тяга горизонтального блока узким хватом'),
  ('superset-sgibanie-ruk-s-gantelyami-na-naklonnoy-skame-10-12-e26502', 'Суперсет: Сгибание рук с гантелями на наклонной скамье 10–12 + Молотковые сгибания 12'),
  ('finisher-skierg-10-min-30-sek-bystro-30-sek-spokoyno-10', 'Финишер SkiErg 10 мин: 30 сек быстро/30 сек спокойно ×10'),
  ('zhim-nogami-ves-rabochiy-bez-poteri-tehniki', 'Жим ногами (вес рабочий, без потери техники)')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('rumynskaya-tyaga-so-shtangoy', 'Румынская тяга со штангой'),
  ('bolgarskie-vypady-s-gantelyami', 'Болгарские выпады с гантелями'),
  ('razgibanie-nog-posl-podhod-drop-set', 'Разгибание ног (посл. подход — дроп-сет)'),
  ('sgibanie-nog-lezha-posl-3-povt-medlenno', 'Сгибание ног лёжа (посл. 3 повт. медленно)'),
  ('superset-mahi-gantelyami-v-storony-15-razvedenie-ganteley-v-naklone-15', 'Суперсет: Махи гантелями в стороны 15 + Разведение гантелей в наклоне 15'),
  ('finisher-nog-4-raunda-30-sek-bystrye-step-up-20-sek-prisedaniya-20-0bcdc9', 'Финишер ног 4 раунда: 30 сек быстрые Step-Up/20 сек приседания/20 сек отдых'),
  ('krugovaya-trenirovka-n1-4-kruga-n2-5-krugov-otdyh-90-sek-kettlebell-ac45df', 'Круговая тренировка (Н1 — 4 круга, Н2 — 5 кругов, отдых 90 сек): Kettlebell Swing 15 + Выпады назад 10+10 + Отжимания 12 + Тяга гантелей в наклоне 12 + Goblet Squat 15 + Жим гантелей стоя 10 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-shtangi-na-naklonnoy', 'Жим штанги на наклонной'),
  ('krossover-posl-podhod-drop-set', 'Кроссовер (посл. подход — дроп-сет)'),
  ('otzhimaniya-uzkim-hvatom', 'Отжимания узким хватом'),
  ('superset-razgibanie-kanatom-12-razgibanie-nad-golovoy-12', 'Суперсет: Разгибание канатом 12 + Разгибание над головой 12'),
  ('kardio-10-min-30-sek-bystro-30-sek-spokoyno-10', 'Кардио 10 мин (30 сек быстро/30 сек спокойно ×10)'),
  ('verhniy-blok-neytralnym-hvatom', 'Верхний блок нейтральным хватом'),
  ('superset-sgibanie-na-naklonnoy-10-molotki-12', 'Суперсет: Сгибание на наклонной 10 + Молотки 12'),
  ('finisher-skierg-10-min-40-sek-bystro-20-sek-spokoyno-10', 'Финишер SkiErg 10 мин: 40 сек быстро/20 сек спокойно ×10'),
  ('superset-mahi-v-storony-15-zadnyaya-delta-15', 'Суперсет: Махи в стороны 15 + Задняя дельта 15'),
  ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-otzhimaniya-e79c6f', '5 кругов (отдых 60 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12 + Тяга гантелей 12 + Выпады 10+10 + Burpee 8 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('zhim-v-smite-s-nebolshim-naklonom', 'Жим в Смите с небольшим наклоном'),
  ('krossover-na-urovne-grudi', 'Кроссовер на уровне груди'),
  ('frantsuzskiy-zhim-s-gantelyu', 'Французский жим с гантелью'),
  ('finisher-10-min-5-20-sek-battle-rope-20-sek-otdyh-20-sek-step-up-20-c3a2e3', 'Финишер 10 мин ×5: 20 сек Battle Rope/20 сек отдых, 20 сек Step-Up/20 сек отдых, 20 сек Mountain Climbers/20 сек отдых, 20 сек отдых'),
  ('tyaga-nizhnego-bloka-shirokim-hvatom', 'Тяга нижнего блока широким хватом'),
  ('tyaga-kanata-k-litsu', 'Тяга каната к лицу'),
  ('pulover-s-gantelyu', 'Пуловер с гантелью'),
  ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotki-s-kanatom-15', 'Суперсет: Сгибание рук с EZ-штангой 10 + Молотки с канатом 15'),
  ('finisher-grebnoy-trenazher-45-sek-bystro-15-sek-spokoyno-10', 'Финишер гребной тренажёр: 45 сек быстро/15 сек спокойно ×10'),
  ('vypady-hodboy', 'Выпады ходьбой'),
  ('zhim-arnolda', 'Жим Арнольда'),
  ('superset-mahi-v-storony-na-nizhnem-bloke-15-face-pull-15', 'Суперсет: Махи в стороны на нижнем блоке 15 + Face Pull 15'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-4e83ae', 'Финишер 5 раундов: 30 сек Step-Up/20 сек быстрые приседания/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-0b13de', '5 кругов (отдых 60–90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12 + Тяга гантелей 12 + Выпады ходьбой 10+10 + Burpee 8 + Mountain Climbers 30 сек + Battle Rope 30 сек'),
  ('pec-deck-posl-podhod-30-vesa-10-povt', 'Pec Deck (посл. подход: -30% веса +10 повт.)'),
  ('krossover-sverhu-vniz-pauza-2-sek', 'Кроссовер сверху вниз (пауза 2 сек)'),
  ('otzhimaniya-ot-pola', 'Отжимания от пола'),
  ('superset-razgibanie-ruk-na-bloke-s-kanatom-12-15-frantsuzskiy-zhim-s-1dd586', 'Суперсет: Разгибание рук на блоке с канатом 12–15 + Французский жим с гантелью сидя 12'),
  ('kardio-finisher-na-velotrenazhere-10-min-30-sek-bystro-30-sek-spokoyno', 'Кардио-финишер на велотренажёре 10 мин: 30 сек быстро/30 сек спокойно'),
  ('podtyagivaniya-obychnym-hvatom-ili-negativnye-3-6-8', 'Подтягивания обычным хватом (или негативные 3×6–8)'),
  ('tyaga-nizhnego-bloka-k-zhivotu', 'Тяга нижнего блока к животу'),
  ('superset-sgibanie-ruk-s-ez-shtangoy-10-12-sgibanie-ruk-na-nizhnem-510bbb', 'Суперсет: Сгибание рук с EZ-штангой 10–12 + Сгибание рук на нижнем блоке 15'),
  ('kardio-skierg-10-min-40-sek-bystro-20-sek-spokoyno', 'Кардио SkiErg 10 мин: 40 сек быстро/20 сек спокойно'),
  ('superset-mahi-gantelyami-v-storony-15-obratnaya-babochka-15', 'Суперсет: Махи гантелями в стороны 15 + Обратная бабочка 15'),
  ('finisher-nog-4-raunda-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 'Финишер ног 4 раунда: 30 сек Step-Up/20 сек приседания/20 сек отдых'),
  ('krugovaya-trenirovka-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-3db7e2', 'Круговая тренировка (Н1 — 4 круга, Н2 — 5 кругов, отдых 60–90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12–15 + Тяга гантелей в наклоне 12 + Выпады назад 10+10 + Жим гантелей стоя 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-shtangi-lezha-posl-podhod-drop-set', 'Жим штанги лёжа (посл. подход — дроп-сет)'),
  ('superset-razgibanie-s-kanatom-12-frantsuzskiy-zhim-10-12', 'Суперсет: Разгибание с канатом 12 + Французский жим 10–12'),
  ('finisher-battle-rope-30-sek-rabota-30-sek-otdyh-10', 'Финишер Battle Rope: 30 сек работа/30 сек отдых ×10'),
  ('tyaga-nizhnego-bloka', 'Тяга нижнего блока'),
  ('superset-ez-sgibaniya-10-nizhniy-blok-15', 'Суперсет: EZ-сгибания 10 + Нижний блок 15'),
  ('finisher-greblya-30-sek-bystro-30-sek-spokoyno-10', 'Финишер гребля: 30 сек быстро/30 сек спокойно ×10'),
  ('superset-mahi-v-storony-15-obratnaya-babochka-15', 'Суперсет: Махи в стороны 15 + Обратная бабочка 15'),
  ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-otzhimaniya-b10323', '5 кругов (отдых 60 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 15 + Тяга гантелей 12 + Выпады 10+10 + Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-v-smite-na-naklonnoy-skame', 'Жим в Смите на наклонной скамье'),
  ('zhim-ganteley-lezha-neytralnym-hvatom', 'Жим гантелей лёжа нейтральным хватом'),
  ('krossover-snizu-vverh-posl-podhod-drop-set', 'Кроссовер снизу вверх (посл. подход — дроп-сет)'),
  ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-ruk-s-ad62d3', 'Суперсет: Разгибание одной руки на блоке 12 на руку + Разгибание рук с канатом над головой 15'),
  ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-mountain-b4a9cc', 'Финишер 10 мин: 20 сек Battle Rope/20 сек отдых, 20 сек Mountain Climbers/20 сек отдых, 20 сек Step-Up/20 сек отдых'),
  ('tyaga-s-uporom-grudyu', 'Тяга с упором грудью'),
  ('tyaga-ganteley-na-naklonnoy-skame', 'Тяга гантелей на наклонной скамье'),
  ('pulover-na-bloke', 'Пуловер на блоке'),
  ('superset-sgibanie-ruk-na-skame-skotta-10-12-molotki-s-kanatom-15', 'Суперсет: Сгибание рук на скамье Скотта 10–12 + Молотки с канатом 15'),
  ('finisher-skierg-45-sek-bystro-15-sek-spokoyno-10', 'Финишер SkiErg: 45 сек быстро/15 сек спокойно ×10'),
  ('superset-mahi-na-nizhnem-bloke-15-face-pull-15', 'Суперсет: Махи на нижнем блоке 15 + Face Pull 15'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 'Финишер 5 раундов: 30 сек Step-Up/20 сек приседания/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-vypady-hodboy-10-10-ce8402', '5 кругов (отдых 60–90 сек): Kettlebell Swing 15 + Выпады ходьбой 10+10 + Отжимания 12 + Тяга гантелей 12 + Goblet Squat 15 + Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-ganteley-na-gorizontalnoy-skame-posl-podhod-25-vesa-10-povt', 'Жим гантелей на горизонтальной скамье (посл. подход: -25% веса +10 повт.)'),
  ('svedenie-ruk-v-trenazhere-posl-5-povt-medlenno', 'Сведение рук в тренажёре (посл. 5 повт. медленно)'),
  ('superset-zhim-ganteley-sidya-10-mahi-gantelyami-v-storony-15', 'Суперсет: Жим гантелей сидя 10 + Махи гантелями в стороны 15'),
  ('superset-razgibanie-ruk-s-pryamoy-rukoyatyu-12-razgibanie-odnoy-ruki-174b66', 'Суперсет: Разгибание рук с прямой рукоятью 12 + Разгибание одной руки из-за головы 12 на руку'),
  ('finisher-battle-rock-30-sek-rabota-30-sek-otdyh-10-10-min', 'Финишер Battle Rock: 30 сек работа/30 сек отдых ×10 (10 мин)'),
  ('tyaga-verhnego-bloka-k-grudi-shirokim-hvatom', 'Тяга верхнего блока к груди широким хватом'),
  ('tyaga-ganteley-lezha-grudyu-na-naklonnoy-skame', 'Тяга гантелей лёжа грудью на наклонной скамье'),
  ('pulover-s-pryamymi-rukami-na-bloke', 'Пуловер с прямыми руками на блоке'),
  ('superset-sgibanie-ruk-s-gantelyami-sidya-10-molotkovye-sgibaniya-12', 'Суперсет: Сгибание рук с гантелями сидя 10 + Молотковые сгибания 12'),
  ('finisher-grebnoy-trenazher-10-min-20-sek-maksimalno-bystro-40-sek-c368a8', 'Финишер гребной тренажёр 10 мин: 20 сек максимально быстро/40 сек спокойно ×10'),
  ('prised-v-smite', 'Присед в Смите'),
  ('yagodichnyy-most-so-shtangoy', 'Ягодичный мост со штангой'),
  ('otvedenie-nogi-nazad-v-krossovere', 'Отведение ноги назад в кроссовере'),
  ('podem-na-noski-stoya', 'Подъём на носки стоя'),
  ('finisher-4-raunda-30-sek-hodba-na-vysokoy-platforme-20-sek-4449b7', 'Финишер 4 раунда: 30 сек ходьба на высокой платформе/20 сек приседания/20 сек отдых'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-kettlebell-clean-10-na-8031fc', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60–90 сек): Kettlebell Clean 10 на руку + Goblet Squat 15 + Отжимания 15 + Тяга гантели одной рукой 10+10 + Выпады назад 10+10 + Push Press с гантелями 10 + Jumping Jack 30 сек + Mountain Climbers 30 сек'),
  ('zhim-ganteley-lezha-posl-podhod-drop-set', 'Жим гантелей лёжа (посл. подход — дроп-сет)'),
  ('mahi-v-storony', 'Махи в стороны'),
  ('superset-razgibanie-na-bloke-12-razgibanie-odnoy-rukoy-12', 'Суперсет: Разгибание на блоке 12 + Разгибание одной рукой 12'),
  ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-10', 'Финишер Battle Rope: 40 сек работа/20 сек отдых ×10'),
  ('verhniy-blok-shirokim-hvatom', 'Верхний блок широким хватом'),
  ('tyaga-ganteley-grudyu-na-skame', 'Тяга гантелей грудью на скамье'),
  ('superset-sgibanie-ganteley-sidya-10-molotki-12', 'Суперсет: Сгибание гантелей сидя 10 + Молотки 12'),
  ('yagodichnyy-most', 'Ягодичный мост'),
  ('otvedenie-nogi-v-krossovere', 'Отведение ноги в кроссовере'),
  ('ikry', 'Икры'),
  ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-goblet-squat-15-550409', '5 кругов (отдых 60 сек): Kettlebell Clean 10+10 + Goblet Squat 15 + Отжимания 15 + Тяга гантели 10+10 + Выпады 10+10 + Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-ganteley-na-nizkom-naklone', 'Жим гантелей на низком наклоне'),
  ('pec-deck-s-pauzoy', 'Pec Deck с паузой'),
  ('superset-zhim-arnolda-10-mahi-na-nizhnem-bloke-15', 'Суперсет: Жим Арнольда 10 + Махи на нижнем блоке 15'),
  ('superset-otzhimaniya-uzkim-hvatom-maks-razgibanie-kanata-nad-golovoy-cc0c1e', 'Суперсет: Отжимания узким хватом макс. + Разгибание каната над головой 15'),
  ('finisher-8-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-8273be', 'Финишер 8 мин: 20 сек Battle Rope/20 сек отдых, 20 сек Burpee/20 сек отдых, 20 сек Mountain Climbers/20 сек отдых'),
  ('tyaga-ganteley-s-uporom-grudyu', 'Тяга гантелей с упором грудью'),
  ('tyaga-pryamymi-rukami-na-bloke', 'Тяга прямыми руками на блоке'),
  ('superset-sgibanie-ruk-na-skame-skotta-10-molotki-s-kanatom-15', 'Суперсет: Сгибание рук на скамье Скотта 10 + Молотки с канатом 15'),
  ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-10', 'Финишер гребля: 45 сек быстро/15 сек спокойно ×10'),
  ('otvedenie-nogi-v-trenazhere', 'Отведение ноги в тренажёре'),
  ('podem-na-noski-sidya', 'Подъём на носки сидя'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-vyprygivaniya-iz-polupriseda-962731', 'Финишер 5 раундов: 30 сек Step-Up/20 сек выпрыгивания из полуприседа/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-walking-lunges-10-10-b2db07', '5 кругов (отдых 60–90 сек): Kettlebell Swing 15 + Walking Lunges 10+10 + Push-Up 12 + Dumbbell Thruster 10 + Renegade Row 8+8 + Burpee 8 + Jumping Jack 30 сек + Mountain Climbers 30 сек'),
  ('zhim-shtangi-uzkim-hvatom', 'Жим штанги узким хватом'),
  ('zhim-v-trenazhere-hammer-posl-podhod-30-vesa-10-povt', 'Жим в тренажёре Hammer (посл. подход: -30% веса +10 повт.)'),
  ('krossover-na-urovne-grudi-pauza-2-sek', 'Кроссовер на уровне груди (пауза 2 сек)'),
  ('superset-razgibanie-ruk-na-verhnem-bloke-kanatom-12-15-frantsuzskiy-9174aa', 'Суперсет: Разгибание рук на верхнем блоке канатом 12–15 + Французский жим EZ-штангой лёжа 10–12'),
  ('podtyagivaniya-neytralnym-hvatom-ili-negativnye-4-5-6', 'Подтягивания нейтральным хватом (или негативные 4×5–6)'),
  ('tyaga-verhnego-bloka-k-grudi-uzkim-neytralnym-hvatom', 'Тяга верхнего блока к груди узким нейтральным хватом'),
  ('gorizontalnaya-tyaga-odnoy-rukoy', 'Горизонтальная тяга одной рукой'),
  ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotkovye-sgibaniya-s-c6bed4', 'Суперсет: Сгибание рук с EZ-штангой 10 + Молотковые сгибания с гантелями 12'),
  ('frontalnyy-prised', 'Фронтальный присед'),
  ('finisher-4-raunda-30-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 'Финишер 4 раунда: 30 сек Step-Up/20 сек быстрые выпады/20 сек отдых'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-kettlebell-clean-10-10-71928b', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60–90 сек): Kettlebell Clean 10+10 + Front Rack Squat 12 + Отжимания 15 + Renegade Row 8+8 + Walking Lunges 10+10 + Dumbbell Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('hammer-posl-podhod-drop-set', 'Hammer (посл. подход — дроп-сет)'),
  ('otzhimaniya-na-brusyah', 'Отжимания на брусьях'),
  ('superset-razgibanie-kanatom-12-frantsuzskiy-zhim-10', 'Суперсет: Разгибание канатом 12 + Французский жим 10'),
  ('verhniy-blok', 'Верхний блок'),
  ('superset-ez-sgibaniya-10-molotki-12', 'Суперсет: EZ-сгибания 10 + Молотки 12'),
  ('zhim-ganteley-stoya', 'Жим гантелей стоя'),
  ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-front-rack-squat-12-push-156b92', '5 кругов (отдых 60 сек): Kettlebell Clean 10+10 + Front Rack Squat 12 + Push-Up 15 + Renegade Row 8+8 + Walking Lunges 10+10 + Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-v-smite-na-gorizontalnoy-skame', 'Жим в Смите на горизонтальной скамье'),
  ('zhim-ganteley-na-naklonnoy-skame-neytralnym-hvatom', 'Жим гантелей на наклонной скамье нейтральным хватом'),
  ('otzhimaniya-s-nogami-na-skame', 'Отжимания с ногами на скамье'),
  ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-kanata-8691b5', 'Суперсет: Разгибание одной руки на блоке 12 на руку + Разгибание каната над головой 15'),
  ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-564cf8', 'Финишер 10 мин: 20 сек Battle Rope/20 сек отдых, 20 сек Burpee/20 сек отдых, 20 сек Mountain Climbers/20 сек отдых'),
  ('tyaga-nizhnego-bloka-odnoy-rukoy', 'Тяга нижнего блока одной рукой'),
  ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-d2cc68', '5 кругов (отдых 60–90 сек): Kettlebell Swing 15 + Goblet Squat 15 + Отжимания 12 + Dumbbell Thruster 10 + Renegade Row 8+8 + Walking Lunges 10+10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-v-trenazhere-sidya-posl-podhod-30-vesa-10-povt', 'Жим в тренажёре сидя (посл. подход: -30% веса +10 повт.)'),
  ('svedenie-ruk-v-krossovere-sverhu-vniz-pauza-2-sek', 'Сведение рук в кроссовере сверху вниз (пауза 2 сек)'),
  ('otzhimaniya-na-brusyah-ili-s-pomoschyu-trenazhera', 'Отжимания на брусьях (или с помощью тренажёра)'),
  ('superset-razgibanie-ruk-s-ez-grifom-nad-golovoy-10-12-razgibanie-c29492', 'Суперсет: Разгибание рук с EZ-грифом над головой 10–12 + Разгибание одной руки на нижнем блоке 12 на руку'),
  ('finisher-assault-bike-20-sek-maksimalno-bystro-40-sek-spokoyno-10', 'Финишер Assault Bike: 20 сек максимально быстро/40 сек спокойно ×10'),
  ('podtyagivaniya-shirokim-hvatom-ili-negativnye-4-5', 'Подтягивания широким хватом (или негативные 4×5)'),
  ('tyaga-ganteley-na-naklonnoy-skame-grudyu-vniz', 'Тяга гантелей на наклонной скамье грудью вниз'),
  ('superset-sgibanie-ruk-s-gantelyami-na-naklonnoy-skame-10-12-141f99', 'Суперсет: Сгибание рук с гантелями на наклонной скамье 10–12 + Молотковый хват через корпус 12'),
  ('sgibanie-nog-sidya-posl-podhod-drop-set', 'Сгибание ног сидя (посл. подход — дроп-сет)'),
  ('finisher-4-raunda-30-sek-step-up-20-sek-pryzhki-cherez-nevysokuyu-a562cc', 'Финишер 4 раунда: 30 сек Step-Up/20 сек прыжки через невысокую платформу/30 сек отдых'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-bfd126', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60 сек): Kettlebell Swing 15 + Goblet Squat 15 + Push-Up 15 + Dumbbell Row 10+10 + Reverse Lunge 10+10 + Dumbbell Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-v-trenazhere-posl-podhod-drop-set', 'Жим в тренажёре (посл. подход — дроп-сет)'),
  ('krossover-sverhu-vniz-posl-podhod-10-chastichnyh-povt', 'Кроссовер сверху вниз (посл. подход +10 частичных повт.)'),
  ('superset-razgibanie-ez-grifa-nad-golovoy-10-razgibanie-odnoy-rukoy-12', 'Суперсет: Разгибание EZ-грифа над головой 10 + Разгибание одной рукой 12'),
  ('finisher-assault-bike-30-sek-bystro-30-sek-spokoyno-10', 'Финишер Assault Bike: 30 сек быстро/30 сек спокойно ×10'),
  ('gorizontalnyy-blok', 'Горизонтальный блок'),
  ('superset-bitseps-na-naklonnoy-10-molotki-12', 'Суперсет: Бицепс на наклонной 10 + Молотки 12'),
  ('sgibanie-nog-posl-podhod-drop-set', 'Сгибание ног (посл. подход — дроп-сет)'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-pryzhki-20-sek-otdyh', 'Финишер 5 раундов: 30 сек Step-Up/20 сек прыжки/20 сек отдых'),
  ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-push-up-15-4b4eff', '5 кругов (отдых 60 сек): Kettlebell Swing 15 + Goblet Squat 15 + Push-Up 15 + Dumbbell Row 10+10 + Reverse Lunge 10+10 + Push Press 10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-v-smite-obratnym-hvatom', 'Жим в Смите обратным хватом'),
  ('zhim-ganteley-na-polu', 'Жим гантелей на полу'),
  ('krossover-snizu-vverh-pauza-2-sek', 'Кроссовер снизу вверх (пауза 2 сек)'),
  ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 'Отжимания с узкой постановкой рук'),
  ('superset-razgibanie-ruk-na-bloke-obratnym-hvatom-12-razgibanie-kanata-73d151', 'Суперсет: Разгибание рук на блоке обратным хватом 12 + Разгибание каната из-за головы 15'),
  ('tyaga-odnoy-ganteli-s-uporom', 'Тяга одной гантели с упором'),
  ('pulover-v-trenazhere', 'Пуловер в тренажёре'),
  ('superset-sgibanie-ruk-na-skame-skotta-10-sgibanie-ruk-s-kanatom-15', 'Суперсет: Сгибание рук на скамье Скотта 10 + Сгибание рук с канатом 15'),
  ('finisher-greblya-40-sek-bystro-20-sek-spokoyno-10', 'Финишер гребля: 40 сек быстро/20 сек спокойно ×10'),
  ('good-morning-so-shtangoy', 'Good Morning со штангой'),
  ('zhim-v-trenazhere-dlya-plech', 'Жим в тренажёре для плеч'),
  ('superset-mahi-odnoy-rukoy-v-krossovere-15-na-ruku-razvedenie-na-c3882b', 'Суперсет: Махи одной рукой в кроссовере 15 на руку + Разведение на заднюю дельту 15'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-s-sobstvennym-7b5a13', 'Финишер 5 раундов: 30 сек Step-Up/20 сек приседания с собственным весом/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalnaya-skorost-pri-sohranenii-7ac458', '5 кругов (отдых 60–90 сек, 5-й круг — максимальная скорость при сохранении техники): Kettlebell Clean 10+10 + Dumbbell Thruster 12 + Renegade Row 8+8 + Walking Lunges 10+10 + Push-Up 12 + Kettlebell Swing 15 + Burpee 8 + High Knees 30 сек'),
  ('zhim-shtangi-na-gorizontalnoy-skame', 'Жим штанги на горизонтальной скамье'),
  ('superset-razgibanie-ruk-na-verhnem-bloke-pryamoy-rukoyatyu-12-06dd67', 'Суперсет: Разгибание рук на верхнем блоке прямой рукоятью 12 + Разгибание рук с канатом над головой 15'),
  ('podtyagivaniya-neytralnym-hvatom-ili-negativnye', 'Подтягивания нейтральным хватом (или негативные)'),
  ('pulover-s-pryamoy-rukoyatyu', 'Пуловер с прямой рукоятью'),
  ('superset-sgibanie-ruk-so-shtangoy-10-molotkovye-sgibaniya-12', 'Суперсет: Сгибание рук со штангой 10 + Молотковые сгибания 12'),
  ('prisedaniya-v-smite', 'Приседания в Смите'),
  ('sgibanie-nog-lezha-posl-podhod-drop-set', 'Сгибание ног лёжа (посл. подход — дроп-сет)'),
  ('superset-mahi-gantelyami-v-storony-15-razvedenie-ruk-v-trenazhere-15', 'Суперсет: Махи гантелями в стороны 15 + Разведение рук в тренажёре 15'),
  ('finisher-4-raunda-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-f113f4', 'Финишер 4 раунда: 30 сек Step-Up/20 сек быстрые приседания/20 сек отдых'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-kettlebell-swing-15-dumbbell-af26d6', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60 сек): Kettlebell Swing 15 + Dumbbell Thruster 12 + Push-Up 15 + Renegade Row 8+8 + Reverse Lunge 10+10 + Kettlebell High Pull 10+10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-shtangi', 'Жим штанги'),
  ('krossover-snizu-vverh-posl-podhod-10-chastichnyh-povt', 'Кроссовер снизу вверх (посл. подход +10 частичных повт.)'),
  ('superset-razgibanie-pryamoy-rukoyatyu-10-kanat-nad-golovoy-15', 'Суперсет: Разгибание прямой рукоятью 10 + Канат над головой 15'),
  ('superset-sgibanie-so-shtangoy-10-molotki-12', 'Суперсет: Сгибание со штангой 10 + Молотки 12'),
  ('5-krugov-otdyh-60-sek-kettlebell-swing-15-dumbbell-thruster-12-push-c4f5c6', '5 кругов (отдых 60 сек): Kettlebell Swing 15 + Dumbbell Thruster 12 + Push-Up 15 + Renegade Row 8+8 + Reverse Lunge 10+10 + Kettlebell High Pull 10+10 + Burpee 8 + Mountain Climbers 30 сек'),
  ('zhim-ganteley-na-gorizontalnoy-skame-s-neytralnym-hvatom', 'Жим гантелей на горизонтальной скамье с нейтральным хватом'),
  ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-kanata-84bfde', 'Суперсет: Разгибание одной руки на блоке 12 на руку + Разгибание каната из-за головы 15'),
  ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-3718f8', 'Финишер 10 мин: 20 сек Battle Rope/20 сек отдых, 20 сек Burpee/20 сек отдых, 20 сек High Knees/20 сек отдых'),
  ('superset-sgibanie-ruk-na-skame-skotta-10-12-sgibanie-ruk-s-kanatom-15', 'Суперсет: Сгибание рук на скамье Скотта 10–12 + Сгибание рук с канатом 15'),
  ('good-morning', 'Good Morning'),
  ('zhim-plechami-v-trenazhere', 'Жим плечами в тренажёре'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 'Финишер 5 раундов: 30 сек Step-Up/20 сек быстрые выпады/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalnaya-skorost-pri-sohranenii-2ef771', '5 кругов (отдых 60–90 сек, 5-й круг — максимальная скорость при сохранении техники): Kettlebell Clean 10+10 + Goblet Squat 15 + Push-Up 12 + Dumbbell Thruster 10 + Renegade Row 8+8 + Walking Lunges 10+10 + Burpee 8 + High Knees 30 сек'),
  ('razminka-ellips-8-min-posl-2-min-uvelichivaem-temp', 'Разминка: эллипс 8 мин, посл. 2 мин увеличиваем темп'),
  ('zhim-ganteley-na-gorizontalnoy-skame', 'Жим гантелей на горизонтальной скамье'),
  ('zhim-v-trenazhere-na-naklonnoy-skame', 'Жим в тренажёре на наклонной скамье'),
  ('superset-razgibanie-ruk-na-bloke-s-kanatom-12-15-otzhimaniya-uzkim-c82bc9', 'Суперсет: Разгибание рук на блоке с канатом 12–15 + Отжимания узким хватом макс.'),
  ('tyaga-ganteli-odnoy-rukoy-s-oporoy', 'Тяга гантели одной рукой с опорой'),
  ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotkovye-sgibaniya-na-kanate-f13415', 'Суперсет: Сгибание рук с EZ-штангой 10 + Молотковые сгибания на канате 12–15'),
  ('vypady-v-hodbe', 'Выпады в ходьбе'),
  ('podemy-na-noski-stoya', 'Подъёмы на носки стоя'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-tsel-ne-rabotat-do-poteri-500e42', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60 сек, цель — не работать до потери техники, сохранять/увеличивать скорость): Kettlebell Clean 10+10 + Goblet Squat 15 + Push-Up 15 + Dumbbell Row 10+10 + Walking Lunges 10+10 + Dumbbell Thruster 12 + Burpee 8 + Mountain Climbers 30 сек'),
  ('superset-razgibanie-na-bloke-12-otzhimaniya-uzkim-hvatom-maks', 'Суперсет: Разгибание на блоке 12 + Отжимания узким хватом макс.'),
  ('verhniy-blok-odnoy-rukoy', 'Верхний блок одной рукой'),
  ('superset-ez-shtanga-8-10-molotki-12', 'Суперсет: EZ-штанга 8–10 + Молотки 12'),
  ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-goblet-squat-15-push-up-b167de', '5 кругов (отдых 60 сек): Kettlebell Clean 10+10 + Goblet Squat 15 + Push-Up 15 + Dumbbell Row 10+10 + Walking Lunges 10+10 + Dumbbell Thruster 12 + Burpee 10 + Mountain Climbers 40 сек'),
  ('zhim-ganteley-s-pola', 'Жим гантелей с пола')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('krossover-sverhu-vniz-posl-podhod-drop-set', 'Кроссовер сверху вниз (посл. подход — дроп-сет)'),
  ('mahi-v-krossovere-odnoy-rukoy', 'Махи в кроссовере одной рукой'),
  ('superset-frantsuzskiy-zhim-s-ez-shtangoy-10-12-razgibanie-odnoy-ruki-2abc70', 'Суперсет: Французский жим с EZ-штангой 10–12 + Разгибание одной руки на блоке 15'),
  ('razvedenie-kanata-k-litsu', 'Разведение каната к лицу'),
  ('superset-sgibanie-ruk-na-skame-skotta-10-sgibanie-ganteley-na-cf6c11', 'Суперсет: Сгибание рук на скамье Скотта 10 + Сгибание гантелей на наклонной скамье 12'),
  ('frontalnye-prisedaniya', 'Фронтальные приседания'),
  ('tyaga-s-girey-ot-pola', 'Тяга с гирей от пола'),
  ('podemy-na-noski-sidya', 'Подъёмы на носки сидя'),
  ('finisher-5-raundov-20-sek-pryzhki-na-platformu-ili-step-up-20-sek-7f7fa6', 'Финишер 5 раундов: 20 сек прыжки на платформу (или Step-Up)/20 сек walking lunges/20 сек отдых'),
  ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalno-intensivno-no-tehnika-d905b4', '5 кругов (отдых 60–90 сек, 5-й круг — максимально интенсивно, но техника важнее скорости): Kettlebell Swing 20 + Front Rack Reverse Lunge 10+10 + Push-Up 12 + Dumbbell Clean 10+10 + Goblet Squat 15 + Renegade Row 8+8 + Burpee 8 + High Knees 40 сек'),
  ('razminka-dorozhka-s-naklonom-10-min-kazhdye-2-min-uvelichivaem-temp', 'Разминка: дорожка с наклоном 10 мин, каждые 2 мин увеличиваем темп'),
  ('superset-razgibanie-ruk-s-kanatom-12-15-otzhimaniya-uzkim-hvatom-maks', 'Суперсет: Разгибание рук с канатом 12–15 + Отжимания узким хватом макс.'),
  ('finisher-battle-rope-30-sek-rabota-20-sek-otdyh-12', 'Финишер Battle Rope: 30 сек работа/20 сек отдых ×12'),
  ('razminka-grebnoy-trenazher-10-min-posl-3-min-postepennoe-uvelichenie-35420d', 'Разминка: гребной тренажёр 10 мин, посл. 3 мин — постепенное увеличение темпа'),
  ('finisher-skierg-30-sek-bystro-20-sek-spokoyno-12', 'Финишер SkiErg: 30 сек быстро/20 сек спокойно ×12'),
  ('razminka-velotrenazher-10-min', 'Разминка: велотренажёр 10 мин'),
  ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-tsel-kachestvo-temp-30d2f1', 'Круг (Н1 — 4 круга, Н2 — 5 кругов, отдых 60 сек, цель — качество+темп+выносливость, не максимальная скорость): Kettlebell Swing 15 + Dumbbell Thruster 12 + Push-Up 15 + Renegade Row 8+8 + Walking Lunges 10+10 + Kettlebell Clean 10+10 + Burpee 8 + Mountain Climbers 40 сек'),
  ('krossover-posl-podhod-10-chastichnyh-povt', 'Кроссовер (посл. подход +10 частичных повт.)'),
  ('superset-razgibanie-kanata-12-otzhimaniya-uzkim-hvatom-maks', 'Суперсет: Разгибание каната 12 + Отжимания узким хватом макс.'),
  ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-12', 'Финишер Battle Rope: 40 сек работа/20 сек отдых ×12'),
  ('superset-sgibanie-so-shtangoy-8-10-molotki-12', 'Суперсет: Сгибание со штангой 8–10 + Молотки 12'),
  ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-12', 'Финишер SkiErg: 40 сек быстро/20 сек спокойно ×12'),
  ('finisher-5-raundov-30-sek-step-up-20-sek-vypady-20-sek-otdyh', 'Финишер 5 раундов: 30 сек Step-Up/20 сек выпады/20 сек отдых'),
  ('5-krugov-otdyh-60-sek-5-y-krug-maksimalnaya-intensivnost-no-tehnika-325f31', '5 кругов (отдых 60 сек, 5-й круг — максимальная интенсивность, но техника всегда выше скорости): Kettlebell Swing 20 + Dumbbell Thruster 12 + Push-Up 15 + Renegade Row 10+10 + Walking Lunges 12+12 + Kettlebell Clean 10+10 + Burpee 10 + Mountain Climbers 40 сек'),
  ('pec-deck-posl-podhod-dvoynoy-drop-set', 'Pec Deck (посл. подход — двойной дроп-сет)'),
  ('superset-zhim-plechami-v-trenazhere-10-mahi-odnoy-rukoy-v-krossovere-41e20b', 'Суперсет: Жим плечами в тренажёре 10 + Махи одной рукой в кроссовере 15'),
  ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-12', 'Финишер гребля: 45 сек быстро/15 сек спокойно ×12'),
  ('ikry-sidya', 'Икры сидя'),
  ('finisher-5-raundov-20-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 'Финишер 5 раундов: 20 сек Step-Up/20 сек быстрые выпады/20 сек отдых'),
  ('final-20-minutnyy-chellendzh-maksimum-kachestvennyh-krugov-ne-d47bca', 'FINAL 20-минутный челлендж: максимум качественных кругов, не жертвуем техникой — Kettlebell Swing 15, Goblet Squat 15, Push-Up 12, Dumbbell Row 10+10, Walking Lunges 10+10, Dumbbell Thruster 10, Burpee 8, Mountain Climbers 30 сек'),
  ('posle-zaversheniya-5-minut-spokoynoy-hodby', 'После завершения — 5 минут спокойной ходьбы'),
  ('grand-final-test-ves-obem-talii-foto-speredi-sboku-szadi-maks-283ec9', '🏆 GRAND FINAL ТЕСТ: вес, объём талии, фото (спереди/сбоку/сзади), макс. отжиманий, макс. подтягиваний, время планки, количество кругов Final Challenge за 20 минут — сравнить с месяцем 1')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Похудение — Мужчины — Зал)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('pohudenie-muzhchiny-zal', 'Похудение для мужчин (зал) — годовая программа', 'Похудение для мужчин (зал) — годовая программа. Оборудование: Штанга, гантели, тренажёры, блоки, Battle Rope, SkiErg/гребной тренажёр, кардио-зона (дорожка/эллипс/велотренажёр)', 'lose_weight', 'male', 'gym', 'intermediate', 72, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + КАРДИО', 1, 'МЕСЯЦ 1 — LEVEL 1: ЗАПУСК (недели 1–2)', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-7-min-2-min-spokoyno-2-min-sredniy-temp-1-min-308a55', 0, null::int, 420, 60, 1, '7 мин'),
    ('zhim-lezha-ves-umerennyy-ne-do-otkaza', 10, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-na-naklonnoy-skame-posl-2-povt-tyazhelye', 20, 12, null::int, 90, 3, '12'),
    ('svedenie-ruk-v-trenazhere-babochka-posl-povt-2-sek-uderzhanie', 30, 15, null::int, 90, 3, '15'),
    ('krossover-sverhu-vniz-posl-podhod-15-10-chastichnyh', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-bloke-s-kanatom', 50, 15, null::int, 90, 3, '15'),
    ('razgibanie-ganteli-iz-za-golovy', 60, 12, null::int, 90, 3, '12'),
    ('kardio-dorozhka-s-naklonom-5-8-1-min-spokoyno-1-min-bystro-5-10-min', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС + КАРДИО', 2, 'МЕСЯЦ 1 — LEVEL 1: ЗАПУСК (недели 1–2)', 1, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-7-min', 0, null::int, 420, 60, 1, '7 мин'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-gorizontalnogo-bloka-1-sek-uderzhanie-v-kontse', 30, 15, null::int, 90, 3, '15'),
    ('tyaga-ganteli-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-verhnego-bloka-pryamymi-rukami', 50, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-s-gantelyami', 60, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('kardio-lyzhi-skierg-20-sek-bystro-40-sek-spokoyno-8-8-min', 80, null::int, 480, 60, 1, '8 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · НОГИ + ПЛЕЧИ + КАРДИО', 3, 'МЕСЯЦ 1 — LEVEL 1: ЗАПУСК (недели 1–2)', 1, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-7-min-naklon-5-8', 0, null::int, 420, 60, 1, '7 мин'),
    ('prisedaniya-so-shtangoy-tehnika-vazhnee-vesa', 10, 12, null::int, 90, 3, '12'),
    ('zhim-nogami', 20, 15, null::int, 90, 3, '15'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-lezha', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-10-korotkih-povt', 50, 15, null::int, 90, 3, '15'),
    ('podemy-ganteley-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('razvedenie-ganteley-v-naklone', 70, 15, null::int, 90, 3, '15'),
    ('finisher-dorozhka-30-sek-bystro-30-sek-spokoyno-kazhduyu-minutu-5-min', 80, null::int, 300, 60, 1, '5 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС (+5% веса)', 1, 'LEVEL UP — неделя 3', 2, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-lezha-5-vesa-diapazon-10-12', 0, 10, null::int, 90, 3, '10–12'),
    ('zhim-ganteley-na-naklonnoy-skame', 10, 10, null::int, 90, 3, '10–12'),
    ('svedenie-ruk-v-trenazhere-babochka', 20, 15, null::int, 90, 3, '15'),
    ('superset-3-otdyh-posle-pary-60-sek-krossover-sverhu-vniz-15-ecd7f4', 30, null::int, null::int, 60, 3, 'круг'),
    ('razgibanie-ganteli-iz-za-golovy', 40, 12, null::int, 90, 3, '12'),
    ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 50, null::int, 720, 60, 1, '12 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС (+5% веса)', 2, 'LEVEL UP — неделя 3', 2, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-shirokim-hvatom-5-vesa', 0, 10, null::int, 90, 3, '10–12'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('tyaga-gorizontalnogo-bloka', 20, 15, null::int, 90, 3, '15'),
    ('tyaga-ganteli-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на руку'),
    ('superset-3-sgibanie-ruk-s-gantelyami-molotkovye-sgibaniya', 40, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 50, null::int, 720, 60, 1, '12 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · НОГИ + ПЛЕЧИ (+5% веса)', 3, 'LEVEL UP — неделя 3', 2, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy-5-vesa', 0, 10, null::int, 90, 3, '10–12'),
    ('zhim-nogami', 10, 15, null::int, 90, 3, '15'),
    ('vypady-nazad-s-gantelyami', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('razgibanie-nog', 30, 15, null::int, 90, 3, '15'),
    ('superset-3-mahi-gantelyami-v-storony-zadnyaya-delta', 40, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-30-sek-bystro-30-sek-spokoyno-12', 50, null::int, 720, 60, 1, '12 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + РУКИ', 1, 'НОВЫЙ УРОВЕНЬ — неделя 4', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-ganteley-lezha', 10, 10, null::int, 90, 4, '10'),
    ('zhim-v-trenazhere-sidya', 20, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh-aktsent-verh-grudi', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-ot-pola-maksimum-kachestvennyh-ne-do-polnogo-razrusheniya-e5fe91', 40, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-na-bloke-obratnym-hvatom', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-ruk-na-nizhnem-bloke', 60, 12, null::int, 90, 3, '12'),
    ('metabolicheskiy-finisher-3-kruga-20-sek-battle-rope-20-sek-otdyh-20-6b94c1', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ УРОВЕНЬ — неделя 4', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-ili-s-trenazherom-pomoschnikom', 0, 6, null::int, 90, 3, '6–10'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('tyaga-t-grifa', 20, 10, null::int, 90, 3, '10'),
    ('tyaga-bloka-odnoy-rukoy', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-na-skame-skotta', 50, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('kardio-skierg-10-min-30-sek-bystro-30-sek-spokoyno', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 3 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ УРОВЕНЬ — неделя 4', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 10, 12, null::int, 90, 3, '12'),
    ('step-up-na-platformu', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-v-trenazhere', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 50, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('final-cardio-12-min-kazhdye-2-min-30-sek-bystro-30-sek-spokoyno-30-7c1bd5', 70, null::int, 720, 60, 1, '12 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 2 — LEVEL 2: УСКОРЕНИЕ (недели 1–2)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min-temp-postepenno-vyshe', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-na-naklonnoy-skame-posl-podhod-25-30-vesa-5-povt', 10, 10, null::int, 90, 4, '10–12'),
    ('zhim-ganteley-lezha-opuskanie-3-sek', 20, 12, null::int, 90, 3, '12'),
    ('zhim-v-trenazhere-posl-5-povt-maks-kontroliruemo', 30, 12, null::int, 90, 3, '12–15'),
    ('svedenie-ruk-v-krossovere-snizu-vverh-pauza-1-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-pervye-2-podhoda-ne-do-otkaza', 50, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-odnoy-ruki-na-bloke', 70, 12, null::int, 90, 3, '12 на руку'),
    ('finisher-6-min-3-30-sek-battle-rope-30-sek-otdyh-30-sek-bystrye-step-c0c991', 80, null::int, null::int, 60, 3, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 2 — LEVEL 2: УСКОРЕНИЕ (недели 1–2)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('podtyagivaniya-ili-gravitron', 10, 6, null::int, 90, 4, '6–10'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-nizhnego-bloka-uzkim-hvatom', 40, 12, null::int, 90, 3, '12–15'),
    ('pulover-na-verhnem-bloke', 50, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-na-skame-skotta', 60, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('finisher-skierg-8-min-20-sek-bystro-40-sek-spokoyno-8', 80, null::int, 480, 60, 1, '8 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 2 — LEVEL 2: УСКОРЕНИЕ (недели 1–2)', 4, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('gakk-prised-ves-postepenno-uvelichivaem', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-posl-podhod-10-chastichnyh-povt', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('zadnyaya-delta-v-trenazhere', 80, 15, null::int, 90, 3, '15'),
    ('kardio-dorozhka-naklon-7-10-1-min-sredniy-temp-30-sek-bystryy-10-min', 90, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY', 4, 'МЕСЯЦ 2 — LEVEL 2: УСКОРЕНИЕ (недели 1–2)', 4, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-3-kruga-n2-4-kruga-otdyh-90-sek-goblet-squat-15-tyaga-8c4452', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС (+веса)', 1, 'LEVEL UP — неделя 3', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-na-naklonnoy-skame', 0, 10, null::int, 90, 4, '10–12'),
    ('zhim-ganteley-lezha', 10, 12, null::int, 90, 3, '12'),
    ('zhim-v-trenazhere', 20, 12, null::int, 90, 3, '12–15'),
    ('superset-3-krossover-otzhimaniya', 30, null::int, null::int, 60, 3, 'круг'),
    ('razgibanie-ruk-s-kanatom', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-odnoy-ruki-na-bloke', 50, 12, null::int, 90, 3, '12 на руку'),
    ('kardio-15-min-30-sek-bystro-30-sek-spokoyno-15', 60, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС (+веса)', 2, 'LEVEL UP — неделя 3', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, 6, null::int, 90, 4, '6–10'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('tyaga-t-grifa', 20, 10, null::int, 90, 4, '10'),
    ('superset-3-pulover-tyaga-nizhnego-bloka-uzkim-hvatom', 30, null::int, null::int, 60, 3, 'круг'),
    ('sgibanie-ruk-na-skame-skotta', 40, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 50, 12, null::int, 90, 3, '12'),
    ('kardio-15-min-30-sek-bystro-30-sek-spokoyno-15', 60, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ (+веса)', 3, 'LEVEL UP — неделя 3', 5, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 50, 10, null::int, 90, 3, '10–12'),
    ('superset-3-mahi-v-storony-zadnyaya-delta', 60, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-30-sek-bystro-30-sek-spokoyno-15', 70, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY (без отдыха между упр.)', 4, 'LEVEL UP — неделя 3', 5, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-bez-otdyha-mezhdu-uprazhneniyami-otdyh-60-90-sek-tolko-posle-712f1f', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + РУКИ', 1, 'НОВЫЙ УРОВЕНЬ — неделя 4', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-na-naklonnoy', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-sverhu-vniz', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 40, 8, null::int, 90, 3, '8–12'),
    ('frantsuzskiy-zhim-s-ez-shtangoy', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-ruk-s-ez-shtangoy', 60, 12, null::int, 90, 3, '12'),
    ('finisher-10-min-30-sek-skierg-30-sek-otdyh-30-sek-battle-rope-30-sek-5fff94', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ УРОВЕНЬ — неделя 4', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-neytralnym-hvatom', 0, 6, null::int, 90, 4, '6–10'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 10, 12, null::int, 90, 3, '12 на сторону'),
    ('tyaga-ganteley-grudyu-na-naklonnoy-skame', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-na-naklonnoy-skame', 50, 12, null::int, 90, 3, '12'),
    ('molotki-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('kardio-12-min-40-sek-rabota-20-sek-spokoyno-skierg-ellips-velosiped-ce1c4d', 70, null::int, 720, 60, 1, '12 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ УРОВЕНЬ — неделя 4', 6, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnye-prisedaniya-ili-goblet-squat-pri-slaboy-tehnike', 0, 10, null::int, 90, 4, '10'),
    ('giperekstenziya', 10, 15, null::int, 90, 3, '15'),
    ('hodba-vypadami', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('zhim-nogami-uzkoy-postanovkoy', 30, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-sidya', 40, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 50, 12, null::int, 90, 3, '12'),
    ('mahi-v-storony-na-nizhnem-bloke', 60, 15, null::int, 90, 3, '15'),
    ('face-pull', 70, 15, null::int, 90, 3, '15'),
    ('finisher-nog-4-raunda-20-sek-bystrye-step-up-20-sek-prisedaniya-s-c967b7', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC FULL BODY', 4, 'НОВЫЙ УРОВЕНЬ — неделя 4', 6, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('4-kruga-otdyh-90-sek-kettlebell-swing-15-goblet-squat-15-tyaga-8ed7cb', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 3 — LEVEL 3: УСКОРЕНИЕ И ПЛОТНОСТЬ (недели 1–2)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-lezha', 10, 10, null::int, 90, 4, '10–12'),
    ('zhim-ganteley-na-naklonnoy-skame', 20, 10, null::int, 90, 4, '10–12'),
    ('zhim-v-trenazhere-hammer', 30, 12, null::int, 90, 3, '12'),
    ('svedenie-ruk-v-pec-deck', 40, 15, null::int, 90, 3, '15'),
    ('krossover-snizu-vverh', 50, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-na-bloke-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('frantsuzskiy-zhim-s-gantelyu-sidya', 70, 12, null::int, 90, 3, '12'),
    ('finisher-2-podhoda-otzhimaniy-do-otkaza-zatem-battle-rope-30-sek-d5a4ee', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 3 — LEVEL 3: УСКОРЕНИЕ И ПЛОТНОСТЬ (недели 1–2)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 10, 10, null::int, 90, 4, '10–12'),
    ('podtyagivaniya-obratnym-hvatom', 20, 6, null::int, 90, 3, '6–10'),
    ('tyaga-gorizontalnogo-bloka-k-zhivotu', 30, 12, null::int, 90, 4, '12'),
    ('tyaga-ganteli-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на сторону'),
    ('pulover-s-kanatom', 50, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-so-shtangoy', 60, 10, null::int, 90, 3, '10–12'),
    ('molotkovye-sgibaniya', 70, 12, null::int, 90, 3, '12'),
    ('finisher-skierg-10-min-20-sek-bystro-40-sek-spokoyno-10', 80, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 3 — LEVEL 3: УСКОРЕНИЕ И ПЛОТНОСТЬ (недели 1–2)', 7, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velosiped-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('prisedaniya-so-shtangoy', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('razgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('razvedenie-ruk-na-zadnyuyu-deltu', 80, 15, null::int, 90, 3, '15'),
    ('finisher-step-up-30-sek-rabota-30-sek-otdyh-6', 90, null::int, null::int, 60, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY', 4, 'МЕСЯЦ 3 — LEVEL 3: УСКОРЕНИЕ И ПЛОТНОСТЬ (недели 1–2)', 7, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-4-kruga-na-2-y-nedele-2-5-5-vesa-pri-sohranenii-547002', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3 (плотность)', 8, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-naklonnoy', 10, 10, null::int, 90, 3, '10'),
    ('hammer', 20, 12, null::int, 90, 3, '12'),
    ('pec-deck-otzhimaniya-superset', 30, 12, null::int, 90, 3, '12 + макс.'),
    ('razgibanie-ruk-s-kanatom', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-iz-za-golovy-na-bloke-posl-podhod-tritsepsa-drop-set', 50, 12, null::int, 90, 3, '12'),
    ('kardio-15-min-30-sek-vysokaya-intensivnost-30-sek-umerenno-15', 60, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3 (плотность)', 8, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka', 0, 10, null::int, 90, 4, '10'),
    ('podtyagivaniya-maksimum-kachestvennyh-povt', 10, null::int, null::int, 90, 4, 'макс.'),
    ('gorizontalnaya-tyaga', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-ganteli-odnoy-rukoy', 30, 12, null::int, 90, 3, '12'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-so-shtangoy', 50, 10, null::int, 90, 3, '10'),
    ('molotki-posl-podhod-bitsepsa-snizhenie-vesa-10-povt', 60, 12, null::int, 90, 3, '12'),
    ('kardio-15-min-30-sek-vysokaya-intensivnost-30-sek-umerenno-15', 70, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3 (плотность)', 8, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 3, '10'),
    ('vypady', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('razgibanie-nog', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley', 50, 10, null::int, 90, 3, '10'),
    ('superset-3-mahi-v-storony-15-zadnyaya-delta-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-30-sek-vysokaya-intensivnost-30-sek-umerenno-15', 70, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC FULL BODY', 4, 'LEVEL UP — неделя 3 (плотность)', 8, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-zadacha-ne-maks-ves-a-maksimalnaya-13766b', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + РУКИ', 1, 'НОВЫЙ LEVEL — неделя 4', 9, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-lezha', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-gorizontalnoy-skame-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('zhim-v-trenazhere-pod-nebolshim-naklonom', 20, 12, null::int, 90, 3, '12'),
    ('krossover-sverhu-vniz', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 40, 8, null::int, 90, 3, '8–12'),
    ('razgibanie-ruk-s-ez-shtangoy-lezha', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-ruk-na-skame-skotta', 60, 12, null::int, 90, 3, '12'),
    ('finisher-battle-rope-20-sek-rabota-40-sek-otdyh-8', 70, null::int, null::int, 60, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 9, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('podtyagivaniya-shirokim-hvatom', 10, null::int, null::int, 90, 3, 'макс.'),
    ('tyaga-t-grifa-s-uporom-grudyu', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-na-naklonnoy-skame', 50, 12, null::int, 90, 3, '12'),
    ('molotki-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('giperekstenziya', 10, 15, null::int, 90, 3, '15'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami-shirokoy-postanovkoy', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-sidya', 40, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 50, 10, null::int, 90, 3, '10–12'),
    ('mahi-na-nizhnem-bloke', 60, 15, null::int, 90, 3, '15'),
    ('zadnyaya-delta-v-trenazhere', 70, 15, null::int, 90, 3, '15'),
    ('finisher-nog-5-raundov-30-sek-step-up-30-sek-prisedaniya-bez-vesa-30-21eca5', 80, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · CROSS TRAINING', 4, 'НОВЫЙ LEVEL — неделя 4', 9, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('4-kruga-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-30be00', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 4 — LEVEL 4: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС (недели 1–2)', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-ganteley-na-naklonnoy-skame-posl-podhod-10-povt-25-vesa-8-10-povt', 10, 10, null::int, 90, 4, '10'),
    ('zhim-shtangi-lezha-uzkim-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-v-trenazhere-sidya-posl-3-povt-medlenno', 30, 12, null::int, 90, 3, '12'),
    ('krossover-sverhu-vniz-pauza-1-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-pervye-2-podhoda-ne-do-otkaza', 50, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-s-kanatom-posl-podhod-drop-set', 60, 15, null::int, 90, 3, '15'),
    ('razgibanie-odnoy-ruki-iz-za-golovy-na-bloke', 70, 12, null::int, 90, 3, '12 на руку'),
    ('finisher-8-min-8-20-sek-battle-rope-40-sek-otdyh-20-sek-bystrye-step-062345', 80, null::int, null::int, 60, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 4 — LEVEL 4: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС (недели 1–2)', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 10, 10, null::int, 90, 4, '10–12'),
    ('podtyagivaniya-neytralnym-hvatom-ili-gravitron', 20, 6, null::int, 90, 3, '6–10'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на сторону'),
    ('pulover-na-verhnem-bloke', 50, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-s-ez-shtangoy', 60, 10, null::int, 90, 3, '10–12'),
    ('molotkovye-sgibaniya-posl-podhod-snizit-ves-10-povt', 70, 12, null::int, 90, 3, '12'),
    ('kardio-finisher-skierg-10-min-30-sek-bystro-30-sek-spokoyno-10', 80, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 4 — LEVEL 4: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС (недели 1–2)', 10, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('gakk-prised', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10'),
    ('vypady-nazad', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('zhim-nogami', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-sidya-posl-podhod-10-sek-uderzhanie-v-sokraschenii', 50, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 60, 10, null::int, 90, 3, '10–12'),
    ('mahi-gantelyami-v-storony', 70, 15, null::int, 90, 3, '15'),
    ('razvedenie-na-zadnyuyu-deltu', 80, 15, null::int, 90, 3, '15'),
    ('finisher-4-raunda-30-sek-step-up-30-sek-prisedaniya-s-sobstvennym-c61f50', 90, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY', 4, 'МЕСЯЦ 4 — LEVEL 4: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС (недели 1–2)', 10, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-kettlebell-swing-15-goblet-squat-15-zhim-ganteley-na-naklonnoy-bba38d', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-trenazhere', 10, 10, null::int, 90, 3, '10'),
    ('krossover', 20, 15, null::int, 90, 3, '15'),
    ('otzhimaniya', 30, null::int, null::int, 90, 3, 'макс.'),
    ('superset-3-posl-do-tehnicheskogo-otkaza-razgibanie-kanatom-otzhimaniya', 40, null::int, null::int, 60, 3, 'круг'),
    ('razgibanie-odnoy-ruki', 50, 12, null::int, 90, 3, '12'),
    ('kardio-15-min-30-sek-bystro-30-sek-umerenno-15', 60, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka', 0, 10, null::int, 90, 4, '10'),
    ('podtyagivaniya', 10, null::int, null::int, 90, 3, 'макс.'),
    ('tyaga-t-grifa', 20, 10, null::int, 90, 3, '10'),
    ('gorizontalnaya-tyaga', 30, 12, null::int, 90, 3, '12'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('superset-3-ez-bitseps-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('kardio-15-min-30-sek-bystro-30-sek-umerenno-15', 60, null::int, 900, 60, 1, '15 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 3, '10'),
    ('vypady', 20, 10, null::int, 90, 3, '10+10'),
    ('zhim-nogami', 30, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 50, 10, null::int, 90, 3, '10'),
    ('superset-3-mahi-v-storony-15-zadnyaya-delta-15', 60, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC LEVEL', 4, 'LEVEL UP — неделя 3', 11, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-zhim-76b690', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + РУКИ', 1, 'НОВЫЙ LEVEL — неделя 4', 12, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-v-smite', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-snizu-vverh', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 40, 8, null::int, 90, 3, '8–12'),
    ('frantsuzskiy-zhim-s-ez-shtangoy', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-ruk-na-skame-skotta', 60, 12, null::int, 90, 3, '12'),
    ('finisher-10-min-10-20-sek-battle-rope-40-sek-otdyh-20-sek-step-up-40-f90955', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 12, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('podtyagivaniya-shirokim-hvatom', 10, null::int, null::int, 90, 3, 'макс.'),
    ('tyaga-ganteley-grudyu-na-naklonnoy-skame', 20, 10, null::int, 90, 4, '10'),
    ('gorizontalnaya-tyaga-shirokim-hvatom', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-ruk-na-naklonnoy-skame', 50, 12, null::int, 90, 3, '12'),
    ('molotki-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised-ili-goblet-squat-4-12-pri-slaboy-tehnike', 0, 8, null::int, 90, 4, '8–10'),
    ('giperekstenziya', 10, 15, null::int, 90, 3, '15'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami-shirokoy-postanovkoy', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-sidya', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 50, 10, null::int, 90, 3, '10'),
    ('mahi-na-nizhnem-bloke', 60, 15, null::int, 90, 3, '15'),
    ('zadnyaya-delta', 70, 15, null::int, 90, 3, '15'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-pryzhkovye-prisedaniya-ili-00e88c', 80, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · CROSS TRAINING', 4, 'НОВЫЙ LEVEL — неделя 4', 12, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-a02ea9', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 5 — LEVEL 5: СИЛА + СКОРОСТЬ + ВЫНОСЛИВОСТЬ (недели 1–2)', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-na-naklonnoy-skame-posl-podhod-10-25-vesa-8-10-povt', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-lezha', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-v-trenazhere-hammer-posl-3-povt-medlenno', 30, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh-pauza-1-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('superset-bez-otdyha-otzhimaniya-s-uzkoy-postanovkoy-maks-razgibanie-0c0deb', 50, null::int, null::int, 60, 1, 'круг'),
    ('finisher-8-min-2-20-sek-battle-rope-20-sek-otdyh-20-sek-bystrye-590e2c', 60, null::int, null::int, 60, 2, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 5 — LEVEL 5: СИЛА + СКОРОСТЬ + ВЫНОСЛИВОСТЬ (недели 1–2)', 13, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-uzkim-hvatom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteli-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на сторону'),
    ('tyaga-verhnego-bloka-pryamymi-rukami', 40, 15, null::int, 90, 3, '15'),
    ('giperekstenziya', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-gantelyami-na-naklonnoy-skame-10-12-e26502', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-10-min-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 5 — LEVEL 5: СИЛА + СКОРОСТЬ + ВЫНОСЛИВОСТЬ (недели 1–2)', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-nogami-ves-rabochiy-bez-poteri-tehniki', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-so-shtangoy', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-lezha-posl-3-povt-medlenno', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10'),
    ('superset-mahi-gantelyami-v-storony-15-razvedenie-ganteley-v-naklone-15', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-nog-4-raunda-30-sek-bystrye-step-up-20-sek-prisedaniya-20-0bcdc9', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY', 4, 'МЕСЯЦ 5 — LEVEL 5: СИЛА + СКОРОСТЬ + ВЫНОСЛИВОСТЬ (недели 1–2)', 13, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krugovaya-trenirovka-n1-4-kruga-n2-5-krugov-otdyh-90-sek-kettlebell-ac45df', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-na-naklonnoy', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-lezha', 10, 10, null::int, 90, 3, '10'),
    ('hammer', 20, 12, null::int, 90, 3, '12'),
    ('krossover-posl-podhod-drop-set', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-uzkim-hvatom', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-kanatom-12-razgibanie-nad-golovoy-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('kardio-10-min-30-sek-bystro-30-sek-spokoyno-10', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('verhniy-blok-neytralnym-hvatom', 0, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnaya-tyaga', 10, 10, null::int, 90, 3, '10'),
    ('tyaga-ganteli-odnoy-rukoy', 20, 10, null::int, 90, 3, '10'),
    ('pulover', 30, 15, null::int, 90, 3, '15'),
    ('giperekstenziya', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-na-naklonnoy-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-10-min-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-nogami', 0, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 3, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10+10'),
    ('razgibanie-nog-posl-podhod-drop-set', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-v-storony-15-zadnyaya-delta-15', 60, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC LEVEL', 4, 'LEVEL UP — неделя 3', 14, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-otzhimaniya-e79c6f', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + РУКИ', 1, 'НОВЫЙ LEVEL — неделя 4', 15, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-s-nebolshim-naklonom', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-na-urovne-grudi', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 40, 8, null::int, 90, 3, '8–12'),
    ('frantsuzskiy-zhim-s-gantelyu', 50, 12, null::int, 90, 3, '12'),
    ('sgibanie-ruk-na-skame-skotta', 60, 12, null::int, 90, 3, '12'),
    ('finisher-10-min-5-20-sek-battle-rope-20-sek-otdyh-20-sek-step-up-20-c3a2e3', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 15, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-t-grifa-s-uporom-grudyu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-nizhnego-bloka-shirokim-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-kanata-k-litsu', 30, 15, null::int, 90, 3, '15'),
    ('pulover-s-gantelyu', 40, 12, null::int, 90, 3, '12'),
    ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotki-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-grebnoy-trenazher-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 15, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('yagodichnyy-most-v-trenazhere', 10, 12, null::int, 90, 4, '12'),
    ('vypady-hodboy', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-sidya', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-arnolda', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-v-storony-na-nizhnem-bloke-15-face-pull-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-4e83ae', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · CROSS TRAINING', 4, 'НОВЫЙ LEVEL — неделя 4', 15, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-0b13de', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 6 — LEVEL 6: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС + НОВЫЕ ДВИЖЕНИЯ (недели 1–2)', 16, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-lezha', 10, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10–12'),
    ('pec-deck-posl-podhod-30-vesa-10-povt', 30, 12, null::int, 90, 3, '12–15'),
    ('krossover-sverhu-vniz-pauza-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-ot-pola', 50, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-ruk-na-bloke-s-kanatom-12-15-frantsuzskiy-zhim-s-1dd586', 60, null::int, null::int, 60, 3, 'круг'),
    ('kardio-finisher-na-velotrenazhere-10-min-30-sek-bystro-30-sek-spokoyno', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 6 — LEVEL 6: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС + НОВЫЕ ДВИЖЕНИЯ (недели 1–2)', 16, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('podtyagivaniya-obychnym-hvatom-ili-negativnye-3-6-8', 10, null::int, null::int, 90, 3, 'макс.'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-nizhnego-bloka-k-zhivotu', 40, 12, null::int, 90, 3, '12'),
    ('face-pull', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-ez-shtangoy-10-12-sgibanie-ruk-na-nizhnem-510bbb', 60, null::int, null::int, 60, 3, 'круг'),
    ('kardio-skierg-10-min-40-sek-bystro-20-sek-spokoyno', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 6 — LEVEL 6: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС + НОВЫЕ ДВИЖЕНИЯ (недели 1–2)', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('gakk-prised', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-sidya', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10'),
    ('superset-mahi-gantelyami-v-storony-15-obratnaya-babochka-15', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-nog-4-raunda-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY', 4, 'МЕСЯЦ 6 — LEVEL 6: СИЛА + МЕТАБОЛИЧЕСКИЙ СТРЕСС + НОВЫЕ ДВИЖЕНИЯ (недели 1–2)', 16, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krugovaya-trenirovka-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-3db7e2', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-posl-podhod-drop-set', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-na-naklonnoy', 10, 10, null::int, 90, 4, '10'),
    ('pec-deck-posl-podhod-drop-set', 20, 12, null::int, 90, 3, '12'),
    ('krossover', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-s-kanatom-12-frantsuzskiy-zhim-10-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-30-sek-rabota-30-sek-otdyh-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 4, '8–10'),
    ('tyaga-nizhnego-bloka', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-ez-sgibaniya-10-nizhniy-blok-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-30-sek-bystro-30-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 17, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad', 20, 10, null::int, 90, 3, '10+10'),
    ('sgibanie-nog', 30, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 50, 8, null::int, 90, 4, '8–10'),
    ('superset-mahi-v-storony-15-obratnaya-babochka-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-4e83ae', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY LEVEL UP', 4, 'LEVEL UP — неделя 3', 17, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-otzhimaniya-b10323', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 18, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-na-naklonnoy-skame', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-trenazhere-hammer', 10, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-lezha-neytralnym-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh-posl-podhod-drop-set', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 40, 8, null::int, 90, 3, '8–12'),
    ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-ruk-s-ad62d3', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-mountain-b4a9cc', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 18, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-s-uporom-grudyu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-ganteley-na-naklonnoy-skame', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-kanata-k-litsu', 30, 15, null::int, 90, 3, '15'),
    ('pulover-na-bloke', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-12-molotki-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 18, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-nogami', 0, 10, null::int, 90, 4, '10'),
    ('yagodichnyy-most-v-trenazhere', 10, 12, null::int, 90, 4, '12'),
    ('vypady-hodboy', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-lezha', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog', 40, 15, null::int, 90, 3, '15'),
    ('zhim-arnolda', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-na-nizhnem-bloke-15-face-pull-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · CROSS TRAINING', 4, 'НОВЫЙ LEVEL — неделя 4', 18, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-vypady-hodboy-10-10-ce8402', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'МЕСЯЦ 7 — LEVEL 7: СИЛА + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-ganteley-na-gorizontalnoy-skame-posl-podhod-25-vesa-10-povt', 10, 10, null::int, 90, 4, '10'),
    ('zhim-shtangi-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10'),
    ('svedenie-ruk-v-trenazhere-posl-5-povt-medlenno', 30, 15, null::int, 90, 3, '15'),
    ('krossover-snizu-vverh', 40, 15, null::int, 90, 3, '15'),
    ('superset-zhim-ganteley-sidya-10-mahi-gantelyami-v-storony-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('superset-razgibanie-ruk-s-pryamoy-rukoyatyu-12-razgibanie-odnoy-ruki-174b66', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rock-30-sek-rabota-30-sek-otdyh-10-10-min', 70, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 7 — LEVEL 7: СИЛА + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-k-grudi-shirokim-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 3, '10'),
    ('tyaga-ganteley-lezha-grudyu-na-naklonnoy-skame', 40, 12, null::int, 90, 3, '12'),
    ('pulover-s-pryamymi-rukami-na-bloke', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-gantelyami-sidya-10-molotkovye-sgibaniya-12', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-grebnoy-trenazher-10-min-20-sek-maksimalno-bystro-40-sek-c368a8', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'МЕСЯЦ 7 — LEVEL 7: СИЛА + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('prised-v-smite', 10, 10, null::int, 90, 4, '10'),
    ('yagodichnyy-most-so-shtangoy', 20, 12, null::int, 90, 4, '12'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-lezha', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-nazad-v-krossovere', 60, 15, null::int, 90, 3, '15 на ногу'),
    ('podem-na-noski-stoya', 70, 15, null::int, 90, 4, '15–20'),
    ('finisher-4-raunda-30-sek-hodba-na-vysokoy-platforme-20-sek-4449b7', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 7 — LEVEL 7: СИЛА + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 19, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-kettlebell-clean-10-na-8031fc', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 20, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-lezha-posl-podhod-drop-set', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-shtangi-na-naklonnoy', 10, 8, null::int, 90, 4, '8–10'),
    ('pec-deck-posl-podhod-drop-set', 20, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh', 30, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 50, 15, null::int, 90, 3, '15'),
    ('superset-razgibanie-na-bloke-12-razgibanie-odnoy-rukoy-12', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 20, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('verhniy-blok-shirokim-hvatom', 0, 8, null::int, 90, 4, '8–10'),
    ('tyaga-t-grifa', 10, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnaya-tyaga', 20, 10, null::int, 90, 3, '10'),
    ('tyaga-ganteley-grudyu-na-skame', 30, 12, null::int, 90, 3, '12'),
    ('pulover-na-bloke', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ganteley-sidya-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'LEVEL UP — неделя 3', 20, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prised-v-smite', 0, 8, null::int, 90, 4, '8–10'),
    ('yagodichnyy-most', 10, 10, null::int, 90, 4, '10'),
    ('vypady-nazad', 20, 10, null::int, 90, 3, '10+10'),
    ('sgibanie-nog', 30, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-v-krossovere', 50, 15, null::int, 90, 3, '15'),
    ('ikry', 60, 15, null::int, 90, 4, '15–20'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC LEVEL UP', 4, 'LEVEL UP — неделя 3', 20, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-goblet-squat-15-550409', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-trenazhere-hammer', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-nizkom-naklone', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-s-pauzoy', 20, 15, null::int, 90, 3, '15'),
    ('krossover-sverhu-vniz', 30, 15, null::int, 90, 3, '15'),
    ('superset-zhim-arnolda-10-mahi-na-nizhnem-bloke-15', 40, null::int, null::int, 60, 3, 'круг'),
    ('superset-otzhimaniya-uzkim-hvatom-maks-razgibanie-kanata-nad-golovoy-cc0c1e', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-8-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-8273be', 60, null::int, 480, 60, 1, '8 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-odnoy-rukoy', 10, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 12, null::int, 90, 3, '12'),
    ('face-pull', 30, 15, null::int, 90, 3, '15'),
    ('tyaga-pryamymi-rukami-na-bloke', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-molotki-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'НОВЫЙ LEVEL — неделя 4', 21, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-nogami-uzkoy-postanovkoy', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 10, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-sidya', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-v-trenazhere', 50, 15, null::int, 90, 3, '15'),
    ('podem-na-noski-sidya', 60, 20, null::int, 90, 4, '20'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-vyprygivaniya-iz-polupriseda-962731', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC CHALLENGE', 4, 'НОВЫЙ LEVEL — неделя 4', 21, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-walking-lunges-10-10-b2db07', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 8 — LEVEL 8: СИЛА + ВЫНОСЛИВОСТЬ + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-uzkim-hvatom', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-v-trenazhere-hammer-posl-podhod-30-vesa-10-povt', 30, 12, null::int, 90, 3, '12'),
    ('krossover-na-urovne-grudi-pauza-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-s-pomoschyu', 50, 8, null::int, 90, 3, '8–12'),
    ('superset-razgibanie-ruk-na-verhnem-bloke-kanatom-12-15-frantsuzskiy-9174aa', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-30-sek-rabota-30-sek-otdyh-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 8 — LEVEL 8: СИЛА + ВЫНОСЛИВОСТЬ + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('podtyagivaniya-neytralnym-hvatom-ili-negativnye-4-5-6', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka-k-grudi-uzkim-neytralnym-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('tyaga-t-grifa-s-uporom-grudyu', 30, 10, null::int, 90, 4, '10'),
    ('gorizontalnaya-tyaga-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на руку'),
    ('pulover-s-kanatom', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotkovye-sgibaniya-s-c6bed4', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 8 — LEVEL 8: СИЛА + ВЫНОСЛИВОСТЬ + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('frontalnyy-prised', 10, 8, null::int, 90, 4, '8–10'),
    ('yagodichnyy-most-so-shtangoy', 20, 10, null::int, 90, 4, '10–12'),
    ('vypady-hodboy', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-lezha', 40, 12, null::int, 90, 3, '12–15'),
    ('razgibanie-nog-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('zhim-arnolda', 60, 10, null::int, 90, 3, '10'),
    ('superset-mahi-gantelyami-v-storony-15-razvedenie-ganteley-v-naklone-15', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-4-raunda-30-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 8 — LEVEL 8: СИЛА + ВЫНОСЛИВОСТЬ + ПЛОТНОСТЬ + АТЛЕТИЧНОСТЬ (недели 1–2)', 22, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-90-sek-kettlebell-clean-10-10-71928b', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 23, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-uzkim-hvatom', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-na-naklonnoy', 10, 10, null::int, 90, 4, '10'),
    ('hammer-posl-podhod-drop-set', 20, 10, null::int, 90, 3, '10–12'),
    ('krossover', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-kanatom-12-frantsuzskiy-zhim-10', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 23, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-neytralnym-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('verhniy-blok', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnaya-tyaga', 30, 10, null::int, 90, 3, '10'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('superset-ez-sgibaniya-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 23, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised', 0, 8, null::int, 90, 4, '8'),
    ('yagodichnyy-most', 10, 10, null::int, 90, 4, '10'),
    ('vypady-hodboy', 20, 10, null::int, 90, 3, '10+10'),
    ('sgibanie-nog', 30, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-stoya', 50, 8, null::int, 90, 4, '8–10'),
    ('superset-mahi-v-storony-15-zadnyaya-delta-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC LEVEL UP', 4, 'LEVEL UP — неделя 3', 23, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-front-rack-squat-12-push-156b92', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 24, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-na-gorizontalnoy-skame', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-naklonnoy-skame-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-snizu-vverh', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-s-nogami-na-skame', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-kanata-8691b5', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-564cf8', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 24, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 10, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-nizhnego-bloka-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на руку'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-12-molotki-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-grebnoy-trenazher-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 24, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 10, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-sidya', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-stoya', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-na-nizhnem-bloke-15-face-pull-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-4e83ae', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC CHALLENGE', 4, 'НОВЫЙ LEVEL — неделя 4', 24, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-kettlebell-swing-15-goblet-squat-15-d2cc68', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 9 — LEVEL 9: СИЛА + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (недели 1–2)', 25, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-ganteley-lezha', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-shtangi-na-naklonnoy-skame', 20, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-trenazhere-sidya-posl-podhod-30-vesa-10-povt', 30, 12, null::int, 90, 3, '12'),
    ('svedenie-ruk-v-krossovere-sverhu-vniz-pauza-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah-ili-s-pomoschyu-trenazhera', 50, 8, null::int, 90, 3, '8–12'),
    ('superset-razgibanie-ruk-s-ez-grifom-nad-golovoy-10-12-razgibanie-c29492', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-assault-bike-20-sek-maksimalno-bystro-40-sek-spokoyno-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 9 — LEVEL 9: СИЛА + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (недели 1–2)', 25, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('podtyagivaniya-shirokim-hvatom-ili-negativnye-4-5', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('tyaga-ganteley-na-naklonnoy-skame-grudyu-vniz', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-uzkim-hvatom', 40, 12, null::int, 90, 3, '12'),
    ('face-pull', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-gantelyami-na-naklonnoy-skame-10-12-141f99', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 9 — LEVEL 9: СИЛА + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (недели 1–2)', 25, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('gakk-prised', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-so-shtangoy', 20, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami', 40, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-sidya-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10'),
    ('superset-mahi-gantelyami-v-storony-15-obratnaya-babochka-15', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-4-raunda-30-sek-step-up-20-sek-pryzhki-cherez-nevysokuyu-a562cc', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 9 — LEVEL 9: СИЛА + ЖИРОСЖИГАНИЕ + АТЛЕТИЧНОСТЬ (недели 1–2)', 25, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-bfd126', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 26, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-lezha', 0, 8, null::int, 90, 4, '8'),
    ('zhim-shtangi-na-naklonnoy', 10, 8, null::int, 90, 4, '8'),
    ('zhim-v-trenazhere-posl-podhod-drop-set', 20, 10, null::int, 90, 3, '10'),
    ('krossover-sverhu-vniz-posl-podhod-10-chastichnyh-povt', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-ez-grifa-nad-golovoy-10-razgibanie-odnoy-rukoy-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-assault-bike-30-sek-bystro-30-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 26, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('verhniy-blok', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-ganteley-grudyu-na-skame', 20, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnyy-blok', 30, 10, null::int, 90, 3, '10'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-bitseps-na-naklonnoy-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 26, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad', 20, 10, null::int, 90, 3, '10+10'),
    ('zhim-nogami', 30, 10, null::int, 90, 3, '10'),
    ('sgibanie-nog-posl-podhod-drop-set', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-sidya', 50, 8, null::int, 90, 4, '8–10'),
    ('superset-mahi-v-storony-15-obratnaya-babochka-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-pryzhki-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC LEVEL UP', 4, 'LEVEL UP — неделя 3', 26, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-swing-15-goblet-squat-15-push-up-15-4b4eff', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 27, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-polu', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-snizu-vverh-pauza-2-sek', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-ruk-na-bloke-obratnym-hvatom-12-razgibanie-kanata-73d151', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-564cf8', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 27, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 10, 12, null::int, 90, 4, '12'),
    ('tyaga-odnoy-ganteli-s-uporom', 20, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на руку'),
    ('pulover-v-trenazhere', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-sgibanie-ruk-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 27, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-nogami-uzkoy-postanovkoy', 0, 12, null::int, 90, 4, '12'),
    ('good-morning-so-shtangoy', 10, 10, null::int, 90, 3, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-lezha', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('zhim-v-trenazhere-dlya-plech', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-odnoy-rukoy-v-krossovere-15-na-ruku-razvedenie-na-c3882b', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-s-sobstvennym-7b5a13', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC CHALLENGE', 4, 'НОВЫЙ LEVEL — неделя 4', 27, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalnaya-skorost-pri-sohranenii-7ac458', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'МЕСЯЦ 10 — LEVEL 10: СИЛА + ЖИРОСЖИГАНИЕ + СКОРОСТЬ (недели 1–2)', 28, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-shtangi-na-gorizontalnoy-skame', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10–12'),
    ('zhim-v-trenazhere-hammer-posl-podhod-30-vesa-10-povt', 30, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh-pauza-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-s-nogami-na-skame', 50, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-ruk-na-verhnem-bloke-pryamoy-rukoyatyu-12-06dd67', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-30-sek-rabota-30-sek-otdyh-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 10 — LEVEL 10: СИЛА + ЖИРОСЖИГАНИЕ + СКОРОСТЬ (недели 1–2)', 28, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('podtyagivaniya-neytralnym-hvatom-ili-negativnye', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka-k-grudi-shirokim-hvatom', 20, 10, null::int, 90, 3, '10–12'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на руку'),
    ('pulover-s-pryamoy-rukoyatyu', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-so-shtangoy-10-molotkovye-sgibaniya-12', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'МЕСЯЦ 10 — LEVEL 10: СИЛА + ЖИРОСЖИГАНИЕ + СКОРОСТЬ (недели 1–2)', 28, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('prisedaniya-v-smite', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('zhim-nogami-shirokoy-postanovkoy', 40, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-lezha-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 60, 10, null::int, 90, 3, '10'),
    ('superset-mahi-gantelyami-v-storony-15-razvedenie-ruk-v-trenazhere-15', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-4-raunda-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-f113f4', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 10 — LEVEL 10: СИЛА + ЖИРОСЖИГАНИЕ + СКОРОСТЬ (недели 1–2)', 28, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-kettlebell-swing-15-dumbbell-af26d6', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'LEVEL UP — неделя 3', 29, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-na-naklonnoy', 10, 10, null::int, 90, 4, '10'),
    ('hammer-posl-podhod-drop-set', 20, 10, null::int, 90, 3, '10'),
    ('krossover-snizu-vverh-posl-podhod-10-chastichnyh-povt', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-s-nogami-na-skame', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-pryamoy-rukoyatyu-10-kanat-nad-golovoy-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'LEVEL UP — неделя 3', 29, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('verhniy-blok', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnaya-tyaga-odnoy-rukoy', 30, 10, null::int, 90, 3, '10'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-so-shtangoy-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'LEVEL UP — неделя 3', 29, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prised-v-smite', 0, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8–10'),
    ('vypady-nazad', 20, 10, null::int, 90, 3, '10+10'),
    ('zhim-nogami', 30, 10, null::int, 90, 3, '10'),
    ('sgibanie-nog-posl-podhod-drop-set', 40, 12, null::int, 90, 3, '12'),
    ('zhim-ganteley-sidya', 50, 8, null::int, 90, 4, '8–10'),
    ('superset-mahi-v-storony-15-obratnaya-babochka-15', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC LEVEL UP', 4, 'LEVEL UP — неделя 3', 29, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-swing-15-dumbbell-thruster-12-push-c4f5c6', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 30, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-gorizontalnoy-skame-s-neytralnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('zhim-v-smite-na-naklonnoy-skame', 10, 10, null::int, 90, 3, '10–12'),
    ('pec-deck-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-sverhu-vniz-pauza-2-sek', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-uzkim-hvatom', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-razgibanie-odnoy-ruki-na-bloke-12-na-ruku-razgibanie-kanata-84bfde', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-3718f8', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 30, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-verhnego-bloka-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-shirokim-hvatom', 10, 12, null::int, 90, 4, '12'),
    ('tyaga-ganteley-s-uporom-grudyu', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на руку'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-12-sgibanie-ruk-s-kanatom-15', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ПЛЕЧИ', 3, 'НОВЫЙ LEVEL — неделя 4', 30, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('good-morning', 10, 10, null::int, 90, 3, '10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-sidya', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('zhim-plechami-v-trenazhere', 50, 10, null::int, 90, 3, '10'),
    ('superset-mahi-odnoy-rukoy-v-krossovere-15-na-ruku-razvedenie-na-c3882b', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC CHALLENGE', 4, 'НОВЫЙ LEVEL — неделя 4', 30, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalnaya-skorost-pri-sohranenii-2ef771', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'МЕСЯЦ 11 — LEVEL 11: ATHLETIC CUT — СИЛА + РЕЛЬЕФ + ВЫНОСЛИВОСТЬ (недели 1–2)', 31, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-ellips-8-min-posl-2-min-uvelichivaem-temp', 0, null::int, 480, 60, 1, '8 мин'),
    ('zhim-ganteley-na-gorizontalnoy-skame', 10, 10, null::int, 90, 4, '10'),
    ('zhim-v-trenazhere-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10–12'),
    ('pec-deck-posl-podhod-drop-set', 30, 15, null::int, 90, 3, '15'),
    ('zhim-ganteley-sidya', 40, 10, null::int, 90, 3, '10'),
    ('mahi-gantelyami-v-storony', 50, 15, null::int, 90, 3, '15'),
    ('superset-razgibanie-ruk-na-bloke-s-kanatom-12-15-otzhimaniya-uzkim-c82bc9', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-30-sek-rabota-30-sek-otdyh-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 11 — LEVEL 11: ATHLETIC CUT — СИЛА + РЕЛЬЕФ + ВЫНОСЛИВОСТЬ (недели 1–2)', 31, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-uzkim-hvatom', 20, 10, null::int, 90, 4, '10–12'),
    ('tyaga-ganteli-odnoy-rukoy-s-oporoy', 30, 12, null::int, 90, 3, '12 на руку'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на руку'),
    ('face-pull', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-s-ez-shtangoy-10-molotkovye-sgibaniya-na-kanate-f13415', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-30-sek-spokoyno-10', 70, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'МЕСЯЦ 11 — LEVEL 11: ATHLETIC CUT — СИЛА + РЕЛЬЕФ + ВЫНОСЛИВОСТЬ (недели 1–2)', 31, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-8-min', 0, null::int, 480, 60, 1, '8 мин'),
    ('gakk-prised', 10, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-so-shtangoy', 20, 10, null::int, 90, 4, '10'),
    ('vypady-v-hodbe', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('zhim-nogami-uzkoy-postanovkoy', 40, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-sidya-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('yagodichnyy-most-v-trenazhere', 60, 12, null::int, 90, 3, '12'),
    ('podemy-na-noski-stoya', 70, 15, null::int, 90, 4, '15–20'),
    ('finisher-4-raunda-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-f113f4', 80, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 11 — LEVEL 11: ATHLETIC CUT — СИЛА + РЕЛЬЕФ + ВЫНОСЛИВОСТЬ (недели 1–2)', 31, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-tsel-ne-rabotat-do-poteri-500e42', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС (LEVEL UP)', 1, 'LEVEL UP — неделя 3', 32, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-trenazhere', 10, 10, null::int, 90, 4, '10'),
    ('pec-deck-posl-podhod-drop-set', 20, 12, null::int, 90, 3, '12–15'),
    ('zhim-ganteley-sidya', 30, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 40, 15, null::int, 90, 3, '15'),
    ('superset-razgibanie-na-bloke-12-otzhimaniya-uzkim-hvatom-maks', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС (LEVEL UP)', 2, 'LEVEL UP — неделя 3', 32, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('verhniy-blok-neytralnym-hvatom', 0, 8, null::int, 90, 4, '8–10'),
    ('gorizontalnaya-tyaga', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-ganteli-odnoy-rukoy', 20, 10, null::int, 90, 3, '10+10'),
    ('verhniy-blok-odnoy-rukoy', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-ez-shtanga-8-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ (LEVEL UP)', 3, 'LEVEL UP — неделя 3', 32, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8–10'),
    ('vypady-v-hodbe', 20, 10, null::int, 90, 3, '10+10'),
    ('zhim-nogami', 30, 10, null::int, 90, 3, '10'),
    ('sgibanie-nog-posl-podhod-drop-set', 40, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most', 50, 10, null::int, 90, 4, '10'),
    ('ikry', 60, 20, null::int, 90, 4, '20'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-prisedaniya-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · ATHLETIC LEVEL UP', 4, 'LEVEL UP — неделя 3', 32, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-kettlebell-clean-10-10-goblet-squat-15-push-up-b167de', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'НОВЫЙ LEVEL — неделя 4', 33, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-na-naklonnoy-skame', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-s-pola', 10, 12, null::int, 90, 3, '12'),
    ('krossover-sverhu-vniz-posl-podhod-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 30, 10, null::int, 90, 3, '10'),
    ('mahi-v-krossovere-odnoy-rukoy', 40, 15, null::int, 90, 3, '15 на руку'),
    ('superset-frantsuzskiy-zhim-s-ez-shtangoy-10-12-razgibanie-odnoy-ruki-2abc70', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-3718f8', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'НОВЫЙ LEVEL — неделя 4', 33, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-t-grifa-s-uporom-grudyu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-nizhnego-bloka-shirokim-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-ganteley-s-uporom-grudyu', 30, 12, null::int, 90, 3, '12'),
    ('razvedenie-kanata-k-litsu', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-sgibanie-ganteley-na-cf6c11', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-10', 60, null::int, null::int, 60, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'НОВЫЙ LEVEL — неделя 4', 33, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnye-prisedaniya', 0, 8, null::int, 90, 4, '8–10'),
    ('bolgarskie-vypady', 10, 10, null::int, 90, 3, '10 на ногу'),
    ('tyaga-s-girey-ot-pola', 20, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog', 30, 15, null::int, 90, 3, '15'),
    ('sgibanie-nog-lezha-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-nazad-v-krossovere', 50, 15, null::int, 90, 3, '15 на ногу'),
    ('podemy-na-noski-sidya', 60, 20, null::int, 90, 4, '20'),
    ('finisher-5-raundov-20-sek-pryzhki-na-platformu-ili-step-up-20-sek-7f7fa6', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · METABOLIC CHALLENGE', 4, 'НОВЫЙ LEVEL — неделя 4', 33, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-90-sek-5-y-krug-maksimalno-intensivno-no-tehnika-d905b4', 0, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'МЕСЯЦ 12 — FINAL LEVEL 🏆 (недели 1–2, FINAL PREPARATION)', 34, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-dorozhka-s-naklonom-10-min-kazhdye-2-min-uvelichivaem-temp', 0, null::int, 600, 60, 1, '10 мин'),
    ('zhim-shtangi-na-gorizontalnoy-skame', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-ganteley-na-naklonnoy-skame', 20, 10, null::int, 90, 3, '10'),
    ('zhim-v-trenazhere-hammer-posl-podhod-30-vesa-10-povt', 30, 12, null::int, 90, 3, '12'),
    ('krossover-snizu-vverh-pauza-2-sek', 40, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 50, 10, null::int, 90, 3, '10'),
    ('mahi-gantelyami-v-storony', 60, 15, null::int, 90, 3, '15'),
    ('superset-razgibanie-ruk-s-kanatom-12-15-otzhimaniya-uzkim-hvatom-maks', 70, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-30-sek-rabota-20-sek-otdyh-12', 80, null::int, null::int, 60, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · СПИНА + БИЦЕПС', 2, 'МЕСЯЦ 12 — FINAL LEVEL 🏆 (недели 1–2, FINAL PREPARATION)', 34, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-grebnoy-trenazher-10-min-posl-3-min-postepennoe-uvelichenie-35420d', 0, null::int, 600, 60, 1, '10 мин'),
    ('podtyagivaniya-neytralnym-hvatom-ili-negativnye', 10, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 20, 10, null::int, 90, 3, '10'),
    ('tyaga-t-grifa', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka-odnoy-rukoy', 40, 12, null::int, 90, 3, '12 на руку'),
    ('pulover-na-verhnem-bloke', 50, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-so-shtangoy-10-molotkovye-sgibaniya-12', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-30-sek-bystro-20-sek-spokoyno-12', 70, null::int, null::int, 60, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · НОГИ + ЯГОДИЦЫ', 3, 'МЕСЯЦ 12 — FINAL LEVEL 🏆 (недели 1–2, FINAL PREPARATION)', 34, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-velotrenazher-10-min', 0, null::int, 600, 60, 1, '10 мин'),
    ('frontalnye-prisedaniya', 10, 8, null::int, 90, 4, '8–10'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('zhim-nogami', 40, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-lezha-posl-podhod-drop-set', 50, 15, null::int, 90, 3, '15'),
    ('yagodichnyy-most', 60, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog', 70, 15, null::int, 90, 3, '15'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-bystrye-prisedaniya-20-sek-4e83ae', 80, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FINAL ATHLETIC', 4, 'МЕСЯЦ 12 — FINAL LEVEL 🏆 (недели 1–2, FINAL PREPARATION)', 34, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-n1-4-kruga-n2-5-krugov-otdyh-60-sek-tsel-kachestvo-temp-30d2f1', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · FINAL BOSS: ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'FINAL BOSS — неделя 3', 35, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-na-naklonnoy', 10, 8, null::int, 90, 4, '8–10'),
    ('hammer-posl-podhod-drop-set', 20, 10, null::int, 90, 3, '10'),
    ('krossover-posl-podhod-10-chastichnyh-povt', 30, 15, null::int, 90, 3, '15'),
    ('arnold-zhim', 40, 8, null::int, 90, 4, '8–10'),
    ('mahi-v-storony', 50, 15, null::int, 90, 3, '15'),
    ('superset-razgibanie-kanata-12-otzhimaniya-uzkim-hvatom-maks', 60, null::int, null::int, 60, 3, 'круг'),
    ('finisher-battle-rope-40-sek-rabota-20-sek-otdyh-12', 70, null::int, null::int, 60, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · FINAL BOSS: СПИНА + БИЦЕПС', 2, 'FINAL BOSS — неделя 3', 35, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('verhniy-blok', 10, 8, null::int, 90, 4, '8–10'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 4, '8'),
    ('gorizontalnaya-tyaga', 30, 10, null::int, 90, 3, '10'),
    ('pulover', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-so-shtangoy-8-10-molotki-12', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-skierg-40-sek-bystro-20-sek-spokoyno-12', 60, null::int, null::int, 60, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · FINAL BOSS: НОГИ + ЯГОДИЦЫ', 3, 'FINAL BOSS — неделя 3', 35, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised', 0, 8, null::int, 90, 4, '8'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8–10'),
    ('bolgarskie-vypady', 20, 10, null::int, 90, 3, '10+10'),
    ('zhim-nogami', 30, 10, null::int, 90, 3, '10'),
    ('sgibanie-nog-posl-podhod-drop-set', 40, 12, null::int, 90, 3, '12'),
    ('yagodichnyy-most', 50, 10, null::int, 90, 4, '10'),
    ('razgibanie-nog', 60, 15, null::int, 90, 3, '15'),
    ('finisher-5-raundov-30-sek-step-up-20-sek-vypady-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FINAL BOSS CHALLENGE', 4, 'FINAL BOSS — неделя 3', 35, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-otdyh-60-sek-5-y-krug-maksimalnaya-intensivnost-no-tehnika-325f31', 0, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · FINAL CHEST CHALLENGE', 1, 'FINAL CHALLENGE — неделя 4 + GRAND FINAL', 36, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-smite-na-naklonnoy-skame', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-neytralnym-hvatom', 10, 12, null::int, 90, 3, '12'),
    ('pec-deck-posl-podhod-dvoynoy-drop-set', 20, 15, null::int, 90, 3, '15'),
    ('krossover-sverhu-vniz-pauza-2-sek', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-s-nogami-na-skame', 40, null::int, null::int, 90, 3, 'макс.'),
    ('superset-zhim-plechami-v-trenazhere-10-mahi-odnoy-rukoy-v-krossovere-41e20b', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-10-min-20-sek-battle-rope-20-sek-otdyh-20-sek-burpee-20-sek-3718f8', 60, null::int, 600, 60, 1, '10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · FINAL BACK CHALLENGE', 2, 'FINAL CHALLENGE — неделя 4 + GRAND FINAL', 36, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-t-grifa-s-uporom-grudyu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-nizhnego-bloka-shirokim-hvatom', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-ganteley-s-uporom-grudyu', 30, 12, null::int, 90, 3, '12'),
    ('face-pull', 40, 15, null::int, 90, 3, '15'),
    ('superset-sgibanie-ruk-na-skame-skotta-10-sgibanie-ganteley-na-cf6c11', 50, null::int, null::int, 60, 3, 'круг'),
    ('finisher-greblya-45-sek-bystro-15-sek-spokoyno-12', 60, null::int, null::int, 60, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · FINAL LEG CHALLENGE', 3, 'FINAL CHALLENGE — неделя 4 + GRAND FINAL', 36, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 10, 12, null::int, 90, 3, '12 на ногу'),
    ('good-morning', 20, 12, null::int, 90, 3, '12'),
    ('sgibanie-nog-sidya', 30, 15, null::int, 90, 3, '15'),
    ('razgibanie-nog-posl-podhod-drop-set', 40, 15, null::int, 90, 3, '15'),
    ('otvedenie-nogi-nazad-v-krossovere', 50, 15, null::int, 90, 3, '15 на ногу'),
    ('ikry-sidya', 60, 20, null::int, 90, 4, '20'),
    ('finisher-5-raundov-20-sek-step-up-20-sek-bystrye-vypady-20-sek-otdyh', 70, null::int, null::int, 60, 5, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · 🏆 GRAND FINAL', 4, 'FINAL CHALLENGE — неделя 4 + GRAND FINAL', 36, 52)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('final-20-minutnyy-chellendzh-maksimum-kachestvennyh-krugov-ne-d47bca', 0, null::int, 1200, 60, 1, '20 мин'),
    ('posle-zaversheniya-5-minut-spokoynoy-hodby', 10, null::int, 300, 60, 1, '5 мин'),
    ('grand-final-test-ves-obem-talii-foto-speredi-sboku-szadi-maks-283ec9', 20, null::int, null::int, 60, 1, 'тест')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
