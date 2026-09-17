-- 0016_seed_nabor_massy_zhenshchiny_doma.sql
-- Программа: Набор массы — Женщины — Дома
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0016), по одной на каждую комбинацию
-- пол × цель × формат — см. 0015..0021 и журнал в PROJECT_PLAN.md.
--
-- 94 тренировок, 365 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Набор массы — Женщины — Дома)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('goblet-squat-prised-s-gantelyu', 'Goblet Squat — присед с гантелью'),
  ('yagodichnyy-most-s-gantelyu', 'Ягодичный мост с гантелью'),
  ('bolgarskie-vypady', 'Болгарские выпады'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('otvedenie-nogi-nazad-s-rezinkoy', 'Отведение ноги назад с резинкой'),
  ('otvedenie-nogi-v-storonu-s-rezinkoy', 'Отведение ноги в сторону с резинкой'),
  ('wall-sit-statika-u-steny', 'Wall Sit — статика у стены'),
  ('core-2-kruga-krug-dead-bug-60-sek-skruchivaniya-60-sek-podem-sognutyh-100046', 'Core — 2 круга: Круг, Dead Bug — 60 сек, Скручивания — 60 сек, Подъём согнутых ног лёжа — 60 сек, Планка — 60 сек, Всего'),
  ('sumo-prised-s-gantelyu', 'Сумо-присед с гантелью'),
  ('sumo-prised-statika', 'Сумо-присед + статика'),
  ('vypady-nazad', 'Выпады назад'),
  ('odnonogaya-rumynskaya-tyaga', 'Одноногая румынская тяга'),
  ('yagodichnyy-most-s-rezinkoy', 'Ягодичный мост с резинкой'),
  ('frog-pumps', 'Frog Pumps'),
  ('rakushka-s-rezinkoy', '«Ракушка» с резинкой'),
  ('core-2-kruga-mountain-climbers-reverse-crunch-russian-twist-planka-na-e5befb', 'Core — 2 круга.: Mountain Climbers, Reverse Crunch, Russian Twist, Планка на локтях'),
  ('tyaga-dvuh-ganteley-v-naklone', 'Тяга двух гантелей в наклоне'),
  ('tyaga-odnoy-ganteli-k-poyasu', 'Тяга одной гантели к поясу'),
  ('tyaga-rezinki-k-zhivotu', 'Тяга резинки к животу'),
  ('face-pull-s-rezinkoy', 'Face Pull с резинкой'),
  ('plechevoy-superset', 'ПЛЕЧЕВОЙ СУПЕРСЕТ'),
  ('otzhimaniya', 'Отжимания'),
  ('razgibanie-ruk-s-rezinkoy-na-tritseps', 'Разгибание рук с резинкой на трицепс'),
  ('sgibanie-ruk-s-rezinkoy-na-bitseps', 'Сгибание рук с резинкой на бицепс'),
  ('core-2-kruga-velosiped-dead-bug-podem-nog-lezha-planka', 'Core — 2 круга: Велосипед, Dead Bug, Подъём ног лёжа, Планка'),
  ('goblet-squat', 'Goblet Squat'),
  ('yagodichnyy-most-s-vesom', 'Ягодичный мост с весом'),
  ('rumynskaya-tyaga', 'Румынская тяга'),
  ('otvedenie-nogi-v-storonu', 'Отведение ноги в сторону'),
  ('yagodichnyy-finisher', 'Ягодичный финишер'),
  ('core-level-up', 'CORE — LEVEL UP'),
  ('sumo-prised', 'Сумо-присед'),
  ('vypady-nazad-s-gantelyami', 'Выпады назад с гантелями'),
  ('rakushka', 'Ракушка'),
  ('otvedenie-nogi-nazad', 'Отведение ноги назад'),
  ('core-3-kruga-reverse-crunch-60-sek-russian-twist-60-sek-bicycle-60-adb041', 'Core — 3 круга: Reverse Crunch — 60 сек, Russian Twist — 60 сек, Bicycle — 60 сек, Планка — 60 сек'),
  ('tyaga-odnoy-ganteli', 'Тяга одной гантели'),
  ('tyaga-rezinki-k-poyasu', 'Тяга резинки к поясу'),
  ('face-pull', 'Face Pull'),
  ('giant-set-plechi', 'GIANT SET — ПЛЕЧИ'),
  ('bitseps-s-rezinkoy', 'Бицепс с резинкой'),
  ('tritseps-s-rezinkoy', 'Трицепс с резинкой'),
  ('core-level-1-final', 'CORE — LEVEL 1 FINAL'),
  ('hip-thrust-s-gantelyu', 'Hip Thrust с гантелью'),
  ('goblet-squat-s-pyatkami-na-nebolshom-vozvyshenii', 'Goblet Squat с пятками на небольшом возвышении'),
  ('step-up-na-ustoychivuyu-platformu', 'Step-Up на устойчивую платформу'),
  ('spanish-squat-s-rezinkoy', 'Spanish Squat с резинкой'),
  ('wall-sit', 'Wall Sit'),
  ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-mountain-147771', 'Core — 3 круга: Каждое упражнение, Reverse Crunch, Dead Bug, Mountain Climbers, Планка'),
  ('tyaga-ganteley-v-naklone', 'Тяга гантелей в наклоне'),
  ('tyaga-rezinki-sverhu-k-grudi', 'Тяга резинки сверху к груди'),
  ('superset-1', 'SUPERSET №1'),
  ('superset-2', 'SUPERSET №2'),
  ('pike-push-up', 'Pike Push-Up'),
  ('core-3-kruga-bicycle-60-sek-podem-nog-lezha-60-sek-russian-twist-60-a32754', 'Core — 3 круга: Bicycle — 60 сек, Подъём ног лёжа — 60 сек, Russian Twist — 60 сек, Планка — 60 сек'),
  ('bulgarian-split-squat', 'Bulgarian Split Squat'),
  ('single-leg-hip-thrust', 'Single-Leg Hip Thrust'),
  ('sgibanie-nog-s-polotentsem-po-polu', 'Сгибание ног с полотенцем по полу'),
  ('banded-lateral-walk', 'Banded Lateral Walk'),
  ('finisher', 'FINISHER'),
  ('core-3-kruga-reverse-crunch-60-sek-mountain-climbers-60-sek-dead-bug-9d40c9', 'Core — 3 круга: Reverse Crunch — 60 сек, Mountain Climbers — 60 сек, Dead Bug — 60 сек, Планка на локтях — 60 сек'),
  ('prisedanie-zhim-ganteley-vverh', 'Приседание + жим гантелей вверх'),
  ('rumynskaya-tyaga-tyaga-ganteley', 'Румынская тяга + тяга гантелей'),
  ('vypad-nazad-podem-kolena', 'Выпад назад + подъём колена'),
  ('renegade-row', 'Renegade Row'),
  ('mahi-gantelyu-mezhdu-nog', 'Махи гантелью между ног'),
  ('farmer-walk', 'Farmer Walk'),
  ('athletic-finisher', 'ATHLETIC FINISHER'),
  ('core-3-kruga-bicycle-60-sek-v-ups-60-sek-russian-twist-60-sek-planka-def1e3', 'Core — 3 круга: Bicycle — 60 сек, V-Ups — 60 сек, Russian Twist — 60 сек, Планка — 60 сек'),
  ('sumo-squat-s-gantelyu', 'Sumo Squat с гантелью'),
  ('b-stance-hip-thrust', 'B-Stance Hip Thrust'),
  ('reverse-lunge-knee-drive', 'Reverse Lunge + Knee Drive'),
  ('cossack-squat', 'Cossack Squat'),
  ('banded-kickback', 'Banded Kickback'),
  ('banded-abduction', 'Banded Abduction'),
  ('glute-finisher', 'GLUTE FINISHER'),
  ('core-3-kruga-reverse-crunch-60-sek-plank-knee-drive-60-sek-bicycle-60-3d2985', 'Core — 3 круга: Reverse Crunch — 60 сек, Plank Knee Drive — 60 сек, Bicycle — 60 сек, Hollow Hold — 60 сек'),
  ('tyaga-rezinki-odnoy-rukoy', 'Тяга резинки одной рукой'),
  ('tyaga-ganteley-k-poyasu-s-pauzoy', 'Тяга гантелей к поясу с паузой'),
  ('pullover-s-rezinkoy', 'Pullover с резинкой'),
  ('reverse-fly', 'Reverse Fly'),
  ('giant-set-shoulders', 'GIANT SET — SHOULDERS'),
  ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 'Отжимания с узкой постановкой рук'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('tritseps-nad-golovoy-s-odnoy-gantelyu', 'Трицепс над головой с одной гантелью'),
  ('core-3-kruga-v-ups-60-sek-russian-twist-60-sek-mountain-climbers-60-d3bd7a', 'Core — 3 круга: V-Ups — 60 сек, Russian Twist — 60 сек, Mountain Climbers — 60 сек, Планка — 60 сек'),
  ('b-stance-romanian-deadlift', 'B-Stance Romanian Deadlift'),
  ('vypad-nazad-s-peredney-nogoy-na-vozvyshenii', 'Выпад назад с передней ногой на возвышении'),
  ('single-leg-glute-bridge', 'Single-Leg Glute Bridge'),
  ('good-morning-s-rezinkoy', 'Good Morning с резинкой'),
  ('hamstring-walkout', 'Hamstring Walkout'),
  ('kickback-s-rezinkoy', 'Kickback с резинкой'),
  ('lateral-band-walk', 'Lateral Band Walk'),
  ('static-challenge', 'STATIC CHALLENGE'),
  ('core-3-kruga-dead-bug-60-sek-reverse-crunch-60-sek-hollow-hold-60-sek-8e1da1', 'Core — 3 круга: Dead Bug — 60 сек, Reverse Crunch — 60 сек, Hollow Hold — 60 сек, Планка — 60 сек'),
  ('dumbbell-thruster', 'Dumbbell Thruster'),
  ('walking-lunges', 'Walking Lunges'),
  ('push-up', 'Push-Up'),
  ('dumbbell-swing', 'Dumbbell Swing'),
  ('step-up', 'Step-Up'),
  ('core-level-2', 'CORE — LEVEL 2'),
  ('bulgarian-split-squat-s-gantelyami', 'Bulgarian Split Squat с гантелями'),
  ('cyclist-squat-s-gantelyu', 'Cyclist Squat с гантелью'),
  ('reverse-lunge', 'Reverse Lunge'),
  ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-cc81b3', 'Core — 3 круга: Каждое упражнение, Reverse Crunch, Mountain Climbers, Dead Bug, Hollow Hold'),
  ('tyaga-odnoy-ganteli-s-oporoy', 'Тяга одной гантели с опорой'),
  ('pullover-s-gantelyu', 'Pullover с гантелью'),
  ('staticheskoe-uderzhanie-ruk-v-storony', 'Статическое удержание рук в стороны'),
  ('core-3-kruga-v-ups-60-sek-bicycle-60-sek-russian-twist-60-sek-planka-da1c12', 'Core — 3 круга: V-Ups — 60 сек, Bicycle — 60 сек, Russian Twist — 60 сек, Планка — 60 сек'),
  ('romanian-deadlift-s-gantelyami', 'Romanian Deadlift с гантелями'),
  ('single-leg-romanian-deadlift', 'Single-Leg Romanian Deadlift'),
  ('elevated-glute-bridge', 'Elevated Glute Bridge'),
  ('sliding-hamstring-curl', 'Sliding Hamstring Curl'),
  ('curtsy-lunge', 'Curtsy Lunge'),
  ('hamstring-finisher', 'HAMSTRING FINISHER'),
  ('core-3-kruga-leg-raise-60-sek-dead-bug-60-sek-mountain-climbers-60-77c30a', 'Core — 3 круга: Leg Raise — 60 сек, Dead Bug — 60 сек, Mountain Climbers — 60 сек, Планка — 60 сек'),
  ('dumbbell-romanian-deadlift', 'Dumbbell Romanian Deadlift'),
  ('emom-8-minut', 'EMOM — 8 МИНУТ'),
  ('core-4-kruga-kazhdoe-uprazhnenie-v-ups-bicycle-russian-twist-hollow-d5e585', 'Core — 4 круга: Каждое упражнение, V-Ups, Bicycle, Russian Twist, Hollow Hold'),
  ('front-foot-elevated-reverse-lunge', 'Front Foot Elevated Reverse Lunge'),
  ('lateral-lunge', 'Lateral Lunge'),
  ('banded-frog-pumps', 'Banded Frog Pumps'),
  ('fire-hydrant-s-rezinkoy', 'Fire Hydrant с резинкой'),
  ('glute-burnout', 'GLUTE BURNOUT'),
  ('core-4-kruga-reverse-crunch-60-sek-mountain-climbers-60-sek-dead-bug-e7c5c7', 'Core — 4 круга: Reverse Crunch — 60 сек, Mountain Climbers — 60 сек, Dead Bug — 60 сек, Планка с касанием плеч — 60 сек'),
  ('tyaga-ganteley-s-pauzoy', 'Тяга гантелей с паузой'),
  ('tyaga-rezinki-k-poyasu-sidya', 'Тяга резинки к поясу сидя'),
  ('y-raise', 'Y-Raise'),
  ('giant-set', 'GIANT SET'),
  ('superset', 'SUPERSET'),
  ('core-4-kruga-hollow-hold-60-sek-bicycle-60-sek-leg-raise-60-sek-390eb2', 'Core — 4 круга: Hollow Hold — 60 сек, Bicycle — 60 сек, Leg Raise — 60 сек, Russian Twist — 60 сек'),
  ('staggered-glute-bridge', 'Staggered Glute Bridge'),
  ('deficit-reverse-lunge', 'Deficit Reverse Lunge'),
  ('fire-hydrant', 'Fire Hydrant'),
  ('posterior-chain-finisher', 'POSTERIOR CHAIN FINISHER'),
  ('core-4-kruga-reverse-crunch-60-sek-dead-bug-60-sek-mountain-climbers-dca09f', 'Core — 4 круга: Reverse Crunch — 60 сек, Dead Bug — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('dumbbell-clean-squat', 'Dumbbell Clean + Squat'),
  ('dumbbell-push-press', 'Dumbbell Push Press'),
  ('walking-lunge-biceps-curl', 'Walking Lunge + Biceps Curl'),
  ('boss-finisher', 'BOSS FINISHER'),
  ('core-boss', 'CORE BOSS'),
  ('progress-mesyatsa-3', 'ПРОГРЕСС МЕСЯЦА 3'),
  ('hip-thrust-s-dvumya-gantelyami', 'Hip Thrust с двумя гантелями'),
  ('front-foot-elevated-bulgarian-split-squat', 'Front Foot Elevated Bulgarian Split Squat'),
  ('goblet-squat-1-5-povtoreniya', 'Goblet Squat — 1,5 повторения'),
  ('step-up-s-gantelyami', 'Step-Up с гантелями'),
  ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-6f2d89', 'Core — 3 круга: Каждое упражнение, Reverse Crunch, Mountain Climbers, Dead Bug, Планка'),
  ('shoulders-giant-set', 'SHOULDERS GIANT SET'),
  ('arms-superset', 'ARMS SUPERSET'),
  ('statika-ruk-v-storony', 'Статика рук в стороны'),
  ('core-3-kruga-v-ups-60-sek-bicycle-60-sek-russian-twist-60-sek-hollow-83a2d3', 'Core — 3 круга: V-Ups — 60 сек, Bicycle — 60 сек, Russian Twist — 60 сек, Hollow Hold — 60 сек'),
  ('reverse-lunge-s-dlinnym-shagom', 'Reverse Lunge с длинным шагом'),
  ('hamstring-slide', 'Hamstring Slide'),
  ('core-3-kruga-leg-raise-60-sek-dead-bug-60-sek-bicycle-60-sek-planka-a35df9', 'Core — 3 круга: Leg Raise — 60 сек, Dead Bug — 60 сек, Bicycle — 60 сек, Планка — 60 сек'),
  ('emom-10-minut', 'EMOM — 10 МИНУТ'),
  ('core-3-kruga-v-ups-60-sek-mountain-climbers-60-sek-russian-twist-60-31083a', 'Core — 3 круга: V-Ups — 60 сек, Mountain Climbers — 60 сек, Russian Twist — 60 сек, Hollow Hold — 60 сек'),
  ('frog-pumps-s-rezinkoy', 'Frog Pumps с резинкой'),
  ('abduction-s-rezinkoy', 'Abduction с резинкой'),
  ('glute-shock-finisher', 'GLUTE SHOCK FINISHER'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-74e7cb', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Mountain Climbers, Bicycle, Планка с касанием плеч'),
  ('tyaga-ganteley-lezha-grudyu-na-naklonnoy-opore', 'Тяга гантелей лежа грудью на наклонной опоре'),
  ('tyaga-rezinki-sverhu-odnoy-rukoy', 'Тяга резинки сверху одной рукой'),
  ('shoulders-tri-set', 'SHOULDERS TRI-SET'),
  ('statika-v-storony', 'Статика в стороны'),
  ('core-4-kruga-hollow-hold-60-sek-leg-raise-60-sek-russian-twist-60-sek-5bd503', 'Core — 4 круга: Hollow Hold — 60 сек, Leg Raise — 60 сек, Russian Twist — 60 сек, Bicycle — 60 сек'),
  ('elevated-single-leg-glute-bridge', 'Elevated Single-Leg Glute Bridge'),
  ('posterior-burnout', 'POSTERIOR BURNOUT'),
  ('core-4-kruga-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-3ab117', 'Core — 4 круга: Dead Bug — 60 сек, Reverse Crunch — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('dumbbell-clean', 'Dumbbell Clean'),
  ('dumbbell-squat-press', 'Dumbbell Squat + Press'),
  ('walking-lunge-knee-drive', 'Walking Lunge + Knee Drive'),
  ('progress-mesyatsa-4', 'ПРОГРЕСС МЕСЯЦА 4'),
  ('level-4-completed', '🏆 LEVEL 4 COMPLETED'),
  ('dumbbell-hip-thrust', 'Dumbbell Hip Thrust'),
  ('heavy-goblet-squat', 'Heavy Goblet Squat'),
  ('glute-mechanical-drop-set', 'GLUTE MECHANICAL DROP SET'),
  ('tyaga-ganteley-grudyu-k-opore', 'Тяга гантелей грудью к опоре'),
  ('shoulders-superset', 'SHOULDERS — SUPERSET'),
  ('shoulders-second-superset', 'SHOULDERS — SECOND SUPERSET'),
  ('romanian-deadlift', 'Romanian Deadlift'),
  ('elevated-hip-thrust', 'Elevated Hip Thrust'),
  ('hamstring-rest-pause', 'HAMSTRING REST-PAUSE'),
  ('sumo-squat', 'Sumo Squat'),
  ('abduction', 'Abduction'),
  ('glute-drop-set', 'GLUTE DROP SET'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-0b49af', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Mountain Climbers, Bicycle, Планка'),
  ('arms-mechanical-drop-set', 'ARMS MECHANICAL DROP SET'),
  ('b-stance-good-morning', 'B-Stance Good Morning'),
  ('kickback', 'Kickback'),
  ('hamstring-shock', 'HAMSTRING SHOCK'),
  ('boss-amrap', 'BOSS AMRAP'),
  ('progress-mesyatsa-5', 'ПРОГРЕСС МЕСЯЦА 5'),
  ('level-5-completed', '🏆 LEVEL 5 COMPLETED'),
  ('hip-thrust-s-gantelyu-shtangoy', 'Hip Thrust с гантелью/штангой'),
  ('sumo-romanian-deadlift', 'Sumo Romanian Deadlift'),
  ('goblet-squat-s-pauzoy', 'Goblet Squat с паузой'),
  ('banded-hip-abduction', 'Banded Hip Abduction'),
  ('diagonal-kickback-s-rezinkoy', 'Diagonal Kickback с резинкой'),
  ('press', 'ПРЕСС'),
  ('tyaga-ganteli-odnoy-rukoy-s-pauzoy', 'Тяга гантели одной рукой с паузой')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('plechi-giant-set', 'ПЛЕЧИ — GIANT SET'),
  ('ruki-superset', 'РУКИ — SUPERSET'),
  ('front-foot-elevated-split-squat', 'Front Foot Elevated Split Squat'),
  ('sliding-leg-curl', 'Sliding Leg Curl'),
  ('good-morning-s-gantelyu', 'Good Morning с гантелью'),
  ('dumbbell-squat-to-press', 'Dumbbell Squat to Press'),
  ('dumbbell-row', 'Dumbbell Row'),
  ('squat-jump', 'Squat Jump'),
  ('power-finisher', 'POWER FINISHER'),
  ('cyclist-squat', 'Cyclist Squat'),
  ('arms-drop-set', 'ARMS DROP SET'),
  ('staggered-stance-good-morning', 'Staggered-Stance Good Morning'),
  ('hip-thrust-s-1-5-povtoreniyami', 'Hip Thrust с 1,5 повторениями'),
  ('diagonal-kickback', 'Diagonal Kickback'),
  ('band-abduction', 'Band Abduction'),
  ('posterior-chain-boss', 'POSTERIOR CHAIN BOSS'),
  ('power-block', 'POWER BLOCK'),
  ('boss-amrap-12', 'BOSS — AMRAP 12'),
  ('finalnyy-core-boss', 'ФИНАЛЬНЫЙ CORE BOSS'),
  ('progressiya-mesyatsa-6', 'ПРОГРЕССИЯ МЕСЯЦА 6'),
  ('level-6-completed', '🎮 LEVEL 6 COMPLETED'),
  ('hip-thrust-s-nogami-na-vozvyshennosti', 'Hip Thrust с ногами на возвышенности'),
  ('bulgarian-split-squat-s-naklonom-korpusa-vpered', 'Bulgarian Split Squat с наклоном корпуса вперед'),
  ('diagonal-banded-kickback', 'Diagonal Banded Kickback'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-a90a52', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Bicycle, Mountain Climbers, Hollow Hold'),
  ('tyaga-ganteley-v-naklone-s-pauzoy', 'Тяга гантелей в наклоне с паузой'),
  ('shoulders-contrast-set', 'SHOULDERS CONTRAST SET'),
  ('ruki', 'РУКИ'),
  ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-russian-twist-60-sek-4725db', 'Core — 4 круга: Leg Raise — 60 сек, V-Ups — 60 сек, Russian Twist — 60 сек, Планка — 60 сек'),
  ('staggered-romanian-deadlift', 'Staggered Romanian Deadlift'),
  ('core-4-kruga-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-cd6ec3', 'Core — 4 круга: Dead Bug — 60 сек, Reverse Crunch — 60 сек, Mountain Climbers — 60 сек, Планка — 60 сек'),
  ('emom-12-minut', 'EMOM — 12 МИНУТ'),
  ('core-4-kruga-v-ups-60-sek-bicycle-60-sek-mountain-climbers-60-sek-973fc1', 'Core — 4 круга: V-Ups — 60 сек, Bicycle — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('step-up-s-vysokim-podemom-kolena', 'Step-Up с высоким подъемом колена'),
  ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-375f31', 'Core — 5 кругов: Каждое упражнение, Reverse Crunch, Bicycle, Mountain Climbers, Планка'),
  ('renegade-row-s-pauzoy', 'Renegade Row с паузой'),
  ('biceps-drop-set', 'BICEPS DROP SET'),
  ('triceps', 'TRICEPS'),
  ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-hollow-hold-60-sek-632a78', 'Core — 5 кругов: Leg Raise — 60 сек, Bicycle — 60 сек, Hollow Hold — 60 сек, Mountain Climbers — 60 сек'),
  ('hip-thrust-1-5-povtoreniya', 'Hip Thrust — 1,5 повторения'),
  ('single-leg-good-morning', 'Single-Leg Good Morning'),
  ('hamstring-boss', 'HAMSTRING BOSS'),
  ('core-5-krugov-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-987b10', 'Core — 5 кругов: Dead Bug — 60 сек, Reverse Crunch — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('block-1', 'BLOCK 1'),
  ('block-2', 'BLOCK 2'),
  ('block-3', 'BLOCK 3'),
  ('amrap-15-minut', 'AMRAP — 15 МИНУТ'),
  ('final-core-boss', 'FINAL CORE BOSS'),
  ('progressiya-mesyatsa-7', 'ПРОГРЕССИЯ МЕСЯЦА 7'),
  ('level-7-completed', '🎮 LEVEL 7 COMPLETED'),
  ('kas-glute-bridge-s-vesom', 'Kas Glute Bridge с весом'),
  ('heel-elevated-bulgarian-split-squat', 'Heel-Elevated Bulgarian Split Squat'),
  ('deficit-step-back-lunge', 'Deficit Step-Back Lunge'),
  ('squat-1-5-reps', 'Squat 1,5 Reps'),
  ('banded-diagonal-kickback', 'Banded Diagonal Kickback'),
  ('glute-tension-finisher', 'GLUTE TENSION FINISHER'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-bicycle-9f1aea', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Dead Bug, Bicycle, Планка с касанием плеч'),
  ('pullover', 'Pullover'),
  ('biceps-finisher', 'BICEPS FINISHER'),
  ('core-4-kruga-v-ups-60-sek-leg-raise-60-sek-russian-twist-60-sek-c6088b', 'Core — 4 круга: V-Ups — 60 сек, Leg Raise — 60 сек, Russian Twist — 60 сек, Hollow Hold — 60 сек'),
  ('reverse-lunge-s-peredney-nogoy-na-vozvyshenii', 'Reverse Lunge с передней ногой на возвышении'),
  ('standing-kickback-s-rezinkoy', 'Standing Kickback с резинкой'),
  ('hamstring-drop-set', 'HAMSTRING DROP SET'),
  ('core-4-kruga-reverse-crunch-60-sek-bicycle-60-sek-mountain-climbers-5cf62d', 'Core — 4 круга: Reverse Crunch — 60 сек, Bicycle — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('block-4', 'BLOCK 4'),
  ('core-4-kruga-kazhdoe-uprazhnenie-v-ups-bicycle-mountain-climbers-0f2a09', 'Core — 4 круга: Каждое упражнение, V-Ups, Bicycle, Mountain Climbers, Hollow Hold'),
  ('frog-stance-hip-thrust', 'Frog-Stance Hip Thrust'),
  ('front-foot-elevated-reverse-lunge-2', 'Front-Foot Elevated Reverse Lunge'),
  ('sumo-squat-pulse', 'Sumo Squat + Pulse'),
  ('cross-back-lunge', 'Cross-Back Lunge'),
  ('glute-shock-circuit', 'GLUTE SHOCK CIRCUIT'),
  ('push-up-s-pauzoy', 'Push-Up с паузой'),
  ('tyaga-ganteli-odnoy-rukoy', 'Тяга гантели одной рукой'),
  ('core-5-krugov-leg-raise-60-sek-v-ups-60-sek-bicycle-60-sek-hollow-748496', 'Core — 5 кругов: Leg Raise — 60 сек, V-Ups — 60 сек, Bicycle — 60 сек, Hollow Hold — 60 сек'),
  ('kickstand-romanian-deadlift', 'Kickstand Romanian Deadlift'),
  ('hamstring-walkout-s-pauzoy', 'Hamstring Walkout с паузой'),
  ('boss-glute-finisher', 'BOSS GLUTE FINISHER'),
  ('progressiya-mesyatsa-8', 'ПРОГРЕССИЯ МЕСЯЦА 8'),
  ('level-8-completed', '🎮 LEVEL 8 COMPLETED'),
  ('hip-thrust-s-gantelyu-tyazhelym-vesom', 'Hip Thrust с гантелью / тяжелым весом'),
  ('glute-power-finisher', 'GLUTE POWER FINISHER'),
  ('push-up-s-nogami-na-vozvyshenii', 'Push-Up с ногами на возвышении'),
  ('one-arm-dumbbell-row', 'One-Arm Dumbbell Row'),
  ('dumbbell-floor-press', 'Dumbbell Floor Press'),
  ('dumbbell-pullover', 'Dumbbell Pullover'),
  ('shoulders-power-tri-set', 'SHOULDERS POWER TRI-SET'),
  ('biceps', 'BICEPS'),
  ('push-up-finisher', 'PUSH-UP FINISHER'),
  ('core-4-kruga-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-84890f', 'Core — 4 круга: Каждое упражнение, Dead Bug, Reverse Crunch, Bicycle, Mountain Climbers'),
  ('emom-15-minut', 'EMOM — 15 МИНУТ'),
  ('kas-bridge-s-uzkoy-postanovkoy-nog', 'Kas Bridge с узкой постановкой ног'),
  ('reverse-bulgarian-split-squat', 'Reverse Bulgarian Split Squat'),
  ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-leg-raise-bicycle-405021', 'Core — 5 кругов: Каждое упражнение, Reverse Crunch, Leg Raise, Bicycle, Планка'),
  ('archer-push-up', 'Archer Push-Up'),
  ('core-5-krugov-v-ups-60-sek-leg-raise-60-sek-mountain-climbers-60-sek-3adf2b', 'Core — 5 кругов: V-Ups — 60 сек, Leg Raise — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('feet-elevated-glute-bridge', 'Feet-Elevated Glute Bridge'),
  ('walking-lunge', 'Walking Lunge'),
  ('core-5-krugov-dead-bug-60-sek-reverse-crunch-60-sek-bicycle-60-sek-a12992', 'Core — 5 кругов: Dead Bug — 60 сек, Reverse Crunch — 60 сек, Bicycle — 60 сек, Mountain Climbers — 60 сек'),
  ('amrap-18-minut', 'AMRAP — 18 МИНУТ'),
  ('progressiya-level-9', 'ПРОГРЕССИЯ LEVEL 9'),
  ('level-9-completed', '🎮 LEVEL 9 COMPLETED'),
  ('hip-thrust-heavy-set', 'Hip Thrust — HEAVY SET'),
  ('deficit-bulgarian-split-squat', 'Deficit Bulgarian Split Squat'),
  ('sumo-dumbbell-squat', 'Sumo Dumbbell Squat'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-dead-bug-258fde', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Bicycle, Dead Bug, Hollow Hold'),
  ('push-up-s-uzkoy-postanovkoy-ruk', 'Push-Up с узкой постановкой рук'),
  ('shoulders-giant-set-2', 'SHOULDERS — GIANT SET'),
  ('biceps-triceps', 'BICEPS + TRICEPS'),
  ('arm-finisher', 'ARM FINISHER'),
  ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-mountain-climbers-60-sek-631a04', 'Core — 4 круга: Leg Raise — 60 сек, V-Ups — 60 сек, Mountain Climbers — 60 сек, Планка — 60 сек'),
  ('feet-elevated-hip-thrust', 'Feet-Elevated Hip Thrust'),
  ('diagonal-band-kickback', 'Diagonal Band Kickback'),
  ('emom-16-minut', 'EMOM — 16 МИНУТ'),
  ('kas-glute-bridge', 'Kas Glute Bridge'),
  ('wide-stance-squat', 'Wide-Stance Squat'),
  ('glute-density-boss', 'GLUTE DENSITY BOSS'),
  ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-v-ups-bicycle-planka', 'Core — 5 кругов: Каждое упражнение, Reverse Crunch, V-Ups, Bicycle, Планка'),
  ('shoulders-mechanical-drop-set', 'SHOULDERS — MECHANICAL DROP SET'),
  ('arms-cluster-set', 'ARMS CLUSTER SET'),
  ('push-up-boss', 'PUSH-UP BOSS'),
  ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-mountain-climbers-60-1196b9', 'Core — 5 кругов: Leg Raise — 60 сек, Bicycle — 60 сек, Mountain Climbers — 60 сек, Hollow Hold — 60 сек'),
  ('hip-thrust-s-uzkoy-postanovkoy-nog', 'Hip Thrust с узкой постановкой ног'),
  ('core-5-krugov-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-98e0fe', 'Core — 5 кругов: Каждое упражнение, Dead Bug, Reverse Crunch, Bicycle, Mountain Climbers'),
  ('amrap-20-minut', 'AMRAP — 20 МИНУТ'),
  ('final-glute-boss', 'FINAL GLUTE BOSS'),
  ('progressiya-level-10', 'ПРОГРЕССИЯ LEVEL 10'),
  ('level-10-completed', '🎮 LEVEL 10 COMPLETED'),
  ('heavy-hip-thrust', 'Heavy Hip Thrust'),
  ('front-foot-elevated-bulgarian-split-squat-2', 'Front-Foot Elevated Bulgarian Split Squat'),
  ('dumbbell-sumo-deadlift', 'Dumbbell Sumo Deadlift'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-bicycle-b58c19', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Dead Bug, Bicycle, Hollow Hold'),
  ('dumbbell-bench-press', 'Dumbbell Bench Press'),
  ('feet-elevated-push-up', 'Feet-Elevated Push-Up'),
  ('arm-boss', 'ARM BOSS'),
  ('core-4-kruga-reverse-crunch-60-sek-bicycle-60-sek-dead-bug-60-sek-0a932f', 'Core — 4 круга: Reverse Crunch — 60 сек, Bicycle — 60 сек, Dead Bug — 60 сек, Mountain Climbers — 60 сек'),
  ('heels-elevated-goblet-squat', 'Heels-Elevated Goblet Squat'),
  ('frog-pump-s-gantelyu', 'Frog Pump с гантелью'),
  ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-v-ups-bicycle-hollow-894227', 'Core — 5 кругов: Каждое упражнение, Reverse Crunch, V-Ups, Bicycle, Hollow Hold'),
  ('close-grip-push-up', 'Close-Grip Push-Up'),
  ('biceps-cluster-set', 'BICEPS — CLUSTER SET'),
  ('triceps-cluster-set', 'TRICEPS — CLUSTER SET'),
  ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-mountain-climbers-60-d81a41', 'Core — 5 кругов: Leg Raise — 60 сек, Bicycle — 60 сек, Mountain Climbers — 60 сек, Планка — 60 сек'),
  ('level-11-progress', '🎮 LEVEL 11 — ПРОГРЕСС'),
  ('level-11-completed', '🏆 LEVEL 11 COMPLETED'),
  ('dumbbell-sumo-squat', 'Dumbbell Sumo Squat'),
  ('final-glute-set', 'FINAL GLUTE SET'),
  ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-dead-bug-40b6d3', 'Core — 4 круга: Каждое упражнение, Reverse Crunch, Bicycle, Dead Bug, Mountain Climbers'),
  ('emom-20-minut', 'EMOM — 20 МИНУТ'),
  ('final-boss', 'FINAL BOSS'),
  ('frog-pump-s-vesom', 'Frog Pump с весом'),
  ('standing-band-abduction', 'Standing Band Abduction'),
  ('final-glute-mechanical-drop-set', 'FINAL GLUTE MECHANICAL DROP SET'),
  ('plank-dumbbell-row', 'Plank Dumbbell Row'),
  ('biceps-cluster', 'BICEPS CLUSTER'),
  ('triceps-cluster', 'TRICEPS CLUSTER'),
  ('push-up-final-test', 'PUSH-UP FINAL TEST'),
  ('frog-pump', 'Frog Pump'),
  ('posterior-chain-final-boss', 'POSTERIOR CHAIN FINAL BOSS'),
  ('final-glute-boss-2', '🏆 FINAL GLUTE BOSS'),
  ('final-core-boss-2', '🏆 FINAL CORE BOSS'),
  ('final-level-itogovyy-test', '🎮 FINAL LEVEL — ИТОГОВЫЙ ТЕСТ'),
  ('vynoslivost', 'ВЫНОСЛИВОСТЬ'),
  ('kontrol', 'КОНТРОЛЬ'),
  ('donatellox-year-1-completed', '🏆 DONATELLOX — YEAR 1 COMPLETED')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Набор массы — Женщины — Дома)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('nabor-massy-zhenshchiny-doma', 'Набор массы для женщин (дома) — годовая программа', 'Набор массы для женщин (дома) — годовая программа. Оборудование: Гантели, резинки разной жёсткости, коврик, устойчивая платформа/ступень', 'build_muscle', 'female', 'home', 'intermediate', 48, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · ЯГОДИЦЫ + КВАДРИЦЕПС', 1, 'МЕСЯЦ 1 — LEVEL 1A — АДАПТАЦИЯ (НЕДЕЛИ 1–2)', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-prised-s-gantelyu', 0, 15, null::int, 60, 4, '15 (Гантель перед грудью. Последние 5 повторений: медленное опускание.)'),
    ('yagodichnyy-most-s-gantelyu', 10, 20, null::int, 60, 4, '20 (В верхней точке: 2 секунды сжатия ягодиц.)'),
    ('bolgarskie-vypady', 20, 12, null::int, 60, 3, '12 на каждую ногу (Корпус слегка наклонён вперёд. Толкаемся пяткой.)'),
    ('rumynskaya-tyaga-s-gantelyami', 30, 15, null::int, 60, 3, '15 (Опускание: 3 секунды. Не округлять поясницу.)'),
    ('otvedenie-nogi-nazad-s-rezinkoy', 40, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('otvedenie-nogi-v-storonu-s-rezinkoy', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('wall-sit-statika-u-steny', 60, null::int, 30, 60, 3, '30 секунд (Колени примерно под углом 90°.)'),
    ('core-2-kruga-krug-dead-bug-60-sek-skruchivaniya-60-sek-podem-sognutyh-100046', 70, 4, null::int, 60, 1, '4 упражнения × 60 секунд, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · ЯГОДИЦЫ + ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА', 2, 'МЕСЯЦ 1 — LEVEL 1A — АДАПТАЦИЯ (НЕДЕЛИ 1–2)', 1, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-prised-s-gantelyu', 0, 15, null::int, 60, 4, '15 (Широкая постановка ног.)'),
    ('sumo-prised-statika', 10, 3, null::int, 60, 1, '3 подхода 15 повторений ↓ 30 секунд удержание в нижней точке'),
    ('vypady-nazad', 20, 15, null::int, 60, 3, '15 на каждую ногу'),
    ('odnonogaya-rumynskaya-tyaga', 30, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('yagodichnyy-most-s-rezinkoy', 40, 20, null::int, 60, 4, '20 (Последние 5: короткие пульсирующие движения.)'),
    ('frog-pumps', 50, 25, null::int, 60, 3, '25'),
    ('rakushka-s-rezinkoy', 60, 20, null::int, 60, 3, '20 на каждую сторону'),
    ('core-2-kruga-mountain-climbers-reverse-crunch-russian-twist-planka-na-e5befb', 70, 4, null::int, 60, 1, '4 упражнения × 60 секунд, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · СПИНА + ПЛЕЧИ + РУКИ', 3, 'МЕСЯЦ 1 — LEVEL 1A — АДАПТАЦИЯ (НЕДЕЛИ 1–2)', 1, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-dvuh-ganteley-v-naklone', 0, 15, null::int, 60, 4, '15 (Контролируем движение.)'),
    ('tyaga-odnoy-ganteli-k-poyasu', 10, 15, null::int, 60, 3, '15 на каждую руку'),
    ('tyaga-rezinki-k-zhivotu', 20, 20, null::int, 60, 3, '20'),
    ('face-pull-s-rezinkoy', 30, 20, null::int, 60, 3, '20 (Акцент на заднюю дельту.)'),
    ('plechevoy-superset', 40, 15, null::int, 60, 3, '15 (Махи гантелями в стороны ↓ сразу Подъём гантелей перед собой 3 × 12 Отдых после двух…)'),
    ('otzhimaniya', 50, null::int, null::int, 60, 3, 'максимум качественных повторений (Можно выполнять с колен. Главное — контролировать движение.)'),
    ('razgibanie-ruk-s-rezinkoy-na-tritseps', 60, 15, null::int, 60, 3, '15'),
    ('sgibanie-ruk-s-rezinkoy-na-bitseps', 70, 15, null::int, 60, 3, '15'),
    ('core-2-kruga-velosiped-dead-bug-podem-nog-lezha-planka', 80, 4, null::int, 60, 1, '4 упражнения × 60 секунд, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'МЕСЯЦ 1 — LEVEL 1B — ПЕРВЫЙ СКАЧОК (НЕДЕЛЯ 3)', 2, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat', 0, 12, null::int, 60, 4, '12 (Вес: +5–10% относительно недель 1–2, если техника позволяет.)'),
    ('yagodichnyy-most-s-vesom', 10, 15, null::int, 60, 4, '15 (Последнее повторение каждого подхода: удержание 3 секунды сверху.)'),
    ('bolgarskie-vypady', 20, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('rumynskaya-tyaga', 30, 12, null::int, 60, 4, '12 (Медленное опускание: 3 секунды.)'),
    ('otvedenie-nogi-nazad-s-rezinkoy', 40, 25, null::int, 60, 3, '25'),
    ('otvedenie-nogi-v-storonu', 50, 25, null::int, 60, 3, '25'),
    ('yagodichnyy-finisher', 60, 3, null::int, 60, 1, '3 круга: 20 Frog Pumps 20 пульсаций в ягодичном мосте 20 секунд статики сверху Отдых: 45…'),
    ('core-level-up', 70, null::int, null::int, 60, 1, 'Теперь: 3 круга Каждое упражнение: 60 секунд Dead Bug Reverse Crunch Mountain Climbers…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · GLUTE + HAMSTRING', 2, 'МЕСЯЦ 1 — LEVEL 1B — ПЕРВЫЙ СКАЧОК (НЕДЕЛЯ 3)', 2, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-prised', 0, 12, null::int, 60, 4, '12'),
    ('sumo-prised-statika', 10, 3, null::int, 60, 1, '3 подхода 12 повторений 40 секунд удержания'),
    ('vypady-nazad-s-gantelyami', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('odnonogaya-rumynskaya-tyaga', 30, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('yagodichnyy-most-s-rezinkoy', 40, 20, null::int, 60, 4, '20 (Последний подход: 20 повторений + 20 пульсаций.)'),
    ('frog-pumps', 50, 30, null::int, 60, 3, '30'),
    ('rakushka', 60, 25, null::int, 60, 3, '25 на каждую сторону'),
    ('otvedenie-nogi-nazad', 70, 25, null::int, 60, 3, '25'),
    ('core-3-kruga-reverse-crunch-60-sek-russian-twist-60-sek-bicycle-60-adb041', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · BACK + SHOULDERS + ARMS', 3, 'МЕСЯЦ 1 — LEVEL 1B — ПЕРВЫЙ СКАЧОК (НЕДЕЛЯ 3)', 2, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-dvuh-ganteley-v-naklone', 0, 12, null::int, 60, 4, '12'),
    ('tyaga-odnoy-ganteli', 10, 12, null::int, 60, 4, '12 на каждую руку'),
    ('tyaga-rezinki-k-poyasu', 20, 15, null::int, 60, 4, '15'),
    ('face-pull', 30, 20, null::int, 60, 3, '20 (Последние 5: медленно.)'),
    ('giant-set-plechi', 40, null::int, null::int, 60, 1, 'Выполнить подряд: Махи в стороны 12 ↓ Подъём перед собой 12 ↓ Задняя дельта в наклоне 15…'),
    ('otzhimaniya', 50, null::int, null::int, 60, 4, 'максимум'),
    ('bitseps-s-rezinkoy', 60, 15, null::int, 60, 3, '15'),
    ('tritseps-s-rezinkoy', 70, 15, null::int, 60, 3, '15'),
    ('core-level-1-final', 80, 3, null::int, 60, 1, '3 круга Каждое упражнение: 60 секунд Круг: Mountain Climbers Подъём ног Russian Twist…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE + QUAD', 1, 'МЕСЯЦ 2 — LEVEL 2A — BUILD (НЕДЕЛИ 5–6)', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-s-gantelyu', 0, 12, null::int, 60, 4, '12 (В верхней точке: 2 секунды удержания.)'),
    ('goblet-squat-s-pyatkami-na-nebolshom-vozvyshenii', 10, 12, null::int, 60, 4, '12 (Последний подход: +5 коротких пульсаций.)'),
    ('step-up-na-ustoychivuyu-platformu', 20, 12, null::int, 60, 3, '12 на каждую ногу (Толчок выполняется преимущественно рабочей ногой.)'),
    ('vypady-nazad-s-gantelyami', 30, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('otvedenie-nogi-v-storonu-s-rezinkoy', 40, 20, null::int, 60, 4, '20'),
    ('spanish-squat-s-rezinkoy', 50, 15, null::int, 60, 3, '15'),
    ('wall-sit', 60, null::int, 45, 60, 3, '45 секунд'),
    ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-mountain-147771', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK + SHOULDERS + ARMS', 2, 'МЕСЯЦ 2 — LEVEL 2A — BUILD (НЕДЕЛИ 5–6)', 3, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-v-naklone', 0, 12, null::int, 60, 4, '12'),
    ('tyaga-odnoy-ganteli-k-poyasu', 10, 12, null::int, 60, 3, '12 на каждую руку'),
    ('tyaga-rezinki-sverhu-k-grudi', 20, 15, null::int, 60, 4, '15 (Имитируем вертикальную тягу.)'),
    ('face-pull', 30, 20, null::int, 60, 3, '20'),
    ('superset-1', 40, null::int, null::int, 60, 1, 'Махи гантелями в стороны 15 Задняя дельта в наклоне 15 4 круга Отдых: 60 секунд.'),
    ('superset-2', 50, null::int, null::int, 60, 1, 'Сгибание рук с гантелями 12 Разгибание рук с резинкой 15 3 круга'),
    ('pike-push-up', 60, 8, null::int, 60, 3, '8–12 (Это первый элемент калистеники. Если тяжело: делать с более высокой опорой.)'),
    ('core-3-kruga-bicycle-60-sek-podem-nog-lezha-60-sek-russian-twist-60-a32754', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE + HAMSTRING', 3, 'МЕСЯЦ 2 — LEVEL 2A — BUILD (НЕДЕЛИ 5–6)', 3, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rumynskaya-tyaga-s-gantelyami', 0, 12, null::int, 60, 4, '12 (Опускание: 3 секунды.)'),
    ('bulgarian-split-squat', 10, 10, null::int, 60, 4, '10 на каждую ногу (Вес умеренно тяжелый.)'),
    ('single-leg-hip-thrust', 20, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('sgibanie-nog-s-polotentsem-po-polu', 30, 12, null::int, 60, 3, '12–15 (Если поверхность позволяет безопасно скользить. Альтернатива: сгибание ног с резинкой.)'),
    ('frog-pumps', 40, 25, null::int, 60, 4, '25'),
    ('otvedenie-nogi-nazad-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('banded-lateral-walk', 60, 20, null::int, 60, 3, '20 шагов'),
    ('finisher', 70, 3, null::int, 60, 1, '3 круга: 20 Frog Pumps 15 отведений назад каждой ногой 20 секунд ягодичный мост Отдых: 45…'),
    ('core-3-kruga-reverse-crunch-60-sek-mountain-climbers-60-sek-dead-bug-9d40c9', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY ATHLETIC', 4, 'МЕСЯЦ 2 — LEVEL 2A — BUILD (НЕДЕЛИ 5–6)', 3, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('prisedanie-zhim-ganteley-vverh', 0, 12, null::int, 60, 4, '12'),
    ('rumynskaya-tyaga-tyaga-ganteley', 10, 12, null::int, 60, 3, '12'),
    ('vypad-nazad-podem-kolena', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('otzhimaniya', 30, null::int, null::int, 60, 3, 'максимум качественных повторений (Можно с колен.)'),
    ('renegade-row', 40, 8, null::int, 60, 3, '8 на каждую руку (Если тяжело: выполнять с колен.)'),
    ('mahi-gantelyu-mezhdu-nog', 50, 15, null::int, 60, 3, '15'),
    ('farmer-walk', 60, null::int, 40, 60, 4, '40 секунд (Тяжелые гантели. Корпус максимально стабильный.)'),
    ('athletic-finisher', 70, 4, null::int, 60, 1, '4 круга 20 секунд: Step-Up быстро 20 секунд: Mountain Climbers 20 секунд: отдых После…'),
    ('core-3-kruga-bicycle-60-sek-v-ups-60-sek-russian-twist-60-sek-planka-def1e3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHAPE', 1, 'МЕСЯЦ 2 — LEVEL 2B — NEW STIMULUS (НЕДЕЛИ 7–8)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-squat-s-gantelyu', 0, 10, null::int, 60, 4, '10 (Вес: +5–10% относительно недель 5–6, если техника позволяет.)'),
    ('b-stance-hip-thrust', 10, 12, null::int, 60, 4, '12 на каждую сторону (Одна нога выполняет основную работу.)'),
    ('reverse-lunge-knee-drive', 20, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('cossack-squat', 30, 10, null::int, 60, 3, '10 на каждую сторону (Новый стимул для ног и ягодиц.)'),
    ('banded-kickback', 40, 20, null::int, 60, 4, '20'),
    ('banded-abduction', 50, 25, null::int, 60, 4, '25'),
    ('frog-pumps', 60, 40, null::int, 60, 2, '40'),
    ('glute-finisher', 70, 3, null::int, 60, 1, '3 круга 30 секунд: ягодичный мост 20 пульсаций 20 секунд статика сверху Отдых: 45 секунд.'),
    ('core-3-kruga-reverse-crunch-60-sek-plank-knee-drive-60-sek-bicycle-60-3d2985', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK + SHOULDERS', 2, 'МЕСЯЦ 2 — LEVEL 2B — NEW STIMULUS (НЕДЕЛИ 7–8)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-rezinki-odnoy-rukoy', 0, 15, null::int, 60, 4, '15 на каждую руку'),
    ('tyaga-ganteley-k-poyasu-s-pauzoy', 10, 10, null::int, 60, 4, '10 (Пауза: 2 секунды в верхней точке.)'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 3, '15'),
    ('reverse-fly', 30, 15, null::int, 60, 4, '15'),
    ('giant-set-shoulders', 40, null::int, null::int, 60, 1, 'Махи в стороны 12 Arnold Press 10 Задняя дельта 15 Статика рук в стороны 20 секунд 4…'),
    ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 50, 8, null::int, 60, 3, '8–15'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 60, 3, '12'),
    ('tritseps-nad-golovoy-s-odnoy-gantelyu', 70, 12, null::int, 60, 3, '12'),
    ('core-3-kruga-v-ups-60-sek-russian-twist-60-sek-mountain-climbers-60-d3bd7a', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN', 3, 'МЕСЯЦ 2 — LEVEL 2B — NEW STIMULUS (НЕДЕЛИ 7–8)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('vypad-nazad-s-peredney-nogoy-na-vozvyshenii', 10, 10, null::int, 60, 4, '10'),
    ('single-leg-glute-bridge', 20, 15, null::int, 60, 4, '15'),
    ('good-morning-s-rezinkoy', 30, 15, null::int, 60, 3, '15'),
    ('hamstring-walkout', 40, 10, null::int, 60, 3, '10 (Медленно.)'),
    ('kickback-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('lateral-band-walk', 60, 25, null::int, 60, 3, '25 шагов'),
    ('static-challenge', 70, null::int, null::int, 60, 1, 'Ягодичный мост: 45 секунд статика 20 пульсаций 30 секунд статика 2 раунда'),
    ('core-3-kruga-dead-bug-60-sek-reverse-crunch-60-sek-hollow-hold-60-sek-8e1da1', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — ATHLETE LEVEL', 4, 'МЕСЯЦ 2 — LEVEL 2B — NEW STIMULUS (НЕДЕЛИ 7–8)', 4, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-thruster', 0, 10, null::int, 60, 4, '10 (Приседание + жим гантелей.)'),
    ('renegade-row', 10, 8, null::int, 60, 4, '8 на каждую руку'),
    ('walking-lunges', 20, 20, null::int, 60, 3, '20 шагов'),
    ('push-up', 30, null::int, null::int, 60, 3, 'максимум'),
    ('dumbbell-swing', 40, 15, null::int, 60, 4, '15'),
    ('step-up', 50, 15, null::int, 60, 3, '15 на каждую ногу'),
    ('farmer-walk', 60, null::int, 45, 60, 4, '45 секунд'),
    ('athletic-finisher', 70, null::int, null::int, 60, 1, 'AMRAP — 8 минут Сделать как можно больше качественных кругов: 8 приседаний 8 отжиманий 10…'),
    ('core-level-2', 80, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Mountain Climbers Russian Twist Hollow Hold…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE + QUAD POWER', 1, 'МЕСЯЦ 3 — LEVEL 3A — SHAPE (НЕДЕЛИ 9–10)', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('bulgarian-split-squat-s-gantelyami', 0, 10, null::int, 60, 4, '10 на каждую ногу (Последние 2 повторения должны быть тяжелыми.)'),
    ('hip-thrust-s-gantelyu', 10, 10, null::int, 60, 4, '10 (Темп: 2 секунды вверх → 2 секунды удержание → медленно вниз.)'),
    ('cyclist-squat-s-gantelyu', 20, 15, null::int, 60, 3, '15 (Пятки слегка приподняты. Последний подход: +10 пульсаций.)'),
    ('reverse-lunge', 30, 12, null::int, 60, 3, '12 на каждую ногу (Последние 5 повторений каждого подхода — медленно.)'),
    ('banded-abduction', 40, 25, null::int, 60, 4, '25 (Последние 10 повторений: короткие пульсации.)'),
    ('step-up', 50, 12, null::int, 60, 3, '12 на каждую ногу (Использовать устойчивую платформу.)'),
    ('wall-sit', 60, null::int, 60, 60, 3, '60 секунд'),
    ('glute-finisher', 70, 3, null::int, 60, 1, '3 круга 30 секунд: Glute Bridge 20 секунд: пульсации 20 секунд: статическое удержание…'),
    ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-cc81b3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · BACK + SHOULDERS + ARMS', 2, 'МЕСЯЦ 3 — LEVEL 3A — SHAPE (НЕДЕЛИ 9–10)', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-dvuh-ganteley-v-naklone', 0, 10, null::int, 60, 4, '10 (Медленное опускание: 3 секунды.)'),
    ('tyaga-odnoy-ganteli-s-oporoy', 10, 10, null::int, 60, 4, '10 на каждую руку (В верхней точке: 2 секунды удержание.)'),
    ('pullover-s-gantelyu', 20, 12, null::int, 60, 3, '12'),
    ('reverse-fly', 30, 15, null::int, 60, 3, '15'),
    ('superset-1', 40, null::int, null::int, 60, 1, 'Arnold Press 12 Махи гантелями в стороны 15 4 круга Отдых: 60 секунд.'),
    ('superset-2', 50, null::int, null::int, 60, 1, 'Молотковые сгибания 12 Трицепс с резинкой вниз 15 3 круга'),
    ('pike-push-up', 60, 8, null::int, 60, 4, '8–12 (Если тяжело — руки на возвышенности.)'),
    ('staticheskoe-uderzhanie-ruk-v-storony', 70, null::int, 30, 60, 3, '30 секунд'),
    ('core-3-kruga-v-ups-60-sek-bicycle-60-sek-russian-twist-60-sek-planka-da1c12', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE + HAMSTRING', 3, 'МЕСЯЦ 3 — LEVEL 3A — SHAPE (НЕДЕЛИ 9–10)', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift-s-gantelyami', 0, 10, null::int, 60, 4, '10 (Темп: 3 секунды вниз.)'),
    ('single-leg-romanian-deadlift', 10, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('elevated-glute-bridge', 20, 12, null::int, 60, 4, '12 (Стопы на устойчивой опоре.)'),
    ('sliding-hamstring-curl', 30, 10, null::int, 60, 4, '10–12 (Если нет возможности использовать полотенце: сгибание ног с резинкой.)'),
    ('curtsy-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('banded-kickback', 50, 25, null::int, 60, 3, '25'),
    ('banded-abduction', 60, 30, null::int, 60, 3, '30'),
    ('hamstring-finisher', 70, 3, null::int, 60, 1, '3 круга 15 сгибаний ног 20 ягодичных мостов 20 пульсаций 20 секунд статика Отдых: 45…'),
    ('core-3-kruga-leg-raise-60-sek-dead-bug-60-sek-mountain-climbers-60-77c30a', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY POWER', 4, 'МЕСЯЦ 3 — LEVEL 3A — SHAPE (НЕДЕЛИ 9–10)', 5, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-thruster', 0, 10, null::int, 60, 4, '10'),
    ('dumbbell-romanian-deadlift', 10, 12, null::int, 60, 3, '12'),
    ('walking-lunges', 20, 20, null::int, 60, 3, '20 шагов'),
    ('push-up', 30, null::int, null::int, 60, 4, 'максимум качественных повторений'),
    ('renegade-row', 40, 8, null::int, 60, 3, '8 на каждую руку'),
    ('dumbbell-swing', 50, 15, null::int, 60, 4, '15'),
    ('farmer-walk', 60, null::int, 45, 60, 4, '45 секунд'),
    ('emom-8-minut', 70, null::int, null::int, 60, 1, 'Каждую минуту начать новый мини-раунд.'),
    ('core-4-kruga-kazhdoe-uprazhnenie-v-ups-bicycle-russian-twist-hollow-d5e585', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'МЕСЯЦ 3 — LEVEL 3B — POWER & CONTROL (НЕДЕЛИ 11–12)', 6, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-squat-s-gantelyu', 0, 12, null::int, 60, 4, '12 (Последние 5 повторений: медленно.)'),
    ('single-leg-hip-thrust', 10, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('front-foot-elevated-reverse-lunge', 20, 10, null::int, 60, 3, '10 на каждую ногу (Передняя нога на небольшой устойчивой опоре.)'),
    ('lateral-lunge', 30, 12, null::int, 60, 3, '12 на каждую сторону'),
    ('banded-frog-pumps', 40, 30, null::int, 60, 4, '30'),
    ('fire-hydrant-s-rezinkoy', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('banded-kickback', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-burnout', 70, 2, null::int, 60, 1, '2 круга 40 Frog Pumps 30 Abductions 20 Kickbacks каждой ногой 30 секунд Glute Bridge Hold…'),
    ('core-4-kruga-reverse-crunch-60-sek-mountain-climbers-60-sek-dead-bug-e7c5c7', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — CONTROL', 2, 'МЕСЯЦ 3 — LEVEL 3B — POWER & CONTROL (НЕДЕЛИ 11–12)', 6, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-s-pauzoy', 0, 12, null::int, 60, 4, '12 (Пауза: 2 секунды.)'),
    ('tyaga-rezinki-k-poyasu-sidya', 10, 15, null::int, 60, 4, '15'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 3, '15'),
    ('y-raise', 30, 15, null::int, 60, 3, '15'),
    ('giant-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Махи в стороны 15 Reverse Fly 15 Статика в положении «руки в стороны» 20…'),
    ('superset', 50, null::int, null::int, 60, 1, 'Сгибание рук с резинкой 15 Трицепс над головой с резинкой 15 4 круга'),
    ('pike-push-up', 60, null::int, null::int, 60, 3, 'максимум качественных повторений'),
    ('core-4-kruga-hollow-hold-60-sek-bicycle-60-sek-leg-raise-60-sek-390eb2', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE + POSTERIOR POWER', 3, 'МЕСЯЦ 3 — LEVEL 3B — POWER & CONTROL (НЕДЕЛИ 11–12)', 6, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 12, null::int, 60, 4, '12 на каждую сторону'),
    ('staggered-glute-bridge', 10, 15, null::int, 60, 4, '15 на каждую сторону'),
    ('deficit-reverse-lunge', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('good-morning-s-rezinkoy', 30, 15, null::int, 60, 4, '15'),
    ('hamstring-walkout', 40, 12, null::int, 60, 3, '12'),
    ('fire-hydrant', 50, 25, null::int, 60, 3, '25'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('posterior-chain-finisher', 70, 3, null::int, 60, 1, '3 круга 15 Good Morning 15 Hamstring Walkout 20 Glute Bridge 30 секунд статика Отдых: 45…'),
    ('core-4-kruga-reverse-crunch-60-sek-dead-bug-60-sek-mountain-climbers-dca09f', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — BOSS LEVEL', 4, 'МЕСЯЦ 3 — LEVEL 3B — POWER & CONTROL (НЕДЕЛИ 11–12)', 6, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-clean-squat', 0, 8, null::int, 60, 4, '8 (Движение выполнять технически чисто.)'),
    ('dumbbell-push-press', 10, 10, null::int, 60, 4, '10'),
    ('walking-lunge-biceps-curl', 20, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('renegade-row', 30, 8, null::int, 60, 4, '8 на каждую руку'),
    ('dumbbell-swing', 40, 20, null::int, 60, 4, '20'),
    ('push-up', 50, null::int, null::int, 60, 3, 'максимум'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('boss-finisher', 70, null::int, null::int, 60, 1, 'AMRAP — 10 минут Сделать максимальное количество качественных кругов: 10 Goblet Squats 8…'),
    ('core-boss', 80, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых…'),
    ('progress-mesyatsa-3', 90, null::int, null::int, 60, 1, 'В конце месяца пользователь фиксирует: Hip Thrust Месяц 1: ____ кг Месяц 2: ____ кг Месяц…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE + QUAD', 1, 'МЕСЯЦ 4 — LEVEL 4A — GLUTE BUILD (НЕДЕЛИ 13–14)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-s-dvumya-gantelyami', 0, 10, null::int, 60, 4, '10 (Последнее повторение каждого подхода: 2 секунды удержание сверху.)'),
    ('front-foot-elevated-bulgarian-split-squat', 10, 10, null::int, 60, 4, '10 на каждую ногу (Передняя нога на небольшой устойчивой опоре. Последние 3 повторения: медленное опускание.)'),
    ('goblet-squat-1-5-povtoreniya', 20, 10, null::int, 60, 3, '10 (Полный присед → подняться наполовину → снова вниз → полностью вверх. Это одно повторение.)'),
    ('step-up-s-gantelyami', 30, 12, null::int, 60, 3, '12 на каждую ногу (Последние 3 повторения: медленно.)'),
    ('banded-abduction', 40, 25, null::int, 60, 4, '25 (Последние 10: пульсации.)'),
    ('banded-kickback', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('wall-sit', 60, null::int, 60, 60, 3, '60 секунд'),
    ('glute-finisher', 70, 3, null::int, 60, 1, '3 круга 20 ягодичных мостов 20 Frog Pumps 20 Abductions 20 секунд статика сверху Отдых:…'),
    ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-6f2d89', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — SHAPE', 2, 'МЕСЯЦ 4 — LEVEL 4A — GLUTE BUILD (НЕДЕЛИ 13–14)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-v-naklone', 0, 10, null::int, 60, 4, '10'),
    ('tyaga-odnoy-ganteli-k-poyasu', 10, 12, null::int, 60, 3, '12 на каждую руку (Пауза: 2 секунды сверху.)'),
    ('pullover-s-gantelyu', 20, 15, null::int, 60, 3, '15'),
    ('reverse-fly', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-giant-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Махи в стороны 15 Передние махи 12 Задняя дельта 15 4 круга Отдых: 60…'),
    ('arms-superset', 50, null::int, null::int, 60, 1, 'Бицепс с гантелями 12 Трицепс с резинкой 15 4 круга'),
    ('pike-push-up', 60, 8, null::int, 60, 3, '8–12'),
    ('statika-ruk-v-storony', 70, null::int, 40, 60, 2, '40 секунд'),
    ('core-3-kruga-v-ups-60-sek-bicycle-60-sek-russian-twist-60-sek-hollow-83a2d3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE + HAMSTRING', 3, 'МЕСЯЦ 4 — LEVEL 4A — GLUTE BUILD (НЕДЕЛИ 13–14)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift-s-gantelyami', 0, 10, null::int, 60, 4, '10 (Темп: 3 секунды вниз.)'),
    ('single-leg-hip-thrust', 10, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('reverse-lunge-s-dlinnym-shagom', 20, 12, null::int, 60, 3, '12 на каждую ногу (Акцент: ягодицы.)'),
    ('hamstring-slide', 30, 10, null::int, 60, 4, '10–12'),
    ('good-morning-s-rezinkoy', 40, 15, null::int, 60, 3, '15'),
    ('fire-hydrant', 50, 25, null::int, 60, 3, '25 на каждую ногу'),
    ('lateral-band-walk', 60, 25, null::int, 60, 3, '25 шагов'),
    ('hamstring-finisher', 70, 3, null::int, 60, 1, '3 круга 15 Hamstring Slides 20 Glute Bridge 20 Frog Pumps 30 секунд удержание сверху…'),
    ('core-3-kruga-leg-raise-60-sek-dead-bug-60-sek-bicycle-60-sek-planka-a35df9', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER', 4, 'МЕСЯЦ 4 — LEVEL 4A — GLUTE BUILD (НЕДЕЛИ 13–14)', 7, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-thruster', 0, 10, null::int, 60, 4, '10'),
    ('dumbbell-romanian-deadlift', 10, 12, null::int, 60, 3, '12'),
    ('walking-lunges', 20, 20, null::int, 60, 3, '20 шагов'),
    ('push-up', 30, null::int, null::int, 60, 4, 'максимум качественных повторений'),
    ('renegade-row', 40, 10, null::int, 60, 3, '10 на каждую руку'),
    ('dumbbell-swing', 50, 15, null::int, 60, 4, '15'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('emom-10-minut', 70, null::int, null::int, 60, 1, 'Чередуем: Нечетная минута 10 Goblet Squats Четная минута 8 Push-Ups + 10 Mountain…'),
    ('core-3-kruga-v-ups-60-sek-mountain-climbers-60-sek-russian-twist-60-31083a', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 4 — LEVEL 4B — GLUTE SHOCK (НЕДЕЛИ 15–16)', 8, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-squat-s-gantelyu', 0, 12, null::int, 60, 4, '12 (Последний подход: +15 пульсаций.)'),
    ('b-stance-hip-thrust', 10, 12, null::int, 60, 4, '12 на каждую сторону'),
    ('deficit-reverse-lunge', 20, 10, null::int, 60, 3, '10 на каждую ногу (Задняя нога уходит назад с небольшой возвышенности под передней ногой.)'),
    ('cossack-squat', 30, 10, null::int, 60, 3, '10 на каждую сторону'),
    ('frog-pumps-s-rezinkoy', 40, 30, null::int, 60, 4, '30'),
    ('fire-hydrant-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('abduction-s-rezinkoy', 60, 30, null::int, 60, 3, '30'),
    ('glute-shock-finisher', 70, 3, null::int, 60, 1, '3 круга 30 секунд: Frog Pumps 20 секунд: Glute Bridge Hold 20 пульсаций 20 отведений ног…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-74e7cb', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — NEW ANGLES', 2, 'МЕСЯЦ 4 — LEVEL 4B — GLUTE SHOCK (НЕДЕЛИ 15–16)', 8, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-lezha-grudyu-na-naklonnoy-opore', 0, 12, null::int, 60, 4, '12 (Это уменьшает помощь поясницы.)'),
    ('tyaga-rezinki-sverhu-odnoy-rukoy', 10, 15, null::int, 60, 3, '15 на каждую руку'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 3, '15'),
    ('y-raise', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-tri-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Махи в стороны 15 Reverse Fly 15 4 круга Отдых: 60 секунд.'),
    ('arms-superset', 50, null::int, null::int, 60, 1, 'Молотковые сгибания 12 Разгибание гантели над головой 12 4 круга'),
    ('otzhimaniya-s-uzkoy-postanovkoy-ruk', 60, null::int, null::int, 60, 3, 'максимум'),
    ('statika-v-storony', 70, null::int, 30, 60, 3, '30 секунд'),
    ('core-4-kruga-hollow-hold-60-sek-leg-raise-60-sek-russian-twist-60-sek-5bd503', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN SHOCK', 3, 'МЕСЯЦ 4 — LEVEL 4B — GLUTE SHOCK (НЕДЕЛИ 15–16)', 8, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('single-leg-romanian-deadlift', 10, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('elevated-single-leg-glute-bridge', 20, 15, null::int, 60, 4, '15'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('curtsy-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('kickback-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('posterior-burnout', 70, 3, null::int, 60, 1, '3 круга 15 Hamstring Walkout 20 Glute Bridge 20 Kickbacks 30 секунд статика Отдых: 45…'),
    ('core-4-kruga-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-3ab117', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — BOSS LEVEL', 4, 'МЕСЯЦ 4 — LEVEL 4B — GLUTE SHOCK (НЕДЕЛИ 15–16)', 8, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-clean', 0, 8, null::int, 60, 4, '8'),
    ('dumbbell-squat-press', 10, 10, null::int, 60, 4, '10'),
    ('walking-lunge-knee-drive', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('renegade-row', 30, 8, null::int, 60, 4, '8 на каждую руку'),
    ('dumbbell-swing', 40, 20, null::int, 60, 4, '20'),
    ('push-up', 50, null::int, null::int, 60, 3, 'максимум'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('boss-finisher', 70, null::int, null::int, 60, 1, 'AMRAP — 12 минут Максимальное количество качественных кругов: 10 Sumo Squats 8 Push-Ups…'),
    ('core-boss', 80, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progress-mesyatsa-4', 90, null::int, null::int, 60, 1, 'Пользователь фиксирует результат: Hip Thrust Месяц 1: ____ кг Месяц 2: ____ кг Месяц 3:…'),
    ('level-4-completed', 100, null::int, null::int, 60, 1, 'После 16-й недели пользователь должен получить ощущение перехода на новый уровень: 3…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE STRENGTH', 1, 'МЕСЯЦ 5 — LEVEL 5A — STRENGTH HYPERTROPHY (НЕДЕЛИ 17–18)', 9, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-hip-thrust', 0, 8, null::int, 60, 5, '8–10 (Последний подход: rest-pause После выполнения подхода: 20 секунд отдыха → дополнительные…)'),
    ('heavy-goblet-squat', 10, 10, null::int, 60, 4, '10 (Последний подход: +10 пульсаций внизу.)'),
    ('bulgarian-split-squat', 20, 8, null::int, 60, 4, '8–10 на каждую ногу (Вес: тяжелый, но техника полностью контролируется.)'),
    ('step-up-s-gantelyami', 30, 10, null::int, 60, 3, '10 на каждую ногу (В верхней точке: 1 секунда удержания.)'),
    ('banded-abduction', 40, 20, null::int, 60, 4, '20 (Последний подход: 20 обычных 20 пульсаций.)'),
    ('banded-kickback', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-mechanical-drop-set', 60, 2, null::int, 60, 1, '2 раунда 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 секунд статика Отдых: 90…'),
    ('core-3-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-6f2d89', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY STRENGTH', 2, 'МЕСЯЦ 5 — LEVEL 5A — STRENGTH HYPERTROPHY (НЕДЕЛИ 17–18)', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-grudyu-k-opore', 0, 10, null::int, 60, 4, '10'),
    ('tyaga-odnoy-ganteli', 10, 10, null::int, 60, 4, '10 на каждую руку (Последние 2 повторения: медленно.)'),
    ('pullover-s-gantelyu', 20, 12, null::int, 60, 3, '12'),
    ('reverse-fly', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-superset', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Махи гантелями в стороны 15 4 круга'),
    ('shoulders-second-superset', 50, null::int, null::int, 60, 1, 'Передние махи 12 Задняя дельта в наклоне 15 3 круга'),
    ('arms-superset', 60, null::int, null::int, 60, 1, 'Молотковые сгибания 12 Трицепс с гантелью над головой 12 3 круга'),
    ('pike-push-up', 70, 8, null::int, 60, 3, '8–12'),
    ('core-3-kruga-v-ups-60-sek-bicycle-60-sek-russian-twist-60-sek-hollow-83a2d3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING + GLUTE STRENGTH', 3, 'МЕСЯЦ 5 — LEVEL 5A — STRENGTH HYPERTROPHY (НЕДЕЛИ 17–18)', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift', 0, 8, null::int, 60, 4, '8–10 (Темп: 3 секунды вниз.)'),
    ('b-stance-romanian-deadlift', 10, 10, null::int, 60, 3, '10 на каждую сторону'),
    ('elevated-hip-thrust', 20, 10, null::int, 60, 4, '10 (Пауза сверху: 2 секунды.)'),
    ('reverse-lunge-s-dlinnym-shagom', 30, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('hamstring-slide', 40, 8, null::int, 60, 4, '8–12'),
    ('good-morning-s-rezinkoy', 50, 15, null::int, 60, 3, '15'),
    ('banded-kickback', 60, 20, null::int, 60, 3, '20'),
    ('hamstring-rest-pause', 70, null::int, null::int, 60, 1, 'Сгибание ног 12 повторений 20 секунд отдыха 5 повторений 20 секунд отдыха 5 повторений'),
    ('core-3-kruga-leg-raise-60-sek-dead-bug-60-sek-bicycle-60-sek-planka-a35df9', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — STRENGTH + ATHLETIC', 4, 'МЕСЯЦ 5 — LEVEL 5A — STRENGTH HYPERTROPHY (НЕДЕЛИ 17–18)', 9, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-clean-squat', 0, 8, null::int, 60, 4, '8'),
    ('dumbbell-push-press', 10, 10, null::int, 60, 4, '10'),
    ('walking-lunges', 20, 16, null::int, 60, 3, '16 шагов'),
    ('renegade-row', 30, 8, null::int, 60, 4, '8 на каждую руку'),
    ('dumbbell-swing', 40, 15, null::int, 60, 4, '15'),
    ('push-up', 50, null::int, null::int, 60, 4, 'максимум качественных повторений'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('emom-10-minut', 70, null::int, null::int, 60, 1, 'Нечетные минуты 10 Goblet Squats Четные минуты 8 Push-Ups 10 Mountain Climbers Оставшееся…'),
    ('core-3-kruga-v-ups-60-sek-mountain-climbers-60-sek-russian-twist-60-31083a', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 5 — LEVEL 5B — MUSCLE SHOCK (НЕДЕЛИ 19–20)', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('sumo-squat', 0, 10, null::int, 60, 4, '10 (Последний подход: 1,5 повторения × 8)'),
    ('b-stance-hip-thrust', 10, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('front-foot-elevated-reverse-lunge', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('cossack-squat', 30, 10, null::int, 60, 3, '10 на каждую сторону'),
    ('frog-pumps', 40, 30, null::int, 60, 4, '30 (Последний подход: +20 пульсаций.)'),
    ('fire-hydrant-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('abduction', 60, 30, null::int, 60, 3, '30'),
    ('glute-drop-set', 70, 3, null::int, 60, 1, '3 раунда 20 Frog Pumps ↓ 20 Glute Bridge ↓ 20 секунд статика ↓ 20 пульсаций Отдых: 60…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-mountain-climbers-0b49af', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY SHOCK', 2, 'МЕСЯЦ 5 — LEVEL 5B — MUSCLE SHOCK (НЕДЕЛИ 19–20)', 10, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-ganteley-s-pauzoy', 0, 12, null::int, 60, 4, '12 (Пауза: 2 секунды.)'),
    ('tyaga-rezinki-odnoy-rukoy', 10, 15, null::int, 60, 3, '15 на каждую сторону'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 4, '15'),
    ('y-raise', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-giant-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Махи в стороны 15 Reverse Fly 15 Статика в стороны 20 секунд 4 круга…'),
    ('arms-mechanical-drop-set', 50, 3, null::int, 60, 1, '3 раунда Молотковые сгибания: 10 ↓ обычные сгибания: 10 ↓ частичные повторения: 10 Отдых:…'),
    ('core-4-kruga-hollow-hold-60-sek-leg-raise-60-sek-russian-twist-60-sek-5bd503', 60, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR SHOCK', 3, 'МЕСЯЦ 5 — LEVEL 5B — MUSCLE SHOCK (НЕДЕЛИ 19–20)', 10, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('b-stance-good-morning', 10, 12, null::int, 60, 3, '12 на каждую сторону'),
    ('single-leg-glute-bridge', 20, 15, null::int, 60, 4, '15'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('curtsy-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('kickback', 50, 25, null::int, 60, 3, '25'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('hamstring-shock', 70, 3, null::int, 60, 1, '3 круга 10 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 секунд статика Отдых: 45…'),
    ('core-4-kruga-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-3ab117', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — LEVEL 5 BOSS', 4, 'МЕСЯЦ 5 — LEVEL 5B — MUSCLE SHOCK (НЕДЕЛИ 19–20)', 10, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-clean', 0, 8, null::int, 60, 4, '8'),
    ('dumbbell-thruster', 10, 10, null::int, 60, 4, '10'),
    ('walking-lunge-knee-drive', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('renegade-row', 30, 8, null::int, 60, 4, '8 на каждую руку'),
    ('dumbbell-swing', 40, 20, null::int, 60, 4, '20'),
    ('push-up', 50, null::int, null::int, 60, 3, 'максимум'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('boss-amrap', 70, null::int, 720, 60, 1, '12 минут Максимальное количество качественных кругов: 10 Sumo Squats 8 Push-Ups 10…'),
    ('core-boss', 80, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progress-mesyatsa-5', 90, null::int, null::int, 60, 1, 'Пользователь фиксирует: Hip Thrust Месяц 1: ____ кг Месяц 2: ____ кг Месяц 3: ____ кг…'),
    ('level-5-completed', 100, null::int, null::int, 60, 1, 'После 20-й недели пользователь переходит на следующий уровень.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'МЕСЯЦ 6 — LEVEL 6A — POWER HYPERTROPHY (НЕДЕЛИ 21–22)', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-s-gantelyu-shtangoy', 0, 8, null::int, 60, 5, '8 (Последний подход: 8 повторений + 20 секунд отдыха + 4–5 повторений)'),
    ('deficit-reverse-lunge', 10, 10, null::int, 60, 4, '10 на каждую ногу (Задняя нога не используется для толчка.)'),
    ('sumo-romanian-deadlift', 20, 10, null::int, 60, 4, '10 (Темп: 3 секунды вниз)'),
    ('goblet-squat-s-pauzoy', 30, 12, null::int, 60, 4, '12 (В нижней точке: 2 секунды)'),
    ('banded-hip-abduction', 40, 20, null::int, 60, 4, '20 (Последний подход: 20 обычных 20 пульсаций 20 секунд статика.)'),
    ('diagonal-kickback-s-rezinkoy', 50, 15, null::int, 60, 3, '15 на каждую ногу'),
    ('frog-pumps', 60, 30, null::int, 60, 3, '30 (Последние 10: максимально короткая амплитуда.)'),
    ('glute-finisher', 70, 3, null::int, 60, 1, '3 раунда 12 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 20 секунд удержание сверху…'),
    ('press', 80, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд Reverse Crunch Mountain Climbers Dead Bug Планка…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — STRENGTH', 2, 'МЕСЯЦ 6 — LEVEL 6A — POWER HYPERTROPHY (НЕДЕЛИ 21–22)', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tyaga-dvuh-ganteley-v-naklone', 0, 10, null::int, 60, 4, '10'),
    ('tyaga-ganteli-odnoy-rukoy-s-pauzoy', 10, 12, null::int, 60, 3, '12 на каждую руку (Пауза в верхней точке: 2 секунды)'),
    ('pullover-s-gantelyu', 20, 12, null::int, 60, 4, '12'),
    ('razvedenie-ganteley-v-naklone', 30, 15, null::int, 60, 3, '15'),
    ('plechi-giant-set', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 ↓ Махи в стороны 12 ↓ Махи вперед 12 ↓ Reverse Fly 15 Отдых:…'),
    ('ruki-superset', 50, null::int, null::int, 60, 1, 'Молотковые сгибания 12 Разгибание гантели над головой 12 4 круга'),
    ('press', 60, 4, null::int, 60, 1, '4 круга V-Ups — 60 сек Bicycle — 60 сек Hollow Hold — 60 сек Leg Raise — 60 сек Отдых: 60…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING + GLUTE', 3, 'МЕСЯЦ 6 — LEVEL 6A — POWER HYPERTROPHY (НЕДЕЛИ 21–22)', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('romanian-deadlift-s-gantelyami', 0, 8, null::int, 60, 4, '8–10 (Последние 2 повторения: медленно.)'),
    ('single-leg-hip-thrust', 10, 10, null::int, 60, 4, '10 на каждую ногу (Пауза сверху: 2 секунды)'),
    ('front-foot-elevated-split-squat', 20, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('sliding-leg-curl', 30, 10, null::int, 60, 4, '10 (Если слишком легко: использовать более медленную фазу возвращения.)'),
    ('good-morning-s-gantelyu', 40, 15, null::int, 60, 3, '15'),
    ('banded-kickback', 50, 20, null::int, 60, 3, '20'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('hamstring-finisher', 70, 3, null::int, 60, 1, '3 круга 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 30 секунд удержание Glute…'),
    ('press', 80, 4, null::int, 60, 1, '4 круга Reverse Crunch — 60 сек Bicycle — 60 сек Mountain Climbers — 60 сек Планка с…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER', 4, 'МЕСЯЦ 6 — LEVEL 6A — POWER HYPERTROPHY (НЕДЕЛИ 21–22)', 11, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-squat-to-press', 0, 10, null::int, 60, 4, '10'),
    ('reverse-lunge-knee-drive', 10, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('dumbbell-row', 20, 10, null::int, 60, 4, '10 на каждую руку'),
    ('push-up', 30, 8, null::int, 60, 4, '8–15'),
    ('dumbbell-swing', 40, 20, null::int, 60, 4, '20'),
    ('squat-jump', 50, 10, null::int, 60, 4, '10 (Между подходами: 60 секунд)'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('power-finisher', 70, 4, null::int, 60, 1, '4 раунда 10 Goblet Squats 8 Push-Ups 10 Dumbbell Rows 10 Reverse Lunges 15 Dumbbell…'),
    ('press', 80, 4, null::int, 60, 1, '4 круга V-Ups — 60 сек Mountain Climbers — 60 сек Russian Twist — 60 сек Hollow Hold — 60…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 6 — LEVEL 6B — ATHLETIC SHOCK (НЕДЕЛИ 23–24)', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-hip-thrust', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('curtsy-lunge', 10, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('cyclist-squat', 20, 12, null::int, 60, 4, '12 (Пятки слегка приподняты. Последний подход: +10 пульсаций)'),
    ('step-up-na-ustoychivuyu-platformu', 30, 10, null::int, 60, 4, '10 на каждую ногу (В верхней точке: 2 секунды)'),
    ('single-leg-glute-bridge', 40, 15, null::int, 60, 3, '15'),
    ('fire-hydrant-s-rezinkoy', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('abduction', 60, 30, null::int, 60, 3, '30'),
    ('glute-burnout', 70, 3, null::int, 60, 1, '3 раунда 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 секунд статика сверху Отдых: 45…'),
    ('press', 80, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд Bicycle Reverse Crunch Mountain Climbers Plank…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY SHOCK', 2, 'МЕСЯЦ 6 — LEVEL 6B — ATHLETIC SHOCK (НЕДЕЛИ 23–24)', 12, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('renegade-row', 0, 8, null::int, 60, 4, '8 на каждую руку'),
    ('tyaga-rezinki-k-zhivotu', 10, 15, null::int, 60, 4, '15 (Пауза: 2 секунды)'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 3, '15'),
    ('y-raise', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-giant-set', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 секунд…'),
    ('arms-drop-set', 50, null::int, null::int, 60, 1, 'Бицепс 12 обычных сгибаний ↓ 10 молотковых ↓ 10 частичных 3 раунда'),
    ('press', 60, 5, null::int, 60, 1, '5 кругов Leg Raise — 60 сек Bicycle — 60 сек Hollow Hold — 60 сек Mountain Climbers — 60…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN SHOCK', 3, 'МЕСЯЦ 6 — LEVEL 6B — ATHLETIC SHOCK (НЕДЕЛИ 23–24)', 12, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('staggered-stance-good-morning', 10, 12, null::int, 60, 3, '12 на каждую сторону'),
    ('hip-thrust-s-1-5-povtoreniyami', 20, 10, null::int, 60, 4, '10 (Каждое повторение: полное вверх → половина вниз → снова вверх → полный вниз.)'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('reverse-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('diagonal-kickback', 50, 20, null::int, 60, 3, '20'),
    ('band-abduction', 60, 30, null::int, 60, 3, '30'),
    ('posterior-chain-boss', 70, 3, null::int, 60, 1, '3 раунда 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 секунд Glute…'),
    ('press', 80, 5, null::int, 60, 1, '5 кругов Dead Bug — 60 сек Reverse Crunch — 60 сек Mountain Climbers — 60 сек Hollow Hold…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ATHLETIC FULL BODY', 4, 'МЕСЯЦ 6 — LEVEL 6B — ATHLETIC SHOCK (НЕДЕЛИ 23–24)', 12, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('power-block', 0, null::int, null::int, 60, 1, '—'),
    ('dumbbell-clean', 10, 8, null::int, 60, 4, '8'),
    ('squat-jump', 20, 8, null::int, 60, 4, '8 (Отдых: 75 секунд)'),
    ('dumbbell-swing', 30, 20, null::int, 60, 4, '20'),
    ('push-up', 40, null::int, null::int, 60, 3, 'максимум'),
    ('farmer-walk', 50, null::int, 60, 60, 4, '60 секунд'),
    ('boss-amrap-12', 60, null::int, null::int, 60, 1, 'За 12 минут выполнить максимально качественное количество кругов: 10 Goblet Squats 8…'),
    ('finalnyy-core-boss', 70, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progressiya-mesyatsa-6', 80, null::int, null::int, 60, 1, 'В течение месяца фиксируются: HIP THRUST Неделя 21: ____ кг Неделя 22: ____ кг Неделя 23:…'),
    ('level-6-completed', 90, null::int, null::int, 60, 1, 'После 24-й недели пользователь получает: +1 LEVEL и переходит к:')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE MASS', 1, 'МЕСЯЦ 7 — LEVEL 7A — GLUTE BUILD (НЕДЕЛИ 25–26)', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-s-nogami-na-vozvyshennosti', 0, 8, null::int, 60, 5, '8–10 (Последний подход: 10 повторений + 20 секунд отдыха + 5 повторений)'),
    ('bulgarian-split-squat-s-naklonom-korpusa-vpered', 10, 10, null::int, 60, 4, '10 на каждую ногу (Акцент: ягодица.)'),
    ('deficit-reverse-lunge', 20, 10, null::int, 60, 3, '10 на каждую ногу (Передняя нога стоит на небольшой устойчивой платформе.)'),
    ('sumo-squat-s-gantelyu', 30, 12, null::int, 60, 4, '12 (Последние 3 повторения: медленно.)'),
    ('banded-abduction', 40, 25, null::int, 60, 4, '25 (Последний подход: 25 повторений 20 пульсаций 20 секунд статика.)'),
    ('diagonal-banded-kickback', 50, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('frog-pumps', 60, 30, null::int, 60, 3, '30 (Последние 10: пульсации.)'),
    ('glute-mechanical-drop-set', 70, 3, null::int, 60, 1, '3 раунда 10 Hip Thrust ↓ 15 Glute Bridge ↓ 20 Frog Pumps ↓ 30 секунд статика Отдых: 60…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-a90a52', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY + SHOULDERS', 2, 'МЕСЯЦ 7 — LEVEL 7A — GLUTE BUILD (НЕДЕЛИ 25–26)', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('renegade-row', 0, 8, null::int, 60, 4, '8 на каждую руку'),
    ('tyaga-ganteley-v-naklone-s-pauzoy', 10, 10, null::int, 60, 4, '10 (Пауза: 2 секунды в верхней точке.)'),
    ('pullover-s-gantelyu', 20, 12, null::int, 60, 3, '12'),
    ('reverse-fly', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-contrast-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 повторений ↓ Махи гантелями в стороны 15 повторений ↓ Статика в стороны…'),
    ('ruki', 50, 12, null::int, 60, 3, '12 (Молотковые сгибания Трицепс с гантелью над головой 3 × 12 Выполняются суперсетом.)'),
    ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-russian-twist-60-sek-4725db', 60, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING + GLUTE', 3, 'МЕСЯЦ 7 — LEVEL 7A — GLUTE BUILD (НЕДЕЛИ 25–26)', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('staggered-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('single-leg-hip-thrust', 10, 12, null::int, 60, 4, '12 на каждую ногу (Пауза сверху: 2 секунды.)'),
    ('front-foot-elevated-split-squat', 20, 10, null::int, 60, 4, '10'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('good-morning-s-rezinkoy', 40, 15, null::int, 60, 3, '15'),
    ('kickback-s-rezinkoy', 50, 20, null::int, 60, 3, '20'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('posterior-chain-finisher', 70, 3, null::int, 60, 1, '3 круга 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 30 секунд Glute…'),
    ('core-4-kruga-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-cd6ec3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ATHLETIC — LOWER BODY POWER', 4, 'МЕСЯЦ 7 — LEVEL 7A — GLUTE BUILD (НЕДЕЛИ 25–26)', 13, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-clean', 0, 8, null::int, 60, 4, '8'),
    ('dumbbell-thruster', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge-knee-drive', 20, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('dumbbell-swing', 30, 20, null::int, 60, 4, '20'),
    ('squat-jump', 40, 8, null::int, 60, 4, '8 (Отдых: 60–75 секунд.)'),
    ('push-up', 50, null::int, null::int, 60, 3, 'максимум качественных повторений'),
    ('farmer-walk', 60, null::int, 60, 60, 4, '60 секунд'),
    ('emom-12-minut', 70, null::int, null::int, 60, 1, 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'),
    ('core-4-kruga-v-ups-60-sek-bicycle-60-sek-mountain-climbers-60-sek-973fc1', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 7 — LEVEL 7B — GLUTE SHOCK (НЕДЕЛИ 27–28)', 14, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-hip-thrust', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('curtsy-lunge', 10, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('cyclist-squat', 20, 12, null::int, 60, 4, '12 (Последний подход: 12 повторений + 10 пульсаций.)'),
    ('step-up-s-vysokim-podemom-kolena', 30, 10, null::int, 60, 4, '10 на каждую ногу (В верхней точке: 2 секунды.)'),
    ('single-leg-glute-bridge', 40, 15, null::int, 60, 4, '15'),
    ('fire-hydrant-s-rezinkoy', 50, 25, null::int, 60, 3, '25'),
    ('abduction', 60, 30, null::int, 60, 3, '30'),
    ('glute-burnout', 70, 3, null::int, 60, 1, '3 раунда 20 Abduction 15 Frog Pumps 10 Glute Bridge 30 секунд статика Отдых: 45 секунд.'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-375f31', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY SHOCK', 2, 'МЕСЯЦ 7 — LEVEL 7B — GLUTE SHOCK (НЕДЕЛИ 27–28)', 14, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('renegade-row-s-pauzoy', 0, 8, null::int, 60, 4, '8 на каждую руку'),
    ('tyaga-rezinki-odnoy-rukoy', 10, 15, null::int, 60, 4, '15 (Пауза: 2 секунды.)'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 4, '15'),
    ('y-raise', 30, 15, null::int, 60, 3, '15'),
    ('shoulders-giant-set', 40, null::int, null::int, 60, 1, 'Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 4 круга Отдых: 60 секунд.'),
    ('biceps-drop-set', 50, 3, null::int, 60, 1, '3 раунда 12 обычных сгибаний ↓ 10 молотковых ↓ 10 частичных повторений'),
    ('triceps', 60, 15, null::int, 60, 4, '15 (Разгибание с резинкой: Последний подход: +15 частичных повторений.)'),
    ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-hollow-hold-60-sek-632a78', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · GLUTE + HAMSTRING SHOCK', 3, 'МЕСЯЦ 7 — LEVEL 7B — GLUTE SHOCK (НЕДЕЛИ 27–28)', 14, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('hip-thrust-1-5-povtoreniya', 10, 10, null::int, 60, 4, '10'),
    ('reverse-lunge-s-dlinnym-shagom', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('hamstring-walkout', 30, 12, null::int, 60, 4, '12'),
    ('single-leg-good-morning', 40, 12, null::int, 60, 3, '12 на каждую сторону'),
    ('diagonal-kickback', 50, 20, null::int, 60, 3, '20'),
    ('band-abduction', 60, 25, null::int, 60, 4, '25'),
    ('hamstring-boss', 70, 3, null::int, 60, 1, '3 круга 12 Hamstring Walkouts 15 Glute Bridges 20 Frog Pumps 30 секунд статика Отдых: 45…'),
    ('core-5-krugov-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-987b10', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · LEVEL 7 — BOSS FIGHT', 4, 'МЕСЯЦ 7 — LEVEL 7B — GLUTE SHOCK (НЕДЕЛИ 27–28)', 14, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 8, null::int, 60, 4, '8 (Dumbbell Clean Squat Jump 4 × 8 Отдых: 75 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Thruster Reverse Lunge 4 × 10 на каждую ногу Отдых: 75 секунд.)'),
    ('block-3', 20, 8, null::int, 60, 4, '8 на каждую руку (Renegade Row Push-Up 4 × максимум Отдых: 75 секунд.)'),
    ('amrap-15-minut', 30, null::int, null::int, 60, 1, 'Максимальное количество качественных кругов: 10 Goblet Squats 10 Walking Lunges 8…'),
    ('finisher', 40, 3, null::int, 60, 1, '3 раунда 20 Frog Pumps 20 Abduction 20 секунд Glute Bridge Hold 10 Squat Pulses Отдых: 45…'),
    ('final-core-boss', 50, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progressiya-mesyatsa-7', 60, null::int, null::int, 60, 1, 'Пользователь фиксирует лучшие показатели.'),
    ('level-7-completed', 70, 28, null::int, 60, 1, '28 недель пройдено.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE TENSION', 1, 'МЕСЯЦ 8 — LEVEL 8A — TENSION BUILD (НЕДЕЛИ 29–30)', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kas-glute-bridge-s-vesom', 0, 10, null::int, 60, 5, '10 (Темп: 2 секунды вверх → 2 секунды удержание → медленно вниз.)'),
    ('heel-elevated-bulgarian-split-squat', 10, 10, null::int, 60, 4, '10 на каждую ногу (Темп: 3 секунды вниз.)'),
    ('b-stance-romanian-deadlift', 20, 10, null::int, 60, 4, '10 на каждую сторону (Пауза в нижней точке: 1 секунда.)'),
    ('deficit-step-back-lunge', 30, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('squat-1-5-reps', 40, 12, null::int, 60, 3, '12'),
    ('banded-abduction', 50, 25, null::int, 60, 4, '25 (Последний подход: 25 повторений 20 пульсаций 20 секунд статика.)'),
    ('banded-diagonal-kickback', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-tension-finisher', 70, 3, null::int, 60, 1, '3 круга 15 Glute Bridge 15 Frog Pumps 15 Abduction 30 секунд Glute Bridge Hold Отдых: 45…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-bicycle-9f1aea', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — CALISTHENICS', 2, 'МЕСЯЦ 8 — LEVEL 8A — TENSION BUILD (НЕДЕЛИ 29–30)', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('renegade-row', 0, 8, null::int, 60, 4, '8 на каждую руку'),
    ('push-up', 10, 8, null::int, 60, 4, '8–15 (Если обычные слишком легкие: ноги на устойчивой возвышенности.)'),
    ('tyaga-ganteley-v-naklone', 20, 12, null::int, 60, 4, '12 (Последние 3 повторения: медленная негативная фаза.)'),
    ('pike-push-up', 30, 8, null::int, 60, 4, '8–12'),
    ('pullover', 40, 12, null::int, 60, 3, '12'),
    ('shoulders-giant-set', 50, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Lateral Raise Hold 20 секунд…'),
    ('arms-superset', 60, null::int, null::int, 60, 1, 'Hammer Curl 12 Overhead Triceps Extension 12 4 круга'),
    ('biceps-finisher', 70, 2, null::int, 60, 1, '2 раунда 10 обычных сгибаний 10 молотковых 10 частичных'),
    ('core-4-kruga-v-ups-60-sek-leg-raise-60-sek-russian-twist-60-sek-c6088b', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN', 3, 'МЕСЯЦ 8 — LEVEL 8A — TENSION BUILD (НЕДЕЛИ 29–30)', 15, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('elevated-single-leg-glute-bridge', 10, 12, null::int, 60, 4, '12 на каждую ногу (Пауза сверху: 2 секунды.)'),
    ('reverse-lunge-s-peredney-nogoy-na-vozvyshenii', 20, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('good-morning-s-rezinkoy', 40, 15, null::int, 60, 4, '15'),
    ('standing-kickback-s-rezinkoy', 50, 20, null::int, 60, 3, '20'),
    ('lateral-band-walk', 60, 20, null::int, 60, 4, '20 шагов'),
    ('hamstring-drop-set', 70, 3, null::int, 60, 1, '3 круга 10 Hamstring Walkouts ↓ 15 Glute Bridges ↓ 20 Frog Pumps ↓ 30 секунд статика…'),
    ('core-4-kruga-reverse-crunch-60-sek-bicycle-60-sek-mountain-climbers-5cf62d', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER', 4, 'МЕСЯЦ 8 — LEVEL 8A — TENSION BUILD (НЕДЕЛИ 29–30)', 15, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Goblet Squat Squat Jump 4 × 8 Отдых: 90 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Romanian Deadlift Broad Jump 4 × 6 Если нет безопасного места для прыжков:…)'),
    ('block-3', 20, 10, null::int, 60, 4, '10 (Dumbbell Push Press Mountain Climbers 4 × 30 секунд)'),
    ('block-4', 30, 8, null::int, 60, 3, '8 на каждую руку (Renegade Row Push-Up 3 × максимум качественных повторений)'),
    ('emom-12-minut', 40, null::int, null::int, 60, 1, 'Минута 1 10 Goblet Squats Минута 2 8 Push-Ups Минута 3 12 Dumbbell Swings Повторить: 4…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-v-ups-bicycle-mountain-climbers-0f2a09', 50, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 8 — LEVEL 8B — ATHLETIC SHOCK (НЕДЕЛИ 31–32)', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('frog-stance-hip-thrust', 0, 12, null::int, 60, 4, '12 (Последние 5 повторений: короткая амплитуда.)'),
    ('front-foot-elevated-reverse-lunge-2', 10, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('sumo-squat-pulse', 20, 10, null::int, 60, 4, '10 (После каждого подхода: 10 пульсаций.)'),
    ('cross-back-lunge', 30, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('single-leg-glute-bridge', 40, 15, null::int, 60, 4, '15'),
    ('fire-hydrant', 50, 25, null::int, 60, 3, '25'),
    ('banded-abduction', 60, 30, null::int, 60, 3, '30'),
    ('glute-shock-circuit', 70, 3, null::int, 60, 1, '3 круга 15 Hip Thrust 20 Frog Pumps 20 Abduction 15 Squat Pulses 30 секунд статика Отдых:…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-375f31', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY SHOCK', 2, 'МЕСЯЦ 8 — LEVEL 8B — ATHLETIC SHOCK (НЕДЕЛИ 31–32)', 16, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-up-s-pauzoy', 0, 8, null::int, 60, 4, '8–12 (Пауза внизу: 2 секунды.)'),
    ('tyaga-ganteli-odnoy-rukoy', 10, 12, null::int, 60, 4, '12 на каждую руку'),
    ('pullover-s-rezinkoy', 20, 15, null::int, 60, 4, '15'),
    ('reverse-fly', 30, 15, null::int, 60, 4, '15'),
    ('shoulders-tri-set', 40, 4, null::int, 60, 1, '4 круга Lateral Raise 12 Arnold Press 10 Reverse Fly 15 Отдых: 60 секунд'),
    ('arms-mechanical-drop-set', 50, null::int, null::int, 60, 1, 'Бицепс 10 обычных сгибаний ↓ 10 молотковых ↓ 10 частичных 3 раунда'),
    ('core-5-krugov-leg-raise-60-sek-v-ups-60-sek-bicycle-60-sek-hollow-748496', 60, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING + GLUTE SHOCK', 3, 'МЕСЯЦ 8 — LEVEL 8B — ATHLETIC SHOCK (НЕДЕЛИ 31–32)', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kickstand-romanian-deadlift', 0, 12, null::int, 60, 4, '12 на каждую сторону'),
    ('single-leg-hip-thrust', 10, 12, null::int, 60, 4, '12 (Пауза: 3 секунды сверху.)'),
    ('curtsy-lunge', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('hamstring-walkout-s-pauzoy', 30, 8, null::int, 60, 4, '8–10 (В полностью вытянутом положении: 1 секунда.)'),
    ('single-leg-good-morning', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('diagonal-kickback', 50, 20, null::int, 60, 3, '20'),
    ('band-abduction', 60, 25, null::int, 60, 4, '25'),
    ('posterior-burnout', 70, 3, null::int, 60, 1, '3 круга 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'),
    ('core-5-krugov-dead-bug-60-sek-reverse-crunch-60-sek-mountain-climbers-987b10', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · LEVEL 8 — BOSS FIGHT', 4, 'МЕСЯЦ 8 — LEVEL 8B — ATHLETIC SHOCK (НЕДЕЛИ 31–32)', 16, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Dumbbell Thruster Squat Jump 4 × 8 Отдых: 75–90 секунд.)'),
    ('block-2', 10, 8, null::int, 60, 4, '8 (Dumbbell Clean Reverse Lunge + Knee Drive 4 × 10 на каждую ногу)'),
    ('block-3', 20, 8, null::int, 60, 4, '8 (Renegade Row Push-Up 4 × максимум)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 40 секунд)'),
    ('amrap-15-minut', 40, null::int, null::int, 60, 1, 'Максимальное количество качественных кругов: 10 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'),
    ('boss-glute-finisher', 50, 3, null::int, 60, 1, '3 раунда 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд Glute…'),
    ('final-core-boss', 60, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progressiya-mesyatsa-8', 70, null::int, null::int, 60, 1, 'Пользователь фиксирует: HIP THRUST Неделя 29: ____ кг Неделя 30: ____ кг Неделя 31: ____…'),
    ('level-8-completed', 80, null::int, null::int, 60, 1, 'После 32 недель пользователь переходит на:')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'МЕСЯЦ 9 — LEVEL 9A — POWER BUILD (НЕДЕЛИ 33–34)', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-s-gantelyu-tyazhelym-vesom', 0, 8, null::int, 60, 5, '8–10 (Темп: 2 секунды вверх → 2 секунды удержание → 3 секунды вниз Последний подход: 10…)'),
    ('front-foot-elevated-bulgarian-split-squat', 10, 10, null::int, 60, 4, '10 на каждую ногу (Темп: 3 секунды вниз Последние 2 повторения: максимально контролируемые.)'),
    ('dumbbell-romanian-deadlift', 20, 10, null::int, 60, 4, '10 (Пауза в нижней точке: 1 секунда)'),
    ('reverse-lunge-knee-drive', 30, 12, null::int, 60, 3, '12 на каждую ногу (После последнего подхода: 10 быстрых повторений без веса на каждую ногу)'),
    ('goblet-squat', 40, 12, null::int, 60, 4, '12 (Последние 3 повторения: 3-секундная негативная фаза)'),
    ('banded-abduction', 50, 25, null::int, 60, 4, '25 (Последний подход: 25 повторений 20 пульсаций 20 секунд статика.)'),
    ('diagonal-kickback-s-rezinkoy', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-power-finisher', 70, 3, null::int, 60, 1, '3 круга 15 Hip Thrust 15 Frog Pumps 15 Squat Pulses 20 Abduction 30 секунд Glute Bridge…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-a90a52', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — POWER', 2, 'МЕСЯЦ 9 — LEVEL 9A — POWER BUILD (НЕДЕЛИ 33–34)', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-up-s-nogami-na-vozvyshenii', 0, 8, null::int, 60, 4, '8–12 (Если тяжело: обычные отжимания.)'),
    ('one-arm-dumbbell-row', 10, 10, null::int, 60, 4, '10 на каждую руку (Последние 3 повторения: медленное опускание.)'),
    ('dumbbell-floor-press', 20, 10, null::int, 60, 4, '10–12'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 3, '12 (Пауза: 2 секунды в растянутом положении)'),
    ('shoulders-power-tri-set', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 повторений Lateral Raise 12 повторений Reverse Fly 15 повторений…'),
    ('biceps', 50, 12, null::int, 60, 3, '12 на каждую руку (Alternating Dumbbell Curl Последний подход: 12 + 10 частичных повторений)'),
    ('triceps', 60, 12, null::int, 60, 3, '12 (Overhead Dumbbell Extension Band Triceps Pushdown 3 × 20)'),
    ('push-up-finisher', 70, 3, null::int, 60, 1, '3 раунда 8 Push-Ups 10 Knee Push-Ups 10 секунд удержание в нижней точке Отдых: 45 секунд'),
    ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-russian-twist-60-sek-4725db', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING POWER', 3, 'МЕСЯЦ 9 — LEVEL 9A — POWER BUILD (НЕДЕЛИ 33–34)', 17, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('single-leg-hip-thrust', 10, 10, null::int, 60, 4, '10 на каждую ногу (Пауза сверху: 3 секунды)'),
    ('sliding-leg-curl', 20, 10, null::int, 60, 4, '10 (Использовать полотенце/скользящую поверхность.)'),
    ('deficit-reverse-lunge', 30, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('single-leg-good-morning', 40, 12, null::int, 60, 3, '12'),
    ('banded-kickback', 50, 20, null::int, 60, 4, '20'),
    ('banded-lateral-walk', 60, 20, null::int, 60, 3, '20 шагов в каждую сторону'),
    ('hamstring-boss', 70, 3, null::int, 60, 1, '3 круга 10 Sliding Leg Curl 15 Glute Bridge 15 Frog Pumps 20 Band Abduction 30 секунд…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-84890f', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · POWER CONDITIONING', 4, 'МЕСЯЦ 9 — LEVEL 9A — POWER BUILD (НЕДЕЛИ 33–34)', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Dumbbell Squat Squat Jump 4 × 8 Отдых: 90 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Romanian Deadlift Skater Jump 4 × 10 на каждую сторону Если прыжки…)'),
    ('block-3', 20, 10, null::int, 60, 4, '10 (Dumbbell Push Press Mountain Climbers 4 × 40 секунд)'),
    ('block-4', 30, 8, null::int, 60, 3, '8 на каждую руку (Renegade Row Push-Up 3 × максимум качественных повторений)'),
    ('emom-15-minut', 40, null::int, null::int, 60, 1, 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'),
    ('boss-finisher', 50, 3, null::int, 60, 1, '3 круга 20 Frog Pumps 15 Squat Pulses 20 Band Abduction 15 Glute Bridge 30 секунд статика…'),
    ('core-4-kruga-v-ups-60-sek-bicycle-60-sek-mountain-climbers-60-sek-973fc1', 60, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE OVERLOAD', 1, 'МЕСЯЦ 9 — LEVEL 9B — GLUTE OVERLOAD (НЕДЕЛИ 35–36)', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kas-bridge-s-uzkoy-postanovkoy-nog', 0, 12, null::int, 60, 5, '12 (Пауза сверху: 3 секунды)'),
    ('reverse-bulgarian-split-squat', 10, 12, null::int, 60, 4, '12 на каждую ногу (Последние 3 повторения: 1,5 повторения)'),
    ('sumo-romanian-deadlift', 20, 10, null::int, 60, 4, '10 (Темп: 3 секунды вниз)'),
    ('curtsy-lunge', 30, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('squat-1-5-reps', 40, 10, null::int, 60, 3, '10'),
    ('frog-pumps', 50, 25, null::int, 60, 4, '25 (Последний подход: 25 + 20 пульсаций)'),
    ('fire-hydrant', 60, 25, null::int, 60, 3, '25 на каждую ногу'),
    ('glute-mechanical-drop-set', 70, 3, null::int, 60, 1, '3 раунда 10 Bulgarian Split Squats ↓ 15 Reverse Lunges ↓ 20 Bodyweight Squats ↓ 30 секунд…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-leg-raise-bicycle-405021', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — CALISTHENICS LEVEL', 2, 'МЕСЯЦ 9 — LEVEL 9B — GLUTE OVERLOAD (НЕДЕЛИ 35–36)', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('push-up-s-pauzoy', 0, 10, null::int, 60, 4, '10 (Пауза внизу: 2 секунды)'),
    ('archer-push-up', 10, 6, null::int, 60, 3, '6–8 на сторону (Если сложно: делать с колен или с уменьшенной амплитудой.)'),
    ('one-arm-dumbbell-row', 20, 12, null::int, 60, 4, '12'),
    ('dumbbell-floor-press', 30, 12, null::int, 60, 4, '12'),
    ('dumbbell-pullover', 40, 15, null::int, 60, 3, '15'),
    ('shoulders-giant-set', 50, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Raise Hold…'),
    ('arms-superset', 60, null::int, null::int, 60, 1, 'Hammer Curl 12 Band Triceps Extension 20 4 круга'),
    ('biceps-drop-set', 70, 3, null::int, 60, 1, '3 раунда 10 Dumbbell Curl ↓ 10 Hammer Curl ↓ 10 частичных повторений'),
    ('core-5-krugov-v-ups-60-sek-leg-raise-60-sek-mountain-climbers-60-sek-3adf2b', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN OVERLOAD', 3, 'МЕСЯЦ 9 — LEVEL 9B — GLUTE OVERLOAD (НЕДЕЛИ 35–36)', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('feet-elevated-glute-bridge', 10, 15, null::int, 60, 4, '15 (Пауза сверху: 3 секунды)'),
    ('walking-lunge', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('sliding-hamstring-curl', 30, 8, null::int, 60, 4, '8–12'),
    ('good-morning-s-rezinkoy', 40, 15, null::int, 60, 4, '15'),
    ('diagonal-kickback', 50, 25, null::int, 60, 3, '25'),
    ('abduction', 60, 30, null::int, 60, 4, '30 (Последние 10: частичные.)'),
    ('hamstring-boss', 70, 4, null::int, 60, 1, '4 круга 8 Sliding Leg Curl 12 Single-Leg Glute Bridge 15 Frog Pumps 20 Abduction 30…'),
    ('core-5-krugov-dead-bug-60-sek-reverse-crunch-60-sek-bicycle-60-sek-a12992', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · LEVEL 9 — BOSS FIGHT', 4, 'МЕСЯЦ 9 — LEVEL 9B — GLUTE OVERLOAD (НЕДЕЛИ 35–36)', 18, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 12, null::int, 60, 4, '12 (Dumbbell Thruster Squat Jump 4 × 10)'),
    ('block-2', 10, 12, null::int, 60, 4, '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 на сторону)'),
    ('block-3', 20, 10, null::int, 60, 4, '10 (Renegade Row Push-Up 4 × максимум)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 45 секунд)'),
    ('amrap-18-minut', 40, null::int, null::int, 60, 1, 'Максимальное количество качественных кругов: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'),
    ('boss-glute-finisher', 50, 4, null::int, 60, 1, '4 круга 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('final-core-boss', 60, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progressiya-level-9', 70, null::int, null::int, 60, 1, 'На каждой тренировке пользователь записывает рабочий вес.'),
    ('level-9-completed', 80, null::int, null::int, 60, 1, 'После прохождения 9-го месяца пользователь открывает:')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE HYPERTROPHY', 1, 'МЕСЯЦ 10 — LEVEL 10A — HYPERTROPHY BUILD (НЕДЕЛИ 37–38)', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('hip-thrust-heavy-set', 0, 8, null::int, 60, 4, '8–10 (Темп: 2 секунды вверх → 2 секунды удержание → 3 секунды вниз Последний подход: 8–10…)'),
    ('deficit-bulgarian-split-squat', 10, 10, null::int, 60, 4, '10 на каждую ногу (Задняя нога на возвышении.)'),
    ('sumo-dumbbell-squat', 20, 12, null::int, 60, 4, '12 (Пауза в нижней точке: 2 секунды)'),
    ('single-leg-romanian-deadlift', 30, 10, null::int, 60, 4, '10 на каждую ногу'),
    ('reverse-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу (Последние 3 повторения: медленная негативная фаза.)'),
    ('banded-abduction', 50, 30, null::int, 60, 4, '30 (Последний подход: 30 повторений 20 пульсаций 20 секунд статика.)'),
    ('banded-kickback', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-drop-set', 70, 3, null::int, 60, 1, '3 круга 12 Hip Thrust ↓ 15 Bodyweight Squats ↓ 20 Frog Pumps ↓ 20 Abduction ↓ 30 секунд…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-dead-bug-258fde', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — STRENGTH', 2, 'МЕСЯЦ 10 — LEVEL 10A — HYPERTROPHY BUILD (НЕДЕЛИ 37–38)', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-floor-press', 0, 8, null::int, 60, 4, '8–10 (Последний подход: +3–5 частичных повторений.)'),
    ('one-arm-dumbbell-row', 10, 10, null::int, 60, 4, '10 на каждую руку (Пауза в верхней точке: 2 секунды.)'),
    ('push-up-s-uzkoy-postanovkoy-ruk', 20, 8, null::int, 60, 4, '8–15'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 3, '12 (Темп: 3 секунды вниз.)'),
    ('shoulders-giant-set-2', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 повторений Lateral Raise 15 повторений Front Raise 12 повторений…'),
    ('biceps-triceps', 50, null::int, null::int, 60, 1, 'Суперсет Dumbbell Curl 12 Overhead Triceps Extension 12 4 круга'),
    ('arm-finisher', 60, null::int, null::int, 60, 1, 'Бицепс 10 обычных сгибаний 10 молотковых 10 частичных Трицепс 15 разгибаний с резинкой 15…'),
    ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-mountain-climbers-60-sek-631a04', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN', 3, 'МЕСЯЦ 10 — LEVEL 10A — HYPERTROPHY BUILD (НЕДЕЛИ 37–38)', 19, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('feet-elevated-hip-thrust', 10, 12, null::int, 60, 4, '12 (Пауза: 3 секунды сверху.)'),
    ('walking-lunge', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('sliding-hamstring-curl', 30, 8, null::int, 60, 4, '8–12 (Если слишком тяжело: Hamstring Walkout.)'),
    ('single-leg-good-morning', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('diagonal-band-kickback', 50, 25, null::int, 60, 3, '25 на каждую ногу'),
    ('band-abduction', 60, 25, null::int, 60, 4, '25 (Последние 10: частичная амплитуда.)'),
    ('hamstring-drop-set', 70, 3, null::int, 60, 1, '3 круга 10 Sliding Leg Curl 15 Glute Bridge 20 Frog Pumps 20 Abduction 30 секунд статика…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-mountain-a90a52', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER + DENSITY', 4, 'МЕСЯЦ 10 — LEVEL 10A — HYPERTROPHY BUILD (НЕДЕЛИ 37–38)', 19, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Dumbbell Thruster Squat Jump 4 × 8 Отдых: 90 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 на каждую ногу)'),
    ('block-3', 20, 8, null::int, 60, 4, '8 на каждую руку (Renegade Row Push-Up 4 × максимум качественных повторений)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 40 секунд)'),
    ('emom-16-minut', 40, null::int, null::int, 60, 1, 'Минута 1 10 Goblet Squats Минута 2 10 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'),
    ('boss-finisher', 50, 3, null::int, 60, 1, '3 круга 20 Frog Pumps 15 Squat Pulses 20 Abduction 15 Glute Bridge 30 секунд статика…'),
    ('core-boss', 60, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE DENSITY', 1, 'МЕСЯЦ 10 — LEVEL 10B — DENSITY SHOCK (НЕДЕЛИ 39–40)', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kas-glute-bridge', 0, 15, null::int, 60, 5, '15 (Пауза сверху: 3 секунды Последний подход: 15 + 10 пульсаций + 20 секунд статика.)'),
    ('front-foot-elevated-reverse-lunge-2', 10, 12, null::int, 60, 4, '12 на каждую ногу (Последние 3 повторения: 1,5 повторения.)'),
    ('wide-stance-squat', 20, 15, null::int, 60, 4, '15 (Темп: 4 секунды вниз.)'),
    ('curtsy-lunge', 30, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('single-leg-glute-bridge', 40, 15, null::int, 60, 4, '15 на каждую ногу'),
    ('frog-pumps', 50, 30, null::int, 60, 4, '30'),
    ('abduction', 60, 30, null::int, 60, 4, '30 (Последний подход: 30 + 20 пульсаций.)'),
    ('glute-density-boss', 70, 4, null::int, 60, 1, '4 круга 15 Reverse Lunges 20 Frog Pumps 20 Squat Pulses 20 Abduction 30 секунд статика…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-v-ups-bicycle-planka', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — CALISTHENICS SHOCK', 2, 'МЕСЯЦ 10 — LEVEL 10B — DENSITY SHOCK (НЕДЕЛИ 39–40)', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('archer-push-up', 0, 6, null::int, 60, 4, '6–8 на каждую сторону (Если тяжело: делать с колен.)'),
    ('one-arm-dumbbell-row', 10, 12, null::int, 60, 4, '12'),
    ('push-up-s-nogami-na-vozvyshenii', 20, 8, null::int, 60, 3, '8–12'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 4, '12'),
    ('renegade-row', 40, 8, null::int, 60, 3, '8 на каждую сторону'),
    ('shoulders-mechanical-drop-set', 50, 4, null::int, 60, 1, '4 круга Arnold Press 10 ↓ Lateral Raise 12 ↓ Partial Lateral Raise 15 ↓ Reverse Fly 15…'),
    ('arms-cluster-set', 60, null::int, null::int, 60, 1, 'Бицепс 8 повторений ↓ 20 секунд отдыха ↓ 4 повторения ↓ 20 секунд отдыха ↓ 4 повторения…'),
    ('push-up-boss', 70, 3, null::int, 60, 1, '3 раунда 10 Push-Ups 10 Knee Push-Ups 20 секунд статика в нижней точке Отдых: 45 секунд.'),
    ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-mountain-climbers-60-1196b9', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING + GLUTE DENSITY', 3, 'МЕСЯЦ 10 — LEVEL 10B — DENSITY SHOCK (НЕДЕЛИ 39–40)', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('single-leg-romanian-deadlift', 0, 12, null::int, 60, 4, '12'),
    ('hip-thrust-s-uzkoy-postanovkoy-nog', 10, 15, null::int, 60, 4, '15 (Пауза: 3 секунды сверху.)'),
    ('walking-lunge', 20, 14, null::int, 60, 4, '14 на каждую ногу'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('good-morning-s-rezinkoy', 40, 20, null::int, 60, 4, '20'),
    ('diagonal-kickback', 50, 20, null::int, 60, 4, '20 на каждую ногу'),
    ('fire-hydrant', 60, 30, null::int, 60, 3, '30 на каждую сторону'),
    ('posterior-chain-boss', 70, 4, null::int, 60, 1, '4 круга 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-98e0fe', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · LEVEL 10 — FINAL BOSS', 4, 'МЕСЯЦ 10 — LEVEL 10B — DENSITY SHOCK (НЕДЕЛИ 39–40)', 20, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 12, null::int, 60, 4, '12 (Dumbbell Thruster Squat Jump 4 × 10)'),
    ('block-2', 10, 12, null::int, 60, 4, '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 на сторону Если прыжки выполнять небезопасно:…)'),
    ('block-3', 20, 10, null::int, 60, 4, '10 (Renegade Row Push-Up 4 × максимум)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 45 секунд)'),
    ('amrap-20-minut', 40, null::int, null::int, 60, 1, 'Максимальное количество качественных кругов: 12 Sumo Squats 10 Reverse Lunges 8 Push-Ups…'),
    ('final-glute-boss', 50, 4, null::int, 60, 1, '4 круга 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('final-core-boss', 60, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('progressiya-level-10', 70, null::int, null::int, 60, 1, 'Пользователь фиксирует показатели каждую неделю.'),
    ('level-10-completed', 80, null::int, null::int, 60, 1, 'NEXT LEVEL')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'МЕСЯЦ 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (НЕДЕЛИ 41–42)', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('heavy-hip-thrust', 0, 8, null::int, 60, 5, '8–10 (Темп: 2 секунды вверх → 2 секунды удержание → 3 секунды вниз Последний подход: 8–10…)'),
    ('front-foot-elevated-bulgarian-split-squat-2', 10, 8, null::int, 60, 4, '8–10 на каждую ногу (Передняя нога на небольшом возвышении. Темп: 3 секунды вниз Последний подход: +5 пульсаций)'),
    ('dumbbell-sumo-deadlift', 20, 10, null::int, 60, 4, '10 (Пауза в нижней точке: 1 секунда)'),
    ('deficit-reverse-lunge', 30, 10, null::int, 60, 4, '10 на каждую ногу (Последние 3 повторения: медленно.)'),
    ('single-leg-hip-thrust', 40, 12, null::int, 60, 3, '12 на каждую ногу (Пауза сверху: 2 секунды)'),
    ('banded-abduction', 50, 25, null::int, 60, 4, '25 (Последний подход: 25 обычных 20 пульсаций 20 секунд статика.)'),
    ('banded-kickback', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('glute-power-finisher', 70, 3, null::int, 60, 1, '3 круга 12 Hip Thrust 15 Bulgarian Pulses 20 Frog Pumps 20 Abduction 30 секунд Glute…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-dead-bug-bicycle-b58c19', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY — STRENGTH', 2, 'МЕСЯЦ 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (НЕДЕЛИ 41–42)', 21, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-bench-press', 0, 8, null::int, 60, 4, '8–10 (Последний подход: +5 частичных повторений)'),
    ('one-arm-dumbbell-row', 10, 8, null::int, 60, 4, '8–10 на каждую руку (Пауза: 2 секунды в верхней точке)'),
    ('feet-elevated-push-up', 20, 8, null::int, 60, 4, '8–12 (Если слишком тяжело: обычные отжимания.)'),
    ('dumbbell-pullover', 30, 10, null::int, 60, 3, '10–12 (Темп: 3 секунды вниз)'),
    ('shoulders-superset', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Reverse Fly 15 Отдых: 60 секунд'),
    ('biceps-triceps', 50, null::int, null::int, 60, 1, 'Суперсет Dumbbell Curl 10–12 Overhead Triceps Extension 10–12 4 круга'),
    ('arm-boss', 60, null::int, null::int, 60, 1, 'Бицепс 10 обычных 10 молотковых 10 частичных Трицепс 15 разгибаний 15 пульсаций 20 секунд…'),
    ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-mountain-climbers-60-sek-631a04', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · HAMSTRING POWER', 3, 'МЕСЯЦ 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (НЕДЕЛИ 41–42)', 21, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-romanian-deadlift', 0, 8, null::int, 60, 5, '8–10 (Темп: 3 секунды вниз)'),
    ('b-stance-hip-thrust', 10, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('walking-lunges', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('sliding-hamstring-curl', 30, 8, null::int, 60, 4, '8–12'),
    ('single-leg-romanian-deadlift', 40, 10, null::int, 60, 3, '10 на каждую ногу'),
    ('diagonal-band-kickback', 50, 20, null::int, 60, 4, '20 на каждую ногу'),
    ('fire-hydrant', 60, 25, null::int, 60, 3, '25 на каждую сторону (Последние 10: короткая амплитуда.)'),
    ('hamstring-boss', 70, 4, null::int, 60, 1, '4 круга 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'),
    ('core-4-kruga-reverse-crunch-60-sek-bicycle-60-sek-dead-bug-60-sek-0a932f', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER', 4, 'МЕСЯЦ 11 — LEVEL 11A — PEAK STRENGTH HYPERTROPHY (НЕДЕЛИ 41–42)', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Dumbbell Thruster Squat Jump 4 × 8 Отдых: 90 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Romanian Deadlift Reverse Lunge + Knee Drive 4 × 10 на каждую ногу)'),
    ('block-3', 20, 8, null::int, 60, 4, '8 на каждую сторону (Renegade Row Push-Up 4 × максимум качественных повторений)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 40 секунд)'),
    ('emom-16-minut', 40, null::int, null::int, 60, 1, 'Каждую минуту начинается новое упражнение.'),
    ('final-glute-boss', 50, 4, null::int, 60, 1, '4 круга 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('core-boss', 60, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'МЕСЯЦ 11 — LEVEL 11B — MUSCLE SHOCK (НЕДЕЛИ 43–44)', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kas-glute-bridge', 0, 12, null::int, 60, 5, '12 (Пауза: 3 секунды сверху Последний подход: 12 10 пульсаций 20 секунд статика.)'),
    ('reverse-lunge-s-peredney-nogoy-na-vozvyshenii', 10, 10, null::int, 60, 4, '10 на каждую ногу (Последние 3 повторения: 1,5 повторения)'),
    ('heels-elevated-goblet-squat', 20, 12, null::int, 60, 4, '12 (Темп: 4 секунды вниз)'),
    ('curtsy-lunge', 30, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('frog-pump-s-gantelyu', 40, 25, null::int, 60, 4, '25'),
    ('banded-abduction', 50, 30, null::int, 60, 4, '30 (Последние 10: пульсации.)'),
    ('banded-kickback', 60, 20, null::int, 60, 4, '20'),
    ('glute-mechanical-drop-set', 70, 4, null::int, 60, 1, '4 круга 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-v-ups-bicycle-hollow-894227', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · CALISTHENICS UPPER BODY', 2, 'МЕСЯЦ 11 — LEVEL 11B — MUSCLE SHOCK (НЕДЕЛИ 43–44)', 22, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('archer-push-up', 0, 6, null::int, 60, 4, '6–8 на каждую сторону (Если тяжело: делать облегченный вариант.)'),
    ('one-arm-dumbbell-row', 10, 12, null::int, 60, 4, '12'),
    ('close-grip-push-up', 20, 8, null::int, 60, 4, '8–15'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 4, '12'),
    ('renegade-row', 40, 8, null::int, 60, 3, '8–10 на каждую сторону'),
    ('shoulders-giant-set-2', 50, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'),
    ('biceps-cluster-set', 60, 8, null::int, 60, 1, '8 повторений ↓ 20 секунд отдыха ↓ 4 повторения ↓ 20 секунд отдыха ↓ 4 повторения 3 раунда'),
    ('triceps-cluster-set', 70, 10, null::int, 60, 1, '10 повторений ↓ 20 секунд отдыха ↓ 5 повторений ↓ 20 секунд отдыха ↓ 5 повторений 3 раунда'),
    ('push-up-boss', 80, 3, null::int, 60, 1, '3 круга 10 Push-Ups 10 Knee Push-Ups 20 секунд удержание Отдых: 45 секунд.'),
    ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-mountain-climbers-60-d81a41', 90, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · POSTERIOR CHAIN SHOCK', 3, 'МЕСЯЦ 11 — LEVEL 11B — MUSCLE SHOCK (НЕДЕЛИ 43–44)', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 12, null::int, 60, 4, '12 на каждую сторону'),
    ('feet-elevated-glute-bridge', 10, 15, null::int, 60, 4, '15 (Пауза: 3 секунды сверху)'),
    ('curtsy-lunge', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('good-morning-s-rezinkoy', 40, 20, null::int, 60, 4, '20'),
    ('diagonal-kickback', 50, 20, null::int, 60, 4, '20 на каждую ногу'),
    ('fire-hydrant', 60, 30, null::int, 60, 3, '30 на каждую сторону'),
    ('posterior-chain-boss', 70, 4, null::int, 60, 1, '4 круга 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-98e0fe', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · LEVEL 11 — FINAL BOSS', 4, 'МЕСЯЦ 11 — LEVEL 11B — MUSCLE SHOCK (НЕДЕЛИ 43–44)', 22, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 12, null::int, 60, 4, '12 (Dumbbell Thruster Squat Jump 4 × 10)'),
    ('block-2', 10, 12, null::int, 60, 4, '12 (Dumbbell Sumo Deadlift Skater Jump 4 × 10 на каждую сторону Если прыжки не подходят:…)'),
    ('block-3', 20, 10, null::int, 60, 4, '10 (Renegade Row Push-Up 4 × максимум качественных повторений)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 45 секунд)'),
    ('amrap-20-minut', 40, null::int, null::int, 60, 1, 'Максимальное количество качественных кругов: 12 Goblet Squats 10 Reverse Lunges 8…'),
    ('final-glute-boss', 50, 4, null::int, 60, 1, '4 круга 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('final-core-boss', 60, 5, null::int, 60, 1, '5 кругов Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('level-11-progress', 70, null::int, null::int, 60, 1, 'Каждую неделю фиксируем: HIP THRUST / GLUTE BRIDGE Неделя 41: ____ кг Неделя 42: ____ кг…'),
    ('level-11-completed', 80, null::int, null::int, 60, 1, 'После этого пользователь переходит на:')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · FINAL GLUTE STRENGTH', 1, 'МЕСЯЦ 12 — FINAL BUILD (недели 45–46)', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('heavy-hip-thrust', 0, 8, null::int, 60, 5, '8 (Темп: 2 сек вверх → 2 сек удержание → 3 сек вниз Последний подход: 8 повторений ↓ снизить…)'),
    ('bulgarian-split-squat', 10, 8, null::int, 60, 4, '8–10 на каждую ногу (Темп: 3 секунды вниз Последний подход: +5 пульсаций)'),
    ('dumbbell-sumo-squat', 20, 10, null::int, 60, 4, '10–12 (Пауза: 2 секунды внизу)'),
    ('b-stance-romanian-deadlift', 30, 10, null::int, 60, 4, '10 на каждую сторону'),
    ('reverse-lunge', 40, 12, null::int, 60, 3, '12 на каждую ногу (Последние 3 повторения: медленная негативная фаза.)'),
    ('banded-abduction', 50, 25, null::int, 60, 4, '25 (Последний подход: 25 обычных 20 пульсаций 20 секунд статика.)'),
    ('banded-kickback', 60, 20, null::int, 60, 3, '20 на каждую ногу'),
    ('final-glute-set', 70, 3, null::int, 60, 1, '3 круга 12 Hip Thrust 15 Bulgarian Lunges 20 Frog Pumps 20 Abduction 30 секунд Glute…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-dead-bug-258fde', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · FINAL UPPER BODY', 2, 'МЕСЯЦ 12 — FINAL BUILD (недели 45–46)', 23, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-floor-press', 0, 8, null::int, 60, 4, '8–10 (Последний подход: +5 частичных повторений)'),
    ('one-arm-dumbbell-row', 10, 10, null::int, 60, 4, '10 на каждую руку (Пауза сверху: 2 секунды)'),
    ('feet-elevated-push-up', 20, 8, null::int, 60, 4, '8–12 (Если тяжело: обычные отжимания.)'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 3, '12 (Темп: 3 секунды вниз)'),
    ('shoulders-giant-set-2', 40, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'),
    ('biceps-triceps', 50, null::int, null::int, 60, 1, 'Суперсет Dumbbell Curl 12 Overhead Triceps Extension 12 4 круга'),
    ('arm-finisher', 60, null::int, null::int, 60, 1, 'Бицепс 10 обычных 10 молотковых 10 частичных Трицепс 15 разгибаний с резинкой 15…'),
    ('core-4-kruga-leg-raise-60-sek-v-ups-60-sek-mountain-climbers-60-sek-631a04', 70, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · FINAL POSTERIOR CHAIN', 3, 'МЕСЯЦ 12 — FINAL BUILD (недели 45–46)', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('dumbbell-romanian-deadlift', 0, 8, null::int, 60, 5, '8–10 (Темп: 4 секунды вниз)'),
    ('single-leg-hip-thrust', 10, 10, null::int, 60, 4, '10 на каждую ногу (Пауза: 3 секунды сверху)'),
    ('walking-lunge', 20, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('sliding-hamstring-curl', 30, 8, null::int, 60, 4, '8–12'),
    ('single-leg-good-morning', 40, 12, null::int, 60, 3, '12 на каждую ногу'),
    ('diagonal-band-kickback', 50, 20, null::int, 60, 4, '20 на каждую ногу'),
    ('fire-hydrant', 60, 30, null::int, 60, 3, '30 на каждую сторону (Последние 10: короткая амплитуда.)'),
    ('hamstring-boss', 70, 4, null::int, 60, 1, '4 круга 10 Sliding Hamstring Curl 15 Glute Bridge 15 Single-Leg Glute Bridge 20 Frog…'),
    ('core-4-kruga-kazhdoe-uprazhnenie-reverse-crunch-bicycle-dead-bug-40b6d3', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FINAL POWER DAY', 4, 'МЕСЯЦ 12 — FINAL BUILD (недели 45–46)', 23, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 10, null::int, 60, 4, '10 (Dumbbell Thruster Squat Jump 4 × 8 Отдых: 90 секунд.)'),
    ('block-2', 10, 10, null::int, 60, 4, '10 (Dumbbell Sumo Deadlift Reverse Lunge + Knee Drive 4 × 10 на каждую ногу)'),
    ('block-3', 20, 8, null::int, 60, 4, '8 на каждую сторону (Renegade Row Push-Up 4 × максимум качественных повторений)'),
    ('block-4', 30, 20, null::int, 60, 4, '20 (Dumbbell Swing Mountain Climbers 4 × 45 секунд)'),
    ('emom-20-minut', 40, null::int, null::int, 60, 1, 'Минута 1 10 Goblet Squats Минута 2 12 Dumbbell Swings Минута 3 8 Push-Ups Минута 4 10…'),
    ('final-glute-boss', 50, 4, null::int, 60, 1, '4 круга 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('core-boss', 60, 4, null::int, 60, 1, '4 круга Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('final-boss', 70, null::int, null::int, 60, 1, 'Теперь полностью меняем упражнения и характер нагрузки.')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · FINAL GLUTE SHOCK', 1, 'МЕСЯЦ 12 — FINAL BOSS (недели 47–48)', 24, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('kas-glute-bridge', 0, 12, null::int, 60, 5, '12 (Пауза сверху: 3 секунды Последний подход: 12 15 пульсаций 30 секунд статика.)'),
    ('front-foot-elevated-reverse-lunge-2', 10, 10, null::int, 60, 4, '10 на каждую ногу (Последние 3 повторения: 1,5 повторения)'),
    ('heels-elevated-goblet-squat', 20, 12, null::int, 60, 4, '12 (Темп: 4 секунды вниз)'),
    ('curtsy-lunge', 30, 12, null::int, 60, 4, '12 на каждую ногу'),
    ('frog-pump-s-vesom', 40, 25, null::int, 60, 4, '25'),
    ('standing-band-abduction', 50, 25, null::int, 60, 4, '25 на каждую ногу'),
    ('diagonal-kickback', 60, 25, null::int, 60, 3, '25 на каждую ногу'),
    ('final-glute-mechanical-drop-set', 70, 4, null::int, 60, 1, '4 круга 12 Reverse Lunges ↓ 15 Bodyweight Squats ↓ 20 Squat Pulses ↓ 20 Frog Pumps ↓ 30…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-reverse-crunch-v-ups-bicycle-hollow-894227', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · FINAL CALISTHENICS', 2, 'МЕСЯЦ 12 — FINAL BOSS (недели 47–48)', 24, 80)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('archer-push-up', 0, 6, null::int, 60, 4, '6–8 на каждую сторону (При необходимости: облегченный вариант.)'),
    ('renegade-row', 10, 8, null::int, 60, 4, '8–10 на каждую сторону'),
    ('close-grip-push-up', 20, 8, null::int, 60, 4, '8–15'),
    ('dumbbell-pullover', 30, 12, null::int, 60, 4, '12'),
    ('plank-dumbbell-row', 40, 10, null::int, 60, 3, '10 на каждую руку'),
    ('shoulders-giant-set-2', 50, 4, null::int, 60, 1, '4 круга Arnold Press 10 Lateral Raise 15 Front Raise 12 Reverse Fly 15 Lateral Hold 20…'),
    ('biceps-cluster', 60, 8, null::int, 60, 1, '8 повторений ↓ 20 секунд отдыха ↓ 4 повторения ↓ 20 секунд отдыха ↓ 4 повторения 3 раунда'),
    ('triceps-cluster', 70, 10, null::int, 60, 1, '10 повторений ↓ 20 секунд отдыха ↓ 5 повторений ↓ 20 секунд отдыха ↓ 5 повторений 3 раунда'),
    ('push-up-final-test', 80, 3, null::int, 60, 1, '3 раунда 10 Push-Ups 10 Knee Push-Ups 20 секунд удержание Отдых: 45 секунд.'),
    ('core-5-krugov-leg-raise-60-sek-bicycle-60-sek-mountain-climbers-60-d81a41', 90, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · FINAL HAMSTRING SHOCK', 3, 'МЕСЯЦ 12 — FINAL BOSS (недели 47–48)', 24, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('b-stance-romanian-deadlift', 0, 12, null::int, 60, 4, '12 на каждую сторону'),
    ('feet-elevated-glute-bridge', 10, 15, null::int, 60, 4, '15 (Пауза: 3 секунды сверху)'),
    ('walking-lunge', 20, 14, null::int, 60, 4, '14 на каждую ногу'),
    ('hamstring-walkout', 30, 10, null::int, 60, 4, '10'),
    ('good-morning-s-rezinkoy', 40, 20, null::int, 60, 4, '20'),
    ('fire-hydrant', 50, 25, null::int, 60, 4, '25 на каждую сторону'),
    ('frog-pump', 60, 30, null::int, 60, 3, '30'),
    ('posterior-chain-final-boss', 70, 4, null::int, 60, 1, '4 круга 10 Hamstring Walkouts 15 Single-Leg Glute Bridges 20 Frog Pumps 20 Abduction 30…'),
    ('core-5-krugov-kazhdoe-uprazhnenie-dead-bug-reverse-crunch-bicycle-98e0fe', 80, 4, null::int, 60, 1, '4 упражнения по 60 сек, отдых 15 сек между упр., 60 сек между кругами')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 FINAL BOSS — YEAR 1', 4, 'МЕСЯЦ 12 — FINAL BOSS (недели 47–48)', 24, 84)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1', 0, 12, null::int, 60, 3, '12 (Dumbbell Thruster Squat Jump 3 × 10)'),
    ('block-2', 10, 15, null::int, 60, 3, '15 (Dumbbell Sumo Deadlift Skater Jump 3 × 10 на каждую сторону Если прыжки не подходят:…)'),
    ('block-3', 20, 10, null::int, 60, 3, '10 на каждую сторону (Renegade Row Push-Up 3 × максимум качественных повторений)'),
    ('block-4', 30, 25, null::int, 60, 3, '25 (Dumbbell Swing Mountain Climbers 3 × 60 секунд)'),
    ('amrap-20-minut', 40, null::int, null::int, 60, 1, 'Выполнить максимальное количество качественных кругов: 10 Goblet Squats 10 Reverse Lunges…'),
    ('final-glute-boss-2', 50, 5, null::int, 60, 1, '5 КРУГОВ 20 Frog Pumps 20 Abduction 15 Glute Bridge 15 Squat Pulses 30 секунд статика…'),
    ('final-core-boss-2', 60, 5, null::int, 60, 1, '5 КРУГОВ Каждое упражнение: 60 секунд V-Ups Bicycle Mountain Climbers Hollow Hold Отдых:…'),
    ('final-level-itogovyy-test', 70, null::int, null::int, 60, 1, 'В конце 48-й недели пользователь сравнивает показатели с первым месяцем.'),
    ('vynoslivost', 80, null::int, null::int, 60, 1, 'Push-Ups Месяц 1: ____ Месяц 12: ____ AMRAP 20 MIN Месяц 1: ____ кругов Месяц 12: ____…'),
    ('kontrol', 90, null::int, null::int, 60, 1, 'Сравнить: вес; объем бедер; объем ягодиц; объем талии; фото спереди; фото сбоку; фото…'),
    ('donatellox-year-1-completed', 100, null::int, null::int, 60, 1, 'Ты прошла:')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
