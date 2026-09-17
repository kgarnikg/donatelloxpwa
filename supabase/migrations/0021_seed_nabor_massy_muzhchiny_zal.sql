-- 0021_seed_nabor_massy_muzhchiny_zal.sql
-- Программа: Набор массы — Мужчины — Зал
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0021), по одной на каждую комбинацию
-- пол × цель × формат — см. 0020..0021 и журнал в PROJECT_PLAN.md.
--
-- 96 тренировок, 317 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Набор массы — Мужчины — Зал)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('zhim-shtangi-lezha', 'Жим штанги лёжа'),
  ('zhim-ganteley-na-naklonnoy-skame', 'Жим гантелей на наклонной скамье'),
  ('svedeniya-ruk-v-krossovere-sverhu-vniz', 'Сведения рук в кроссовере сверху вниз'),
  ('otzhimaniya', 'Отжимания'),
  ('razgibanie-ruk-na-verhnem-bloke', 'Разгибание рук на верхнем блоке'),
  ('frantsuzskiy-zhim-ez-grifom', 'Французский жим EZ-грифом'),
  ('finisher-otzhimaniya-uzkim-hvatom', 'Финишер: отжимания узким хватом'),
  ('prisedaniya-bez-vesa', 'Приседания без веса'),
  ('zhim-nogami', 'Жим ногами'),
  ('bolgarskie-vypady', 'Болгарские выпады'),
  ('sgibanie-nog-lezha', 'Сгибание ног лёжа'),
  ('podemy-na-noski-stoya', 'Подъёмы на носки стоя'),
  ('finisher-wall-sit-statika', 'Финишер: Wall Sit (статика)'),
  ('podtyagivaniya', 'Подтягивания'),
  ('tyaga-verhnego-bloka-shirokim-hvatom', 'Тяга верхнего блока широким хватом'),
  ('tyaga-gorizontalnogo-bloka', 'Тяга горизонтального блока'),
  ('tyaga-ganteli-odnoy-rukoy', 'Тяга гантели одной рукой'),
  ('podem-ez-grifa-sidya', 'Подъём EZ-грифа сидя'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('finisher-fermerskaya-progulka-s-gantelyami', 'Финишер: фермерская прогулка с гантелями'),
  ('zhim-ganteley-sidya', 'Жим гантелей сидя'),
  ('podemy-ganteley-cherez-storony-mahi', 'Подъёмы гантелей через стороны (махи)'),
  ('face-pull-obratnym-hvatom', 'Face Pull обратным хватом'),
  ('razvedeniya-v-naklone-sidya', 'Разведения в наклоне сидя'),
  ('shragi-trapetsiya', 'Шраги (трапеция)'),
  ('zhim-v-hammer-strength', 'Жим в Hammer Strength'),
  ('zhim-ganteley-na-gorizontalnoy-skame', 'Жим гантелей на горизонтальной скамье'),
  ('pec-deck-babochka', 'Pec Deck (бабочка)'),
  ('otzhimaniya-na-brusyah', 'Отжимания на брусьях'),
  ('razgibanie-ruk-kanatom', 'Разгибание рук канатом'),
  ('razgibanie-odnoy-ruki-nad-golovoy', 'Разгибание одной руки над головой'),
  ('finisher-battle-rope', 'Финишер: Battle Rope'),
  ('hak-prised', 'Хак-присед'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('vypady-nazad-s-gantelyami', 'Выпады назад с гантелями'),
  ('razgibanie-nog', 'Разгибание ног'),
  ('podemy-na-noski-sidya', 'Подъёмы на носки сидя'),
  ('finisher-pryzhki-na-tumbu', 'Финишер: прыжки на тумбу'),
  ('tyaga-t-grifa', 'Тяга Т-грифа'),
  ('chest-supported-row-ganteli-na-naklonnoy', 'Chest Supported Row (гантели на наклонной)'),
  ('podtyagivaniya-obratnym-hvatom', 'Подтягивания обратным хватом'),
  ('straight-arm-pulldown', 'Straight Arm Pulldown'),
  ('sgibaniya-na-skame-skotta', 'Сгибания на скамье Скотта'),
  ('kanatnye-sgibaniya', 'Канатные сгибания'),
  ('finisher-trx-row', 'Финишер: TRX Row'),
  ('arnold-press', 'Arnold Press'),
  ('y-raise-supermen', 'Y-Raise (супермен)'),
  ('podemy-cherez-storony-v-trenazhere', 'Подъёмы через стороны в тренажёре'),
  ('reverse-pec-deck-obratnym-hvatom', 'Reverse Pec Deck обратным хватом'),
  ('overhead-carry-perenos-2-ganteley-nad-golovoy', 'Overhead Carry (перенос 2 гантелей над головой)'),
  ('zhim-shtangi-na-naklonnoy-skame', 'Жим штанги на наклонной скамье'),
  ('svedenie-ruk-v-pec-deck', 'Сведение рук в Pec Deck'),
  ('razgibanie-ruk-na-verhnem-bloke-s-kanatom', 'Разгибание рук на верхнем блоке с канатом'),
  ('frantsuzskiy-zhim-gantelyu-sidya', 'Французский жим гантелью сидя'),
  ('frontalnye-prisedaniya', 'Фронтальные приседания'),
  ('zhim-nogami-uzkoy-postanovkoy', 'Жим ногами узкой постановкой'),
  ('vypady-vpered-s-gantelyami', 'Выпады вперёд с гантелями'),
  ('finisher-fermerskaya-progulka', 'Финишер: фермерская прогулка'),
  ('podtyagivaniya-neytralnym-hvatom', 'Подтягивания нейтральным хватом'),
  ('tyaga-verhnego-bloka-odnoy-rukoy', 'Тяга верхнего блока одной рукой'),
  ('tyaga-nizhnego-bloka-shirokim-hvatom', 'Тяга нижнего блока широким хватом'),
  ('sgibaniya-ez-grifom', 'Сгибания EZ-грифом'),
  ('kontsentrirovannye-sgibaniya', 'Концентрированные сгибания'),
  ('podemy-cherez-storony-sidya', 'Подъёмы через стороны сидя'),
  ('face-pull', 'Face Pull'),
  ('reverse-pec-deck', 'Reverse Pec Deck'),
  ('shragi-s-gantelyami', 'Шраги с гантелями'),
  ('finisher-perenos-dvuh-gir-nad-golovoy', 'Финишер: перенос двух гирь над головой'),
  ('otzhimaniya-na-koltsah', 'Отжимания на кольцах'),
  ('krossover-snizu-vverh', 'Кроссовер снизу вверх'),
  ('zhim-odnoy-rukoy-v-trenazhere', 'Жим одной рукой в тренажёре'),
  ('razgibanie-ruki-v-krossovere-odnoy-rukoy', 'Разгибание руки в кроссовере одной рукой'),
  ('uzkie-otzhimaniya', 'Узкие отжимания'),
  ('finisher-medbol-broski-v-pol', 'Финишер: медбол — броски в пол'),
  ('goblet-squat', 'Goblet Squat'),
  ('podemy-na-noski-v-trenazhere', 'Подъёмы на носки в тренажёре'),
  ('chest-supported-row', 'Chest Supported Row'),
  ('podtyagivaniya-shirokim-hvatom', 'Подтягивания широким хватом'),
  ('meadows-row', 'Meadows Row'),
  ('z-press', 'Z-Press'),
  ('y-raise', 'Y-Raise'),
  ('razvedeniya-v-naklone-s-pauzoy-2-sek', 'Разведения в наклоне с паузой 2 сек'),
  ('overhead-carry', 'Overhead Carry'),
  ('finisher-trx-pike', 'Финишер: TRX Pike'),
  ('zhim-ganteley-na-naklonnoy-skame-medlennyy-negativ-3-sek', 'Жим гантелей на наклонной скамье (медленный негатив 3 сек)'),
  ('zhim-v-hammer-sidya-drop-set-na-poslednem-podhode', 'Жим в Hammer сидя + дроп-сет на последнем подходе'),
  ('krossover-snizu-vverh-pauza-2-sek', 'Кроссовер снизу вверх (пауза 2 сек)'),
  ('otzhimaniya-s-nogami-na-vozvyshenii', 'Отжимания с ногами на возвышении'),
  ('razgibanie-ruk-s-kanatom-uderzhanie-20-sek-vnizu', 'Разгибание рук с канатом + удержание 20 сек внизу'),
  ('frantsuzskiy-zhim-ez-grifom-lezha', 'Французский жим EZ-грифом лёжа'),
  ('finisher-medbol-brosok-v-pol', 'Финишер: медбол бросок в пол'),
  ('gakk-prised', 'Гакк-присед'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('bolgarskie-vypady-s-pauzoy-2-sek', 'Болгарские выпады с паузой 2 сек'),
  ('razgibanie-nog-drop-set-15-10-10', 'Разгибание ног + дроп-сет 15+10+10'),
  ('ikry-stoya', 'Икры стоя'),
  ('finisher-krug-3-15-pryzhkov-na-tumbu-20-prisedaniy-30-sek-planka', 'Финишер: круг ×3 — 15 прыжков на тумбу, 20 приседаний, 30 сек планка'),
  ('podtyagivaniya-tsel-bolshe-povtoreniy', 'Подтягивания (цель — больше повторений)'),
  ('tyaga-t-grifa-s-uporom-grudyu', 'Тяга Т-грифа с упором грудью'),
  ('tyaga-verhnego-bloka-obratnym-hvatom', 'Тяга верхнего блока обратным хватом'),
  ('tyaga-ganteley-na-naklonnoy-skame', 'Тяга гантелей на наклонной скамье'),
  ('pulover-na-verhnem-bloke', 'Пуловер на верхнем блоке'),
  ('sgibanie-ruk-s-gantelyami-na-naklonnoy-skame', 'Сгибание рук с гантелями на наклонной скамье'),
  ('molotki-s-kanatom', 'Молотки с канатом'),
  ('finisher-farmer-walk', 'Финишер: Farmer Walk'),
  ('zhim-arnolda', 'Жим Арнольда'),
  ('zhim-giri-odnoy-rukoy-stoya', 'Жим гири одной рукой стоя'),
  ('mahi-gantelyami-cherez-storony-chastichnye-povtoreniya-na-posl-podhode', 'Махи гантелями через стороны + частичные повторения на посл. подходе'),
  ('staticheskoe-uderzhanie-ganteley-v-storony', 'Статическое удержание гантелей в стороны'),
  ('zhim-shtangi-s-pauzoy-vnizu', 'Жим штанги с паузой внизу'),
  ('pec-deck-odnoy-rukoy', 'Pec Deck одной рукой'),
  ('landmine-press', 'Landmine Press'),
  ('otzhimaniya-uzkim-hvatom', 'Отжимания узким хватом'),
  ('razgibanie-ruk-nad-golovoy-s-kanatom', 'Разгибание рук над головой с канатом'),
  ('finisher-emom-6-min-10-otzhimaniy-kazhduyu-minutu', 'Финишер: EMOM 6 мин — 10 отжиманий каждую минуту'),
  ('frontalnyy-prised', 'Фронтальный присед'),
  ('nordic-curl-oblegchennyy', 'Nordic Curl (облегчённый)'),
  ('zhim-nogami-vysokoy-postanovkoy', 'Жим ногами высокой постановкой'),
  ('yagodichnyy-most-so-shtangoy', 'Ягодичный мост со штангой'),
  ('ikry-sidya', 'Икры сидя'),
  ('finisher-krug-3-20-walking-lunges-20-air-squats-30-sek-wall-sit', 'Финишер: круг ×3 — 20 Walking Lunges, 20 Air Squats, 30 сек Wall Sit'),
  ('podtyagivaniya-s-pauzoy-sverhu', 'Подтягивания с паузой сверху'),
  ('tyaga-bloka-odnoy-rukoy', 'Тяга блока одной рукой'),
  ('sgibanie-ez-grif', 'Сгибание EZ-гриф'),
  ('bitseps-na-bloke-odnoy-rukoy', 'Бицепс на блоке одной рукой'),
  ('podem-ganteley-cherez-storony-s-pauzoy', 'Подъём гантелей через стороны с паузой'),
  ('kubinskiy-zhim', 'Кубинский жим'),
  ('rear-delt-fly', 'Rear Delt Fly'),
  ('farmer-carry-tyazhelyy', 'Farmer Carry тяжёлый'),
  ('zhim-shtangi-lezha-2-5-5-vesa-kazhduyu-nedelyu', 'Жим штанги лёжа (+2.5–5% веса каждую неделю)'),
  ('zhim-ganteley-na-naklonnoy-rest-pause-na-posl-podhode', 'Жим гантелей на наклонной + Rest-Pause на посл. подходе'),
  ('zhim-v-hammer-snizu-vverh', 'Жим в Hammer снизу вверх'),
  ('krossover-s-pauzoy-3-sek', 'Кроссовер с паузой 3 сек'),
  ('razgibanie-ruk-na-bloke-obratnym-hvatom', 'Разгибание рук на блоке обратным хватом'),
  ('frantsuzskiy-zhim-gantelyu', 'Французский жим гантелью'),
  ('finisher-emom-5-min-15-otzhimaniy', 'Финишер: EMOM 5 мин — 15 отжиманий'),
  ('prisedaniya-so-shtangoy-tyazhelyy-rabochiy-ves-na-posl-podhode', 'Приседания со штангой (тяжёлый рабочий вес на посл. подходе)'),
  ('rumynskaya-tyaga-so-shtangoy', 'Румынская тяга со штангой'),
  ('finisher-wall-sit', 'Финишер: Wall Sit'),
  ('podtyagivaniya-s-dop-vesom', 'Подтягивания с доп. весом'),
  ('tyaga-shtangi-v-naklone', 'Тяга штанги в наклоне'),
  ('tyaga-verhnego-bloka-neytralnym-hvatom', 'Тяга верхнего блока нейтральным хватом'),
  ('pulover-s-kanatom', 'Пуловер с канатом'),
  ('molotki-stoya', 'Молотки стоя'),
  ('zhim-shtangi-stoya', 'Жим штанги стоя'),
  ('mahi-gantelyami-v-storony-drop-set-12-10-10', 'Махи гантелями в стороны + дроп-сет 12+10+10'),
  ('shragi-so-shtangoy', 'Шраги со штангой'),
  ('zhim-ganteley-tyazhelyy', 'Жим гантелей тяжёлый'),
  ('floor-press-so-shtangoy', 'Floor Press со штангой'),
  ('pec-deck', 'Pec Deck'),
  ('zhim-uzkim-hvatom', 'Жим узким хватом'),
  ('razgibanie-ruk-s-kanatom-nad-golovoy', 'Разгибание рук с канатом над головой'),
  ('finisher-battle-rope-8-raundov-po-20-sek', 'Финишер: Battle Rope — 8 раундов по 20 сек'),
  ('trap-bar-deadlift', 'Trap Bar Deadlift'),
  ('vypady-nazad', 'Выпады назад'),
  ('nordic-curl', 'Nordic Curl'),
  ('finisher-krug-3-20-pryzhkov-20-prisedaniy-40-sek-planka', 'Финишер: круг ×3 — 20 прыжков, 20 приседаний, 40 сек планка'),
  ('reverse-fly', 'Reverse Fly'),
  ('sgibanie-ruk-na-skame-skotta', 'Сгибание рук на скамье Скотта'),
  ('kanatnye-molotki', 'Канатные молотки'),
  ('finisher-trx-row-100-povtoreniy-lyuboe-kol-vo-podhodov', 'Финишер: TRX Row 100 повторений (любое кол-во подходов)'),
  ('push-press', 'Push Press'),
  ('mahi-cherez-storony', 'Махи через стороны'),
  ('zadnyaya-delta-v-naklone', 'Задняя дельта в наклоне'),
  ('farmer-carry-nad-golovoy', 'Farmer Carry над головой'),
  ('zhim-v-hammer-strength-drop-set-10-30-10', 'Жим в Hammer Strength + дроп-сет 10/-30%/10'),
  ('superset-4-krossover-15-otzhimaniya-do-otkaza', 'Суперсет ×4: Кроссовер 15 + Отжимания до отказа'),
  ('zhim-ganteley-uzkim-hvatom', 'Жим гантелей узким хватом'),
  ('prisedaniya-so-shtangoy', 'Приседания со штангой'),
  ('superset-4-razgibanie-nog-15-sgibanie-nog-15', 'Суперсет ×4: Разгибание ног 15 + Сгибание ног 15'),
  ('finisher-crossfit-3-15-goblet-squat-10-pryzhkov-na-tumbu-20-vypadov-d0cb0e', 'Финишер CrossFit ×3: 15 Goblet Squat, 10 прыжков на тумбу, 20 выпадов, 40 сек Wall Sit'),
  ('superset-4-chest-supported-row-12-straight-arm-pulldown-15', 'Суперсет ×4: Chest Supported Row 12 + Straight Arm Pulldown 15'),
  ('bitseps-ez-grif', 'Бицепс EZ-гриф'),
  ('superset-5-mahi-cherez-storony-15-face-pull-20', 'Суперсет ×5: Махи через стороны 15 + Face Pull 20'),
  ('shragi', 'Шраги'),
  ('zhim-shtangi-s-pauzoy', 'Жим штанги с паузой'),
  ('krossover-odnoy-rukoy', 'Кроссовер одной рукой'),
  ('finisher-emom-8-min-15-otzhimaniy', 'Финишер: EMOM 8 мин — 15 отжиманий'),
  ('front-squat', 'Front Squat'),
  ('walking-lunges', 'Walking Lunges'),
  ('girevoy-sving', 'Гиревой свинг'),
  ('finisher-amrap-10-min-10-goblet-squat-10-pryzhkov-10-vypadov', 'Финишер AMRAP 10 мин: 10 Goblet Squat, 10 прыжков, 10 выпадов'),
  ('trx-row', 'TRX Row'),
  ('finisher-battle-rope-10-20-sek', 'Финишер: Battle Rope — 10×20 сек'),
  ('zhim-shtangi-lezha-s-pauzoy-3-sek-vniz-1-sek-pauza', 'Жим штанги лёжа с паузой (3 сек вниз, 1 сек пауза)'),
  ('zhim-ganteley-na-naklonnoy-meh-drop-set-10-10-10', 'Жим гантелей на наклонной + мех. дроп-сет 10/10/10'),
  ('superset-5-krossover-sverhu-vniz-15-uzkie-otzhimaniya-maks', 'Суперсет ×5: Кроссовер сверху-вниз 15 + Узкие отжимания макс.'),
  ('zhim-v-hammer-odnoy-rukoy', 'Жим в Hammer одной рукой'),
  ('razgibanie-ruk-na-bloke-kanatom-uderzhanie-30-sek-vnizu', 'Разгибание рук на блоке канатом + удержание 30 сек внизу'),
  ('frantsuzskiy-zhim-ez-posl-3-povt-medlenno-5-sek', 'Французский жим EZ (посл. 3 повт. медленно 5 сек)'),
  ('rumynskaya-tyaga-negativ-3-sek', 'Румынская тяга (негатив 3 сек)'),
  ('bolgarskie-vypady-posl-podhod-do-otkaza', 'Болгарские выпады (посл. подход до отказа)'),
  ('superset-4-razgibanie-nog-20-wall-sit-45-sek', 'Суперсет ×4: Разгибание ног 20 + Wall Sit 45 сек'),
  ('sgibanie-nog-lezha-pauza-2-sek-vverhu', 'Сгибание ног лёжа (пауза 2 сек вверху)'),
  ('finisher-5-10-pryzhkov-na-tumbu-15-goblet-squat-30-sek-planka', 'Финишер ×5: 10 прыжков на тумбу, 15 Goblet Squat, 30 сек планка'),
  ('podtyagivaniya-posl-podhod-maksimum', 'Подтягивания (посл. подход — максимум)'),
  ('tyaga-verhnego-bloka-shirokim-hvatom-pauza-2-sek-vnizu', 'Тяга верхнего блока широким хватом (пауза 2 сек внизу)'),
  ('superset-4-gorizontalnaya-tyaga-12-pulover-kanatom-15', 'Суперсет ×4: Горизонтальная тяга 12 + Пуловер канатом 15'),
  ('molotki-s-gantelyami', 'Молотки с гантелями'),
  ('superset-5-mahi-cherez-storony-15-mahi-nazad-v-naklone-15', 'Суперсет ×5: Махи через стороны 15 + Махи назад в наклоне 15')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('statika-uderzhanie-ganteley-v-storony', 'Статика: удержание гантелей в стороны'),
  ('zhim-ganteley-na-polu-floor-press', 'Жим гантелей на полу (Floor Press)'),
  ('pec-deck-drop-set-na-posl-podhode', 'Pec Deck + дроп-сет на посл. подходе'),
  ('finisher-emom-10-min-15-otzhimaniy', 'Финишер: EMOM 10 мин — 15 отжиманий'),
  ('finisher-amrap-12-min-10-pryzhkov-15-prisedaniy-20-vypadov', 'Финишер AMRAP 12 мин: 10 прыжков, 15 приседаний, 20 выпадов'),
  ('skamya-skotta', 'Скамья Скотта'),
  ('finisher-battle-rope-12-20-sek', 'Финишер: Battle Rope — 12×20 сек'),
  ('zhim-ganteley-na-naklonnoy-skame-3-sek-vniz-1-sek-pauza-vzryv-vverh', 'Жим гантелей на наклонной скамье (3 сек вниз, 1 сек пауза, взрыв вверх)'),
  ('zhim-shtangi-lezha-rest-pause-na-posl-podhode', 'Жим штанги лёжа + Rest-Pause на посл. подходе'),
  ('superset-4-krossover-sverhu-vniz-15-otzhimaniya-do-otkaza', 'Суперсет ×4: Кроссовер сверху-вниз 15 + Отжимания до отказа'),
  ('razgibanie-ruk-na-bloke', 'Разгибание рук на блоке'),
  ('frantsuzskiy-zhim-s-gantelyu', 'Французский жим с гантелью'),
  ('fst-7-finisher-krossover-7-10-12-otdyh-30-sek', 'FST-7 финишер: Кроссовер — 7×10–12, отдых 30 сек'),
  ('superset-5-razgibanie-nog-20-sgibanie-nog-15', 'Суперсет ×5: Разгибание ног 20 + Сгибание ног 15'),
  ('yagodichnyy-most', 'Ягодичный мост'),
  ('finisher-walking-lunges-100-shagov', 'Финишер: Walking Lunges — 100 шагов'),
  ('superset-4-straight-arm-pulldown-15-face-pull-20', 'Суперсет ×4: Straight Arm Pulldown 15 + Face Pull 20'),
  ('molotki', 'Молотки'),
  ('fst-7-sgibanie-ruk-na-bloke-7-12-otdyh-30-sek', 'FST-7: Сгибание рук на блоке — 7×12, отдых 30 сек'),
  ('gigantskiy-set-4-mahi-v-storony-15-mahi-vpered-15-mahi-nazad-15-face-d2f034', 'Гигантский сет ×4: Махи в стороны 15 + Махи вперёд 15 + Махи назад 15 + Face Pull 20'),
  ('zhim-shtangi-s-obratnym-hvatom', 'Жим штанги с обратным хватом'),
  ('zhim-ganteley-gorizontalno', 'Жим гантелей горизонтально'),
  ('kanat-na-tritseps', 'Канат на трицепс'),
  ('finisher-med-ball-slam', 'Финишер: Med Ball Slam'),
  ('finisher-3-20-pryzhkov-20-goblet-squat-40-sek-wall-sit', 'Финишер ×3: 20 прыжков, 20 Goblet Squat, 40 сек Wall Sit'),
  ('mahi-cherez-storony-otdyh-30-sek', 'Махи через стороны — отдых 30 сек'),
  ('zhim-ganteley-na-naklonnoy-posl-podhod-1-5-povtoreniya', 'Жим гантелей на наклонной (посл. подход — 1.5 повторения)'),
  ('zhim-shtangi-lezha-drop-set-8-30-10', 'Жим штанги лёжа + дроп-сет 8/-30%/10'),
  ('superset-4-razgibanie-ruk-s-kanatom-15-almaznye-otzhimaniya-10-15', 'Суперсет ×4: Разгибание рук с канатом 15 + Алмазные отжимания 10–15'),
  ('razgibanie-ruki-iz-za-golovy-na-bloke', 'Разгибание руки из-за головы на блоке'),
  ('finisher-battle-rope-6-30-sek', 'Финишер: Battle Rope — 6×30 сек'),
  ('bolgarskie-vypady-uderzhanie-20-sek-vnizu-na-posl-podhode', 'Болгарские выпады (удержание 20 сек внизу на посл. подходе)'),
  ('sgibanie-nog-lezha-negativy-5-sek-na-posl-podhode', 'Сгибание ног лёжа (негативы 5 сек на посл. подходе)'),
  ('finisher-sportsmen-4-10-pryzhkov-na-tumbu-15-goblet-squat-20-m-farmer-2df0e7', 'Финишер «Спортсмен» ×4: 10 прыжков на тумбу, 15 Goblet Squat, 20 м Farmer Walk'),
  ('tyaga-gorizontalnogo-bloka-dvoynoy-drop-set-na-posl', 'Тяга горизонтального блока + двойной дроп-сет на посл.'),
  ('superset-5-sgibanie-ez-grif-10-molotki-12', 'Суперсет ×5: Сгибание EZ-гриф 10 + Молотки 12'),
  ('sgibanie-ruk-na-bloke', 'Сгибание рук на блоке'),
  ('finisher-trx-row-100-povtoreniy', 'Финишер: TRX Row 100 повторений'),
  ('gigantskiy-set-5-mahi-cherez-storony-15-mahi-vpered-12-mahi-nazad-15-07f5b4', 'Гигантский сет ×5: Махи через стороны 15 + Махи вперёд 12 + Махи назад 15 + Face Pull 20'),
  ('floor-press', 'Floor Press'),
  ('zhim-ganteley-obratnym-hvatom', 'Жим гантелей обратным хватом'),
  ('frantsuzskiy-zhim-ez', 'Французский жим EZ'),
  ('ikry', 'Икры'),
  ('finisher-amrap-10-min-10-pryzhkov-15-prisedaniy-20-vypadov', 'Финишер AMRAP 10 мин: 10 прыжков, 15 приседаний, 20 выпадов'),
  ('podtyagivaniya-s-pauzoy', 'Подтягивания с паузой'),
  ('zhim-shtangi-lezha-80-85-ot-maks-klaster-5-2-3-na-posl-podhode', 'Жим штанги лёжа (80–85% от макс.) + кластер 5+2–3 на посл. подходе'),
  ('zhim-ganteley-na-naklonnoy-3-sek-vniz', 'Жим гантелей на наклонной (3 сек вниз)'),
  ('zhim-v-hammer-drop-set-10-10-10', 'Жим в Hammer + дроп-сет 10+10+10'),
  ('krossover-pauza-2-sek', 'Кроссовер (пауза 2 сек)'),
  ('frantsuzskiy-zhim-ez-grif', 'Французский жим EZ-гриф'),
  ('razgibanie-ruk-s-kanatom', 'Разгибание рук с канатом'),
  ('finisher-medbol-broski', 'Финишер: медбол броски'),
  ('prisedaniya-so-shtangoy-80-85', 'Приседания со штангой (80–85%)'),
  ('sgibanie-nog-lezha-negativy-5-sek', 'Сгибание ног лёжа (негативы 5 сек)'),
  ('finisher-5-10-pryzhkov-na-tumbu-15-goblet-squat-30-sek-wall-sit', 'Финишер ×5: 10 прыжков на тумбу, 15 Goblet Squat, 30 сек Wall Sit'),
  ('podtyagivaniya-s-vesom', 'Подтягивания с весом'),
  ('razgibanie-ruk-nad-golovoy', 'Разгибание рук над головой'),
  ('gigantskiy-set-5-mahi-v-storony-15-zadnyaya-delta-15-face-pull-20', 'Гигантский сет ×5: Махи в стороны 15 + Задняя дельта 15 + Face Pull 20'),
  ('zhim-ganteley-na-naklonnoy-drop-set-10-30-10', 'Жим гантелей на наклонной + дроп-сет 10/-30%/10'),
  ('superset-4-otzhimaniya-na-brusyah-12-mahi-gantelyami-v-storony-15', 'Суперсет ×4: Отжимания на брусьях 12 + Махи гантелями в стороны 15'),
  ('fst-7-mahi-cherez-storony-7-12-otdyh-30-sek', 'FST-7: Махи через стороны — 7×12, отдых 30 сек'),
  ('finisher-3-20-pryzhkov-na-tumbu-20-goblet-squat-60-sek-wall-sit', 'Финишер ×3: 20 прыжков на тумбу, 20 Goblet Squat, 60 сек Wall Sit'),
  ('superset-5-straight-arm-pulldown-15-face-pull-20', 'Суперсет ×5: Straight Arm Pulldown 15 + Face Pull 20'),
  ('bitseps-na-naklonnoy-skame', 'Бицепс на наклонной скамье'),
  ('fst-7-sgibanie-ruk-na-bloke-7-12', 'FST-7: Сгибание рук на блоке — 7×12'),
  ('zadnyaya-delta-v-trenazhere', 'Задняя дельта в тренажёре'),
  ('superset-ruk-5-frantsuzskiy-zhim-kanatom-12-molotki-kanatom-12', 'Суперсет рук ×5: Французский жим канатом 12 + Молотки канатом 12'),
  ('zhim-ganteley-neytralnym-hvatom', 'Жим гантелей нейтральным хватом'),
  ('hack-squat', 'Hack Squat'),
  ('gigantskiy-set-4-mahi-v-storony-15-zadnyaya-delta-15-face-pull-20-1e960d', 'Гигантский сет ×4: Махи в стороны 15 + Задняя дельта 15 + Face Pull 20 + Удержание гантелей 30 сек'),
  ('superset-ruk-5-bitseps-ez-12-razgibanie-kanatom-15', 'Суперсет рук ×5: Бицепс EZ 12 + Разгибание канатом 15'),
  ('zhim-shtangi-lezha-85-90-klaster-4-2-na-posl-podhode', 'Жим штанги лёжа (85–90%) + кластер 4+2 на посл. подходе'),
  ('zhim-ganteley-na-naklonnoy-3-sek-vniz-1-sek-pauza', 'Жим гантелей на наклонной (3 сек вниз, 1 сек пауза)'),
  ('zhim-v-hammer-troynoy-drop-set-10-30-10-30-10', 'Жим в Hammer + тройной дроп-сет 10/-30%/10/-30%/10'),
  ('krossover-posl-5-povt-medlenno', 'Кроссовер (посл. 5 повт. медленно)'),
  ('kanat-na-bloke-uderzhanie-20-sek-vnizu', 'Канат на блоке + удержание 20 сек внизу'),
  ('finisher-battle-rope-8-30-sek', 'Финишер: Battle Rope — 8×30 сек'),
  ('prisedaniya-so-shtangoy-85', 'Приседания со штангой (85%)'),
  ('finisher-voin-5-10-pryzhkov-na-tumbu-20-prisedaniy-30-sek-planka', 'Финишер «Воин» ×5: 10 прыжков на тумбу, 20 приседаний, 30 сек планка'),
  ('tyaga-verhnim-blokom-shirokim-hvatom-pauza-2-sek', 'Тяга верхним блоком широким хватом (пауза 2 сек)'),
  ('gorizontalnaya-tyaga-troynoy-drop-set', 'Горизонтальная тяга + тройной дроп-сет'),
  ('pulover-kanatom', 'Пуловер канатом'),
  ('zadnyaya-delta', 'Задняя дельта'),
  ('superset-ruk-5-bitseps-na-naklonnoy-12-razgibanie-kanatom-15', 'Суперсет рук ×5: Бицепс на наклонной 12 + Разгибание канатом 15'),
  ('zhim-ganteley-lezha', 'Жим гантелей лёжа'),
  ('zhim-v-mashine-smita', 'Жим в машине Смита'),
  ('otzhimaniya-s-dop-vesom', 'Отжимания с доп. весом'),
  ('finisher-100-otzhimaniy-min-kol-vo-podhodov', 'Финишер: 100 отжиманий (мин. кол-во подходов)'),
  ('gudmorning', 'Гудморнинг'),
  ('sgibanie-nog-sidya', 'Сгибание ног сидя'),
  ('finisher-emom-10-min-15-goblet-squat', 'Финишер: EMOM 10 мин — 15 Goblet Squat'),
  ('tyaga-bloka-uzkim-hvatom', 'Тяга блока узким хватом'),
  ('gigantskiy-set-6-mahi-v-storony-15-face-pull-20-zadnyaya-delta-20', 'Гигантский сет ×6: Махи в стороны 15 + Face Pull 20 + Задняя дельта 20'),
  ('superset-5-ez-bitseps-10-frantsuzskiy-zhim-10', 'Суперсет ×5: EZ-бицепс 10 + Французский жим 10'),
  ('zhim-shtangi-lezha-80-85-amrap-na-posl-podhode', 'Жим штанги лёжа (80–85%) + AMRAP на посл. подходе'),
  ('krossover-posl-5-povt-uderzhanie-2-sek', 'Кроссовер (посл. 5 повт. — удержание 2 сек)'),
  ('gigantskiy-set-plech-5-mahi-v-storony-15-mahi-vpered-12-zadnyaya-f357ed', 'Гигантский сет плеч ×5: Махи в стороны 15 + Махи вперёд 12 + Задняя дельта 15 + Face Pull 20'),
  ('superset-tritsepsa-4-frantsuzskiy-zhim-ez-10-kanat-na-bloke-15', 'Суперсет трицепса ×4: Французский жим EZ 10 + Канат на блоке 15'),
  ('prisedaniya', 'Приседания'),
  ('sgibanie-nog-uderzhanie-20-sek-na-posl-podhode', 'Сгибание ног (удержание 20 сек на посл. подходе)'),
  ('finisher-5-10-pryzhkov-na-tumbu-20-vypadov-30-sek-sprint-na-meste', 'Финишер ×5: 10 прыжков на тумбу, 20 выпадов, 30 сек спринт на месте'),
  ('gorizontalnaya-tyaga', 'Горизонтальная тяга'),
  ('superset-bitsepsa-5-sgibanie-ez-grif-10-molotki-12', 'Суперсет бицепса ×5: Сгибание EZ-гриф 10 + Молотки 12'),
  ('kontsentratsiya-na-bitseps', 'Концентрация на бицепс'),
  ('superset-ruk-6-bitseps-na-bloke-15-razgibanie-kanatom-15', 'Суперсет рук ×6: Бицепс на блоке 15 + Разгибание канатом 15'),
  ('zhim-ganteley', 'Жим гантелей'),
  ('zhim-v-trenazhere', 'Жим в тренажёре'),
  ('krossover', 'Кроссовер'),
  ('superset-ruk-6-bitseps-ez-12-tritseps-kanat-15', 'Суперсет рук ×6: Бицепс EZ 12 + Трицепс канат 15'),
  ('vypady-hodboy', 'Выпады ходьбой'),
  ('sgibanie-nog', 'Сгибание ног'),
  ('finisher-amrap-10-min-10-pryzhkov-15-prisedaniy-20-mountain-climbers', 'Финишер AMRAP 10 мин: 10 прыжков, 15 приседаний, 20 Mountain Climbers'),
  ('podtyagivaniya-100-povtoreniy-lyuboe-kol-vo-podhodov', 'Подтягивания — 100 повторений (любое кол-во подходов)'),
  ('tyaga-bloka', 'Тяга блока'),
  ('gigantskiy-set-bitsepsa-5-ez-grif-10-molotki-12-kanat-15', 'Гигантский сет бицепса ×5: EZ-гриф 10 + Молотки 12 + Канат 15'),
  ('mahi-cherez-storony-otdyh-20-sek', 'Махи через стороны — отдых 20 сек'),
  ('finalnyy-kompleks-3-20-otzhimaniy-20-prisedaniy-20-russian-twist-60-522591', 'Финальный комплекс ×3: 20 отжиманий, 20 приседаний, 20 Russian Twist, 60 сек планка')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Набор массы — Мужчины — Зал)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('nabor-massy-muzhchiny-zal', 'Набор массы для мужчин (зал) — годовая программа', 'Набор массы для мужчин (зал) — годовая программа. Оборудование: Полный набор зала: штанги, гантели, тренажёры, турник, канаты, TRX, гири', 'build_muscle', 'male', 'gym', 'intermediate', 48, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 1–2 — Фундамент', 1, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha', 0, 12, null::int, 90, 4, '12'),
    ('zhim-ganteley-na-naklonnoy-skame', 10, 10, null::int, 90, 4, '10–12'),
    ('svedeniya-ruk-v-krossovere-sverhu-vniz', 20, 15, null::int, 90, 3, '15'),
    ('otzhimaniya', 30, null::int, null::int, 90, 3, 'до отказа'),
    ('razgibanie-ruk-na-verhnem-bloke', 40, 12, null::int, 90, 4, '12–15'),
    ('frantsuzskiy-zhim-ez-grifom', 50, 10, null::int, 90, 3, '10–12'),
    ('finisher-otzhimaniya-uzkim-hvatom', 60, null::int, null::int, 90, 2, 'до отказа')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 1–2 — Фундамент', 1, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-bez-vesa', 0, 10, null::int, 90, 4, '10'),
    ('zhim-nogami', 10, 12, null::int, 90, 4, '12'),
    ('bolgarskie-vypady', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('sgibanie-nog-lezha', 30, 12, null::int, 90, 4, '12'),
    ('podemy-na-noski-stoya', 40, 15, null::int, 90, 5, '15'),
    ('finisher-wall-sit-statika', 50, null::int, 60, 90, 2, '60 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 1–2 — Фундамент', 1, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 4, 'макс.'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 10, 12, null::int, 90, 4, '12'),
    ('tyaga-gorizontalnogo-bloka', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-ganteli-odnoy-rukoy', 30, 12, null::int, 90, 3, '12'),
    ('podem-ez-grifa-sidya', 40, 10, null::int, 90, 4, '10'),
    ('molotkovye-sgibaniya', 50, 12, null::int, 90, 3, '12'),
    ('finisher-fermerskaya-progulka-s-gantelyami', 60, 40, null::int, 90, 3, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 1–2 — Фундамент', 1, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-sidya', 0, 10, null::int, 90, 4, '10'),
    ('podemy-ganteley-cherez-storony-mahi', 10, 15, null::int, 90, 4, '15'),
    ('face-pull-obratnym-hvatom', 20, 15, null::int, 90, 4, '15'),
    ('razvedeniya-v-naklone-sidya', 30, 15, null::int, 90, 3, '15'),
    ('shragi-trapetsiya', 40, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 3–4 — Фундамент (новый блок)', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-v-hammer-strength', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-na-gorizontalnoy-skame', 10, 12, null::int, 90, 4, '12'),
    ('pec-deck-babochka', 20, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-na-brusyah', 30, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-kanatom', 40, 15, null::int, 90, 4, '15'),
    ('razgibanie-odnoy-ruki-nad-golovoy', 50, 12, null::int, 90, 3, '12'),
    ('finisher-battle-rope', 60, null::int, 20, 90, 5, '20 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 3–4 — Фундамент (новый блок)', 2, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hak-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 4, '10'),
    ('vypady-nazad-s-gantelyami', 20, 12, null::int, 90, 3, '12'),
    ('razgibanie-nog', 30, 15, null::int, 90, 3, '15'),
    ('podemy-na-noski-sidya', 40, 20, null::int, 90, 5, '20'),
    ('finisher-pryzhki-na-tumbu', 50, 10, null::int, 90, 3, '10')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 3–4 — Фундамент (новый блок)', 2, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-t-grifa', 0, 10, null::int, 90, 4, '10'),
    ('chest-supported-row-ganteli-na-naklonnoy', 10, 12, null::int, 90, 4, '12'),
    ('podtyagivaniya-obratnym-hvatom', 20, null::int, null::int, 90, 3, 'макс.'),
    ('straight-arm-pulldown', 30, 15, null::int, 90, 3, '15'),
    ('sgibaniya-na-skame-skotta', 40, 10, null::int, 90, 4, '10'),
    ('kanatnye-sgibaniya', 50, 15, null::int, 90, 3, '15'),
    ('finisher-trx-row', 60, null::int, null::int, 90, 2, 'до отказа')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 3–4 — Фундамент (новый блок)', 2, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 10, null::int, 90, 4, '10'),
    ('y-raise-supermen', 10, 15, null::int, 90, 3, '15'),
    ('podemy-cherez-storony-v-trenazhere', 20, 15, null::int, 90, 4, '15'),
    ('reverse-pec-deck-obratnym-hvatom', 30, 15, null::int, 90, 4, '15'),
    ('overhead-carry-perenos-2-ganteley-nad-golovoy', 40, 30, null::int, 90, 3, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 5–6 — Наращивание массы', 3, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-na-naklonnoy-skame', 0, 10, null::int, 90, 4, '10'),
    ('zhim-v-hammer-strength', 10, 12, null::int, 90, 4, '12'),
    ('svedenie-ruk-v-pec-deck', 20, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-na-brusyah', 30, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-na-verhnem-bloke-s-kanatom', 40, 12, null::int, 90, 4, '12'),
    ('frantsuzskiy-zhim-gantelyu-sidya', 50, 12, null::int, 90, 3, '12'),
    ('finisher-battle-rope', 60, null::int, 20, 90, 5, '20 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 5–6 — Наращивание массы', 3, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnye-prisedaniya', 0, 10, null::int, 90, 4, '10'),
    ('zhim-nogami-uzkoy-postanovkoy', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('vypady-vpered-s-gantelyami', 30, 12, null::int, 90, 3, '12'),
    ('podemy-na-noski-sidya', 40, 20, null::int, 90, 5, '20'),
    ('finisher-fermerskaya-progulka', 50, 40, null::int, 90, 3, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 5–6 — Наращивание массы', 3, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-neytralnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('tyaga-t-grifa', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 20, 12, null::int, 90, 3, '12'),
    ('tyaga-nizhnego-bloka-shirokim-hvatom', 30, 12, null::int, 90, 4, '12'),
    ('sgibaniya-ez-grifom', 40, 10, null::int, 90, 4, '10'),
    ('kontsentrirovannye-sgibaniya', 50, 12, null::int, 90, 3, '12'),
    ('finisher-trx-row', 60, null::int, null::int, 90, 2, 'до отказа')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 5–6 — Наращивание массы', 3, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 10, null::int, 90, 4, '10'),
    ('podemy-cherez-storony-sidya', 10, 15, null::int, 90, 4, '15'),
    ('face-pull', 20, 15, null::int, 90, 4, '15'),
    ('reverse-pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('shragi-s-gantelyami', 40, 15, null::int, 90, 4, '15'),
    ('finisher-perenos-dvuh-gir-nad-golovoy', 50, 30, null::int, 90, 3, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 7–8 — Калистеника и функционал', 4, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-gorizontalnoy-skame', 0, 8, null::int, 90, 4, '8–10'),
    ('otzhimaniya-na-koltsah', 10, null::int, null::int, 90, 4, 'макс.'),
    ('krossover-snizu-vverh', 20, 15, null::int, 90, 4, '15'),
    ('zhim-odnoy-rukoy-v-trenazhere', 30, 12, null::int, 90, 3, '12'),
    ('razgibanie-ruki-v-krossovere-odnoy-rukoy', 40, 12, null::int, 90, 4, '12'),
    ('uzkie-otzhimaniya', 50, null::int, null::int, 90, 3, 'макс.'),
    ('finisher-medbol-broski-v-pol', 60, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 7–8 — Калистеника и функционал', 4, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hak-prised', 0, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 10, 10, null::int, 90, 4, '10'),
    ('sgibanie-nog-lezha', 20, 12, null::int, 90, 4, '12'),
    ('goblet-squat', 30, 15, null::int, 90, 3, '15'),
    ('podemy-na-noski-v-trenazhere', 40, 20, null::int, 90, 5, '20'),
    ('finisher-pryzhki-na-tumbu', 50, 10, null::int, 90, 4, '10')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 7–8 — Калистеника и функционал', 4, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('chest-supported-row', 0, 10, null::int, 90, 4, '10'),
    ('podtyagivaniya-shirokim-hvatom', 10, null::int, null::int, 90, 4, 'макс.'),
    ('straight-arm-pulldown', 20, 15, null::int, 90, 4, '15'),
    ('meadows-row', 30, 12, null::int, 90, 3, '12'),
    ('molotkovye-sgibaniya', 40, 12, null::int, 90, 4, '12'),
    ('kanatnye-sgibaniya', 50, 15, null::int, 90, 3, '15'),
    ('finisher-battle-rope', 60, null::int, 20, 90, 5, '20 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 7–8 — Калистеника и функционал', 4, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('z-press', 0, 10, null::int, 90, 4, '10'),
    ('y-raise', 10, 15, null::int, 90, 4, '15'),
    ('podemy-cherez-storony-v-trenazhere', 20, 15, null::int, 90, 4, '15'),
    ('razvedeniya-v-naklone-s-pauzoy-2-sek', 30, 12, null::int, 90, 4, '12'),
    ('overhead-carry', 40, 40, null::int, 90, 3, '40 метров'),
    ('finisher-trx-pike', 50, 12, null::int, 90, 3, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 9–10 — Новый стресс: сила + растяжение', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy-skame-medlennyy-negativ-3-sek', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-hammer-sidya-drop-set-na-poslednem-podhode', 10, 10, null::int, 90, 4, '10'),
    ('krossover-snizu-vverh-pauza-2-sek', 20, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 30, null::int, null::int, 90, 3, 'макс.'),
    ('razgibanie-ruk-s-kanatom-uderzhanie-20-sek-vnizu', 40, 12, null::int, 90, 4, '12–15'),
    ('frantsuzskiy-zhim-ez-grifom-lezha', 50, 10, null::int, 90, 3, '10–12'),
    ('finisher-medbol-brosok-v-pol', 60, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + ФУНКЦИОНАЛ', 2, 'Недели 9–10 — Новый стресс: сила + растяжение', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 4, '10'),
    ('rumynskaya-tyaga-s-gantelyami', 10, 12, null::int, 90, 4, '12'),
    ('bolgarskie-vypady-s-pauzoy-2-sek', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('razgibanie-nog-drop-set-15-10-10', 30, 15, null::int, 90, 4, '15'),
    ('sgibanie-nog-lezha', 40, 12, null::int, 90, 4, '12'),
    ('ikry-stoya', 50, 20, null::int, 90, 5, '20'),
    ('finisher-krug-3-15-pryzhkov-na-tumbu-20-prisedaniy-30-sek-planka', 60, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 9–10 — Новый стресс: сила + растяжение', 5, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-tsel-bolshe-povtoreniy', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-t-grifa-s-uporom-grudyu', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka-obratnym-hvatom', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-ganteley-na-naklonnoy-skame', 30, 12, null::int, 90, 4, '12'),
    ('pulover-na-verhnem-bloke', 40, 15, null::int, 90, 4, '15'),
    ('sgibanie-ruk-s-gantelyami-na-naklonnoy-skame', 50, 10, null::int, 90, 4, '10'),
    ('molotki-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('finisher-farmer-walk', 70, 40, null::int, 90, 4, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 9–10 — Новый стресс: сила + растяжение', 5, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-arnolda', 0, 10, null::int, 90, 4, '10'),
    ('zhim-giri-odnoy-rukoy-stoya', 10, 10, null::int, 90, 3, '10 на сторону'),
    ('mahi-gantelyami-cherez-storony-chastichnye-povtoreniya-na-posl-podhode', 20, 15, null::int, 90, 5, '15'),
    ('face-pull', 30, 15, null::int, 90, 4, '15'),
    ('reverse-pec-deck', 40, 15, null::int, 90, 4, '15'),
    ('staticheskoe-uderzhanie-ganteley-v-storony', 50, null::int, 30, 90, 3, '30 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 11–12 — Новый стресс: полностью новая программа', 6, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-s-pauzoy-vnizu', 0, 8, null::int, 90, 5, '8'),
    ('otzhimaniya-na-koltsah', 10, null::int, null::int, 90, 4, 'макс.'),
    ('pec-deck-odnoy-rukoy', 20, 15, null::int, 90, 3, '15'),
    ('landmine-press', 30, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-uzkim-hvatom', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-nad-golovoy-s-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('finisher-emom-6-min-10-otzhimaniy-kazhduyu-minutu', 60, null::int, null::int, 90, 6, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 11–12 — Новый стресс: полностью новая программа', 6, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised', 0, 8, null::int, 90, 5, '8'),
    ('vypady-nazad-s-gantelyami', 10, 12, null::int, 90, 4, '12'),
    ('nordic-curl-oblegchennyy', 20, 8, null::int, 90, 3, '8'),
    ('zhim-nogami-vysokoy-postanovkoy', 30, 15, null::int, 90, 4, '15'),
    ('yagodichnyy-most-so-shtangoy', 40, 12, null::int, 90, 4, '12'),
    ('ikry-sidya', 50, 20, null::int, 90, 5, '20'),
    ('finisher-krug-3-20-walking-lunges-20-air-squats-30-sek-wall-sit', 60, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 11–12 — Новый стресс: полностью новая программа', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-pauzoy-sverhu', 0, 8, null::int, 90, 4, '8–10'),
    ('meadows-row', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-bloka-odnoy-rukoy', 20, 12, null::int, 90, 4, '12'),
    ('chest-supported-row', 30, 12, null::int, 90, 4, '12'),
    ('face-pull', 40, 20, null::int, 90, 4, '20'),
    ('sgibanie-ez-grif', 50, 10, null::int, 90, 4, '10'),
    ('bitseps-na-bloke-odnoy-rukoy', 60, 15, null::int, 90, 3, '15'),
    ('finisher-trx-row', 70, null::int, null::int, 90, 3, 'до отказа')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 11–12 — Новый стресс: полностью новая программа', 6, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('z-press', 0, 8, null::int, 90, 4, '8–10'),
    ('podem-ganteley-cherez-storony-s-pauzoy', 10, 12, null::int, 90, 4, '12'),
    ('kubinskiy-zhim', 20, 12, null::int, 90, 3, '12'),
    ('rear-delt-fly', 30, 15, null::int, 90, 5, '15'),
    ('farmer-carry-tyazhelyy', 40, 30, null::int, 90, 4, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 13–14 — Сила + масса: тяжёлый жим', 7, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-2-5-5-vesa-kazhduyu-nedelyu', 0, 6, null::int, 90, 5, '6–8'),
    ('zhim-ganteley-na-naklonnoy-rest-pause-na-posl-podhode', 10, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-hammer-snizu-vverh', 20, 10, null::int, 90, 4, '10'),
    ('krossover-s-pauzoy-3-sek', 30, 15, null::int, 90, 3, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-na-bloke-obratnym-hvatom', 50, 12, null::int, 90, 4, '12'),
    ('frantsuzskiy-zhim-gantelyu', 60, 10, null::int, 90, 3, '10'),
    ('finisher-emom-5-min-15-otzhimaniy', 70, null::int, null::int, 90, 5, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 13–14 — Сила + масса: тяжёлый жим', 7, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy-tyazhelyy-rabochiy-ves-na-posl-podhode', 0, 6, null::int, 90, 5, '6–8'),
    ('rumynskaya-tyaga-so-shtangoy', 10, 8, null::int, 90, 4, '8'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 30, 10, null::int, 90, 3, '10 на ногу'),
    ('sgibanie-nog-lezha', 40, 12, null::int, 90, 4, '12'),
    ('ikry-stoya', 50, 15, null::int, 90, 5, '15'),
    ('finisher-wall-sit', 60, null::int, 90, 90, 3, '90 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 13–14 — Сила + масса: тяжёлый жим', 7, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-dop-vesom', 0, 6, null::int, 90, 5, '6–8'),
    ('tyaga-shtangi-v-naklone', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka', 30, 10, null::int, 90, 4, '10'),
    ('pulover-s-kanatom', 40, 15, null::int, 90, 3, '15'),
    ('sgibanie-ez-grif', 50, 8, null::int, 90, 4, '8–10'),
    ('molotki-stoya', 60, 12, null::int, 90, 3, '12'),
    ('finisher-farmer-walk', 70, 30, null::int, 90, 5, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 13–14 — Сила + масса: тяжёлый жим', 7, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-stoya', 0, 6, null::int, 90, 5, '6–8'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('mahi-gantelyami-v-storony-drop-set-12-10-10', 20, 12, null::int, 90, 5, '12'),
    ('face-pull', 30, 15, null::int, 90, 4, '15'),
    ('reverse-pec-deck', 40, 15, null::int, 90, 4, '15'),
    ('shragi-so-shtangoy', 50, 12, null::int, 90, 4, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 15–16 — Сила + атлетизм', 8, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-tyazhelyy', 0, 6, null::int, 90, 5, '6'),
    ('floor-press-so-shtangoy', 10, 8, null::int, 90, 4, '8'),
    ('otzhimaniya-na-koltsah', 20, null::int, null::int, 90, 4, 'макс.'),
    ('pec-deck', 30, 12, null::int, 90, 4, '12'),
    ('zhim-uzkim-hvatom', 40, 8, null::int, 90, 4, '8'),
    ('razgibanie-ruk-s-kanatom-nad-golovoy', 50, 12, null::int, 90, 4, '12'),
    ('finisher-battle-rope-8-raundov-po-20-sek', 60, null::int, null::int, 90, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 15–16 — Сила + атлетизм', 8, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised', 0, 6, null::int, 90, 5, '6'),
    ('trap-bar-deadlift', 10, 8, null::int, 90, 4, '8'),
    ('vypady-nazad', 20, 10, null::int, 90, 4, '10'),
    ('hak-prised', 30, 12, null::int, 90, 4, '12'),
    ('nordic-curl', 40, 8, null::int, 90, 3, '8'),
    ('ikry-sidya', 50, 20, null::int, 90, 5, '20'),
    ('finisher-krug-3-20-pryzhkov-20-prisedaniy-40-sek-planka', 60, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 15–16 — Сила + атлетизм', 8, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-t-grifa', 0, 6, null::int, 90, 5, '6–8'),
    ('podtyagivaniya-shirokim-hvatom', 10, null::int, null::int, 90, 5, 'макс.'),
    ('meadows-row', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-bloka-odnoy-rukoy', 30, 12, null::int, 90, 4, '12'),
    ('reverse-fly', 40, 15, null::int, 90, 4, '15'),
    ('sgibanie-ruk-na-skame-skotta', 50, 10, null::int, 90, 4, '10'),
    ('kanatnye-molotki', 60, 15, null::int, 90, 3, '15'),
    ('finisher-trx-row-100-povtoreniy-lyuboe-kol-vo-podhodov', 70, 100, null::int, 90, 1, '100')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 15–16 — Сила + атлетизм', 8, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('z-press', 10, 8, null::int, 90, 4, '8'),
    ('mahi-cherez-storony', 20, 15, null::int, 90, 5, '15'),
    ('kubinskiy-zhim', 30, 12, null::int, 90, 3, '12'),
    ('zadnyaya-delta-v-naklone', 40, 15, null::int, 90, 5, '15'),
    ('farmer-carry-nad-golovoy', 50, 30, null::int, 90, 4, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + ФУНКЦ. ФИНИШЕР', 1, 'Недели 17–18 — Гипертрофия 2.0', 9, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy-skame', 0, 8, null::int, 90, 4, '8–10'),
    ('zhim-v-hammer-strength-drop-set-10-30-10', 10, 10, null::int, 90, 4, '10'),
    ('superset-4-krossover-15-otzhimaniya-do-otkaza', 20, null::int, null::int, 90, 4, 'круг'),
    ('zhim-ganteley-uzkim-hvatom', 30, 10, null::int, 90, 4, '10'),
    ('razgibanie-ruk-s-kanatom-uderzhanie-20-sek-vnizu', 40, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-ez-grifom', 50, 12, null::int, 90, 3, '12'),
    ('finisher-battle-rope-8-raundov-po-20-sek', 60, null::int, null::int, 90, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + АТЛЕТИКА', 2, 'Недели 17–18 — Гипертрофия 2.0', 9, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy', 0, 8, null::int, 90, 4, '8'),
    ('bolgarskie-vypady', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('superset-4-razgibanie-nog-15-sgibanie-nog-15', 30, null::int, null::int, 90, 4, 'круг'),
    ('ikry-stoya', 40, 20, null::int, 90, 5, '20'),
    ('finisher-crossfit-3-15-goblet-squat-10-pryzhkov-na-tumbu-20-vypadov-d0cb0e', 50, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 17–18 — Гипертрофия 2.0', 9, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-t-grifa', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-verhnego-bloka-neytralnym-hvatom', 20, 12, null::int, 90, 4, '12'),
    ('superset-4-chest-supported-row-12-straight-arm-pulldown-15', 30, null::int, null::int, 90, 4, 'круг'),
    ('bitseps-ez-grif', 40, 10, null::int, 90, 4, '10'),
    ('molotki-s-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('finisher-farmer-walk', 60, 40, null::int, 90, 5, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 17–18 — Гипертрофия 2.0', 9, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 10, null::int, 90, 4, '10'),
    ('zhim-giri-odnoy-rukoy-stoya', 10, 10, null::int, 90, 4, '10 на сторону'),
    ('superset-5-mahi-cherez-storony-15-face-pull-20', 20, null::int, null::int, 90, 5, 'круг'),
    ('reverse-pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('shragi', 40, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 19–20 — Мышечная выносливость', 10, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-na-koltsah', 0, null::int, null::int, 90, 5, 'макс.'),
    ('zhim-shtangi-s-pauzoy', 10, 8, null::int, 90, 4, '8'),
    ('landmine-press', 20, 12, null::int, 90, 4, '12'),
    ('krossover-odnoy-rukoy', 30, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-uzkim-hvatom', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-nad-golovoy-s-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('finisher-emom-8-min-15-otzhimaniy', 60, null::int, null::int, 90, 8, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 19–20 — Мышечная выносливость', 10, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trap-bar-deadlift', 0, 6, null::int, 90, 5, '6'),
    ('front-squat', 10, 8, null::int, 90, 4, '8'),
    ('walking-lunges', 20, 20, null::int, 90, 4, '20 шагов'),
    ('girevoy-sving', 30, 15, null::int, 90, 5, '15'),
    ('nordic-curl', 40, 8, null::int, 90, 3, '8'),
    ('finisher-amrap-10-min-10-goblet-squat-10-pryzhkov-10-vypadov', 50, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 19–20 — Мышечная выносливость', 10, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('meadows-row', 10, 10, null::int, 90, 4, '10'),
    ('tyaga-bloka-odnoy-rukoy', 20, 12, null::int, 90, 4, '12'),
    ('trx-row', 30, 15, null::int, 90, 4, '15'),
    ('sgibaniya-na-skame-skotta', 40, 12, null::int, 90, 4, '12'),
    ('molotki-stoya', 50, 15, null::int, 90, 3, '15'),
    ('finisher-battle-rope-10-20-sek', 60, null::int, null::int, 90, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 19–20 — Мышечная выносливость', 10, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 6, null::int, 90, 5, '6'),
    ('z-press', 10, 10, null::int, 90, 4, '10'),
    ('mahi-cherez-storony', 20, 15, null::int, 90, 5, '15'),
    ('rear-delt-fly', 30, 15, null::int, 90, 5, '15'),
    ('overhead-carry', 40, 40, null::int, 90, 4, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 21–22 — Шоковая адаптация', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-s-pauzoy-3-sek-vniz-1-sek-pauza', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-na-naklonnoy-meh-drop-set-10-10-10', 10, 10, null::int, 90, 4, '10'),
    ('superset-5-krossover-sverhu-vniz-15-uzkie-otzhimaniya-maks', 20, null::int, null::int, 90, 5, 'круг'),
    ('zhim-v-hammer-odnoy-rukoy', 30, 12, null::int, 90, 3, '12 на сторону'),
    ('razgibanie-ruk-na-bloke-kanatom-uderzhanie-30-sek-vnizu', 40, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-ez-posl-3-povt-medlenno-5-sek', 50, 10, null::int, 90, 4, '10'),
    ('finisher-battle-rope-10-20-sek', 60, null::int, null::int, 90, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + ВЗРЫВНАЯ РАБОТА', 2, 'Недели 21–22 — Шоковая адаптация', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnye-prisedaniya', 0, 6, null::int, 90, 5, '6–8'),
    ('rumynskaya-tyaga-negativ-3-sek', 10, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady-posl-podhod-do-otkaza', 20, 10, null::int, 90, 4, '10 на ногу'),
    ('superset-4-razgibanie-nog-20-wall-sit-45-sek', 30, null::int, null::int, 90, 4, 'круг'),
    ('sgibanie-nog-lezha-pauza-2-sek-vverhu', 40, 12, null::int, 90, 4, '12'),
    ('ikry-stoya', 50, 20, null::int, 90, 5, '20'),
    ('finisher-5-10-pryzhkov-na-tumbu-15-goblet-squat-30-sek-planka', 60, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 21–22 — Шоковая адаптация', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-posl-podhod-maksimum', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-shtangi-v-naklone', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnego-bloka-shirokim-hvatom-pauza-2-sek-vnizu', 20, 12, null::int, 90, 4, '12'),
    ('superset-4-gorizontalnaya-tyaga-12-pulover-kanatom-15', 30, null::int, null::int, 90, 4, 'круг'),
    ('sgibanie-ez-grif', 40, 10, null::int, 90, 4, '10'),
    ('molotki-s-gantelyami', 50, 12, null::int, 90, 4, '12'),
    ('finisher-farmer-walk', 60, 40, null::int, 90, 6, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 21–22 — Шоковая адаптация', 11, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('superset-5-mahi-cherez-storony-15-mahi-nazad-v-naklone-15', 20, null::int, null::int, 90, 5, 'круг'),
    ('face-pull', 30, 20, null::int, 90, 4, '20'),
    ('shragi-s-gantelyami', 40, 15, null::int, 90, 4, '15'),
    ('statika-uderzhanie-ganteley-v-storony', 50, null::int, 40, 90, 3, '40 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 23–24 — Атлетизм: мышцы как у спортсмена', 12, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-polu-floor-press', 0, 8, null::int, 90, 5, '8'),
    ('otzhimaniya-na-koltsah', 10, null::int, null::int, 90, 4, 'макс.'),
    ('landmine-press', 20, 12, null::int, 90, 4, '12'),
    ('pec-deck-drop-set-na-posl-podhode', 30, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-nad-golovoy-s-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('finisher-emom-10-min-15-otzhimaniy', 60, null::int, null::int, 90, 10, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 23–24 — Атлетизм: мышцы как у спортсмена', 12, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('trap-bar-deadlift', 0, 5, null::int, 90, 5, '5'),
    ('hak-prised', 10, 10, null::int, 90, 4, '10'),
    ('walking-lunges', 20, 24, null::int, 90, 4, '24 шага'),
    ('girevoy-sving', 30, 20, null::int, 90, 5, '20'),
    ('nordic-curl', 40, 8, null::int, 90, 4, '8'),
    ('finisher-amrap-12-min-10-pryzhkov-15-prisedaniy-20-vypadov', 50, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 23–24 — Атлетизм: мышцы как у спортсмена', 12, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-t-grifa', 0, 8, null::int, 90, 5, '8'),
    ('podtyagivaniya-neytralnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('meadows-row', 20, 12, null::int, 90, 4, '12'),
    ('trx-row', 30, 15, null::int, 90, 4, '15'),
    ('skamya-skotta', 40, 12, null::int, 90, 4, '12'),
    ('kanatnye-sgibaniya', 50, 15, null::int, 90, 3, '15'),
    ('finisher-battle-rope-12-20-sek', 60, null::int, null::int, 90, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 23–24 — Атлетизм: мышцы как у спортсмена', 12, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-stoya', 0, 6, null::int, 90, 5, '6'),
    ('z-press', 10, 8, null::int, 90, 4, '8'),
    ('mahi-cherez-storony', 20, 12, null::int, 90, 6, '12'),
    ('reverse-pec-deck', 30, 15, null::int, 90, 5, '15'),
    ('farmer-carry-nad-golovoy', 40, 30, null::int, 90, 4, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 25–26 — Пиковая гипертрофия: максимальный объём груди', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy-skame-3-sek-vniz-1-sek-pauza-vzryv-vverh', 0, 10, null::int, 90, 4, '10'),
    ('zhim-shtangi-lezha-rest-pause-na-posl-podhode', 10, 8, null::int, 90, 4, '8'),
    ('zhim-v-hammer-strength', 20, 12, null::int, 90, 4, '12'),
    ('superset-4-krossover-sverhu-vniz-15-otzhimaniya-do-otkaza', 30, null::int, null::int, 90, 4, 'круг'),
    ('razgibanie-ruk-na-bloke', 40, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-s-gantelyu', 50, 12, null::int, 90, 3, '12'),
    ('fst-7-finisher-krossover-7-10-12-otdyh-30-sek', 60, 10, null::int, 90, 7, '10–12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 25–26 — Пиковая гипертрофия: максимальный объём груди', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('gakk-prised', 0, 10, null::int, 90, 5, '10'),
    ('bolgarskie-vypady', 10, 12, null::int, 90, 4, '12 на ногу'),
    ('rumynskaya-tyaga-s-gantelyami', 20, 10, null::int, 90, 4, '10'),
    ('superset-5-razgibanie-nog-20-sgibanie-nog-15', 30, null::int, null::int, 90, 5, 'круг'),
    ('yagodichnyy-most', 40, 12, null::int, 90, 4, '12'),
    ('ikry-stoya', 50, 15, null::int, 90, 6, '15'),
    ('finisher-walking-lunges-100-shagov', 60, 100, null::int, 90, 1, '100')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 25–26 — Пиковая гипертрофия: максимальный объём груди', 13, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 10, 12, null::int, 90, 4, '12'),
    ('tyaga-t-grifa', 20, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka', 30, 12, null::int, 90, 4, '12'),
    ('superset-4-straight-arm-pulldown-15-face-pull-20', 40, null::int, null::int, 90, 4, 'круг'),
    ('bitseps-ez-grif', 50, 10, null::int, 90, 4, '10'),
    ('molotki', 60, 12, null::int, 90, 4, '12'),
    ('fst-7-sgibanie-ruk-na-bloke-7-12-otdyh-30-sek', 70, 12, null::int, 90, 7, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ПРЕСС', 4, 'Недели 25–26 — Пиковая гипертрофия: максимальный объём груди', 13, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-sidya', 10, 8, null::int, 90, 4, '8'),
    ('gigantskiy-set-4-mahi-v-storony-15-mahi-vpered-15-mahi-nazad-15-face-d2f034', 20, null::int, null::int, 90, 4, 'круг'),
    ('reverse-pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('shragi', 40, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 27–28 — Бодибилдинг + атлетизм', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-s-obratnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('zhim-ganteley-gorizontalno', 10, 8, null::int, 90, 5, '8'),
    ('otzhimaniya-na-koltsah', 20, null::int, null::int, 90, 4, 'макс.'),
    ('pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('kanat-na-tritseps', 40, 12, null::int, 90, 5, '12'),
    ('otzhimaniya-uzkim-hvatom', 50, null::int, null::int, 90, 3, 'макс.'),
    ('finisher-med-ball-slam', 60, 20, null::int, 90, 5, '20')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 27–28 — Бодибилдинг + атлетизм', 14, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frontalnyy-prised', 0, 8, null::int, 90, 5, '8'),
    ('zhim-nogami', 10, 15, null::int, 90, 4, '15'),
    ('nordic-curl', 20, 8, null::int, 90, 4, '8'),
    ('vypady-nazad', 30, 12, null::int, 90, 4, '12'),
    ('ikry-sidya', 40, 20, null::int, 90, 6, '20'),
    ('finisher-3-20-pryzhkov-20-goblet-squat-40-sek-wall-sit', 50, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 27–28 — Бодибилдинг + атлетизм', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-shtangi-v-naklone', 0, 8, null::int, 90, 5, '8'),
    ('podtyagivaniya-neytralnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('meadows-row', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-bloka-odnoy-rukoy', 30, 15, null::int, 90, 4, '15'),
    ('skamya-skotta', 40, 10, null::int, 90, 4, '10'),
    ('kanatnye-molotki', 50, 15, null::int, 90, 4, '15'),
    ('finisher-farmer-walk', 60, 50, null::int, 90, 6, '50 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 27–28 — Бодибилдинг + атлетизм', 14, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('z-press', 10, 10, null::int, 90, 4, '10'),
    ('mahi-cherez-storony-otdyh-30-sek', 20, 12, null::int, 90, 7, '12'),
    ('rear-delt-fly', 30, 15, null::int, 90, 5, '15'),
    ('overhead-carry', 40, 40, null::int, 90, 4, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС + ПРЕСС', 1, 'Недели 29–30 — Специализация: верх груди + объём', 15, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy-posl-podhod-1-5-povtoreniya', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-shtangi-lezha-drop-set-8-30-10', 10, 8, null::int, 90, 4, '8'),
    ('krossover-snizu-vverh-pauza-2-sek', 20, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-na-koltsah', 30, null::int, null::int, 90, 4, 'макс.'),
    ('superset-4-razgibanie-ruk-s-kanatom-15-almaznye-otzhimaniya-10-15', 40, null::int, null::int, 90, 4, 'круг'),
    ('razgibanie-ruki-iz-za-golovy-na-bloke', 50, 15, null::int, 90, 3, '15'),
    ('finisher-battle-rope-6-30-sek', 60, null::int, null::int, 90, 6, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + ФУНКЦ. СИЛА', 2, 'Недели 29–30 — Специализация: верх груди + объём', 15, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy', 0, 8, null::int, 90, 5, '8'),
    ('bolgarskie-vypady-uderzhanie-20-sek-vnizu-na-posl-podhode', 10, 10, null::int, 90, 4, '10 на ногу'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('zhim-nogami', 30, 15, null::int, 90, 4, '15'),
    ('sgibanie-nog-lezha-negativy-5-sek-na-posl-podhode', 40, 12, null::int, 90, 4, '12'),
    ('ikry-stoya', 50, 20, null::int, 90, 6, '20'),
    ('finisher-sportsmen-4-10-pryzhkov-na-tumbu-15-goblet-squat-20-m-farmer-2df0e7', 60, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 29–30 — Специализация: верх груди + объём', 15, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-t-grifa', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-gorizontalnogo-bloka-dvoynoy-drop-set-na-posl', 30, 10, null::int, 90, 4, '10'),
    ('pulover-s-kanatom', 40, 15, null::int, 90, 4, '15'),
    ('superset-5-sgibanie-ez-grif-10-molotki-12', 50, null::int, null::int, 90, 5, 'круг'),
    ('sgibanie-ruk-na-bloke', 60, 15, null::int, 90, 3, '15'),
    ('finisher-trx-row-100-povtoreniy', 70, 100, null::int, 90, 1, '100')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 29–30 — Специализация: верх груди + объём', 15, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-sidya', 0, 8, null::int, 90, 5, '8'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('gigantskiy-set-5-mahi-cherez-storony-15-mahi-vpered-12-mahi-nazad-15-07f5b4', 20, null::int, null::int, 90, 5, 'круг'),
    ('reverse-pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('shragi', 40, 12, null::int, 90, 4, '12'),
    ('statika-uderzhanie-ganteley-v-storony', 50, null::int, 45, 90, 3, '45 сек')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 31–32 — Мышцы + контроль тела', 16, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('floor-press', 0, 8, null::int, 90, 5, '8'),
    ('zhim-ganteley-obratnym-hvatom', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-s-nogami-na-vozvyshenii', 20, null::int, null::int, 90, 4, 'макс.'),
    ('pec-deck', 30, 15, null::int, 90, 4, '15'),
    ('kanat-na-tritseps', 40, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-ez', 50, 10, null::int, 90, 4, '10'),
    ('finisher-emom-8-min-15-otzhimaniy', 60, null::int, null::int, 90, 8, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 31–32 — Мышцы + контроль тела', 16, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 6, null::int, 90, 5, '6'),
    ('trap-bar-deadlift', 10, 8, null::int, 90, 4, '8'),
    ('walking-lunges', 20, 30, null::int, 90, 4, '30 шагов'),
    ('nordic-curl', 30, 8, null::int, 90, 4, '8'),
    ('yagodichnyy-most', 40, 12, null::int, 90, 4, '12'),
    ('ikry', 50, 25, null::int, 90, 5, '25'),
    ('finisher-amrap-10-min-10-pryzhkov-15-prisedaniy-20-vypadov', 60, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 31–32 — Мышцы + контроль тела', 16, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-pauzoy', 0, 8, null::int, 90, 5, '8'),
    ('meadows-row', 10, 10, null::int, 90, 4, '10'),
    ('chest-supported-row', 20, 12, null::int, 90, 4, '12'),
    ('straight-arm-pulldown', 30, 15, null::int, 90, 4, '15'),
    ('skamya-skotta', 40, 12, null::int, 90, 4, '12'),
    ('kanatnye-molotki', 50, 15, null::int, 90, 4, '15'),
    ('finisher-battle-rope-10-20-sek', 60, null::int, null::int, 90, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 31–32 — Мышцы + контроль тела', 16, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('z-press', 10, 8, null::int, 90, 4, '8'),
    ('mahi-cherez-storony-otdyh-30-sek', 20, 12, null::int, 90, 8, '12'),
    ('rear-delt-fly', 30, 20, null::int, 90, 5, '20'),
    ('farmer-carry-nad-golovoy', 40, 30, null::int, 90, 5, '30 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 33–34 — Силовой пик: тяжёлый вес + объём', 17, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-80-85-ot-maks-klaster-5-2-3-na-posl-podhode', 0, 5, null::int, 90, 5, '5'),
    ('zhim-ganteley-na-naklonnoy-3-sek-vniz', 10, 8, null::int, 90, 4, '8'),
    ('zhim-v-hammer-drop-set-10-10-10', 20, 10, null::int, 90, 4, '10'),
    ('krossover-pauza-2-sek', 30, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 4, 'макс.'),
    ('frantsuzskiy-zhim-ez-grif', 50, 8, null::int, 90, 4, '8–10'),
    ('razgibanie-ruk-s-kanatom', 60, 15, null::int, 90, 3, '15'),
    ('finisher-medbol-broski', 70, 15, null::int, 90, 5, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 33–34 — Силовой пик: тяжёлый вес + объём', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy-80-85', 0, 5, null::int, 90, 5, '5'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 4, '8'),
    ('zhim-nogami', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 30, 8, null::int, 90, 4, '8 на ногу'),
    ('sgibanie-nog-lezha-negativy-5-sek', 40, 10, null::int, 90, 4, '10'),
    ('ikry-stoya', 50, 15, null::int, 90, 6, '15'),
    ('finisher-5-10-pryzhkov-na-tumbu-15-goblet-squat-30-sek-wall-sit', 60, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 33–34 — Силовой пик: тяжёлый вес + объём', 17, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-vesom', 0, 5, null::int, 90, 5, '5–8'),
    ('tyaga-shtangi-v-naklone', 10, 6, null::int, 90, 5, '6–8'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 4, '8'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 30, 10, null::int, 90, 4, '10'),
    ('tyaga-gorizontalnogo-bloka', 40, 12, null::int, 90, 4, '12'),
    ('sgibanie-ez-grif', 50, 8, null::int, 90, 4, '8'),
    ('molotki', 60, 10, null::int, 90, 4, '10'),
    ('finisher-farmer-walk', 70, 50, null::int, 90, 6, '50 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 33–34 — Силовой пик: тяжёлый вес + объём', 17, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-stoya', 0, 5, null::int, 90, 5, '5'),
    ('arnold-press', 10, 8, null::int, 90, 4, '8'),
    ('mahi-cherez-storony-otdyh-30-sek', 20, 12, null::int, 90, 6, '12'),
    ('face-pull', 30, 15, null::int, 90, 5, '15'),
    ('reverse-pec-deck', 40, 15, null::int, 90, 4, '15'),
    ('shragi', 50, 12, null::int, 90, 4, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 35–36 — Сила + тело атлета', 18, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-tyazhelyy', 0, 6, null::int, 90, 5, '6'),
    ('otzhimaniya-na-koltsah', 10, null::int, null::int, 90, 5, 'макс.'),
    ('floor-press', 20, 8, null::int, 90, 4, '8'),
    ('krossover-odnoy-rukoy', 30, 15, null::int, 90, 4, '15'),
    ('otzhimaniya-uzkim-hvatom', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-nad-golovoy', 50, 12, null::int, 90, 4, '12'),
    ('finisher-emom-10-min-15-otzhimaniy', 60, null::int, null::int, 90, 10, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 35–36 — Сила + тело атлета', 18, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 5, null::int, 90, 5, '5'),
    ('trap-bar-deadlift', 10, 5, null::int, 90, 5, '5'),
    ('walking-lunges', 20, 30, null::int, 90, 4, '30 шагов'),
    ('nordic-curl', 30, 8, null::int, 90, 4, '8'),
    ('girevoy-sving', 40, 20, null::int, 90, 5, '20'),
    ('finisher-amrap-12-min-10-pryzhkov-15-prisedaniy-20-vypadov', 50, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 35–36 — Сила + тело атлета', 18, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-shirokim-hvatom', 0, null::int, null::int, 90, 5, 'макс.'),
    ('meadows-row', 10, 8, null::int, 90, 5, '8'),
    ('chest-supported-row', 20, 10, null::int, 90, 4, '10'),
    ('straight-arm-pulldown', 30, 15, null::int, 90, 4, '15'),
    ('skamya-skotta', 40, 10, null::int, 90, 4, '10'),
    ('kanatnye-molotki', 50, 15, null::int, 90, 4, '15'),
    ('finisher-battle-rope-12-20-sek', 60, null::int, null::int, 90, 12, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ', 4, 'Недели 35–36 — Сила + тело атлета', 18, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('z-press', 10, 8, null::int, 90, 4, '8'),
    ('gigantskiy-set-5-mahi-v-storony-15-zadnyaya-delta-15-face-pull-20', 20, null::int, null::int, 90, 5, 'круг'),
    ('farmer-carry-nad-golovoy', 30, 40, null::int, 90, 5, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'Недели 37–38 — Верх тела 3D', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-na-naklonnoy-drop-set-10-30-10', 0, 8, null::int, 90, 5, '8–10'),
    ('zhim-shtangi-lezha', 10, 8, null::int, 90, 4, '8'),
    ('krossover-snizu-vverh-pauza-2-sek', 20, 15, null::int, 90, 4, '15'),
    ('superset-4-otzhimaniya-na-brusyah-12-mahi-gantelyami-v-storony-15', 30, null::int, null::int, 90, 4, 'круг'),
    ('zhim-arnolda', 40, 10, null::int, 90, 4, '10'),
    ('razgibanie-ruk-s-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('frantsuzskiy-zhim-ez-grifom', 60, 12, null::int, 90, 3, '12'),
    ('fst-7-mahi-cherez-storony-7-12-otdyh-30-sek', 70, 12, null::int, 90, 7, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + КОР', 2, 'Недели 37–38 — Верх тела 3D', 19, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy', 0, 8, null::int, 90, 5, '8'),
    ('zhim-nogami', 10, 12, null::int, 90, 4, '12'),
    ('rumynskaya-tyaga', 20, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 30, 12, null::int, 90, 4, '12'),
    ('superset-5-razgibanie-nog-20-sgibanie-nog-15', 40, null::int, null::int, 90, 5, 'круг'),
    ('ikry-stoya', 50, 20, null::int, 90, 6, '20'),
    ('finisher-3-20-pryzhkov-na-tumbu-20-goblet-squat-60-sek-wall-sit', 60, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 37–38 — Верх тела 3D', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-t-grifa', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnego-bloka-shirokim-hvatom', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-gorizontalnogo-bloka', 30, 12, null::int, 90, 4, '12'),
    ('superset-5-straight-arm-pulldown-15-face-pull-20', 40, null::int, null::int, 90, 5, 'круг'),
    ('sgibanie-ez-grif', 50, 10, null::int, 90, 4, '10'),
    ('bitseps-na-naklonnoy-skame', 60, 12, null::int, 90, 4, '12'),
    ('fst-7-sgibanie-ruk-na-bloke-7-12', 70, 12, null::int, 90, 7, '12')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + РУКИ + ПРЕСС', 4, 'Недели 37–38 — Верх тела 3D', 19, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-sidya', 0, 8, null::int, 90, 5, '8'),
    ('mahi-cherez-storony', 10, 15, null::int, 90, 6, '15'),
    ('zadnyaya-delta-v-trenazhere', 20, 15, null::int, 90, 5, '15'),
    ('superset-ruk-5-frantsuzskiy-zhim-kanatom-12-molotki-kanatom-12', 30, null::int, null::int, 90, 5, 'круг'),
    ('shragi', 40, 15, null::int, 90, 4, '15')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 39–40 — Памп + контроль тела', 20, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-neytralnym-hvatom', 0, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-na-koltsah', 10, null::int, null::int, 90, 5, 'макс.'),
    ('landmine-press', 20, 12, null::int, 90, 4, '12'),
    ('pec-deck', 30, 15, null::int, 90, 5, '15'),
    ('uzkie-otzhimaniya', 40, null::int, null::int, 90, 4, 'макс.'),
    ('razgibanie-ruk-nad-golovoy', 50, 15, null::int, 90, 4, '15'),
    ('finisher-emom-8-min-15-otzhimaniy', 60, null::int, null::int, 90, 8, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 39–40 — Памп + контроль тела', 20, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 8, null::int, 90, 5, '8'),
    ('hack-squat', 10, 12, null::int, 90, 4, '12'),
    ('walking-lunges', 20, 30, null::int, 90, 4, '30 шагов'),
    ('nordic-curl', 30, 8, null::int, 90, 4, '8'),
    ('yagodichnyy-most', 40, 12, null::int, 90, 4, '12'),
    ('ikry', 50, 25, null::int, 90, 6, '25'),
    ('finisher-amrap-10-min-10-pryzhkov-15-prisedaniy-20-vypadov', 60, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 39–40 — Памп + контроль тела', 20, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-neytralnym-hvatom', 0, null::int, null::int, 90, 5, 'макс.'),
    ('meadows-row', 10, 10, null::int, 90, 5, '10'),
    ('chest-supported-row', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-bloka-odnoy-rukoy', 30, 15, null::int, 90, 4, '15'),
    ('skamya-skotta', 40, 12, null::int, 90, 4, '12'),
    ('molotki', 50, 15, null::int, 90, 4, '15'),
    ('finisher-farmer-walk', 60, 50, null::int, 90, 6, '50 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + РУКИ', 4, 'Недели 39–40 — Памп + контроль тела', 20, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 6, null::int, 90, 5, '6'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('gigantskiy-set-4-mahi-v-storony-15-zadnyaya-delta-15-face-pull-20-1e960d', 20, null::int, null::int, 90, 4, 'круг'),
    ('superset-ruk-5-bitseps-ez-12-razgibanie-kanatom-15', 30, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 41–42 — PRO ATHLETE: максимальная сила груди', 21, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-85-90-klaster-4-2-na-posl-podhode', 0, 4, null::int, 90, 6, '4'),
    ('zhim-ganteley-na-naklonnoy-3-sek-vniz-1-sek-pauza', 10, 8, null::int, 90, 5, '8'),
    ('zhim-v-hammer-troynoy-drop-set-10-30-10-30-10', 20, 10, null::int, 90, 4, '10'),
    ('krossover-posl-5-povt-medlenno', 30, 15, null::int, 90, 5, '15'),
    ('otzhimaniya-na-brusyah', 40, null::int, null::int, 90, 5, 'макс.'),
    ('frantsuzskiy-zhim-ez', 50, 8, null::int, 90, 4, '8'),
    ('kanat-na-bloke-uderzhanie-20-sek-vnizu', 60, 15, null::int, 90, 4, '15'),
    ('finisher-battle-rope-8-30-sek', 70, null::int, null::int, 90, 8, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 41–42 — PRO ATHLETE: максимальная сила груди', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya-so-shtangoy-85', 0, 4, null::int, 90, 6, '4'),
    ('rumynskaya-tyaga', 10, 8, null::int, 90, 5, '8'),
    ('zhim-nogami', 20, 10, null::int, 90, 5, '10'),
    ('bolgarskie-vypady', 30, 10, null::int, 90, 4, '10 на ногу'),
    ('sgibanie-nog-lezha-negativy-5-sek', 40, 12, null::int, 90, 5, '12'),
    ('ikry', 50, 15, null::int, 90, 8, '15'),
    ('finisher-voin-5-10-pryzhkov-na-tumbu-20-prisedaniy-30-sek-planka', 60, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 41–42 — PRO ATHLETE: максимальная сила груди', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-s-vesom', 0, 5, null::int, 90, 6, '5'),
    ('tyaga-shtangi-v-naklone', 10, 6, null::int, 90, 5, '6'),
    ('tyaga-t-grifa', 20, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnim-blokom-shirokim-hvatom-pauza-2-sek', 30, 10, null::int, 90, 4, '10'),
    ('gorizontalnaya-tyaga-troynoy-drop-set', 40, 12, null::int, 90, 4, '12'),
    ('pulover-kanatom', 50, 15, null::int, 90, 4, '15'),
    ('bitseps-ez-grif', 60, 8, null::int, 90, 5, '8'),
    ('molotki', 70, 12, null::int, 90, 4, '12'),
    ('finisher-farmer-walk', 80, 60, null::int, 90, 6, '60 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + РУКИ', 4, 'Недели 41–42 — PRO ATHLETE: максимальная сила груди', 21, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-stoya', 0, 5, null::int, 90, 6, '5'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('mahi-cherez-storony-otdyh-30-sek', 20, 12, null::int, 90, 8, '12'),
    ('zadnyaya-delta', 30, 20, null::int, 90, 5, '20'),
    ('shragi', 40, 12, null::int, 90, 5, '12'),
    ('superset-ruk-5-bitseps-na-naklonnoy-12-razgibanie-kanatom-15', 50, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ТРИЦЕПС', 1, 'Недели 43–44 — FINAL MASS SHOCK', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-lezha', 0, 6, null::int, 90, 5, '6'),
    ('zhim-v-mashine-smita', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-s-dop-vesom', 20, 12, null::int, 90, 4, '12'),
    ('pec-deck', 30, 15, null::int, 90, 5, '15'),
    ('krossover-odnoy-rukoy', 40, 15, null::int, 90, 4, '15'),
    ('razgibanie-ruk-nad-golovoy-s-kanatom', 50, 12, null::int, 90, 4, '12'),
    ('otzhimaniya-uzkim-hvatom', 60, null::int, null::int, 90, 3, 'макс.'),
    ('finisher-100-otzhimaniy-min-kol-vo-podhodov', 70, 100, null::int, 90, 1, '100')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 43–44 — FINAL MASS SHOCK', 22, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 5, null::int, 90, 5, '5'),
    ('hack-squat', 10, 10, null::int, 90, 5, '10'),
    ('vypady-nazad-s-gantelyami', 20, 12, null::int, 90, 4, '12'),
    ('gudmorning', 30, 10, null::int, 90, 4, '10'),
    ('sgibanie-nog-sidya', 40, 12, null::int, 90, 5, '12'),
    ('ikry-sidya', 50, 20, null::int, 90, 6, '20'),
    ('finisher-emom-10-min-15-goblet-squat', 60, null::int, null::int, 90, 10, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 43–44 — FINAL MASS SHOCK', 22, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('meadows-row', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-bloka-uzkim-hvatom', 20, 12, null::int, 90, 4, '12'),
    ('tyaga-ganteley-na-naklonnoy-skame', 30, 15, null::int, 90, 4, '15'),
    ('reverse-fly', 40, 20, null::int, 90, 5, '20'),
    ('skamya-skotta', 50, 10, null::int, 90, 5, '10'),
    ('kanatnye-molotki', 60, 15, null::int, 90, 4, '15'),
    ('finisher-battle-rope-10-20-sek', 70, null::int, null::int, 90, 10, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + РУКИ', 4, 'Недели 43–44 — FINAL MASS SHOCK', 22, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-press', 0, 5, null::int, 90, 5, '5'),
    ('z-press', 10, 8, null::int, 90, 4, '8'),
    ('gigantskiy-set-6-mahi-v-storony-15-face-pull-20-zadnyaya-delta-20', 20, null::int, null::int, 90, 6, 'круг'),
    ('superset-5-ez-bitseps-10-frantsuzskiy-zhim-10', 30, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + ПЛЕЧИ + ТРИЦЕПС', 1, 'Недели 45–46 — 3D верх тела', 23, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-shtangi-lezha-80-85-amrap-na-posl-podhode', 0, 8, null::int, 90, 4, '8'),
    ('zhim-ganteley-na-naklonnoy-3-sek-vniz', 10, 10, null::int, 90, 4, '10'),
    ('otzhimaniya-na-koltsah', 20, null::int, null::int, 90, 4, 'макс.'),
    ('krossover-posl-5-povt-uderzhanie-2-sek', 30, 20, null::int, 90, 4, '20'),
    ('gigantskiy-set-plech-5-mahi-v-storony-15-mahi-vpered-12-zadnyaya-f357ed', 40, null::int, null::int, 90, 5, 'круг'),
    ('superset-tritsepsa-4-frantsuzskiy-zhim-ez-10-kanat-na-bloke-15', 50, null::int, null::int, 90, 4, 'круг'),
    ('finisher-emom-10-min-15-otzhimaniy', 60, null::int, null::int, 90, 10, 'мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ + АТЛЕТИЗМ', 2, 'Недели 45–46 — 3D верх тела', 23, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedaniya', 0, 6, null::int, 90, 5, '6'),
    ('rumynskaya-tyaga', 10, 10, null::int, 90, 4, '10'),
    ('bolgarskie-vypady', 20, 12, null::int, 90, 4, '12'),
    ('zhim-nogami', 30, 15, null::int, 90, 4, '15'),
    ('sgibanie-nog-uderzhanie-20-sek-na-posl-podhode', 40, 15, null::int, 90, 4, '15'),
    ('ikry', 50, 25, null::int, 90, 6, '25'),
    ('finisher-5-10-pryzhkov-na-tumbu-20-vypadov-30-sek-sprint-na-meste', 60, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 45–46 — 3D верх тела', 23, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya', 0, null::int, null::int, 90, 5, 'макс.'),
    ('tyaga-t-grifa', 10, 8, null::int, 90, 5, '8'),
    ('tyaga-verhnego-bloka-odnoy-rukoy', 20, 12, null::int, 90, 4, '12'),
    ('gorizontalnaya-tyaga', 30, 12, null::int, 90, 4, '12'),
    ('pulover-kanatom', 40, 15, null::int, 90, 5, '15'),
    ('superset-bitsepsa-5-sgibanie-ez-grif-10-molotki-12', 50, null::int, null::int, 90, 5, 'круг'),
    ('kontsentratsiya-na-bitseps', 60, 15, null::int, 90, 3, '15'),
    ('finisher-farmer-walk', 70, 40, null::int, 90, 8, '40 метров')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + РУКИ + КОР', 4, 'Недели 45–46 — 3D верх тела', 23, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley-sidya', 0, 8, null::int, 90, 5, '8'),
    ('arnold-press', 10, 10, null::int, 90, 4, '10'),
    ('mahi-cherez-storony-otdyh-30-sek', 20, 15, null::int, 90, 7, '15'),
    ('zadnyaya-delta', 30, 20, null::int, 90, 5, '20'),
    ('superset-ruk-6-bitseps-na-bloke-15-razgibanie-kanatom-15', 40, null::int, null::int, 90, 6, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ГРУДЬ + РУКИ', 1, 'Недели 47–48 — FINAL BOSS: памп, рельеф, форма', 24, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('zhim-ganteley', 0, 12, null::int, 90, 4, '12'),
    ('zhim-v-trenazhere', 10, 15, null::int, 90, 4, '15'),
    ('krossover', 20, 20, null::int, 90, 5, '20'),
    ('otzhimaniya', 30, null::int, null::int, 90, 3, 'макс.'),
    ('superset-ruk-6-bitseps-ez-12-tritseps-kanat-15', 40, null::int, null::int, 90, 6, 'круг'),
    ('finisher-100-otzhimaniy-min-kol-vo-podhodov', 50, 100, null::int, 90, 1, '100')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · НОГИ', 2, 'Недели 47–48 — FINAL BOSS: памп, рельеф, форма', 24, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('front-squat', 0, 8, null::int, 90, 4, '8'),
    ('hack-squat', 10, 12, null::int, 90, 4, '12'),
    ('vypady-hodboy', 20, 40, null::int, 90, 4, '40 шагов'),
    ('sgibanie-nog', 30, 15, null::int, 90, 5, '15'),
    ('ikry', 40, 20, null::int, 90, 8, '20'),
    ('finisher-amrap-10-min-10-pryzhkov-15-prisedaniy-20-mountain-climbers', 50, null::int, null::int, 90, 1, 'AMRAP')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · СПИНА + БИЦЕПС', 3, 'Недели 47–48 — FINAL BOSS: памп, рельеф, форма', 24, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('podtyagivaniya-100-povtoreniy-lyuboe-kol-vo-podhodov', 0, 100, null::int, 90, 1, '100'),
    ('tyaga-ganteley-na-naklonnoy-skame', 10, 15, null::int, 90, 4, '15'),
    ('tyaga-bloka', 20, 15, null::int, 90, 5, '15'),
    ('face-pull', 30, 20, null::int, 90, 5, '20'),
    ('gigantskiy-set-bitsepsa-5-ez-grif-10-molotki-12-kanat-15', 40, null::int, null::int, 90, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · ПЛЕЧИ + ФИНАЛЬНЫЙ ПАМП', 4, 'Недели 47–48 — FINAL BOSS: памп, рельеф, форма', 24, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('arnold-press', 0, 12, null::int, 90, 4, '12'),
    ('mahi-cherez-storony-otdyh-20-sek', 10, 10, null::int, 90, 10, '10'),
    ('zadnyaya-delta', 20, 25, null::int, 90, 5, '25'),
    ('shragi', 30, 15, null::int, 90, 5, '15'),
    ('finalnyy-kompleks-3-20-otzhimaniy-20-prisedaniy-20-russian-twist-60-522591', 40, null::int, null::int, 90, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
