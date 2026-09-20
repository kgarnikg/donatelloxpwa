-- 0014_seed_pohudenie_zhenshchiny_doma.sql
-- Программа: Похудение — Женщины — Дома
-- Часть Фазы 2 (Контент) — заливка годовых программ тренировок.
-- Одна из 8 миграций (0014), по одной на каждую комбинацию
-- пол × цель × формат — см. 0014..0021 и журнал в PROJECT_PLAN.md.
--
-- 94 тренировок, 497 уникальных упражнений (в этой программе).
-- Диапазоны/текстовые обозначения повторений ("10–12", "AMRAP 12 мин", "макс.")
-- сохранены полностью в notes; в reps/duration_seconds — число, где формат позволяет
-- (тот же подход, что в 0002/0003 для суперсетов).
--
-- gender/training_format — из 0012, week_label/week_order — из 0013.
-- Безопасно выполнять повторно: upsert по slug, workouts программы пересоздаются.

-- =====================================================================
-- УПРАЖНЕНИЯ (Похудение — Женщины — Дома)
-- =====================================================================
insert into public.exercises (slug, title) values
  ('razminka-2-30-sek-hodba-na-meste-30-sek-shagi-v-storony-30-sek-podem-ff336f', 'Разминка ×2: 30 сек ходьба на месте, 30 сек шаги в стороны, 30 сек подъём коленей, 30 сек приседания без веса, 30 сек вращения руками'),
  ('osnovnoy-krug-4-prisedanie-15-vypad-nazad-12-na-nogu-yagodichnyy-most-9fd93e', 'Основной круг ×4: Приседание 15 + Выпад назад 12 на ногу + Ягодичный мост 20 (пауза 1 сек) + Подъём на платформу 12 на ногу (или выпады назад) + Разведение ног с резинкой 20 + Наклоны с гантелями/Good Morning 15'),
  ('glute-finisher-3-30-sek-prisedaniya-s-korotkoy-amplitudoy-30-sek-a03001', 'Glute Finisher ×3: 30 сек приседания с короткой амплитудой, 30 сек ягодичный мост, 30 сек шаги с высоким коленом, 30 сек отдых'),
  ('kardio-10-min-40-sek-rabota-20-sek-otdyh-2-bystraya-hodba-na-meste-b762bc', 'Кардио 10 мин (40 сек работа/20 сек отдых) ×2: Быстрая ходьба на месте, Step Touch, Подъём коленей, Шаг назад+колено, Джампинг-джек без прыжка'),
  ('press-3-kruga-po-60-sek-dead-bug-bicycle-reverse-crunch-planka-otdyh-32e8f1', 'Пресс ×3 круга по 60 сек: Dead Bug, Bicycle, Reverse Crunch, Планка, отдых 60 сек'),
  ('razminka', 'Разминка'),
  ('osnovnoy-krug-4-otzhimaniya-ot-vozvysheniya-12-15-tyaga-rezinki-k-79704b', 'Основной круг ×4: Отжимания от возвышения 12–15 + Тяга резинки к животу 15 + Жим гантелей вверх 12 + Face Pull с резинкой 15 + Разведение гантелей в стороны 12–15 + Сгибание рук с гантелями 15 + Разгибание рук с резинкой 15'),
  ('cardio-circuit-4-40-sek-high-knees-40-sek-step-touch-40-sek-mountain-8cd129', 'Cardio Circuit ×4: 40 сек High Knees, 40 сек Step Touch, 40 сек Mountain Climbers с опорой, 40 сек Jumping Jacks, 40 сек удары руками+шаги, отдых 60 сек'),
  ('press-3-kruga-po-60-sek-podem-sognutyh-nog-bicycle-toe-touch-planka-4fdba2', 'Пресс ×3 круга по 60 сек: Подъём согнутых ног, Bicycle, Toe Touch, Планка, отдых 60 сек'),
  ('krug-4-goblet-squat-15-ili-obychnyy-prised-rumynskaya-tyaga-s-5b1795', 'Круг ×4: Goblet Squat 15 (или обычный присед) + Румынская тяга с гантелями 15 + Отжимания от возвышения 12 + Тяга гантели одной рукой 12 на руку + Выпад назад 10 на ногу + Жим гантелей вверх 12'),
  ('cardio-block-4-30-sek-squat-knee-drive-30-sek-mountain-climbers-30-65cd7b', 'Cardio Block ×4: 30 сек Squat+Knee Drive, 30 сек Mountain Climbers, 30 сек Fast Feet, 30 сек шаг назад+колено, 30 сек удары руками, отдых 60 сек'),
  ('finisher-5-min-30-30-high-knees-squat-mountain-climbers-jumping-jack-1887bd', 'Finisher 5 мин (30/30): High Knees, Squat, Mountain Climbers, Jumping Jack, Fast March'),
  ('press-3-kruga-po-60-sek-reverse-crunch-bicycle-leg-raise-planka-otdyh-7e0937', 'Пресс ×3 круга по 60 сек: Reverse Crunch, Bicycle, Leg Raise, Планка, отдых 60 сек'),
  ('krug-4-sumo-squat-15-posl-5-pulsatsii-bulgarian-split-squat-10-na-bf9070', 'Круг ×4: Sumo Squat 15 (посл.5 — пульсации) + Bulgarian Split Squat 10 на ногу + Single-Leg Glute Bridge 12 на ногу + Lateral Lunge 12 на ногу + Banded Kickback 15 на ногу + Wall Sit 40 сек'),
  ('glute-finisher-4-20-squat-pulses-20-glute-bridge-20-abduction-30-sek-446efe', 'Glute Finisher ×4: 20 Squat Pulses, 20 Glute Bridge, 20 Abduction, 30 сек Wall Sit, отдых 45 сек'),
  ('kardio-12-min-3-30-30-high-knees-mountain-climbers-fast-feet-step-33cc38', 'Кардио 12 мин ×3 (30/30): High Knees, Mountain Climbers, Fast Feet, Step Touch'),
  ('press-4-kruga-po-60-sek-dead-bug-reverse-crunch-bicycle-planka-otdyh-5d6295', 'Пресс ×4 круга по 60 сек: Dead Bug, Reverse Crunch, Bicycle, Планка, отдых 60 сек'),
  ('krug-4-obychnye-otzhimaniya-8-15-s-kolen-esli-tyazhelo-tyaga-ganteli-7505b1', 'Круг ×4: Обычные отжимания 8–15 (с колен если тяжело) + Тяга гантели одной рукой 12 на руку + Arnold Press 12 + Face Pull с резинкой 15 + Lateral Raise 15 + Hammer Curl 12 + Overhead Triceps Extension 15'),
  ('emom-12-min-4-min-1-10-otzhimaniy-min-2-15-tyag-rezinki-min-3-30-sek-a6939a', 'EMOM 12 мин ×4: мин.1 — 10 отжиманий, мин.2 — 15 тяг резинки, мин.3 — 30 сек Mountain Climbers'),
  ('press-4-kruga-po-60-sek-leg-raise-bicycle-toe-touch-plank-otdyh-60-sek', 'Пресс ×4 круга по 60 сек: Leg Raise, Bicycle, Toe Touch, Plank, отдых 60 сек'),
  ('5-krugov-dumbbell-thruster-12-reverse-lunge-knee-drive-10-na-nogu-35d180', '5 кругов: Dumbbell Thruster 12 + Reverse Lunge+Knee Drive 10 на ногу + Dumbbell Row 12 на руку + Push-Up 10–15 + Dumbbell Romanian Deadlift 15 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('final-6-6-min-40-20-squat-high-knees-push-up-mountain-climbers-4d92d4', 'Final 6 — 6 мин (40/20): Squat, High Knees, Push-Up, Mountain Climbers, Reverse Lunge, Fast Feet'),
  ('press-4-kruga-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-hold-a16aa8', 'Пресс ×4 круга по 60 сек: V-Ups, Bicycle, Reverse Crunch, Hollow Hold, отдых 60 сек'),
  ('level-1-final-challenge-amrap-10-min-10-squats-8-reverse-lunges-8-ccf0fb', '🏆 LEVEL 1 FINAL CHALLENGE — AMRAP 10 мин: 10 Squats, 8 Reverse Lunges, 8 Push-Ups, 10 Dumbbell Rows, 15 Mountain Climbers. Записать количество кругов'),
  ('razminka-2-30-sek-marsh-prised-shagi-v-storonu-podem-koleney-a63bd1', 'Разминка ×2: 30 сек марш, присед, шаги в сторону, подъём коленей, ягодичный мост, лёгкие выпады'),
  ('osnovnoy-blok-4-goblet-squat-15-posl-5-medlenno-bulgarian-split-squat-f97058', 'Основной блок ×4: Goblet Squat 15 (посл.5 медленно) + Bulgarian Split Squat 10 на ногу + Hip Thrust с гантелью 15 (пауза 2 сек) + Romanian Deadlift 12 + Lateral Lunge 12 на ногу + Banded Abduction 25'),
  ('glute-superset-3-banded-kickback-15-na-nogu-frog-pumps-25-otdyh-45-sek', 'Glute Superset ×3: Banded Kickback 15 на ногу + Frog Pumps 25, отдых 45 сек'),
  ('leg-finisher-3-30-sek-squat-pulses-30-sek-reverse-lunge-30-sek-wall-157979', 'Leg Finisher ×3: 30 сек Squat Pulses, 30 сек Reverse Lunge, 30 сек Wall Sit, 30 сек отдых'),
  ('kardio-12-min-3-40-20-high-knees-mountain-climbers-fast-feet-jumping-d68794', 'Кардио 12 мин ×3 (40/20): High Knees, Mountain Climbers, Fast Feet, Jumping Jacks'),
  ('core-4-kruga-po-60-sek-reverse-crunch-dead-bug-bicycle-plank-otdyh-60-865fec', 'Core ×4 круга по 60 сек: Reverse Crunch, Dead Bug, Bicycle, Plank, отдых 60 сек'),
  ('krug-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-arnold-press-12-729118', 'Круг ×4: Push-Up 10–15 + One-Arm Dumbbell Row 12 на руку + Arnold Press 12 + Band Face Pull 15 + Lateral Raise 15 + Hammer Curl 12 + Overhead Triceps Extension 15'),
  ('superset-shoulders-3-lateral-raise-15-reverse-fly-15-uderzhanie-ruk-v-d8bf39', 'Superset Shoulders ×3: Lateral Raise 15 + Reverse Fly 15 + удержание рук в стороны 20 сек, отдых 60 сек'),
  ('emom-12-min-4-min-1-10-push-ups-min-2-15-band-rows-min-3-40-sek-f84761', 'EMOM 12 мин ×4: мин.1 — 10 Push-Ups, мин.2 — 15 Band Rows, мин.3 — 40 сек Mountain Climbers'),
  ('core-4-kruga-po-60-sek-leg-raise-bicycle-toe-touch-hollow-hold-otdyh-717fad', 'Core ×4 круга по 60 сек: Leg Raise, Bicycle, Toe Touch, Hollow Hold, отдых 60 сек'),
  ('block-1-4-reverse-lunge-12-na-nogu-squat-15-calf-raise-20', 'Block 1 ×4: Reverse Lunge 12 на ногу + Squat 15 + Calf Raise 20'),
  ('block-2-4-romanian-deadlift-15-glute-bridge-20-banded-abduction-25', 'Block 2 ×4: Romanian Deadlift 15 + Glute Bridge 20 + Banded Abduction 25'),
  ('block-3-3-step-up-12-na-nogu-knee-drive-12-na-nogu', 'Block 3 ×3: Step-Up 12 на ногу + Knee Drive 12 на ногу'),
  ('metabolic-finisher-5-30-sek-squat-30-sek-high-knees-30-sek-reverse-400cf4', 'Metabolic Finisher ×5: 30 сек Squat, 30 сек High Knees, 30 сек Reverse Lunge, 30 сек Mountain Climbers, 30 сек отдых'),
  ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-60-c2833e', 'Core ×4 круга по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Plank, отдых 60 сек'),
  ('circuit-5-dumbbell-thruster-12-dumbbell-row-10-na-ruku-reverse-lunge-c9b796', 'Circuit ×5: Dumbbell Thruster 12 + Dumbbell Row 10 на руку + Reverse Lunge+Knee Drive 10 на ногу + Push-Up 10 + Romanian Deadlift 12 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-4878d9', 'EMOM 15 мин ×3: мин.1 — 12 Goblet Squats, мин.2 — 10 Push-Ups, мин.3 — 12 Dumbbell Rows, мин.4 — 30 сек High Knees, мин.5 — 30 сек Plank'),
  ('final-burn-4-min-20-20-squat-mountain-climbers-fast-feet-otdyh', 'Final Burn 4 мин (20/20): Squat, Mountain Climbers, Fast Feet, отдых'),
  ('core-4-kruga-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-hold-otdyh-a922d0', 'Core ×4 круга по 60 сек: V-Ups, Bicycle, Reverse Crunch, Hollow Hold, отдых 60 сек'),
  ('krug-4-sumo-squat-12-temp-3-sek-vniz-single-leg-hip-thrust-12-na-nogu-aac2d9', 'Круг ×4: Sumo Squat 12 (темп 3 сек вниз) + Single-Leg Hip Thrust 12 на ногу + Front-Foot Elevated Reverse Lunge 10 на ногу + B-Stance Romanian Deadlift 12 на ногу + Curtsy Lunge 12 на ногу + Banded Abduction 30'),
  ('glute-mechanical-drop-set-3-12-bulgarian-split-squats-15-reverse-b5f90b', 'Glute Mechanical Drop Set ×3: 12 Bulgarian Split Squats → 15 Reverse Lunges → 20 Bodyweight Squats → 20 Squat Pulses, отдых 60 сек'),
  ('static-finisher-3-wall-sit-45-sek-glute-bridge-hold-45-sek-otdyh-30-249a9d', 'Static Finisher ×3: Wall Sit 45 сек, Glute Bridge Hold 45 сек, отдых 30 сек'),
  ('kardio-14-min-30-30-high-knees-skater-step-mountain-climbers-fast-a8f0cd', 'Кардио 14 мин (30/30): High Knees, Skater Step, Mountain Climbers, Fast Feet, Jumping Jacks, March'),
  ('superset-1-4-push-up-10-15-one-arm-row-12-na-ruku', 'Superset 1 ×4: Push-Up 10–15 + One-Arm Row 12 на руку'),
  ('superset-2-4-arnold-press-10-lateral-raise-15', 'Superset 2 ×4: Arnold Press 10 + Lateral Raise 15'),
  ('superset-3-3-hammer-curl-12-triceps-kickback-15', 'Superset 3 ×3: Hammer Curl 12 + Triceps Kickback 15'),
  ('superset-4-3-band-face-pull-20-reverse-fly-15', 'Superset 4 ×3: Band Face Pull 20 + Reverse Fly 15'),
  ('calisthenics-finisher-4-8-push-ups-10-mountain-climbers-na-storonu-20-28859b', 'Calisthenics Finisher ×4: 8 Push-Ups, 10 Mountain Climbers на сторону, 20 сек Plank Shoulder Taps, 20 сек Fast Feet, отдых 45 сек'),
  ('emom-12-min-4-min-1-10-push-ups-min-2-15-band-rows-min-3-40-sek-b33109', 'EMOM 12 мин ×4: мин.1 — 10 Push-Ups, мин.2 — 15 Band Rows, мин.3 — 40 сек Shadow Boxing'),
  ('core-4-kruga-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-d5cc18', 'Core ×4 круга по 60 сек: Leg Raise, V-Ups, Bicycle, Hollow Hold, отдых 60 сек'),
  ('block-1-4-goblet-squat-12-reverse-lunge-10-na-nogu-squat-pulse-20', 'Block 1 ×4: Goblet Squat 12 + Reverse Lunge 10 на ногу + Squat Pulse 20'),
  ('block-2-4-romanian-deadlift-12-single-leg-glute-bridge-12-na-nogu-93df67', 'Block 2 ×4: Romanian Deadlift 12 + Single-Leg Glute Bridge 12 на ногу + Banded Kickback 20 на ногу'),
  ('block-3-3-lateral-lunge-12-na-nogu-step-up-12-na-nogu', 'Block 3 ×3: Lateral Lunge 12 на ногу + Step-Up 12 на ногу'),
  ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-reverse-lunges-na-nogu-f12804', 'EMOM 15 мин ×3: мин.1 — 12 Goblet Squats, мин.2 — 10 Reverse Lunges на ногу, мин.3 — 15 Glute Bridges, мин.4 — 40 сек High Knees, мин.5 — 40 сек Mountain Climbers'),
  ('finisher-5-min-20-sek-kazhdoe-squat-pulses-high-knees-glute-bridge-5e842b', 'Finisher 5 мин (20 сек каждое): Squat Pulses, High Knees, Glute Bridge, Mountain Climbers, отдых'),
  ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-v-ups-plank-otdyh-60-sek', 'Core ×4 круга по 60 сек: Reverse Crunch, Bicycle, V-Ups, Plank, отдых 60 сек'),
  ('block-1-strength-4-goblet-squat-12-push-up-10-romanian-deadlift-12-d540ee', 'Block 1 — Strength ×4: Goblet Squat 12 + Push-Up 10 + Romanian Deadlift 12 + One-Arm Row 10 на руку, отдых 60 сек'),
  ('block-2-power-4-squat-to-knee-drive-12-na-nogu-dumbbell-thruster-10-ad44f9', 'Block 2 — Power ×4: Squat to Knee Drive 12 на ногу + Dumbbell Thruster 10 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('block-3-glutes-3-15-hip-thrust-15-reverse-lunges-20-abduction-30-sek-92f22a', 'Block 3 — Glutes ×3: 15 Hip Thrust, 15 Reverse Lunges, 20 Abduction, 30 сек Glute Bridge Hold'),
  ('final-amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-62f7f0', '🔥 FINAL AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Mountain Climbers, 20 Glute Bridges. Записать количество кругов'),
  ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-6e41c0', 'Final Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Hollow Hold, отдых 60 сек'),
  ('razminka-7-min-marsh-s-vysokim-kolenom-prised-shagi-v-storonu-dc6987', 'Разминка 7 мин: марш с высоким коленом, присед, шаги в сторону, ягодичный мост, обратные выпады, лёгкие jumping jacks'),
  ('block-1-4-dumbbell-front-squat-12-reverse-lunge-knee-drive-10-na-nogu-9a8c76', 'Block 1 ×4: Dumbbell Front Squat 12 + Reverse Lunge+Knee Drive 10 на ногу + Hip Thrust с весом 15 (пауза 2 сек) + Single-Leg Romanian Deadlift 10 на ногу + Banded Abduction 25, отдых 60 сек'),
  ('block-2-glute-superset-3-curtsy-lunge-12-na-nogu-frog-pumps-25-glute-562651', 'Block 2 — Glute Superset ×3: Curtsy Lunge 12 на ногу + Frog Pumps 25 + Glute Bridge Hold 30 сек, отдых 60 сек'),
  ('leg-burn-3-20-squat-pulses-10-reverse-lunges-na-nogu-30-sek-wall-sit-89fd1f', 'Leg Burn ×3: 20 Squat Pulses, 10 Reverse Lunges на ногу, 30 сек Wall Sit, 20 сек отдых'),
  ('cardio-interval-15-min-3-30-30-high-knees-skater-mountain-climbers-9a913f', 'Cardio Interval 15 мин ×3 (30/30): High Knees, Skater, Mountain Climbers, Fast Feet, Jumping Jacks'),
  ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-shoulder-adaa15', 'Core ×4 круга по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Plank Shoulder Taps, отдых 60 сек'),
  ('superset-1-4-push-up-12-15-one-arm-dumbbell-row-12-na-ruku', 'Superset 1 ×4: Push-Up 12–15 + One-Arm Dumbbell Row 12 на руку'),
  ('superset-2-4-arnold-press-12-lateral-raise-15', 'Superset 2 ×4: Arnold Press 12 + Lateral Raise 15'),
  ('superset-3-4-hammer-curl-12-overhead-triceps-extension-15', 'Superset 3 ×4: Hammer Curl 12 + Overhead Triceps Extension 15'),
  ('superset-4-4-band-face-pull-20-reverse-fly-15', 'Superset 4 ×4: Band Face Pull 20 + Reverse Fly 15'),
  ('calisthenics-block-4-8-12-push-ups-10-plank-shoulder-taps-na-storonu-ddfeaf', 'Calisthenics Block ×4: 8–12 Push-Ups + 10 Plank Shoulder Taps на сторону + 10 Bear Crawl вперёд + 10 назад + 20 сек Hollow Hold, отдых 60 сек'),
  ('emom-15-min-3-min-1-12-push-ups-min-2-15-band-rows-min-3-40-sek-2750c8', 'EMOM 15 мин ×3: мин.1 — 12 Push-Ups, мин.2 — 15 Band Rows, мин.3 — 40 сек Shadow Boxing, мин.4 — 12 Dumbbell Thrusters, мин.5 — 40 сек Mountain Climbers'),
  ('block-1-4-sumo-squat-15-posl-5-medlenno-walking-lunges-12-na-nogu-01e097', 'Block 1 ×4: Sumo Squat 15 (посл.5 медленно) + Walking Lunges 12 на ногу + Calf Raise 25'),
  ('block-2-4-staggered-romanian-deadlift-12-na-nogu-single-leg-glute-00f57b', 'Block 2 ×4: Staggered Romanian Deadlift 12 на ногу + Single-Leg Glute Bridge 15 на ногу + Banded Kickback 20 на ногу'),
  ('block-3-3-step-up-12-na-nogu-step-up-knee-drive-10-na-nogu', 'Block 3 ×3: Step-Up 12 на ногу + Step-Up Knee Drive 10 на ногу'),
  ('metabolic-circuit-5-30-sek-kazhdoe-squat-high-knees-mountain-climbers-da4ede', 'Metabolic Circuit ×5 (30 сек каждое): Squat, High Knees, Mountain Climbers, Reverse Lunges, отдых'),
  ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-plank-dead-bug-otdyh-60-48081e', 'Core ×4 круга по 60 сек: Reverse Crunch, Bicycle, Plank, Dead Bug, отдых 60 сек'),
  ('circuit-5-dumbbell-thruster-12-reverse-lunge-10-na-nogu-one-arm-row-9758cf', 'Circuit ×5: Dumbbell Thruster 12 + Reverse Lunge 10 на ногу + One-Arm Row 10 на руку + Push-Up 10–12 + Romanian Deadlift 12 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-11ef68', 'EMOM 15 мин ×3: мин.1 — 12 Goblet Squats, мин.2 — 10 Push-Ups, мин.3 — 12 Dumbbell Rows, мин.4 — 10 Reverse Lunges на ногу, мин.5 — 40 сек High Knees'),
  ('finisher-6-min-20-20-fast-feet-squat-pulses-mountain-climbers-jumping-92a711', 'Finisher 6 мин (20/20): Fast Feet, Squat Pulses, Mountain Climbers, Jumping Jacks, отдых'),
  ('core-4-kruga-po-60-sek-v-ups-reverse-crunch-bicycle-plank-otdyh-60-sek', 'Core ×4 круга по 60 сек: V-Ups, Reverse Crunch, Bicycle, Plank, отдых 60 сек'),
  ('block-1-4-sumo-squat-15-curtsy-lunge-12-na-nogu-hip-thrust-20-banded-ef6693', 'Block 1 ×4: Sumo Squat 15 + Curtsy Lunge 12 на ногу + Hip Thrust 20 + Banded Abduction 30, отдых 60 сек'),
  ('block-2-4-bulgarian-split-squat-10-na-nogu-romanian-deadlift-12-frog-03f3a6', 'Block 2 ×4: Bulgarian Split Squat 10 на ногу + Romanian Deadlift 12 + Frog Pumps 25'),
  ('glute-drop-set-3-10-bulgarian-split-squats-12-reverse-lunges-15-31f24f', 'Glute Drop Set ×3: 10 Bulgarian Split Squats → 12 Reverse Lunges → 15 Bodyweight Squats → 20 Squat Pulses → 20 сек Wall Sit, отдых 60 сек'),
  ('power-finisher-5-20-sek-kazhdoe-squat-jump-ili-bystryy-prised-bez-421957', 'Power Finisher ×5 (20 сек каждое): Squat Jump (или быстрый присед без прыжка), High Knees, Mountain Climbers, отдых'),
  ('core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-shoulder-ac0641', 'Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank Shoulder Taps, отдых 60 сек'),
  ('superset-1-3-incline-push-up-15-dumbbell-row-15-na-ruku', 'Superset 1 ×3: Incline Push-Up 15 + Dumbbell Row 15 на руку'),
  ('superset-2-3-dumbbell-shoulder-press-12-bent-over-reverse-fly-15', 'Superset 2 ×3: Dumbbell Shoulder Press 12 + Bent-Over Reverse Fly 15'),
  ('superset-3-3-alternating-biceps-curl-12-na-ruku-triceps-kickback-15', 'Superset 3 ×3: Alternating Biceps Curl 12 на руку + Triceps Kickback 15'),
  ('superset-4-3-band-pull-apart-20-band-face-pull-20', 'Superset 4 ×3: Band Pull-Apart 20 + Band Face Pull 20'),
  ('calisthenics-challenge-4-10-push-ups-10-bear-crawl-steps-20-plank-3ce486', 'Calisthenics Challenge ×4: 10 Push-Ups, 10 Bear Crawl Steps, 20 Plank Shoulder Taps, 10 Burpees (без прыжка проще), 20 сек Hollow Hold, отдых 60 сек'),
  ('emom-16-min-4-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-8fd629', 'EMOM 16 мин ×4: мин.1 — 12 Push-Ups, мин.2 — 15 Dumbbell Rows, мин.3 — 12 Shoulder Press, мин.4 — 40 сек Shadow Boxing'),
  ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-hollow-hold-otdyh-60-afe180', 'Core ×5 кругов по 60 сек: Leg Raise, Bicycle, V-Ups, Hollow Hold, отдых 60 сек'),
  ('circuit-1-4-front-rack-squat-12-walking-lunge-12-na-nogu-single-leg-9c5070', 'Circuit 1 ×4: Front Rack Squat 12 + Walking Lunge 12 на ногу + Single-Leg Romanian Deadlift 10 на ногу + Calf Raise 25'),
  ('circuit-2-4-hip-thrust-15-frog-pumps-30-banded-kickback-20-na-nogu-8616f0', 'Circuit 2 ×4: Hip Thrust 15 + Frog Pumps 30 + Banded Kickback 20 на ногу + Banded Abduction 30'),
  ('emom-15-min-3-min-1-15-goblet-squats-min-2-12-reverse-lunges-na-nogu-0485bb', 'EMOM 15 мин ×3: мин.1 — 15 Goblet Squats, мин.2 — 12 Reverse Lunges на ногу, мин.3 — 20 Glute Bridges, мин.4 — 40 сек High Knees, мин.5 — 40 сек Mountain Climbers'),
  ('metabolic-finisher-6-min-2-30-sek-kazhdoe-squat-mountain-climbers-87312e', 'Metabolic Finisher 6 мин ×2 (30 сек каждое): Squat, Mountain Climbers, Reverse Lunge, Fast Feet, Glute Bridge, отдых'),
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-plank-dead-bug-otdyh-1ca84b', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Plank, Dead Bug, отдых 60 сек'),
  ('block-1-full-body-5-goblet-squat-12-push-up-10-romanian-deadlift-12-592202', 'Block 1 — Full Body ×5: Goblet Squat 12 + Push-Up 10 + Romanian Deadlift 12 + One-Arm Row 10 на руку + Reverse Lunge 10 на ногу + Mountain Climbers 40 сек, отдых 60 сек'),
  ('block-2-power-4-dumbbell-thruster-12-squat-to-knee-drive-10-na-nogu-118e96', 'Block 2 — Power ×4: Dumbbell Thruster 12 + Squat to Knee Drive 10 на ногу + Bear Crawl 20 шагов + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-735f25', '🔥 AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 10 Dumbbell Thrusters, 20 Mountain Climbers, 15 Glute Bridges. Записать: полных кругов + доп. повторений'),
  ('final-burn-5-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-4ebd3c', 'Final Burn 5 мин (20 сек каждое): High Knees, Squat Pulses, Mountain Climbers, Jumping Jacks, отдых'),
  ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-7be596', '🧨 Final Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank Shoulder Taps, отдых 60 сек'),
  ('razminka-7-min-marsh-s-vysokim-kolenom-bodyweight-squat-lateral-step-a5c291', 'Разминка 7 мин: марш с высоким коленом, bodyweight squat, lateral step, glute bridge, reverse lunge, jumping jack, лёгкий бег на месте'),
  ('block-1-4-dumbbell-sumo-squat-12-temp-3-sek-vniz-front-foot-elevated-eedb53', 'Block 1 ×4: Dumbbell Sumo Squat 12 (темп 3 сек вниз) + Front-Foot Elevated Reverse Lunge 10 на ногу + Dumbbell Hip Thrust 15 (пауза 3 сек) + B-Stance Romanian Deadlift 12 на ногу + Banded Abduction 30, отдых 60 сек'),
  ('block-2-unilateral-glute-3-single-leg-glute-bridge-15-na-nogu-curtsy-2f14db', 'Block 2 — Unilateral Glute ×3: Single-Leg Glute Bridge 15 на ногу + Curtsy Lunge 12 на ногу + Banded Kickback 20 на ногу + Glute Bridge Hold 30 сек, отдых 60 сек'),
  ('leg-finisher-4-20-squat-pulses-10-reverse-lunges-na-nogu-30-sek-wall-310d28', 'Leg Finisher ×4: 20 Squat Pulses, 10 Reverse Lunges на ногу, 30 сек Wall Sit, 20 сек отдых'),
  ('kardio-16-min-2-30-sek-rabota-30-sek-otdyh-high-knees-skater-mountain-cc8e54', 'Кардио 16 мин ×2 (30 сек работа/30 сек отдых): High Knees, Skater, Mountain Climbers, Fast Feet'),
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-e802fa', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Plank Shoulder Taps, отдых 60 сек'),
  ('superset-2-4-dumbbell-shoulder-press-12-lateral-raise-15', 'Superset 2 ×4: Dumbbell Shoulder Press 12 + Lateral Raise 15'),
  ('superset-3-4-alternating-biceps-curl-12-na-ruku-triceps-kickback-15', 'Superset 3 ×4: Alternating Biceps Curl 12 на руку + Triceps Kickback 15'),
  ('superset-4-4-band-face-pull-20-bent-over-reverse-fly-15', 'Superset 4 ×4: Band Face Pull 20 + Bent-Over Reverse Fly 15'),
  ('calisthenics-block-4-10-push-ups-10-bear-crawl-vpered-10-nazad-20-346b7c', 'Calisthenics Block ×4: 10 Push-Ups + 10 Bear Crawl вперёд + 10 назад + 20 Plank Shoulder Taps + 30 сек Hollow Hold, отдых 60 сек'),
  ('cardio-finisher-6-min-20-sek-kazhdoe-fast-feet-mountain-climbers-241428', 'Cardio Finisher 6 мин (20 сек каждое): Fast Feet, Mountain Climbers, Shadow Boxing, Jumping Jacks, отдых'),
  ('core-5-krugov-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-e5fac3', 'Core ×5 кругов по 60 сек: Leg Raise, V-Ups, Bicycle, Hollow Hold, отдых 60 сек'),
  ('block-1-4-dumbbell-front-squat-12-walking-lunge-12-na-nogu-single-leg-60cc6a', 'Block 1 ×4: Dumbbell Front Squat 12 + Walking Lunge 12 на ногу + Single-Leg Romanian Deadlift 10 на ногу + Calf Raise 25, отдых 60 сек'),
  ('block-2-4-dumbbell-romanian-deadlift-15-hip-thrust-15-frog-pumps-30-83cae0', 'Block 2 ×4: Dumbbell Romanian Deadlift 15 + Hip Thrust 15 + Frog Pumps 30 + Banded Abduction 30'),
  ('static-challenge-3-wall-sit-45-sek-glute-bridge-hold-45-sek-squat-c14ac9', 'Static Challenge ×3: Wall Sit 45 сек + Glute Bridge Hold 45 сек + Squat Hold 30 сек, отдых 60 сек'),
  ('metabolic-block-5-30-sek-kazhdoe-high-knees-reverse-lunges-mountain-9d1923', 'Metabolic Block ×5 (30 сек каждое): High Knees, Reverse Lunges, Mountain Climbers, Squat, отдых'),
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-389d9d', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Plank, отдых 60 сек'),
  ('circuit-5-dumbbell-thruster-12-reverse-lunge-knee-drive-10-na-nogu-54082d', 'Circuit ×5: Dumbbell Thruster 12 + Reverse Lunge+Knee Drive 10 на ногу + One-Arm Dumbbell Row 10 на руку + Push-Up 10–12 + Romanian Deadlift 12 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('amrap-8-min-10-squats-8-push-ups-10-reverse-lunges-10-dumbbell-rows-e934e7', 'AMRAP 8 мин: 10 Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Mountain Climbers. Записать кругов'),
  ('core-5-krugov-po-60-sek-v-ups-reverse-crunch-bicycle-plank-shoulder-bd2b07', 'Core ×5 кругов по 60 сек: V-Ups, Reverse Crunch, Bicycle, Plank Shoulder Taps, отдых 60 сек'),
  ('circuit-1-4-goblet-squat-pulse-12-3-pulses-bulgarian-split-squat-10-0a4221', 'Circuit 1 ×4: Goblet Squat+Pulse 12+3 pulses + Bulgarian Split Squat 10 на ногу + Single-Leg Hip Thrust 12 на ногу + Lateral Lunge 12 на ногу + Banded Abduction 30, отдых 60 сек'),
  ('circuit-2-3-romanian-deadlift-12-curtsy-lunge-12-na-nogu-frog-pumps-81f47c', 'Circuit 2 ×3: Romanian Deadlift 12 + Curtsy Lunge 12 на ногу + Frog Pumps 30 + Glute Bridge Hold 40 сек'),
  ('glute-drop-challenge-3-10-bulgarian-split-squats-12-reverse-lunges-15-697122', 'Glute Drop Challenge ×3: 10 Bulgarian Split Squats → 12 Reverse Lunges → 15 Bodyweight Squats → 20 Squat Pulses → 30 сек Wall Sit, отдых 60 сек'),
  ('kardio-18-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet-a95c09', 'Кардио 18 мин ×3 (40/20): High Knees, Skater, Mountain Climbers, Fast Feet, Jumping Jacks, Shadow Boxing'),
  ('core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-otdyh-60-4aa7be', 'Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank, отдых 60 сек'),
  ('superset-2-3-arnold-press-10-front-raise-12-lateral-raise-15', 'Superset 2 ×3: Arnold Press 10 + Front Raise 12 + Lateral Raise 15'),
  ('superset-3-3-hammer-curl-12-overhead-triceps-extension-15', 'Superset 3 ×3: Hammer Curl 12 + Overhead Triceps Extension 15'),
  ('superset-4-3-band-pull-apart-25-face-pull-20', 'Superset 4 ×3: Band Pull-Apart 25 + Face Pull 20'),
  ('calisthenics-challenge-5-8-12-push-ups-20-plank-shoulder-taps-10-bear-e09aff', 'Calisthenics Challenge ×5: 8–12 Push-Ups, 20 Plank Shoulder Taps, 10 Bear Crawl вперёд, 10 назад, 10 Squat Thrusts, 20 сек Hollow Hold, отдых 60 сек'),
  ('emom-15-min-3-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-af4d18', 'EMOM 15 мин ×3: мин.1 — 12 Push-Ups, мин.2 — 15 Dumbbell Rows, мин.3 — 12 Arnold Press, мин.4 — 40 сек Shadow Boxing, мин.5 — 30 сек Mountain Climbers'),
  ('circuit-1-4-sumo-squat-15-walking-lunges-12-na-nogu-staggered-rdl-12-5be235', 'Circuit 1 ×4: Sumo Squat 15 + Walking Lunges 12 на ногу + Staggered RDL 12 на ногу + Calf Raise 25'),
  ('circuit-2-4-hip-thrust-20-single-leg-glute-bridge-15-na-nogu-banded-08087b', 'Circuit 2 ×4: Hip Thrust 20 + Single-Leg Glute Bridge 15 на ногу + Banded Kickback 20 на ногу + Abduction 30'),
  ('emom-16-min-4-min-1-15-goblet-squats-min-2-12-walking-lunges-na-nogu-86af7a', 'EMOM 16 мин ×4: мин.1 — 15 Goblet Squats, мин.2 — 12 Walking Lunges на ногу, мин.3 — 20 Hip Thrusts, мин.4 — 40 сек High Knees'),
  ('metabolic-finisher-6-min-2-30-sek-kazhdoe-squat-pulses-mountain-9b56ec', 'Metabolic Finisher 6 мин ×2 (30 сек каждое): Squat Pulses, Mountain Climbers, Reverse Lunge, Fast Feet, Glute Bridge, отдых'),
  ('round-1-5-goblet-squat-12-push-up-10-romanian-deadlift-12-reverse-fb2c91', 'Round 1 ×5: Goblet Squat 12 + Push-Up 10 + Romanian Deadlift 12 + Reverse Lunge 10 на ногу + Dumbbell Row 10 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-dumbbell-thruster-10-bear-crawl-20-shagov-squat-to-knee-e853f7', 'Round 2 ×4: Dumbbell Thruster 10 + Bear Crawl 20 шагов + Squat to Knee Drive 10 на ногу + Push-Up 10 + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-walking-lunges-10-870cc6', '🔥 AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Walking Lunges, 10 Dumbbell Rows, 10 Dumbbell Thrusters, 20 Mountain Climbers, 15 Glute Bridges. Записать: полных кругов + доп. повторений'),
  ('final-challenge-6-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-8d3275', 'Final Challenge 6 мин (20 сек каждое): High Knees, Squat Pulses, Mountain Climbers, Skater, Shadow Boxing, отдых'),
  ('razminka-7-min-marsh-s-vysokim-kolenom-bodyweight-squat-lateral-walk-f2b21a', 'Разминка 7 мин: марш с высоким коленом, bodyweight squat, lateral walk, glute bridge, reverse lunge, jumping jack, лёгкий бег'),
  ('block-1-4-dumbbell-front-squat-10-12-bulgarian-split-squat-10-na-nogu-1fa536', 'Block 1 ×4: Dumbbell Front Squat 10–12 + Bulgarian Split Squat 10 на ногу (рабочий вес) + Dumbbell Hip Thrust 12–15 (пауза 2 сек) + Romanian Deadlift 10–12 + Banded Abduction 25, отдых 60–75 сек'),
  ('block-2-posterior-chain-3-single-leg-romanian-deadlift-10-na-nogu-d1fd48', 'Block 2 — Posterior Chain ×3: Single-Leg Romanian Deadlift 10 на ногу + Single-Leg Glute Bridge 12 на ногу + Banded Kickback 20 на ногу + Glute Bridge Hold 30 сек'),
  ('glute-mechanical-drop-set-3-8-bulgarian-split-squats-10-reverse-1f06f0', 'Glute Mechanical Drop Set ×3: 8 Bulgarian Split Squats → 10 Reverse Lunges → 15 Bodyweight Squats → 20 Squat Pulses → 30 сек Wall Sit, отдых 75 сек'),
  ('kardio-15-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet-7f7387', 'Кардио 15 мин ×3 (40/20): High Knees, Skater, Mountain Climbers, Fast Feet, Jumping Jacks'),
  ('superset-1-4-dumbbell-floor-press-10-12-one-arm-dumbbell-row-12-na-466578', 'Superset 1 ×4: Dumbbell Floor Press 10–12 + One-Arm Dumbbell Row 12 на руку'),
  ('superset-2-4-arnold-press-10-12-lateral-raise-15', 'Superset 2 ×4: Arnold Press 10–12 + Lateral Raise 15'),
  ('superset-3-3-hammer-curl-12-overhead-triceps-extension-12-15', 'Superset 3 ×3: Hammer Curl 12 + Overhead Triceps Extension 12–15'),
  ('superset-4-3-bent-over-reverse-fly-15-band-face-pull-20', 'Superset 4 ×3: Bent-Over Reverse Fly 15 + Band Face Pull 20'),
  ('weighted-calisthenics-4-push-up-8-12-plank-shoulder-tap-20-bear-crawl-5927ab', 'Weighted Calisthenics ×4: Push-Up 8–12 + Plank Shoulder Tap 20 + Bear Crawl 20 шагов + Dumbbell Renegade Row 8 на руку, отдых 60 сек'),
  ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-e20be0', 'EMOM 16 мин ×4: мин.1 — 10 Push-Ups, мин.2 — 12 Dumbbell Rows, мин.3 — 10 Arnold Press, мин.4 — 40 сек Shadow Boxing'),
  ('block-1-4-goblet-squat-12-walking-lunge-10-na-nogu-dumbbell-romanian-812b88', 'Block 1 ×4: Goblet Squat 12 + Walking Lunge 10 на ногу + Dumbbell Romanian Deadlift 12 + Calf Raise 25'),
  ('block-2-4-step-up-s-gantelyami-10-na-nogu-hip-thrust-15-banded-ee581c', 'Block 2 ×4: Step-Up с гантелями 10 на ногу + Hip Thrust 15 + Banded Kickback 20 на ногу + Abduction 25'),
  ('static-strength-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-8e43c5', 'Static Strength ×3: Wall Sit 60 сек + Glute Bridge Hold 45 сек + Squat Hold 30 сек, отдых 60 сек'),
  ('metabolic-block-5-30-sek-kazhdoe-high-knees-squat-mountain-climbers-a4166c', 'Metabolic Block ×5 (30 сек каждое): High Knees, Squat, Mountain Climbers, Reverse Lunge, отдых'),
  ('circuit-5-dumbbell-thruster-10-romanian-deadlift-12-reverse-lunge-10-35c494', 'Circuit ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Reverse Lunge 10 на ногу + One-Arm Row 10 на руку + Push-Up 10 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('emom-15-min-3-min-1-10-goblet-squats-min-2-10-push-ups-min-3-12-6ad7cb', 'EMOM 15 мин ×3: мин.1 — 10 Goblet Squats, мин.2 — 10 Push-Ups, мин.3 — 12 Dumbbell Rows, мин.4 — 10 Reverse Lunges на ногу, мин.5 — 40 сек High Knees'),
  ('amrap-10-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-e1f864', 'AMRAP 10 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 10 Dumbbell Thrusters, 15 Mountain Climbers, 15 Glute Bridges. Записать кругов'),
  ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-c17ffb', 'Final Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank Shoulder Taps, отдых 60 сек'),
  ('circuit-1-4-sumo-goblet-squat-12-posl-3-pauza-vnizu-deficit-reverse-358221', 'Circuit 1 ×4: Sumo Goblet Squat 12 (посл.3 — пауза внизу) + Deficit Reverse Lunge 10 на ногу + Single-Leg Hip Thrust 12 на ногу + Lateral Lunge 12 на ногу + Banded Abduction 30'),
  ('circuit-2-4-staggered-romanian-deadlift-12-na-nogu-frog-pumps-30-a4753b', 'Circuit 2 ×4: Staggered Romanian Deadlift 12 на ногу + Frog Pumps 30 + Banded Kickback 20 на ногу + Glute Bridge Hold 40 сек'),
  ('glute-burn-3-12-squats-12-reverse-lunges-15-frog-pumps-20-squat-d17dc8', 'Glute Burn ×3: 12 Squats, 12 Reverse Lunges, 15 Frog Pumps, 20 Squat Pulses, 30 сек Wall Sit'),
  ('cardio-turbo-18-min-3-30-30-high-knees-skater-mountain-climbers-fast-ce07b9', 'Cardio Turbo 18 мин ×3 (30/30): High Knees, Skater, Mountain Climbers, Fast Feet, Squat to Knee Drive, Shadow Boxing'),
  ('core-5-krugov-po-60-sek-v-ups-reverse-crunch-bicycle-plank-otdyh-60-7a62a6', 'Core ×5 кругов по 60 сек: V-Ups, Reverse Crunch, Bicycle, Plank, отдых 60 сек'),
  ('tri-set-1-3-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-dumbbell-514e43', 'Tri-Set 1 ×3: Push-Up 10–15 + One-Arm Dumbbell Row 12 на руку + Dumbbell Shoulder Press 10, отдых 75 сек'),
  ('tri-set-2-3-lateral-raise-15-reverse-fly-15-band-face-pull-20', 'Tri-Set 2 ×3: Lateral Raise 15 + Reverse Fly 15 + Band Face Pull 20'),
  ('arm-finisher-3-hammer-curl-12-triceps-kickback-15-biceps-hold-20-sek', 'Arm Finisher ×3: Hammer Curl 12 + Triceps Kickback 15 + Biceps Hold 20 сек'),
  ('calisthenics-circuit-5-8-12-push-ups-20-plank-shoulder-taps-20-bear-7571e4', 'Calisthenics Circuit ×5: 8–12 Push-Ups, 20 Plank Shoulder Taps, 20 Bear Crawl Steps, 10 Squat Thrusts, 30 сек Shadow Boxing, отдых 45 сек'),
  ('emom-16-min-4-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-0ee2e4', 'EMOM 16 мин ×4: мин.1 — 12 Push-Ups, мин.2 — 15 Dumbbell Rows, мин.3 — 12 Shoulder Press, мин.4 — 40 сек Mountain Climbers'),
  ('block-1-4-dumbbell-front-squat-12-walking-lunge-12-na-nogu-single-leg-36208f', 'Block 1 ×4: Dumbbell Front Squat 12 + Walking Lunge 12 на ногу + Single-Leg RDL 10 на ногу + Calf Raise 25'),
  ('block-2-4-hip-thrust-15-bulgarian-split-squat-10-na-nogu-frog-pumps-7c0edc', 'Block 2 ×4: Hip Thrust 15 + Bulgarian Split Squat 10 на ногу + Frog Pumps 30 + Banded Abduction 30'),
  ('emom-16-min-4-min-1-12-goblet-squats-min-2-10-bulgarian-split-squats-b40a8c', 'EMOM 16 мин ×4: мин.1 — 12 Goblet Squats, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 20 Hip Thrusts, мин.4 — 40 сек High Knees'),
  ('metabolic-finisher-8-min-20-sek-kazhdoe-squat-pulses-mountain-84bd7b', 'Metabolic Finisher 8 мин (20 сек каждое): Squat Pulses, Mountain Climbers, High Knees, Reverse Lunges, Glute Bridge, отдых'),
  ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-7c18c7', 'Round 1 ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Push-Up 10 + Reverse Lunge 10 на ногу + One-Arm Row 10 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-sumo-squat-12-dumbbell-shoulder-press-10-walking-lunge-10-0859ff', 'Round 2 ×4: Sumo Squat 12 + Dumbbell Shoulder Press 10 + Walking Lunge 10 на ногу + Bear Crawl 20 шагов + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-44d457', '🔥 AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 10 Dumbbell Thrusters, 20 Mountain Climbers, 15 Glute Bridges. Записать: полных кругов + доп. повторений (сравнить с началом месяца)'),
  ('final-boss-6-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-5a367a', 'Final Boss 6 мин (20 сек каждое): High Knees, Squat Pulses, Mountain Climbers, Skater, Shadow Boxing, отдых'),
  ('razminka-7-min-march-high-knees-bodyweight-squat-hip-circle-glute-d6c934', 'Разминка 7 мин: March High Knees, Bodyweight Squat, Hip Circle, Glute Bridge, Reverse Lunge, Side Step, Jumping Jack'),
  ('block-1-sila-4-goblet-squat-12-temp-3-sek-vniz-romanian-deadlift-s-760be9', 'Block 1 — Сила ×4: Goblet Squat 12 (темп 3 сек вниз) + Romanian Deadlift с гантелями 12 (темп 3 сек вниз) + Reverse Lunge 10 на ногу + Glute Bridge 15 (пауза 2 сек), отдых 75 сек'),
  ('block-2-yagoditsy-3-bulgarian-split-squat-10-na-nogu-single-leg-glute-13459a', 'Block 2 — Ягодицы ×3: Bulgarian Split Squat 10 на ногу + Single-Leg Glute Bridge 12 на ногу + Banded Kickback 20 на ногу + Banded Abduction 25'),
  ('static-block-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-30-45d9dd', 'Static Block ×3: Wall Sit 60 сек + Glute Bridge Hold 45 сек + Squat Hold 30 сек, отдых 60 сек'),
  ('glute-finisher-3-15-squats-15-frog-pumps-20-glute-bridge-20-squat-67f380', 'Glute Finisher ×3: 15 Squats, 15 Frog Pumps, 20 Glute Bridge, 20 Squat Pulses, 30 сек Wall Sit, отдых 60 сек'),
  ('kardio-12-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet', 'Кардио 12 мин ×3 (40/20): High Knees, Skater, Mountain Climbers, Fast Feet'),
  ('superset-1-4-push-up-8-15-one-arm-dumbbell-row-12-na-ruku', 'Superset 1 ×4: Push-Up 8–15 + One-Arm Dumbbell Row 12 на руку'),
  ('superset-2-4-dumbbell-shoulder-press-10-12-lateral-raise-15', 'Superset 2 ×4: Dumbbell Shoulder Press 10–12 + Lateral Raise 15'),
  ('superset-3-3-hammer-curl-12-triceps-extension-15-band-face-pull-20', 'Superset 3 ×3: Hammer Curl 12 + Triceps Extension 15 + Band Face Pull 20'),
  ('calisthenics-block-4-push-up-10-bear-crawl-20-shagov-plank-shoulder-dc01ec', 'Calisthenics Block ×4: Push-Up 10 + Bear Crawl 20 шагов + Plank Shoulder Tap 20 + Squat Thrust 10, отдых 60 сек'),
  ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-bffd22', 'EMOM 16 мин ×4: мин.1 — 10 Push-Ups, мин.2 — 12 Dumbbell Rows, мин.3 — 10 Shoulder Press, мин.4 — 40 сек Shadow Boxing'),
  ('cardio-finisher-8-min-2-30-30-high-knees-skater-mountain-climbers-228c03', 'Cardio Finisher 8 мин ×2 (30/30): High Knees, Skater, Mountain Climbers, Fast Feet'),
  ('block-1-4-sumo-goblet-squat-12-walking-lunge-10-na-nogu-dumbbell-5615ec', 'Block 1 ×4: Sumo Goblet Squat 12 + Walking Lunge 10 на ногу + Dumbbell Romanian Deadlift 12 + Calf Raise 25'),
  ('block-2-4-step-up-10-na-nogu-hip-thrust-15-banded-kickback-20-na-nogu-968c6a', 'Block 2 ×4: Step-Up 10 на ногу + Hip Thrust 15 + Banded Kickback 20 на ногу + Banded Abduction 25'),
  ('single-leg-challenge-3-single-leg-squat-to-chair-8-na-nogu-single-leg-a3685d', 'Single-Leg Challenge ×3: Single-Leg Squat to Chair 8 на ногу + Single-Leg RDL 10 на ногу + Single-Leg Glute Bridge 12 на ногу'),
  ('metabolic-interval-10-min-40-20-squat-to-knee-drive-mountain-climbers-7833c3', 'Metabolic Interval 10 мин (40/20): Squat to Knee Drive, Mountain Climbers, Skater, Reverse Lunges'),
  ('static-finisher-3-wall-sit-60-sek-glute-bridge-hold-60-sek-plank-60-30c19d', 'Static Finisher ×3: Wall Sit 60 сек + Glute Bridge Hold 60 сек + Plank 60 сек')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-side-plank-77345f', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Side Plank, отдых 60 сек'),
  ('round-1-strength-circuit-4-goblet-squat-12-dumbbell-romanian-deadlift-4fd640', 'Round 1 — Strength Circuit ×4: Goblet Squat 12 + Dumbbell Romanian Deadlift 12 + Push-Up 10 + One-Arm Row 10 на руку + Reverse Lunge 10 на ногу, отдых 60 сек'),
  ('round-2-athletic-4-squat-jump-8-bear-crawl-20-shagov-mountain-486354', 'Round 2 — Athletic ×4: Squat Jump 8 + Bear Crawl 20 шагов + Mountain Climbers 30 + Skater 20 + High Knees 30 сек, отдых 60 сек'),
  ('amrap-10-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-d4a8b3', 'AMRAP 10 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 10 Glute Bridges, 20 Mountain Climbers. Записать кругов'),
  ('circuit-1-4-sumo-squat-15-curtsy-lunge-12-na-nogu-staggered-rdl-12-na-ff1e2c', 'Circuit 1 ×4: Sumo Squat 15 + Curtsy Lunge 12 на ногу + Staggered RDL 12 на ногу + Hip Thrust 15'),
  ('circuit-2-4-step-up-knee-drive-10-na-nogu-frog-pumps-30-banded-ad2bc1', 'Circuit 2 ×4: Step-Up+Knee Drive 10 на ногу + Frog Pumps 30 + Banded Kickback 20 на ногу + Banded Abduction 30'),
  ('glute-ladder-10-15-20-25-30-squats-otdyh-20-sek-mezhdu-stupenyami-60-8272a6', 'Glute Ladder: 10→15→20→25→30 Squats, отдых 20 сек между ступенями, 60 сек после лестницы, повторить 2 раза'),
  ('interval-cardio-15-min-3-30-30-high-knees-skater-squat-jump-mountain-99d73a', 'Interval Cardio 15 мин ×3 (30/30): High Knees, Skater, Squat Jump, Mountain Climbers, Fast Feet'),
  ('core-5-krugov-po-60-sek-bicycle-reverse-crunch-leg-raise-plank-otdyh-dc98f6', 'Core ×5 кругов по 60 сек: Bicycle, Reverse Crunch, Leg Raise, Plank, отдых 60 сек'),
  ('tri-set-1-4-push-up-10-15-renegade-row-8-na-ruku-arnold-press-10-3471ad', 'Tri-Set 1 ×4: Push-Up 10–15 + Renegade Row 8 на руку + Arnold Press 10, отдых 60 сек'),
  ('tri-set-2-3-lateral-raise-15-bent-over-reverse-fly-15-band-face-pull-918a0a', 'Tri-Set 2 ×3: Lateral Raise 15 + Bent-Over Reverse Fly 15 + Band Face Pull 20'),
  ('arms-3-hammer-curl-12-overhead-triceps-extension-15-biceps-hold-30-sek', 'Arms ×3: Hammer Curl 12 + Overhead Triceps Extension 15 + Biceps Hold 30 сек'),
  ('calisthenics-circuit-5-10-push-ups-20-plank-shoulder-taps-20-bear-b37e29', 'Calisthenics Circuit ×5: 10 Push-Ups, 20 Plank Shoulder Taps, 20 Bear Crawl Steps, 10 Squat Thrusts, 30 сек Shadow Boxing, отдых 45 сек'),
  ('emom-16-min-4-min-1-12-push-ups-min-2-12-renegade-rows-min-3-12-97851b', 'EMOM 16 мин ×4: мин.1 — 12 Push-Ups, мин.2 — 12 Renegade Rows, мин.3 — 12 Arnold Press, мин.4 — 40 сек Mountain Climbers'),
  ('cardio-finisher-6-min-20-sek-kazhdoe-fast-feet-high-knees-skater-otdyh', 'Cardio Finisher 6 мин (20 сек каждое): Fast Feet, High Knees, Skater, отдых'),
  ('core-5-krugov-po-60-sek-v-ups-bicycle-hollow-hold-plank-shoulder-tap-548020', 'Core ×5 кругов по 60 сек: V-Ups, Bicycle, Hollow Hold, Plank Shoulder Tap, отдых 60 сек'),
  ('circuit-1-4-goblet-squat-15-reverse-lunge-knee-drive-10-na-nogu-c4f2ce', 'Circuit 1 ×4: Goblet Squat 15 + Reverse Lunge+Knee Drive 10 на ногу + Single-Leg RDL 10 на ногу + Calf Raise 30'),
  ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-20-frog-pumps-50fc4b', 'Circuit 2 ×4: Bulgarian Split Squat 10 на ногу + Hip Thrust 20 + Frog Pumps 30 + Banded Abduction 30'),
  ('emom-16-min-4-min-1-15-goblet-squats-min-2-10-bulgarian-split-squats-be4f58', 'EMOM 16 мин ×4: мин.1 — 15 Goblet Squats, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 20 Hip Thrusts, мин.4 — 40 сек High Knees'),
  ('metabolic-finisher-8-min-20-sek-kazhdoe-squat-pulses-mountain-bd119d', 'Metabolic Finisher 8 мин (20 сек каждое): Squat Pulses, Mountain Climbers, Skater, Reverse Lunges, High Knees, отдых'),
  ('static-challenge-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-491ba9', 'Static Challenge: Wall Sit 90 сек + Glute Bridge Hold 60 сек + Squat Hold 45 сек, 2 раунда'),
  ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-curtsy-0da472', 'Round 1 ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Push-Up 10 + Curtsy Lunge 10 на ногу + One-Arm Row 10 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-sumo-squat-15-arnold-press-10-walking-lunge-10-na-nogu-bear-4db7f6', 'Round 2 ×4: Sumo Squat 15 + Arnold Press 10 + Walking Lunge 10 на ногу + Bear Crawl 20 шагов + Skater 20 + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-9b84d1', 'AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Renegade Rows, 15 Glute Bridges, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений'),
  ('final-boss-8-min-30-30-high-knees-mountain-climbers-skater-squat-00ba44', '⚡ Final Boss 8 мин (30/30): High Knees, Mountain Climbers, Skater, Squat Pulses, отдых'),
  ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-f774d8', '🔥 Final Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank Shoulder Taps, отдых 60 сек'),
  ('razminka-7-min-legkiy-beg-na-meste-hip-circle-bodyweight-squat-0fe248', 'Разминка 7 мин: лёгкий бег на месте, Hip Circle, Bodyweight Squat, Reverse Lunge, Glute Bridge, Side Step, High Knees'),
  ('block-1-sila-4-dumbbell-sumo-squat-12-posl-3-pauza-2-sek-vnizu-546e7e', 'Block 1 — Сила ×4: Dumbbell Sumo Squat 12 (посл.3 пауза 2 сек внизу) + Bulgarian Split Squat 10 на ногу + Dumbbell Hip Thrust 12–15 (пауза 3 сек) + Romanian Deadlift 10–12, отдых 75 сек'),
  ('block-2-odnostoronnyaya-rabota-3-step-up-12-na-nogu-single-leg-48915f', 'Block 2 — Односторонняя работа ×3: Step-Up 12 на ногу + Single-Leg Romanian Deadlift 10 на ногу + Single-Leg Glute Bridge 15 на ногу + Banded Kickback 20 на ногу'),
  ('static-triangle-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-a49ab0', 'Static Triangle ×3: Wall Sit 60 сек + Glute Bridge Hold 45 сек + Squat Hold 30 сек, отдых 60 сек'),
  ('glute-finisher-3-20-frog-pumps-15-squat-pulses-15-reverse-lunges-30-2580ca', 'Glute Finisher ×3: 20 Frog Pumps, 15 Squat Pulses, 15 Reverse Lunges, 30 сек Glute Bridge Hold, отдых 45 сек'),
  ('hiit-10-min-2-40-20-high-knees-skater-mountain-climbers-squat-to-knee-1deb2f', 'HIIT 10 мин ×2 (40/20): High Knees, Skater, Mountain Climbers, Squat to Knee Drive, Fast Feet'),
  ('core-5-krugov-po-60-sek-dead-bug-reverse-crunch-bicycle-plank-df89d8', 'Core ×5 кругов по 60 сек: Dead Bug, Reverse Crunch, Bicycle, Plank Shoulder Taps, отдых 60 сек'),
  ('superset-1-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku', 'Superset 1 ×4: Push-Up 10–15 + One-Arm Dumbbell Row 12 на руку'),
  ('superset-2-4-arnold-press-10-bent-over-reverse-fly-15', 'Superset 2 ×4: Arnold Press 10 + Bent-Over Reverse Fly 15'),
  ('superset-3-3-hammer-curl-12-dumbbell-triceps-extension-15-band-face-d28779', 'Superset 3 ×3: Hammer Curl 12 + Dumbbell Triceps Extension 15 + Band Face Pull 20'),
  ('hiit-finisher-8-min-20-sek-kazhdoe-fast-feet-mountain-climbers-shadow-b54211', 'HIIT Finisher 8 мин (20 сек каждое): Fast Feet, Mountain Climbers, Shadow Boxing, отдых'),
  ('core-5-krugov-po-60-sek-v-ups-leg-raise-bicycle-hollow-hold-otdyh-60-7f96e2', 'Core ×5 кругов по 60 сек: V-Ups, Leg Raise, Bicycle, Hollow Hold, отдых 60 сек'),
  ('block-1-4-front-foot-elevated-reverse-lunge-10-na-nogu-goblet-squat-19361a', 'Block 1 ×4: Front-Foot Elevated Reverse Lunge 10 на ногу + Goblet Squat 12 + Dumbbell Staggered RDL 12 на ногу + Calf Raise 25'),
  ('block-2-4-step-up-knee-drive-10-na-nogu-hip-thrust-15-frog-pumps-30-fb06d8', 'Block 2 ×4: Step-Up+Knee Drive 10 на ногу + Hip Thrust 15 + Frog Pumps 30 + Banded Abduction 30'),
  ('balance-challenge-3-single-leg-stand-30-sek-na-nogu-single-leg-rdl-10-7f7dee', 'Balance Challenge ×3: Single-Leg Stand 30 сек на ногу + Single-Leg RDL 10 на ногу + Reverse Lunge 10 на ногу'),
  ('athletic-interval-12-min-30-30-squat-jump-skater-mountain-climbers-f3450d', 'Athletic Interval 12 мин (30/30): Squat Jump, Skater, Mountain Climbers, High Knees'),
  ('static-finisher-wall-sit-90-sek-glute-bridge-hold-60-sek-plank-60-sek-a223b2', 'Static Finisher: Wall Sit 90 сек + Glute Bridge Hold 60 сек + Plank 60 сек, 2 круга'),
  ('round-2-4-sumo-squat-15-arnold-press-10-step-up-10-na-nogu-bear-crawl-234f2d', 'Round 2 ×4: Sumo Squat 15 + Arnold Press 10 + Step-Up 10 на ногу + Bear Crawl 20 шагов + Skater 20 + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-eecd0b', 'AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Glute Bridges, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений'),
  ('final-boss-8-min-30-30-high-knees-mountain-climbers-skater-squat-43787a', 'Final Boss 8 мин (30/30): High Knees, Mountain Climbers, Skater, Squat Pulses, отдых'),
  ('circuit-1-4-sumo-squat-calf-raise-15-curtsy-lunge-12-na-nogu-single-87a857', 'Circuit 1 ×4: Sumo Squat+Calf Raise 15 + Curtsy Lunge 12 на ногу + Single-Leg Hip Thrust 12 на ногу + Dumbbell Good Morning 15, отдых 60 сек'),
  ('circuit-2-4-reverse-lunge-knee-drive-10-na-nogu-frog-pumps-30-banded-011639', 'Circuit 2 ×4: Reverse Lunge+Knee Drive 10 на ногу + Frog Pumps 30 + Banded Kickback 20 на ногу + Abduction Pulses 30'),
  ('glute-ladder-frog-pumps-10-15-20-25-30-otdyh-15-sek-mezhdu-stupenyami-46758d', 'Glute Ladder: Frog Pumps 10→15→20→25→30, отдых 15 сек между ступенями, 60 сек после подъёма, повторить 2 раза'),
  ('power-interval-10-min-20-20-squat-jump-skater-high-knees', 'Power Interval 10 мин (20/20): Squat Jump, Skater, High Knees'),
  ('tri-set-1-4-push-up-10-15-renegade-row-8-na-ruku-dumbbell-push-press-82f4f2', 'Tri-Set 1 ×4: Push-Up 10–15 + Renegade Row 8 на руку + Dumbbell Push Press 10, отдых 60 сек'),
  ('arm-finisher-3-hammer-curl-12-triceps-kickback-15-biceps-hold-30-sek', 'Arm Finisher ×3: Hammer Curl 12 + Triceps Kickback 15 + Biceps Hold 30 сек'),
  ('emom-16-min-4-min-1-12-push-ups-min-2-12-renegade-rows-min-3-12-push-c6b045', 'EMOM 16 мин ×4: мин.1 — 12 Push-Ups, мин.2 — 12 Renegade Rows, мин.3 — 12 Push Press, мин.4 — 40 сек Mountain Climbers'),
  ('cardio-finisher-8-min-20-sek-kazhdoe-fast-feet-high-knees-skater-1daca1', 'Cardio Finisher 8 мин (20 сек каждое): Fast Feet, High Knees, Skater, Mountain Climbers, отдых'),
  ('circuit-1-4-goblet-squat-15-walking-lunge-12-na-nogu-single-leg-rdl-ab61bb', 'Circuit 1 ×4: Goblet Squat 15 + Walking Lunge 12 на ногу + Single-Leg RDL 10 на ногу + Calf Raise 30'),
  ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-pulses-25-65934e', 'Circuit 2 ×4: Bulgarian Split Squat 10 на ногу + Hip Thrust Pulses 25 + Frog Pumps 30 + Banded Abduction 30'),
  ('emom-16-min-4-min-1-15-goblet-squats-min-2-10-bulgarian-split-squats-78f9f1', 'EMOM 16 мин ×4: мин.1 — 15 Goblet Squats, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 20 Hip Thrust Pulses, мин.4 — 40 сек High Knees'),
  ('athletic-finisher-10-min-20-sek-kazhdoe-squat-jump-mountain-climbers-1d83b5', 'Athletic Finisher 10 мин (20 сек каждое): Squat Jump, Mountain Climbers, Skater, Reverse Lunge, High Knees, отдых'),
  ('static-challenge-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-cbc738', 'Static Challenge: Wall Sit 90 сек + Glute Bridge Hold 60 сек + Squat Hold 45 сек, 2 круга'),
  ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-curtsy-17ef8e', 'Round 1 ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Push-Up 10 + Curtsy Lunge 10 на ногу + Renegade Row 8 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-sumo-squat-15-push-press-10-walking-lunge-10-na-nogu-bear-aff0c6', 'Round 2 ×4: Sumo Squat 15 + Push Press 10 + Walking Lunge 10 на ногу + Bear Crawl 20 шагов + Skater 20 + High Knees 30 сек, отдых 60 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-curtsy-lunges-10-renegade-1df5b1', 'AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Curtsy Lunges, 10 Renegade Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений + время'),
  ('final-athlete-test-10-min-30-30-high-knees-mountain-climbers-skater-f2d661', '🏆 Final Athlete Test 10 мин (30/30): High Knees, Mountain Climbers, Skater, Squat Pulses, Shadow Boxing, отдых'),
  ('razminka-7-min-shagi-s-vysokim-kolenom-bodyweight-good-morning-346c78', 'Разминка 7 мин: шаги с высоким коленом, Bodyweight Good Morning, приседания, боковые шаги, ягодичный мост, обратные выпады, лёгкие jumping jacks'),
  ('block-1-4-dumbbell-front-squat-12-posl-3-medlenno-reverse-lunge-knee-028a46', 'Block 1 ×4: Dumbbell Front Squat 12 (посл.3 медленно) + Reverse Lunge+Knee Drive 10 на ногу + Dumbbell Hip Thrust 15 (пауза 2 сек) + Dumbbell Romanian Deadlift 12, отдых 60 сек'),
  ('block-2-4-lateral-lunge-12-na-nogu-single-leg-glute-bridge-15-na-nogu-76caac', 'Block 2 ×4: Lateral Lunge 12 на ногу + Single-Leg Glute Bridge 15 на ногу + Banded Abduction 25 + Donkey Kick 20 на ногу, отдых 45 сек'),
  ('metabolic-ladder-squats-10-20-30-40-50-otdyh-20-sek-mezhdu-urovnyami-cc206d', 'Metabolic Ladder: Squats 10→20→30→40→50, отдых 20 сек между уровнями, 60 сек после 50'),
  ('glute-burn-3-30-frog-pumps-20-glute-bridge-pulses-20-banded-e5e996', 'Glute Burn ×3: 30 Frog Pumps, 20 Glute Bridge Pulses, 20 Banded Abductions, 30 сек Glute Bridge Hold, отдых 30 сек'),
  ('hiit-10-min-30-30-squat-jack-skater-high-knees-mountain-climbers', 'HIIT 10 мин (30/30): Squat Jack, Skater, High Knees, Mountain Climbers'),
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-knee-to-b17653', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Dead Bug, Plank Knee to Elbow, отдых 60 сек'),
  ('superset-1-4-push-up-10-15-dumbbell-row-12-na-ruku-dumbbell-push-c986cf', 'Superset 1 ×4: Push-Up 10–15 + Dumbbell Row 12 на руку + Dumbbell Push Press 10, отдых 60 сек'),
  ('superset-2-4-floor-dumbbell-chest-press-12-lateral-raise-15-bent-over-90e043', 'Superset 2 ×4: Floor Dumbbell Chest Press 12 + Lateral Raise 15 + Bent-Over Reverse Fly 15, отдых 60 сек'),
  ('arm-tri-set-3-hammer-curl-12-triceps-kickback-15-band-face-pull-20', 'Arm Tri-Set ×3: Hammer Curl 12 + Triceps Kickback 15 + Band Face Pull 20'),
  ('calisthenics-block-4-incline-push-up-12-bear-crawl-20-shagov-plank-cc0207', 'Calisthenics Block ×4: Incline Push-Up 12 + Bear Crawl 20 шагов + Plank Shoulder Tap 20 + Squat Thrust 10, отдых 45 сек'),
  ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-push-464603', 'EMOM 16 мин ×4: мин.1 — 10 Push-Ups, мин.2 — 12 Dumbbell Rows, мин.3 — 10 Push Press, мин.4 — 40 сек Shadow Boxing'),
  ('cardio-finisher-8-min-20-sek-kazhdoe-fast-feet-mountain-climbers-e70829', 'Cardio Finisher 8 мин (20 сек каждое): Fast Feet, Mountain Climbers, Shadow Boxing, отдых'),
  ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-plank-otdyh-60-sek', 'Core ×5 кругов по 60 сек: Leg Raise, Bicycle, V-Ups, Plank, отдых 60 сек'),
  ('block-1-4-dumbbell-sumo-squat-15-walking-lunges-12-na-nogu-staggered-90daee', 'Block 1 ×4: Dumbbell Sumo Squat 15 + Walking Lunges 12 на ногу + Staggered Romanian Deadlift 12 на ногу + Calf Raise 25, отдых 60 сек'),
  ('block-2-4-step-up-knee-drive-12-na-nogu-hip-thrust-pulses-25-banded-431863', 'Block 2 ×4: Step-Up+Knee Drive 12 на ногу + Hip Thrust Pulses 25 + Banded Kickback 20 на ногу + Frog Pumps 30'),
  ('power-circuit-4-squat-jump-10-reverse-lunge-10-na-nogu-skater-20-99f335', 'Power Circuit ×4: Squat Jump 10 + Reverse Lunge 10 на ногу + Skater 20 + Mountain Climbers 30 сек, отдых 60 сек'),
  ('emom-12-min-4-min-1-15-goblet-squats-min-2-12-reverse-lunges-min-3-40-e7f959', 'EMOM 12 мин ×4: мин.1 — 15 Goblet Squats, мин.2 — 12 Reverse Lunges, мин.3 — 40 сек High Knees'),
  ('static-finisher-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-332ad6', 'Static Finisher: Wall Sit 90 сек + Glute Bridge Hold 60 сек + Squat Hold 45 сек, 2 круга'),
  ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-side-plank-dead-bug-494575', 'Core ×5 кругов по 60 сек: Reverse Crunch, Bicycle, Side Plank, Dead Bug, отдых 60 сек'),
  ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-95b8b7', 'Round 1 ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Push-Up 10 + Walking Lunge 10 на ногу + Dumbbell Row 10 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-sumo-squat-15-push-press-10-step-up-10-na-nogu-bear-crawl-40a19e', 'Round 2 ×4: Sumo Squat 15 + Push Press 10 + Step-Up 10 на ногу + Bear Crawl 20 шагов + Skater 20 + High Knees 30 сек, отдых 45 сек'),
  ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-e40934', 'AMRAP 12 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений'),
  ('final-burn-8-min-30-30-high-knees-squat-jacks-mountain-climbers-6f5ea8', 'Final Burn 8 мин (30/30): High Knees, Squat Jacks, Mountain Climbers, Skater, отдых'),
  ('circuit-1-4-tempo-goblet-squat-12-temp-3-sek-vniz-curtsy-lunge-12-na-7854a3', 'Circuit 1 ×4: Tempo Goblet Squat 12 (темп 3 сек вниз) + Curtsy Lunge 12 на ногу + Single-Leg Hip Thrust 12 на ногу + Dumbbell Good Morning 15, отдых 60 сек'),
  ('circuit-2-4-lateral-lunge-12-na-nogu-single-leg-rdl-10-na-nogu-frog-b1c3d8', 'Circuit 2 ×4: Lateral Lunge 12 на ногу + Single-Leg RDL 10 на ногу + Frog Pumps 30 + Banded Abduction 30, отдых 45 сек'),
  ('glute-ladder-frog-pumps-20-25-30-35-40-otdyh-15-sek-mezhdu-urovnyami', 'Glute Ladder: Frog Pumps 20→25→30→35→40, отдых 15 сек между уровнями'),
  ('power-finisher-4-squat-jump-10-curtsy-lunge-10-na-nogu-skater-20-28d8e0', 'Power Finisher ×4: Squat Jump 10 + Curtsy Lunge 10 на ногу + Skater 20 + Glute Bridge Pulses 30, отдых 45 сек'),
  ('hiit-8-min-20-sek-kazhdoe-high-knees-squat-jump-mountain-climbers-05e1e7', 'HIIT 8 мин (20 сек каждое): High Knees, Squat Jump, Mountain Climbers, отдых'),
  ('core-5-krugov-po-60-sek-toe-touch-crunch-bicycle-reverse-crunch-plank-2a219f', 'Core ×5 кругов по 60 сек: Toe Touch Crunch, Bicycle, Reverse Crunch, Plank Knee Drive, отдых 60 сек'),
  ('tri-set-2-4-floor-chest-fly-12-lateral-raise-15-reverse-fly-15', 'Tri-Set 2 ×4: Floor Chest Fly 12 + Lateral Raise 15 + Reverse Fly 15'),
  ('arms-3-zottman-curl-10-overhead-triceps-extension-12-band-face-pull-20', 'Arms ×3: Zottman Curl 10 + Overhead Triceps Extension 12 + Band Face Pull 20'),
  ('calisthenics-5-incline-push-up-12-bear-crawl-20-shagov-plank-walk-10-4f3813', 'Calisthenics ×5: Incline Push-Up 12 + Bear Crawl 20 шагов + Plank Walk 10 + Squat Thrust 10, отдых 45 сек'),
  ('emom-16-min-4-min-1-10-renegade-rows-min-2-12-push-ups-min-3-10-953b2b', 'EMOM 16 мин ×4: мин.1 — 10 Renegade Rows, мин.2 — 12 Push-Ups, мин.3 — 10 Arnold Press, мин.4 — 40 сек Shadow Boxing'),
  ('metabolic-finisher-6-min-30-sek-kazhdoe-shadow-boxing-mountain-d3fdf9', 'Metabolic Finisher 6 мин (30 сек каждое): Shadow Boxing, Mountain Climbers, Fast Feet, отдых'),
  ('core-5-krugov-po-60-sek-v-ups-toe-touch-bicycle-hollow-hold-otdyh-60-3dfab3', 'Core ×5 кругов по 60 сек: V-Ups, Toe Touch, Bicycle, Hollow Hold, отдых 60 сек'),
  ('circuit-1-4-front-rack-squat-12-curtsy-lunge-12-na-nogu-single-leg-e80c3f', 'Circuit 1 ×4: Front Rack Squat 12 + Curtsy Lunge 12 на ногу + Single-Leg RDL 10 на ногу + Calf Raise 30, отдых 60 сек'),
  ('circuit-2-4-step-back-lunge-knee-drive-12-na-nogu-hip-thrust-15-frog-ad513b', 'Circuit 2 ×4: Step-Back Lunge+Knee Drive 12 на ногу + Hip Thrust 15 + Frog Pumps 30 + Banded Kickback 20 на ногу'),
  ('power-circuit-4-squat-jump-10-skater-20-reverse-lunge-10-na-nogu-b13366', 'Power Circuit ×4: Squat Jump 10 + Skater 20 + Reverse Lunge 10 на ногу + Mountain Climbers 30 сек, отдых 45 сек'),
  ('emom-15-min-3-min-1-15-squats-min-2-12-lunges-min-3-30-frog-pumps-min-229212', 'EMOM 15 мин ×3: мин.1 — 15 Squats, мин.2 — 12 Lunges, мин.3 — 30 Frog Pumps, мин.4 — 40 сек High Knees, мин.5 — 30 сек Wall Sit'),
  ('static-challenge-wall-sit-120-sek-glute-bridge-hold-75-sek-squat-hold-84d6b9', 'Static Challenge: Wall Sit 120 сек + Glute Bridge Hold 75 сек + Squat Hold 45 сек, 2 круга'),
  ('round-1-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-squat-12-6feb5f', 'Round 1 ×5: Devil Press 8 (или Burpee без прыжка ×10) + Goblet Squat 12 + Renegade Row 8 на руку + Curtsy Lunge 10 на ногу + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-dumbbell-thruster-10-single-leg-rdl-10-na-nogu-push-up-10-1f54a5', 'Round 2 ×4: Dumbbell Thruster 10 + Single-Leg RDL 10 на ногу + Push-Up 10 + Bear Crawl 20 шагов + Skater 20, отдых 45 сек'),
  ('chaos-amrap-15-min-10-goblet-squats-8-push-ups-10-curtsy-lunges-8-df6b82', 'CHAOS AMRAP 15 мин: 10 Goblet Squats, 8 Push-Ups, 10 Curtsy Lunges, 8 Renegade Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skaters, 10 Squat Thrusts. Записать: кругов + доп. повторений'),
  ('final-boss-10-min-30-30-high-knees-mountain-climbers-skater-squat-3df6c9', 'Final Boss 10 мин (30/30): High Knees, Mountain Climbers, Skater, Squat Jacks, Shadow Boxing, отдых'),
  ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-knee-54568a', 'Final Core ×5 кругов по 60 сек: V-Ups, Bicycle, Reverse Crunch, Plank Knee Drive, отдых 60 сек'),
  ('razminka-7-min-marching-high-knees-good-morning-bodyweight-squat-361c60', 'Разминка 7 мин: Marching High Knees, Good Morning, Bodyweight Squat, Reverse Lunge, Glute Bridge, Side Step, Skater'),
  ('block-1-4-dumbbell-squat-to-press-12-reverse-lunge-12-na-nogu-200188', 'Block 1 ×4: Dumbbell Squat to Press 12 + Reverse Lunge 12 на ногу + Dumbbell Romanian Deadlift 12 + Hip Thrust 15 (пауза 2 сек), отдых 60 сек'),
  ('block-2-4-curtsy-lunge-12-na-nogu-single-leg-glute-bridge-15-na-nogu-a151b1', 'Block 2 ×4: Curtsy Lunge 12 на ногу + Single-Leg Glute Bridge 15 на ногу + Banded Abduction 30 + Donkey Kick 20 на ногу, отдых 45 сек'),
  ('time-attack-8-min-maksimum-krugov-10-goblet-squats-10-reverse-lunges-f8f21b', 'Time Attack 8 мин: максимум кругов — 10 Goblet Squats, 10 Reverse Lunges, 15 Glute Bridges, 20 Banded Abductions, 20 Mountain Climbers. Записать кругов + повторений'),
  ('mechanical-drop-set-3-squat-12-squat-pulses-20-wall-sit-30-sek-otdyh-ad7b62', 'Mechanical Drop Set ×3: Squat 12 → Squat Pulses 20 → Wall Sit 30 сек, отдых 60 сек'),
  ('hiit-8-min-20-sek-kazhdoe-squat-jump-skater-mountain-climbers-otdyh', 'HIIT 8 мин (20 сек каждое): Squat Jump, Skater, Mountain Climbers, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-dead-92b431', 'Core ×5 кругов по 60 сек (15 сек между упр.): Reverse Crunch, Bicycle, Dead Bug, Plank Knee Drive'),
  ('superset-1-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-push-press-b1d5c1', 'Superset 1 ×4: Push-Up 10–15 + One-Arm Dumbbell Row 12 на руку + Push Press 10, отдых 60 сек'),
  ('superset-2-4-floor-dumbbell-press-12-lateral-raise-15-reverse-fly-15-d082b7', 'Superset 2 ×4: Floor Dumbbell Press 12 + Lateral Raise 15 + Reverse Fly 15, отдых 60 сек'),
  ('arm-drop-set-3-hammer-curl-12-menshiy-ves-10-isometric-hold-30-sek-ee5404', 'Arm Drop Set ×3: Hammer Curl 12 → меньший вес 10 → Isometric Hold 30 сек + Triceps Kickback 15, отдых 60 сек'),
  ('calisthenics-arena-4-incline-push-up-12-bear-crawl-20-shagov-plank-c39d93', 'Calisthenics Arena ×4: Incline Push-Up 12 + Bear Crawl 20 шагов + Plank Walk 10 + Squat Thrust 10 + Mountain Climbers 20, отдых 45 сек'),
  ('time-attack-6-min-maksimum-krugov-5-push-ups-10-dumbbell-rows-10-c620e1', 'Time Attack 6 мин: максимум кругов — 5 Push-Ups, 10 Dumbbell Rows, 10 Shoulder Press, 20 Mountain Climbers, 20 Shadow Boxing'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-toe-touch-crunch-701efb', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Toe Touch Crunch, Bicycle, Plank Shoulder Tap'),
  ('block-1-4-goblet-squat-15-walking-lunge-12-na-nogu-single-leg-rdl-10-358b03', 'Block 1 ×4: Goblet Squat 15 + Walking Lunge 12 на ногу + Single-Leg RDL 10 на ногу + Calf Raise 25, отдых 60 сек'),
  ('block-2-4-step-up-knee-drive-10-na-nogu-hip-thrust-pulses-25-frog-15119f', 'Block 2 ×4: Step-Up+Knee Drive 10 на ногу + Hip Thrust Pulses 25 + Frog Pumps 30 + Banded Kickback 20 на ногу'),
  ('speed-circuit-5-20-sek-kazhdoe-fast-feet-squat-jump-skater-mountain-e8e38c', 'Speed Circuit ×5 (20 сек каждое): Fast Feet, Squat Jump, Skater, Mountain Climbers, отдых'),
  ('emom-15-min-3-min-1-15-goblet-squats-min-2-12-reverse-lunges-min-3-30-2c02a8', 'EMOM 15 мин ×3: мин.1 — 15 Goblet Squats, мин.2 — 12 Reverse Lunges, мин.3 — 30 Frog Pumps, мин.4 — 40 сек High Knees, мин.5 — 30 сек Wall Sit'),
  ('leg-drop-set-3-reverse-lunge-10-na-nogu-pulses-10-na-nogu-static-hold-1f05f8', 'Leg Drop Set ×3: Reverse Lunge 10 на ногу → Pulses 10 на ногу → Static Hold 20 сек на ногу, отдых 60 сек'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 'Core ×5 кругов по 60 сек (15 сек между упр.): Reverse Crunch, Bicycle, Side Plank, Dead Bug'),
  ('round-2-4-curtsy-lunge-10-na-nogu-push-press-10-step-up-10-na-nogu-a027b6', 'Round 2 ×4: Curtsy Lunge 10 на ногу + Push Press 10 + Step-Up 10 на ногу + Bear Crawl 20 шагов + Skater 20 + High Knees 30 сек, отдых 45 сек'),
  ('time-attack-boss-15-min-maksimum-krugov-10-goblet-squats-8-push-ups-1e9ea1', 'Time Attack Boss 15 мин: максимум кругов — 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skaters, 10 Squat Thrusts'),
  ('final-burn-8-min-30-30-high-knees-mountain-climbers-squat-jacks-6b4ab7', 'Final Burn 8 мин (30/30): High Knees, Mountain Climbers, Squat Jacks, Skater, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-2bdf80', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Bicycle, Reverse Crunch, Plank Knee Drive'),
  ('circuit-1-4-dumbbell-sumo-squat-pulse-12-5-pulsatsiy-cossack-squat-10-96a48e', 'Circuit 1 ×4: Dumbbell Sumo Squat+Pulse 12+5 пульсаций + Cossack Squat 10 на ногу + Dumbbell Good Morning 15 + Single-Leg Hip Thrust 12 на ногу, отдых 60 сек'),
  ('circuit-2-4-front-foot-elevated-reverse-lunge-10-na-nogu-single-leg-97b52f', 'Circuit 2 ×4: Front-Foot Elevated Reverse Lunge 10 на ногу + Single-Leg RDL 10 на ногу + Frog Pumps 30 + Banded Abduction Hold 20+10 сек, отдых 45 сек'),
  ('glute-ladder-frog-pumps-20-25-30-35-40-50-otdyh-15-sek-mezhdu-e8e6bb', 'Glute Ladder: Frog Pumps 20→25→30→35→40→50, отдых 15 сек между уровнями'),
  ('power-finisher-4-10-squat-jumps-10-cossack-squats-20-skaters-20-glute-668915', 'Power Finisher ×4: 10 Squat Jumps, 10 Cossack Squats, 20 Skaters, 20 Glute Pulses, отдых 45 сек'),
  ('hiit-8-min-30-sek-kazhdoe-skater-jump-high-knees-mountain-climbers-096c1d', 'HIIT 8 мин (30 сек каждое): Skater Jump, High Knees, Mountain Climbers, Squat Jump, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-toe-touch-crunch-reverse-3afab1', 'Core ×5 кругов по 60 сек (15 сек между упр.): Toe Touch Crunch, Reverse Crunch, Bicycle, Plank Hip Dips'),
  ('tri-set-4-renegade-row-8-na-ruku-push-up-10-15-arnold-press-10-otdyh-d27f64', 'Tri-Set ×4: Renegade Row 8 на руку + Push-Up 10–15 + Arnold Press 10, отдых 60 сек'),
  ('tri-set-2-4-dumbbell-pullover-12-bent-over-reverse-fly-15-lateral-cd75a5', 'Tri-Set 2 ×4: Dumbbell Pullover 12 + Bent-Over Reverse Fly 15 + Lateral Raise 15'),
  ('arm-complex-3-zottman-curl-10-overhead-triceps-extension-12-hammer-4e54fb', 'Arm Complex ×3: Zottman Curl 10 + Overhead Triceps Extension 12 + Hammer Curl Hold 30 сек + Triceps Kickback 15'),
  ('calisthenics-circuit-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-755da5', 'Calisthenics Circuit ×5: Push-Up 10 + Bear Crawl 20 шагов + Plank Walk 10 + Sprawl 8 + Mountain Climbers 20, отдых 45 сек'),
  ('emom-16-min-4-min-1-10-renegade-rows-min-2-10-push-ups-min-3-10-8b5611', 'EMOM 16 мин ×4: мин.1 — 10 Renegade Rows, мин.2 — 10 Push-Ups, мин.3 — 10 Arnold Press, мин.4 — 30 сек Shadow Boxing'),
  ('metabolic-attack-6-min-20-sek-kazhdoe-fast-feet-shadow-boxing-771958', 'Metabolic Attack 6 мин (20 сек каждое): Fast Feet, Shadow Boxing, Mountain Climbers, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-hollow-hold-6492ee', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Bicycle, Hollow Hold, Plank Shoulder Tap'),
  ('circuit-1-4-tempo-goblet-squat-12-temp-3-sek-vniz-walking-lunge-12-na-59d084', 'Circuit 1 ×4: Tempo Goblet Squat 12 (темп 3 сек вниз) + Walking Lunge 12 на ногу + Staggered RDL 12 на ногу + Calf Raise 30, отдых 60 сек'),
  ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-15-frog-pumps-a2a2f4', 'Circuit 2 ×4: Bulgarian Split Squat 10 на ногу + Hip Thrust 15 + Frog Pumps 30 + Banded Kickback 20 на ногу'),
  ('athlete-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-445a4e', 'Athlete Circuit ×5: Squat Jump 10 + Cossack Squat 10 на ногу + Skater Jump 20 + Reverse Lunge 10 на ногу + Mountain Climbers 30 сек, отдых 45 сек'),
  ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-bulgarian-split-squats-dc9a71', 'EMOM 15 мин ×3: мин.1 — 12 Goblet Squats, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 30 Frog Pumps, мин.4 — 40 сек High Knees, мин.5 — 30 сек Wall Sit'),
  ('static-ladder-wall-sit-30-sek-45-sek-60-sek-75-sek-90-sek-otdyh-30-245e47', 'Static Ladder — Wall Sit: 30 сек → 45 сек → 60 сек → 75 сек → 90 сек, отдых 30 сек между уровнями'),
  ('round-1-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-squat-12-8a07b2', 'Round 1 ×5: Devil Press 8 (или Burpee без прыжка ×10) + Goblet Squat 12 + Renegade Row 8 на руку + Walking Lunge 10 на ногу + Push-Up 10 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-dumbbell-thruster-10-cossack-squat-10-na-nogu-single-leg-9e1af8', 'Round 2 ×4: Dumbbell Thruster 10 + Cossack Squat 10 на ногу + Single-Leg RDL 10 на ногу + Bear Crawl 20 шагов + Skater Jump 20, отдых 45 сек'),
  ('arena-amrap-15-min-10-goblet-squats-8-push-ups-10-cossack-squats-8-4be4da', '🔥 ARENA AMRAP 15 мин: 10 Goblet Squats, 8 Push-Ups, 10 Cossack Squats, 8 Renegade Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skater Jumps, 8 Sprawls'),
  ('time-attack-dlya-sravneniya-progressa-8-min-10-squats-10-lunges-10-b5bcc9', '⏱️ TIME ATTACK (для сравнения прогресса) 8 мин: 10 Squats, 10 Lunges, 10 Push-Ups, 20 Mountain Climbers, 20 Skaters. Записать кругов'),
  ('final-boss-10-min-30-30-high-knees-mountain-climbers-skater-jump-074c8a', 'Final Boss 10 мин (30/30): High Knees, Mountain Climbers, Skater Jump, Squat Jacks, Shadow Boxing, отдых'),
  ('final-core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-918c86', 'Final Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Bicycle, Reverse Crunch, Plank Hip Dips'),
  ('razminka-7-min-march-in-place-bodyweight-good-morning-air-squat-dce581', 'Разминка 7 мин: March in Place, Bodyweight Good Morning, Air Squat, Alternating Reverse Lunge, Glute Bridge, Side Step, High Knees'),
  ('block-1-4-dumbbell-front-squat-12-reverse-lunge-knee-drive-10-na-nogu-88a37d', 'Block 1 ×4: Dumbbell Front Squat 12 + Reverse Lunge+Knee Drive 10 на ногу + Dumbbell Romanian Deadlift 12 + Hip Thrust 15 (пауза 2 сек), отдых 60 сек'),
  ('block-2-4-bulgarian-split-squat-10-na-nogu-single-leg-rdl-10-na-nogu-c967ed', 'Block 2 ×4: Bulgarian Split Squat 10 на ногу + Single-Leg RDL 10 на ногу + Frog Pumps 30 + Banded Abduction 25, отдых 45 сек'),
  ('power-ladder-squat-10-12-14-16-18-20-otdyh-15-sek-posle-kazhdogo-fc51d2', 'Power Ladder — Squat: 10→12→14→16→18→20, отдых 15 сек после каждого уровня'),
  ('athletic-finisher-5-10-squat-jumps-10-reverse-lunges-20-skaters-20-e5708a', 'Athletic Finisher ×5: 10 Squat Jumps, 10 Reverse Lunges, 20 Skaters, 20 Mountain Climbers, отдых 30 сек'),
  ('wall-sit-challenge-30-sek-45-sek-60-sek-75-sek-90-sek-otdyh-30-sek', 'Wall Sit Challenge: 30 сек → 45 сек → 60 сек → 75 сек → 90 сек, отдых 30 сек'),
  ('cardio-burst-6-min-20-sek-rabota-10-sek-otdyh-high-knees-skater-jump-2237d1', 'Cardio Burst 6 мин (20 сек работа/10 сек отдых): High Knees, Skater Jump, Mountain Climbers'),
  ('superset-1-4-dumbbell-floor-press-12-one-arm-dumbbell-row-12-na-ruku-75cba8', 'Superset 1 ×4: Dumbbell Floor Press 12 + One-Arm Dumbbell Row 12 на руку + Push Press 10, отдых 60 сек'),
  ('superset-2-4-arnold-press-10-bent-over-reverse-fly-15-lateral-raise-5a3865', 'Superset 2 ×4: Arnold Press 10 + Bent-Over Reverse Fly 15 + Lateral Raise 15, отдых 45 сек'),
  ('arm-complex-3-hammer-curl-12-overhead-triceps-extension-12-hammer-081251', 'Arm Complex ×3: Hammer Curl 12 → Overhead Triceps Extension 12 → Hammer Curl Hold 30 сек → Triceps Kickback 15, отдых 45 сек'),
  ('calisthenics-circuit-5-incline-push-up-12-bear-crawl-20-shagov-plank-9957cf', 'Calisthenics Circuit ×5: Incline Push-Up 12 + Bear Crawl 20 шагов + Plank Walk 10 + Sprawl 8 + Mountain Climbers 20, отдых 30 сек'),
  ('tabata-4-min-20-sek-rabota-10-sek-otdyh-punches-mountain-climbers', 'Tabata 4 мин (20 сек работа/10 сек отдых): Punches, Mountain Climbers'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-toe-touch-crunch-b37daa', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Toe Touch Crunch, Plank Shoulder Tap, Bicycle'),
  ('block-1-4-goblet-squat-15-walking-lunge-12-na-nogu-staggered-rdl-12-a5cefb', 'Block 1 ×4: Goblet Squat 15 + Walking Lunge 12 на ногу + Staggered RDL 12 на ногу + Calf Raise 30, отдых 60 сек'),
  ('block-2-4-step-up-knee-drive-12-na-nogu-hip-thrust-pulses-25-banded-7f0918', 'Block 2 ×4: Step-Up+Knee Drive 12 на ногу + Hip Thrust Pulses 25 + Banded Kickback 20 на ногу + Wall Sit 40 сек, отдых 45 сек'),
  ('speed-circuit-6-20-sek-kazhdoe-fast-feet-skater-squat-jump-otdyh', 'Speed Circuit ×6 (20 сек каждое): Fast Feet, Skater, Squat Jump, отдых'),
  ('leg-finisher-3-10-bulgarian-split-squats-10-pulses-20-sek-static-hold-a66f88', 'Leg Finisher ×3: 10 Bulgarian Split Squats → 10 Pulses → 20 сек Static Hold на ногу, отдых 45 сек'),
  ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-9d217c', 'Round 1 ×5: Dumbbell Thruster 10 + Romanian Deadlift 12 + Push-Up 10 + Reverse Lunge 10 на ногу + One-Arm Dumbbell Row 10 на руку + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-squat-jump-10-push-press-10-cossack-squat-10-na-nogu-bear-93977d', 'Round 2 ×4: Squat Jump 10 + Push Press 10 + Cossack Squat 10 на ногу + Bear Crawl 20 шагов + Skater 20, отдых 45 сек'),
  ('amrap-15-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-30a41b', '🔥 AMRAP 15 мин: 10 Goblet Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений'),
  ('final-cardio-8-min-30-30-high-knees-mountain-climbers-skater-squat-e66f04', 'Final Cardio 8 мин (30/30): High Knees, Mountain Climbers, Skater, Squat Jacks, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-ef343c', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Bicycle, Reverse Crunch, Plank Hip Dips'),
  ('circuit-1-4-dumbbell-sumo-squat-15-cossack-squat-10-na-nogu-dumbbell-01ffc0', 'Circuit 1 ×4: Dumbbell Sumo Squat 15 + Cossack Squat 10 на ногу + Dumbbell Good Morning 15 + Single-Leg Hip Thrust 15 на ногу, отдых 60 сек'),
  ('circuit-2-4-front-foot-elevated-reverse-lunge-10-na-nogu-single-leg-4c6a4c', 'Circuit 2 ×4: Front-Foot Elevated Reverse Lunge 10 на ногу + Single-Leg Romanian Deadlift 12 на ногу + Frog Pumps 35 + Banded Abduction 30, отдых 45 сек'),
  ('glute-ladder-frog-pumps-20-25-30-35-40-45-50-otdyh-15-sek', 'Glute Ladder: Frog Pumps 20→25→30→35→40→45→50, отдых 15 сек'),
  ('tempo-squat-4-12-povtoreniy-temp-4-sek-vniz-2-sek-pauza-obychnyy-e26348', 'Tempo Squat ×4: 12 повторений, темп 4 сек вниз + 2 сек пауза + обычный подъём, отдых 45 сек'),
  ('athletic-finisher-5-10-sumo-squat-jumps-10-cossack-squats-20-skater-64736a', 'Athletic Finisher ×5: 10 Sumo Squat Jumps, 10 Cossack Squats, 20 Skater Jumps, 20 Mountain Climbers, отдых 30 сек'),
  ('complex-4-renegade-row-8-na-ruku-dumbbell-clean-10-push-press-10-push-902c67', 'Complex ×4: Renegade Row 8 на руку + Dumbbell Clean 10 + Push Press 10 + Push-Up 10, отдых 60 сек'),
  ('tri-set-4-dumbbell-pullover-12-bent-over-reverse-fly-15-lateral-raise-ba69ca', 'Tri-Set ×4: Dumbbell Pullover 12 + Bent-Over Reverse Fly 15 + Lateral Raise 15, отдых 45 сек'),
  ('arms-3-zottman-curl-10-overhead-triceps-extension-12-hammer-curl-12-430bd2', 'Arms ×3: Zottman Curl 10 + Overhead Triceps Extension 12 + Hammer Curl 12 + Triceps Kickback 15, отдых 45 сек'),
  ('calisthenics-beast-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-de6a16', 'Calisthenics Beast ×5: Push-Up 10 + Bear Crawl 20 шагов + Plank Walk 10 + Sprawl 8 + Mountain Climbers 30, отдых 30 сек'),
  ('emom-16-min-4-min-1-8-renegade-rows-min-2-10-push-ups-min-3-10-9daf77', 'EMOM 16 мин ×4: мин.1 — 8 Renegade Rows, мин.2 — 10 Push-Ups, мин.3 — 10 Dumbbell Clean, мин.4 — 40 сек Shadow Boxing'),
  ('tabata-4-min-20-sek-rabota-10-sek-otdyh-fast-punches-mountain-252099', 'Tabata 4 мин (20 сек работа/10 сек отдых): Fast Punches, Mountain Climbers, Squat Thrust, отдых'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-hollow-hold-bicycle-fc03a3', 'Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Hollow Hold, Bicycle, Plank Shoulder Tap'),
  ('circuit-1-4-tempo-sumo-squat-12-bulgarian-split-squat-10-na-nogu-d9b439', 'Circuit 1 ×4: Tempo Sumo Squat 12 + Bulgarian Split Squat 10 на ногу + Staggered RDL 12 на ногу + Calf Raise 30, отдых 60 сек'),
  ('circuit-2-4-step-up-12-na-nogu-hip-thrust-15-frog-pumps-35-banded-5e8a15', 'Circuit 2 ×4: Step-Up 12 на ногу + Hip Thrust 15 + Frog Pumps 35 + Banded Kickback 20 на ногу'),
  ('athletic-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-673fed', 'Athletic Circuit ×5: Squat Jump 10 + Cossack Squat 10 на ногу + Skater Jump 20 + Reverse Lunge 10 на ногу + High Knees 30 сек, отдых 30 сек'),
  ('emom-15-min-3-min-1-12-sumo-squats-min-2-10-bulgarian-split-squats-na-8f8ed9', 'EMOM 15 мин ×3: мин.1 — 12 Sumo Squats, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 30 Frog Pumps, мин.4 — 40 сек High Knees, мин.5 — 40 сек Wall Sit'),
  ('static-ladder-wall-sit-30-45-60-75-90-sek-otdyh-30-sek', 'Static Ladder — Wall Sit: 30→45→60→75→90 сек, отдых 30 сек'),
  ('part-1-beast-complex-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-e140cf', 'Part 1 — Beast Complex ×5: Devil Press 8 (или Burpee без прыжка ×10) → Goblet Squat 12 → Renegade Row 8 на руку → Reverse Lunge 10 на ногу → Push-Up 10 → Mountain Climbers 40 сек, отдых 60 сек'),
  ('part-2-athlete-mode-4-dumbbell-thruster-10-cossack-squat-10-na-nogu-4353b4', 'Part 2 — Athlete Mode ×4: Dumbbell Thruster 10 + Cossack Squat 10 на ногу + Single-Leg RDL 10 на ногу + Bear Crawl 20 шагов + Skater Jump 20 + Sprawl 8, отдых 45 сек'),
  ('beast-amrap-15-min-10-sumo-squats-8-push-ups-10-cossack-squats-8-33da78', '🔥 BEAST AMRAP 15 мин: 10 Sumo Squats, 8 Push-Ups, 10 Cossack Squats, 8 Renegade Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skater Jumps, 8 Sprawls'),
  ('time-cap-10-min-50-sumo-squats-40-mountain-climbers-30-reverse-lunges-3f4d11', '⏱️ TIME CAP 10 мин: 50 Sumo Squats → 40 Mountain Climbers → 30 Reverse Lunges → 20 Push-Ups → 10 Burpees/Sprawls → 20 Push-Ups → 30 Reverse Lunges → 40 Mountain Climbers → 50 Sumo Squats. Цель: уложиться быстрее 10 минут'),
  ('final-conditioning-10-min-30-30-high-knees-skater-jump-mountain-49405e', 'Final Conditioning 10 мин (30/30): High Knees, Skater Jump, Mountain Climbers, Squat Jacks, Shadow Boxing, отдых')
on conflict (slug) do nothing;
insert into public.exercises (slug, title) values
  ('final-core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-243cfa', 'Final Core ×5 кругов по 60 сек (15 сек между упр.): V-Ups, Bicycle, Reverse Crunch, Plank Knee Drive'),
  ('razminka-7-min-step-touch-good-morning-bodyweight-squat-alternating-4cfeb9', 'Разминка 7 мин: Step Touch, Good Morning, Bodyweight Squat, Alternating Lunges, Hip Circles, Glute Bridge, High Knees'),
  ('block-1-4-dumbbell-sumo-squat-12-curtsy-lunge-12-na-nogu-dumbbell-628525', 'Block 1 ×4: Dumbbell Sumo Squat 12 + Curtsy Lunge 12 на ногу + Dumbbell Romanian Deadlift 12 + Hip Thrust 15 (пауза 2 сек), отдых 60 сек'),
  ('block-2-4-bulgarian-split-squat-10-na-nogu-single-leg-glute-bridge-15-211175', 'Block 2 ×4: Bulgarian Split Squat 10 на ногу + Single-Leg Glute Bridge 15 на ногу + Frog Pumps 30 + Banded Abduction 30, отдых 45 сек'),
  ('glute-mechanical-drop-set-3-hip-thrust-12-pulses-15-glute-bridge-20-5960fd', 'Glute Mechanical Drop Set ×3: Hip Thrust 12 → Pulses 15 → Glute Bridge 20 → Isometric Hold 20 сек, отдых 60 сек'),
  ('lunge-challenge-4-10-reverse-lunges-10-pulses-20-sek-static-hold-na-01e60f', 'Lunge Challenge ×4: 10 Reverse Lunges + 10 Pulses + 20 сек Static Hold на ногу, отдых 45 сек'),
  ('cardio-burst-8-min-20-sek-rabota-10-sek-otdyh-skater-high-knees-ff49ce', 'Cardio Burst 8 мин (20 сек работа/10 сек отдых): Skater, High Knees, Mountain Climbers, Squat Jack'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-dead-97c48b', 'Core ×5 кругов по 60 сек (15 сек между упр.): Reverse Crunch, Bicycle, Dead Bug, Plank Hip Dips'),
  ('superset-1-4-dumbbell-arnold-press-10-one-arm-dumbbell-row-12-na-ruku-ac5ba4', 'Superset 1 ×4: Dumbbell Arnold Press 10 + One-Arm Dumbbell Row 12 на руку + Push-Up 10–15, отдых 60 сек'),
  ('superset-2-4-dumbbell-floor-fly-12-bent-over-reverse-fly-15-lateral-c8f1e8', 'Superset 2 ×4: Dumbbell Floor Fly 12 + Bent-Over Reverse Fly 15 + Lateral Raise 15, отдых 45 сек'),
  ('arm-complex-3-zottman-curl-10-alternating-curl-10-na-ruku-overhead-881d65', 'Arm Complex ×3: Zottman Curl 10 → Alternating Curl 10 на руку → Overhead Triceps Extension 12 → Triceps Kickback 15, отдых 45 сек'),
  ('calisthenics-circuit-5-incline-push-up-12-bear-crawl-20-shagov-plank-d8a5c7', 'Calisthenics Circuit ×5: Incline Push-Up 12 + Bear Crawl 20 шагов + Plank Walk 10 + Shoulder Tap 20 + Squat Thrust 10, отдых 30 сек'),
  ('emom-16-min-4-min-1-10-arnold-press-min-2-12-dumbbell-rows-min-3-10-c53e70', 'EMOM 16 мин ×4: мин.1 — 10 Arnold Press, мин.2 — 12 Dumbbell Rows, мин.3 — 10 Push-Ups, мин.4 — 40 сек Shadow Boxing'),
  ('tabata-4-min-20-sek-rabota-10-sek-otdyh-shadow-boxing-mountain-7edd06', 'Tabata 4 мин (20 сек работа/10 сек отдых): Shadow Boxing, Mountain Climbers, Plank Jack'),
  ('block-1-4-front-foot-elevated-reverse-lunge-10-na-nogu-dumbbell-sumo-62eaee', 'Block 1 ×4: Front-Foot Elevated Reverse Lunge 10 на ногу + Dumbbell Sumo Deadlift 15 + Step-Up+Knee Drive 10 на ногу + Calf Raise 30, отдых 60 сек'),
  ('block-2-4-tempo-goblet-squat-12-temp-4-sek-vniz-single-leg-rdl-10-na-73cbef', 'Block 2 ×4: Tempo Goblet Squat 12 (темп 4 сек вниз) + Single-Leg RDL 10 на ногу + Hip Thrust Pulses 25 + Banded Kickback 20 на ногу, отдых 45 сек'),
  ('athletic-circuit-5-10-squat-jumps-10-reverse-lunges-20-skater-jumps-b637fc', 'Athletic Circuit ×5: 10 Squat Jumps, 10 Reverse Lunges, 20 Skater Jumps, 20 High Knees, 20 Mountain Climbers, отдых 30 сек'),
  ('emom-15-min-3-min-1-12-sumo-deadlifts-min-2-10-step-ups-na-nogu-min-3-0b7465', 'EMOM 15 мин ×3: мин.1 — 12 Sumo Deadlifts, мин.2 — 10 Step-Ups на ногу, мин.3 — 25 Hip Thrust Pulses, мин.4 — 40 сек High Knees, мин.5 — 40 сек Wall Sit'),
  ('static-leg-ladder-wall-sit-30-45-60-75-90-sek-otdyh-30-sek', 'Static Leg Ladder — Wall Sit: 30→45→60→75→90 сек, отдых 30 сек'),
  ('round-1-5-dumbbell-sumo-squat-12-push-up-10-reverse-lunge-10-na-nogu-432b05', 'Round 1 ×5: Dumbbell Sumo Squat 12 + Push-Up 10 + Reverse Lunge 10 на ногу + One-Arm Dumbbell Row 10 на руку + Hip Thrust 15 + Mountain Climbers 40 сек, отдых 60 сек'),
  ('round-2-4-arnold-press-10-step-up-10-na-nogu-cossack-squat-10-na-nogu-3b8358', 'Round 2 ×4: Arnold Press 10 + Step-Up 10 на ногу + Cossack Squat 10 на ногу + Bear Crawl 20 шагов + Skater 20, отдых 45 сек'),
  ('amrap-15-min-10-sumo-squats-8-push-ups-10-reverse-lunges-10-dumbbell-f02514', '🔥 AMRAP 15 мин: 10 Sumo Squats, 8 Push-Ups, 10 Reverse Lunges, 10 Dumbbell Rows, 15 Hip Thrusts, 20 Mountain Climbers, 20 Skaters. Записать: кругов + доп. повторений'),
  ('time-cap-10-min-40-sumo-squats-30-reverse-lunges-20-push-ups-30-step-5f19cb', '⏱️ TIME CAP 10 мин: 40 Sumo Squats → 30 Reverse Lunges → 20 Push-Ups → 30 Step-Ups → 20 Dumbbell Rows → 10 Squat Thrusts → 30 Mountain Climbers. Цель: уложиться быстрее 10 мин'),
  ('final-conditioning-8-min-30-30-high-knees-skater-mountain-climbers-25df91', 'Final Conditioning 8 мин (30/30): High Knees, Skater, Mountain Climbers, Squat Jack, отдых'),
  ('circuit-1-4-dumbbell-sumo-deadlift-12-front-foot-elevated-split-squat-9eb6f5', 'Circuit 1 ×4: Dumbbell Sumo Deadlift 12 + Front-Foot Elevated Split Squat 10 на ногу + Single-Leg RDL 12 на ногу + Frog Pumps 35, отдых 60 сек'),
  ('circuit-2-4-curtsy-lunge-12-na-nogu-step-up-12-na-nogu-glute-bridge-4e7ddc', 'Circuit 2 ×4: Curtsy Lunge 12 на ногу + Step-Up 12 на ногу + Glute Bridge March 20 + Banded Abduction 30, отдых 45 сек'),
  ('tempo-glute-complex-3-glute-bridge-12-3-sek-uderzhanie-15-pulses-20-2cff37', 'Tempo Glute Complex ×3: Glute Bridge 12 → 3 сек удержание → 15 Pulses → 20 сек Isometric Hold, отдых 45 сек'),
  ('leg-burn-4-10-split-squats-10-pulses-20-sek-hold-na-nogu', 'Leg Burn ×4: 10 Split Squats + 10 Pulses + 20 сек Hold на ногу'),
  ('hiit-8-min-20-sek-rabota-10-sek-otdyh-skater-jump-high-knees-squat-d1b9e0', 'HIIT 8 мин (20 сек работа/10 сек отдых): Skater Jump, High Knees, Squat Jump, Mountain Climbers'),
  ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-toe-touch-crunch-reverse-d19780', 'Core ×5 кругов по 60 сек (15 сек между упр.): Toe Touch Crunch, Reverse Crunch, Bicycle, Side Plank Hip Lift'),
  ('complex-4-dumbbell-clean-10-push-press-10-renegade-row-8-na-ruku-push-d93aa4', 'Complex ×4: Dumbbell Clean 10 + Push Press 10 + Renegade Row 8 на руку + Push-Up 10, отдых 60 сек'),
  ('tri-set-4-dumbbell-pullover-12-rear-delt-fly-15-lateral-raise-15-6ed429', 'Tri-Set ×4: Dumbbell Pullover 12 + Rear Delt Fly 15 + Lateral Raise 15, отдых 45 сек'),
  ('arm-burn-3-hammer-curl-12-zottman-curl-10-overhead-triceps-extension-632a6d', 'Arm Burn ×3: Hammer Curl 12 + Zottman Curl 10 + Overhead Triceps Extension 12 + Triceps Kickback 15, отдых 45 сек'),
  ('calisthenics-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-sprawl-8-1f1281', 'Calisthenics ×5: Push-Up 10 + Bear Crawl 20 шагов + Plank Walk 10 + Sprawl 8 + Mountain Climbers 30, отдых 30 сек'),
  ('emom-16-min-4-min-1-8-dumbbell-cleans-min-2-10-push-ups-min-3-8-cad5b2', 'EMOM 16 мин ×4: мин.1 — 8 Dumbbell Cleans, мин.2 — 10 Push-Ups, мин.3 — 8 Renegade Rows на руку, мин.4 — 40 сек Shadow Boxing'),
  ('tabata-4-min-20-sek-rabota-10-sek-otdyh-fast-punches-mountain-1860cd', 'Tabata 4 мин (20 сек работа/10 сек отдых): Fast Punches, Mountain Climbers, Squat Thrust'),
  ('circuit-1-4-dumbbell-sumo-deadlift-15-bulgarian-split-squat-10-na-41c2eb', 'Circuit 1 ×4: Dumbbell Sumo Deadlift 15 + Bulgarian Split Squat 10 на ногу + Cossack Squat 10 на ногу + Calf Raise 30, отдых 60 сек'),
  ('circuit-2-4-step-up-12-na-nogu-single-leg-hip-thrust-12-na-nogu-frog-12e7ee', 'Circuit 2 ×4: Step-Up 12 на ногу + Single-Leg Hip Thrust 12 на ногу + Frog Pumps 35 + Banded Kickback 20 на ногу'),
  ('athletic-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-4fbf83', 'Athletic Circuit ×5: Squat Jump 10 + Cossack Squat 10 на ногу + Skater Jump 20 + High Knees 30 сек + Mountain Climbers 30 сек, отдых 30 сек'),
  ('emom-15-min-3-min-1-12-sumo-deadlifts-min-2-10-bulgarian-split-squats-d9f3c0', 'EMOM 15 мин ×3: мин.1 — 12 Sumo Deadlifts, мин.2 — 10 Bulgarian Split Squats на ногу, мин.3 — 30 Frog Pumps, мин.4 — 40 сек High Knees, мин.5 — 45 сек Wall Sit'),
  ('static-challenge-wall-sit-45-60-75-90-120-sek-otdyh-30-sek', 'Static Challenge — Wall Sit: 45→60→75→90→120 сек, отдых 30 сек'),
  ('part-1-beast-complex-5-devil-press-8-ili-burpee-bez-pryzhka-10-sumo-19ba75', 'Part 1 — Beast Complex ×5: Devil Press 8 (или Burpee без прыжка ×10) → Sumo Deadlift 12 → Renegade Row 8 на руку → Reverse Lunge 10 на ногу → Push-Up 10 → Mountain Climbers 40 сек, отдых 60 сек'),
  ('part-2-athlete-mode-4-dumbbell-clean-10-cossack-squat-10-na-nogu-step-de30dd', 'Part 2 — Athlete Mode ×4: Dumbbell Clean 10 + Cossack Squat 10 на ногу + Step-Up 10 на ногу + Bear Crawl 20 шагов + Skater Jump 20 + Sprawl 8, отдых 45 сек'),
  ('peak-amrap-15-min-10-sumo-deadlifts-8-push-ups-10-cossack-squats-8-a6f0b9', '🔥 PEAK AMRAP 15 мин: 10 Sumo Deadlifts, 8 Push-Ups, 10 Cossack Squats, 8 Renegade Rows, 15 Frog Pumps, 20 Mountain Climbers, 20 Skater Jumps, 8 Sprawls'),
  ('time-cap-12-min-50-sumo-squats-40-mountain-climbers-30-reverse-lunges-f525eb', '⏱️ TIME CAP 12 мин: 50 Sumo Squats → 40 Mountain Climbers → 30 Reverse Lunges → 20 Push-Ups → 20 Dumbbell Rows → 10 Sprawls → 20 Push-Ups → 30 Reverse Lunges → 40 Mountain Climbers → 50 Sumo Squats. Записать время'),
  ('final-burn-10-min-30-30-high-knees-skater-mountain-climbers-squat-9ff558', 'Final Burn 10 мин (30/30): High Knees, Skater, Mountain Climbers, Squat Jacks, Shadow Boxing, отдых'),
  ('razminka-hodba-na-meste-s-vysokim-podemom-koleney-3-po-40-sek-otdyh-979a50', 'Разминка: ходьба на месте с высоким подъёмом коленей ×3 по 40 сек, отдых 20 сек'),
  ('prisedaniya-s-gantelyu-posl-podhod-15-10-pulsiruyuschih', 'Приседания с гантелью (посл. подход: 15 + 10 пульсирующих)'),
  ('bolgarskie-vypady-posl-podhod-12-10-korotkih-pulsatsiy', 'Болгарские выпады (посл. подход: 12 + 10 коротких пульсаций)'),
  ('yagodichnyy-most-s-vesom-pauza-2-sek-vverhu-posl-podhod-15-20-sek-d3a671', 'Ягодичный мост с весом (пауза 2 сек вверху; посл. подход: 15 + 20 сек статика)'),
  ('otvedenie-nogi-nazad-s-rezinkoy', 'Отведение ноги назад с резинкой'),
  ('shagi-v-storonu-s-rezinkoy', 'Шаги в сторону с резинкой'),
  ('prisedanie-podem-na-noski', 'Приседание + подъём на носки'),
  ('finalnyy-krug-3-30-sek-prisedaniya-30-sek-jumping-jacks-30-sek-32d5e7', '🔥 Финальный круг ×3: 30 сек приседания, 30 сек jumping jacks, 30 сек ягодичный мост, 30 сек быстрые шаги, отдых 60 сек'),
  ('otzhimaniya-ot-pola-s-kolen', 'Отжимания от пола/с колен'),
  ('tyaga-rezinki-k-zhivotu', 'Тяга резинки к животу'),
  ('tyaga-ganteli-odnoy-rukoy', 'Тяга гантели одной рукой'),
  ('zhim-ganteley-vverh', 'Жим гантелей вверх'),
  ('mahi-gantelyami-v-storony-posl-podhod-15-10-chastichnyh', 'Махи гантелями в стороны (посл. подход: 15 + 10 частичных)'),
  ('razgibanie-ruki-s-rezinkoy-na-tritseps', 'Разгибание руки с резинкой на трицепс'),
  ('bitseps-s-gantelyami', 'Бицепс с гантелями'),
  ('kardio-8-min-20-sek-bystro-40-sek-spokoyno-8-beg-na-meste-jumping-3b4bf4', 'Кардио 8 мин (20 сек быстро/40 сек спокойно ×8): бег на месте / jumping jacks / быстрые шаги / high knees'),
  ('press-nedeli-1-3-3-kruga-po-60-sek-skruchivaniya-podem-sognutyh-nog-e7fb4e', 'Пресс (недели 1–3) ×3 круга по 60 сек: Скручивания, Подъём согнутых ног, Велосипед, Планка, отдых 60 сек'),
  ('rumynskaya-tyaga-s-gantelyami', 'Румынская тяга с гантелями'),
  ('vypady-nazad', 'Выпады назад'),
  ('yagodichnyy-most-s-uzkoy-postanovkoy-nog-posl-podhod-20-30-sek-10b3a5', 'Ягодичный мост с узкой постановкой ног (посл. подход: 20 + 30 сек удержание)'),
  ('pozharnyy-gidrant-s-rezinkoy', '«Пожарный гидрант» с резинкой'),
  ('otvedenie-nogi-v-storonu', 'Отведение ноги в сторону'),
  ('sumo-prisedanie-posl-podhod-20-15-pulsatsiy', 'Сумо-приседание (посл. подход: 20 + 15 пульсаций)'),
  ('finisher-tabata-4-min-20-sek-rabota-10-sek-otdyh-prisedaniya-bystrye-52434e', '🔥 Финишер — Tabata 4 мин (20 сек работа/10 сек отдых): приседания / быстрые шаги с высоким коленом'),
  ('krug-4-prisedanie-zhim-ganteley-15-tyaga-ganteley-v-naklone-15-vypady-145f6b', 'Круг ×4: Приседание + жим гантелей 15 + Тяга гантелей в наклоне 15 + Выпады назад 10+10 + Отжимания 10–15 + Махи гантелью/kettlebell swing 20 + Mountain Climbers 30 сек + Jumping Jacks 30 сек, отдых 90 сек между кругами'),
  ('goblet-squat-s-shirokoy-postanovkoy', 'Goblet Squat с широкой постановкой'),
  ('vypady-v-storonu', 'Выпады в сторону'),
  ('odnonogiy-yagodichnyy-most', 'Одноногий ягодичный мост'),
  ('rumynskaya-tyaga-na-odnoy-noge', 'Румынская тяга на одной ноге'),
  ('lyagushka-frog-pumps', '«Лягушка» — Frog Pumps'),
  ('bokovye-shagi-s-rezinkoy', 'Боковые шаги с резинкой'),
  ('finisher-4-raunda-20-sek-kazhdoe-squat-jumps-mountain-climbers-otdyh', '🔥 Финишер ×4 раунда (20 сек каждое): Squat Jumps, Mountain Climbers, отдых'),
  ('otzhimaniya-s-uzkoy-postanovkoy', 'Отжимания с узкой постановкой'),
  ('tyaga-rezinki-sverhu-k-grudi', 'Тяга резинки сверху к груди'),
  ('tyaga-ganteli-k-poyasu-s-pauzoy', 'Тяга гантели к поясу с паузой'),
  ('arnold-press', 'Arnold Press'),
  ('razvedenie-ganteley-v-naklone', 'Разведение гантелей в наклоне'),
  ('razgibanie-ruk-s-rezinkoy', 'Разгибание рук с резинкой'),
  ('molotkovye-sgibaniya', 'Молотковые сгибания'),
  ('kardio-12-min-40-sek-rabota-20-sek-otdyh-high-knees-jumping-jacks-6e11da', 'Кардио 12 мин (40 сек работа/20 сек отдых): High Knees, Jumping Jacks, Skater, быстрые приседания'),
  ('press-nedelya-4-novyy-kompleks-4-kruga-po-60-sek-dead-bug-obratnye-aff6af', '🟣 Пресс (неделя 4, новый комплекс) ×4 круга по 60 сек: Dead Bug, Обратные скручивания, Russian Twist, Планка с касанием плеч, отдых 60 сек'),
  ('step-up-na-ustoychivuyu-platformu-stupen', 'Step-up на устойчивую платформу/ступень'),
  ('curtsy-lunge', 'Curtsy Lunge'),
  ('yagodichnyy-most-s-shirokoy-postanovkoy', 'Ягодичный мост с широкой постановкой'),
  ('otvedenie-nogi-nazad-v-upore', 'Отведение ноги назад в упоре'),
  ('otvedenie-nogi-v-storonu-lezha', 'Отведение ноги в сторону лёжа'),
  ('wall-sit', 'Wall Sit'),
  ('final-3-kruga-30-sek-kazhdoe-bystrye-step-up-jumping-jacks-squat-e0102f', '🔥 Финал ×3 круга (30 сек каждое): быстрые step-up, jumping jacks, squat pulses, отдых'),
  ('5-krugov-goblet-squat-15-tyaga-ganteley-v-naklone-15-vypady-nazad-10-1975d1', '5 кругов: Goblet Squat 15 + Тяга гантелей в наклоне 15 + Выпады назад 10+10 + Отжимания 10 + Румынская тяга 15 + Arnold Press 12 + Mountain Climbers 30 сек + Burpee (без прыжка или обычный) 30 сек. Отдых 60 сек после круга, 90 сек после 3-го круга, финиш после 5-го'),
  ('finalnyy-chellendzh-3-minuty-bez-ostanovki-30-sek-jumping-jacks-30-f5dcd7', '🏆 Финальный челлендж — 3 минуты без остановки: 30 сек jumping jacks, 30 сек приседания, 30 сек mountain climbers, 30 сек быстрые шаги, 30 сек jumping jacks, 30 сек планка'),
  ('itogovyy-kontrol-goda-sravnit-ves-taliyu-bedra-foto-i-rezultat-amrap-39a783', '📊 ИТОГОВЫЙ КОНТРОЛЬ ГОДА: сравнить вес/талию/бёдра/фото и результат AMRAP с показателями месяца 1 — это финиш 12-месячного цикла DonatelleX')
on conflict (slug) do nothing;

-- =====================================================================
-- ПРОГРАММА, ТРЕНИРОВКИ И ПОДХОДЫ (Похудение — Женщины — Дома)
-- =====================================================================
do $$
declare
  v_program_id uuid;
  v_workout_id uuid;
begin
  insert into public.workout_programs
    (slug, title, description, goal, gender, training_format, difficulty, duration_weeks, workouts_per_week, is_premium, locale)
  values
    ('pohudenie-zhenshchiny-doma', 'Похудение для женщин (дома) — DonatelleX, годовая программа', 'Похудение для женщин (дома) — DonatelleX, годовая программа. Оборудование: Гантели, резинки разной жёсткости, коврик, устойчивая платформа/ступень (по возможности)', 'lose_weight', 'female', 'home', 'intermediate', 48, 4, true, 'ru')
  on conflict (slug) do update set
    title = excluded.title, description = excluded.description, goal = excluded.goal,
    gender = excluded.gender, training_format = excluded.training_format,
    duration_weeks = excluded.duration_weeks, workouts_per_week = excluded.workouts_per_week,
    updated_at = now()
  returning id into v_program_id;

  delete from public.workouts where program_id = v_program_id;

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · LOWER BODY + GLUTES', 1, 'LEVEL 1.1 — ADAPTATION (недели 1–2)', 1, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-2-30-sek-hodba-na-meste-30-sek-shagi-v-storony-30-sek-podem-ff336f', 0, null::int, 300, 60, 1, '5 мин'),
    ('osnovnoy-krug-4-prisedanie-15-vypad-nazad-12-na-nogu-yagodichnyy-most-9fd93e', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-finisher-3-30-sek-prisedaniya-s-korotkoy-amplitudoy-30-sek-a03001', 20, null::int, null::int, 60, 3, 'круг'),
    ('kardio-10-min-40-sek-rabota-20-sek-otdyh-2-bystraya-hodba-na-meste-b762bc', 30, null::int, 600, 60, 1, '10 мин'),
    ('press-3-kruga-po-60-sek-dead-bug-bicycle-reverse-crunch-planka-otdyh-32e8f1', 40, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · UPPER BODY + FAT BURN', 2, 'LEVEL 1.1 — ADAPTATION (недели 1–2)', 1, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('osnovnoy-krug-4-otzhimaniya-ot-vozvysheniya-12-15-tyaga-rezinki-k-79704b', 10, null::int, null::int, 60, 4, 'круг'),
    ('cardio-circuit-4-40-sek-high-knees-40-sek-step-touch-40-sek-mountain-8cd129', 20, null::int, null::int, 60, 4, 'круг'),
    ('press-3-kruga-po-60-sek-podem-sognutyh-nog-bicycle-toe-touch-planka-4fdba2', 30, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · FULL BODY FAT BURN', 3, 'LEVEL 1.1 — ADAPTATION (недели 1–2)', 1, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka', 0, null::int, 300, 60, 1, '5 мин'),
    ('krug-4-goblet-squat-15-ili-obychnyy-prised-rumynskaya-tyaga-s-5b1795', 10, null::int, null::int, 60, 4, 'круг'),
    ('cardio-block-4-30-sek-squat-knee-drive-30-sek-mountain-climbers-30-65cd7b', 20, null::int, null::int, 60, 4, 'круг'),
    ('finisher-5-min-30-30-high-knees-squat-mountain-climbers-jumping-jack-1887bd', 30, null::int, 300, 60, 1, '5 мин'),
    ('press-3-kruga-po-60-sek-reverse-crunch-bicycle-leg-raise-planka-otdyh-7e0937', 40, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · LOWER BODY BOOST', 1, 'LEVEL 1.2 — BOOST (недели 3–4)', 2, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-sumo-squat-15-posl-5-pulsatsii-bulgarian-split-squat-10-na-bf9070', 0, null::int, null::int, 60, 4, 'круг'),
    ('glute-finisher-4-20-squat-pulses-20-glute-bridge-20-abduction-30-sek-446efe', 10, null::int, null::int, 45, 4, 'круг'),
    ('kardio-12-min-3-30-30-high-knees-mountain-climbers-fast-feet-step-33cc38', 20, null::int, 720, 60, 1, '12 мин'),
    ('press-4-kruga-po-60-sek-dead-bug-reverse-crunch-bicycle-planka-otdyh-5d6295', 30, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Среда · UPPER BODY BOOST', 2, 'LEVEL 1.2 — BOOST (недели 3–4)', 2, 52)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-obychnye-otzhimaniya-8-15-s-kolen-esli-tyazhelo-tyaga-ganteli-7505b1', 0, null::int, null::int, 60, 4, 'круг'),
    ('emom-12-min-4-min-1-10-otzhimaniy-min-2-15-tyag-rezinki-min-3-30-sek-a6939a', 10, null::int, null::int, 60, 4, 'круг'),
    ('press-4-kruga-po-60-sek-leg-raise-bicycle-toe-touch-plank-otdyh-60-sek', 20, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Пятница · FULL BODY — LEVEL BOOST', 3, 'LEVEL 1.2 — BOOST (недели 3–4)', 2, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-dumbbell-thruster-12-reverse-lunge-knee-drive-10-na-nogu-35d180', 0, null::int, null::int, 60, 5, 'круг'),
    ('final-6-6-min-40-20-squat-high-knees-push-up-mountain-climbers-4d92d4', 10, null::int, 360, 60, 1, '6 мин'),
    ('press-4-kruga-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-hold-a16aa8', 20, null::int, null::int, 60, 4, 'круг'),
    ('level-1-final-challenge-amrap-10-min-10-squats-8-reverse-lunges-8-ccf0fb', 30, null::int, null::int, 60, 1, 'AMRAP 10 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTES + LEGS', 1, 'LEVEL 2.1 — BUILD (недели 5–6)', 3, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-2-30-sek-marsh-prised-shagi-v-storonu-podem-koleney-a63bd1', 0, null::int, 360, 60, 1, '6 мин'),
    ('osnovnoy-blok-4-goblet-squat-15-posl-5-medlenno-bulgarian-split-squat-f97058', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-superset-3-banded-kickback-15-na-nogu-frog-pumps-25-otdyh-45-sek', 20, null::int, null::int, 45, 3, 'круг'),
    ('leg-finisher-3-30-sek-squat-pulses-30-sek-reverse-lunge-30-sek-wall-157979', 30, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-3-40-20-high-knees-mountain-climbers-fast-feet-jumping-d68794', 40, null::int, 720, 60, 1, '12 мин'),
    ('core-4-kruga-po-60-sek-reverse-crunch-dead-bug-bicycle-plank-otdyh-60-865fec', 50, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY + CARDIO', 2, 'LEVEL 2.1 — BUILD (недели 5–6)', 3, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-arnold-press-12-729118', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-shoulders-3-lateral-raise-15-reverse-fly-15-uderzhanie-ruk-v-d8bf39', 10, null::int, null::int, 60, 3, 'круг'),
    ('emom-12-min-4-min-1-10-push-ups-min-2-15-band-rows-min-3-40-sek-f84761', 20, null::int, null::int, 60, 4, 'круг'),
    ('core-4-kruga-po-60-sek-leg-raise-bicycle-toe-touch-hollow-hold-otdyh-717fad', 30, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY + METABOLIC', 3, 'LEVEL 2.1 — BUILD (недели 5–6)', 3, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-reverse-lunge-12-na-nogu-squat-15-calf-raise-20', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-romanian-deadlift-15-glute-bridge-20-banded-abduction-25', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-3-3-step-up-12-na-nogu-knee-drive-12-na-nogu', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-finisher-5-30-sek-squat-30-sek-high-knees-30-sek-reverse-400cf4', 30, null::int, null::int, 60, 5, 'круг'),
    ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-60-c2833e', 40, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — LEVEL 2', 4, 'LEVEL 2.1 — BUILD (недели 5–6)', 3, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-5-dumbbell-thruster-12-dumbbell-row-10-na-ruku-reverse-lunge-c9b796', 0, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-4878d9', 10, null::int, null::int, 60, 3, 'круг'),
    ('final-burn-4-min-20-20-squat-mountain-climbers-fast-feet-otdyh', 20, null::int, 240, 60, 1, '4 мин'),
    ('core-4-kruga-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-hold-otdyh-a922d0', 30, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE SHOCK', 1, 'LEVEL 2.2 — SHOCK (недели 7–8)', 4, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-sumo-squat-12-temp-3-sek-vniz-single-leg-hip-thrust-12-na-nogu-aac2d9', 0, null::int, null::int, 60, 4, 'круг'),
    ('glute-mechanical-drop-set-3-12-bulgarian-split-squats-15-reverse-b5f90b', 10, null::int, null::int, 60, 3, 'круг'),
    ('static-finisher-3-wall-sit-45-sek-glute-bridge-hold-45-sek-otdyh-30-249a9d', 20, null::int, null::int, 30, 3, 'круг'),
    ('kardio-14-min-30-30-high-knees-skater-step-mountain-climbers-fast-a8f0cd', 30, null::int, 840, 60, 1, '14 мин'),
    ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-60-c2833e', 40, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY SHOCK', 2, 'LEVEL 2.2 — SHOCK (недели 7–8)', 4, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-10-15-one-arm-row-12-na-ruku', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-arnold-press-10-lateral-raise-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-3-hammer-curl-12-triceps-kickback-15', 20, null::int, null::int, 60, 3, 'круг'),
    ('superset-4-3-band-face-pull-20-reverse-fly-15', 30, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-finisher-4-8-push-ups-10-mountain-climbers-na-storonu-20-28859b', 40, null::int, null::int, 45, 4, 'круг'),
    ('emom-12-min-4-min-1-10-push-ups-min-2-15-band-rows-min-3-40-sek-b33109', 50, null::int, null::int, 60, 4, 'круг'),
    ('core-4-kruga-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-d5cc18', 60, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LEGS + METABOLIC SHOCK', 3, 'LEVEL 2.2 — SHOCK (недели 7–8)', 4, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-goblet-squat-12-reverse-lunge-10-na-nogu-squat-pulse-20', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-romanian-deadlift-12-single-leg-glute-bridge-12-na-nogu-93df67', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-3-3-lateral-lunge-12-na-nogu-step-up-12-na-nogu', 20, null::int, null::int, 60, 3, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-reverse-lunges-na-nogu-f12804', 30, null::int, null::int, 60, 3, 'круг'),
    ('finisher-5-min-20-sek-kazhdoe-squat-pulses-high-knees-glute-bridge-5e842b', 40, null::int, 300, 60, 1, '5 мин'),
    ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-v-ups-plank-otdyh-60-sek', 50, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 LEVEL 2 — BOSS TRAINING', 4, 'LEVEL 2.2 — SHOCK (недели 7–8)', 4, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-strength-4-goblet-squat-12-push-up-10-romanian-deadlift-12-d540ee', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-power-4-squat-to-knee-drive-12-na-nogu-dumbbell-thruster-10-ad44f9', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-3-glutes-3-15-hip-thrust-15-reverse-lunges-20-abduction-30-sek-92f22a', 20, null::int, null::int, 60, 3, 'круг'),
    ('final-amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-62f7f0', 30, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-hollow-6e41c0', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'LEVEL 3.1 — IGNITION 🔥 (недели 9–10)', 5, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-marsh-s-vysokim-kolenom-prised-shagi-v-storonu-dc6987', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-front-squat-12-reverse-lunge-knee-drive-10-na-nogu-9a8c76', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-glute-superset-3-curtsy-lunge-12-na-nogu-frog-pumps-25-glute-562651', 20, null::int, null::int, 60, 3, 'круг'),
    ('leg-burn-3-20-squat-pulses-10-reverse-lunges-na-nogu-30-sek-wall-sit-89fd1f', 30, null::int, null::int, 60, 3, 'круг'),
    ('cardio-interval-15-min-3-30-30-high-knees-skater-mountain-climbers-9a913f', 40, null::int, 900, 60, 1, '15 мин'),
    ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-shoulder-adaa15', 50, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY + CONDITIONING', 2, 'LEVEL 3.1 — IGNITION 🔥 (недели 9–10)', 5, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-12-15-one-arm-dumbbell-row-12-na-ruku', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-arnold-press-12-lateral-raise-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-4-hammer-curl-12-overhead-triceps-extension-15', 20, null::int, null::int, 60, 4, 'круг'),
    ('superset-4-4-band-face-pull-20-reverse-fly-15', 30, null::int, null::int, 60, 4, 'круг'),
    ('calisthenics-block-4-8-12-push-ups-10-plank-shoulder-taps-na-storonu-ddfeaf', 40, null::int, null::int, 60, 4, 'круг'),
    ('emom-15-min-3-min-1-12-push-ups-min-2-15-band-rows-min-3-40-sek-2750c8', 50, null::int, null::int, 60, 3, 'круг'),
    ('core-4-kruga-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-d5cc18', 60, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY — POWER + METABOLIC', 3, 'LEVEL 3.1 — IGNITION 🔥 (недели 9–10)', 5, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-sumo-squat-15-posl-5-medlenno-walking-lunges-12-na-nogu-01e097', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-staggered-romanian-deadlift-12-na-nogu-single-leg-glute-00f57b', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-3-3-step-up-12-na-nogu-step-up-knee-drive-10-na-nogu', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-circuit-5-30-sek-kazhdoe-squat-high-knees-mountain-climbers-da4ede', 30, null::int, null::int, 60, 5, 'круг'),
    ('core-4-kruga-po-60-sek-reverse-crunch-bicycle-plank-dead-bug-otdyh-60-48081e', 40, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — IGNITION', 4, 'LEVEL 3.1 — IGNITION 🔥 (недели 9–10)', 5, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-5-dumbbell-thruster-12-reverse-lunge-10-na-nogu-one-arm-row-9758cf', 0, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-11ef68', 10, null::int, null::int, 60, 3, 'круг'),
    ('finisher-6-min-20-20-fast-feet-squat-pulses-mountain-climbers-jumping-92a711', 20, null::int, 360, 60, 1, '6 мин'),
    ('core-4-kruga-po-60-sek-v-ups-reverse-crunch-bicycle-plank-otdyh-60-sek', 30, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE OVERDRIVE', 1, 'LEVEL 3.2 — OVERDRIVE ⚡ (недели 11–12)', 6, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-sumo-squat-15-curtsy-lunge-12-na-nogu-hip-thrust-20-banded-ef6693', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-bulgarian-split-squat-10-na-nogu-romanian-deadlift-12-frog-03f3a6', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-drop-set-3-10-bulgarian-split-squats-12-reverse-lunges-15-31f24f', 20, null::int, null::int, 60, 3, 'круг'),
    ('power-finisher-5-20-sek-kazhdoe-squat-jump-ili-bystryy-prised-bez-421957', 30, null::int, null::int, 60, 5, 'круг'),
    ('core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-shoulder-ac0641', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY OVERDRIVE', 2, 'LEVEL 3.2 — OVERDRIVE ⚡ (недели 11–12)', 6, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-3-incline-push-up-15-dumbbell-row-15-na-ruku', 0, null::int, null::int, 60, 3, 'круг'),
    ('superset-2-3-dumbbell-shoulder-press-12-bent-over-reverse-fly-15', 10, null::int, null::int, 60, 3, 'круг'),
    ('superset-3-3-alternating-biceps-curl-12-na-ruku-triceps-kickback-15', 20, null::int, null::int, 60, 3, 'круг'),
    ('superset-4-3-band-pull-apart-20-band-face-pull-20', 30, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-challenge-4-10-push-ups-10-bear-crawl-steps-20-plank-3ce486', 40, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-8fd629', 50, null::int, null::int, 60, 4, 'круг'),
    ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-hollow-hold-otdyh-60-afe180', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY — SHOCK', 3, 'LEVEL 3.2 — OVERDRIVE ⚡ (недели 11–12)', 6, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-front-rack-squat-12-walking-lunge-12-na-nogu-single-leg-9c5070', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-hip-thrust-15-frog-pumps-30-banded-kickback-20-na-nogu-8616f0', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-15-min-3-min-1-15-goblet-squats-min-2-12-reverse-lunges-na-nogu-0485bb', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-finisher-6-min-2-30-sek-kazhdoe-squat-mountain-climbers-87312e', 30, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-plank-dead-bug-otdyh-1ca84b', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 👑 BOSS FIGHT — LEVEL 3', 4, 'LEVEL 3.2 — OVERDRIVE ⚡ (недели 11–12)', 6, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-full-body-5-goblet-squat-12-push-up-10-romanian-deadlift-12-592202', 0, null::int, null::int, 60, 5, 'круг'),
    ('block-2-power-4-dumbbell-thruster-12-squat-to-knee-drive-10-na-nogu-118e96', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-735f25', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-burn-5-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-4ebd3c', 30, null::int, 300, 60, 1, '5 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-7be596', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE POWER', 1, 'LEVEL 4.1 — POWER ⚡ (недели 13–14)', 7, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-marsh-s-vysokim-kolenom-bodyweight-squat-lateral-step-a5c291', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-sumo-squat-12-temp-3-sek-vniz-front-foot-elevated-eedb53', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-unilateral-glute-3-single-leg-glute-bridge-15-na-nogu-curtsy-2f14db', 20, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-4-20-squat-pulses-10-reverse-lunges-na-nogu-30-sek-wall-310d28', 30, null::int, null::int, 60, 4, 'круг'),
    ('kardio-16-min-2-30-sek-rabota-30-sek-otdyh-high-knees-skater-mountain-cc8e54', 40, null::int, 960, 60, 1, '16 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-e802fa', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY POWER', 2, 'LEVEL 4.1 — POWER ⚡ (недели 13–14)', 7, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-12-15-one-arm-dumbbell-row-12-na-ruku', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-dumbbell-shoulder-press-12-lateral-raise-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-4-alternating-biceps-curl-12-na-ruku-triceps-kickback-15', 20, null::int, null::int, 60, 4, 'круг'),
    ('superset-4-4-band-face-pull-20-bent-over-reverse-fly-15', 30, null::int, null::int, 60, 4, 'круг'),
    ('calisthenics-block-4-10-push-ups-10-bear-crawl-vpered-10-nazad-20-346b7c', 40, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-8fd629', 50, null::int, null::int, 60, 4, 'круг'),
    ('cardio-finisher-6-min-20-sek-kazhdoe-fast-feet-mountain-climbers-241428', 60, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-e5fac3', 70, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY — STRENGTH + CONDITIONING', 3, 'LEVEL 4.1 — POWER ⚡ (недели 13–14)', 7, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-dumbbell-front-squat-12-walking-lunge-12-na-nogu-single-leg-60cc6a', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-dumbbell-romanian-deadlift-15-hip-thrust-15-frog-pumps-30-83cae0', 10, null::int, null::int, 60, 4, 'круг'),
    ('static-challenge-3-wall-sit-45-sek-glute-bridge-hold-45-sek-squat-c14ac9', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-block-5-30-sek-kazhdoe-high-knees-reverse-lunges-mountain-9d1923', 30, null::int, null::int, 60, 5, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-389d9d', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — POWER CHALLENGE', 4, 'LEVEL 4.1 — POWER ⚡ (недели 13–14)', 7, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-5-dumbbell-thruster-12-reverse-lunge-knee-drive-10-na-nogu-54082d', 0, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-11ef68', 10, null::int, null::int, 60, 3, 'круг'),
    ('amrap-8-min-10-squats-8-push-ups-10-reverse-lunges-10-dumbbell-rows-e934e7', 20, null::int, null::int, 60, 1, 'AMRAP 8 мин'),
    ('core-5-krugov-po-60-sek-v-ups-reverse-crunch-bicycle-plank-shoulder-bd2b07', 30, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE CHAOS', 1, 'LEVEL 4.2 — CHAOS 🔥 (недели 15–16)', 8, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-goblet-squat-pulse-12-3-pulses-bulgarian-split-squat-10-0a4221', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-3-romanian-deadlift-12-curtsy-lunge-12-na-nogu-frog-pumps-81f47c', 10, null::int, null::int, 60, 3, 'круг'),
    ('glute-drop-challenge-3-10-bulgarian-split-squats-12-reverse-lunges-15-697122', 20, null::int, null::int, 60, 3, 'круг'),
    ('kardio-18-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet-a95c09', 30, null::int, 1080, 60, 1, '18 мин'),
    ('core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-otdyh-60-4aa7be', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY CHAOS', 2, 'LEVEL 4.2 — CHAOS 🔥 (недели 15–16)', 8, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-3-incline-push-up-15-dumbbell-row-15-na-ruku', 0, null::int, null::int, 60, 3, 'круг'),
    ('superset-2-3-arnold-press-10-front-raise-12-lateral-raise-15', 10, null::int, null::int, 60, 3, 'круг'),
    ('superset-3-3-hammer-curl-12-overhead-triceps-extension-15', 20, null::int, null::int, 60, 3, 'круг'),
    ('superset-4-3-band-pull-apart-25-face-pull-20', 30, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-challenge-5-8-12-push-ups-20-plank-shoulder-taps-10-bear-e09aff', 40, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-af4d18', 50, null::int, null::int, 60, 3, 'круг'),
    ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-hollow-hold-otdyh-60-afe180', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY — CHAOS', 3, 'LEVEL 4.2 — CHAOS 🔥 (недели 15–16)', 8, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-sumo-squat-15-walking-lunges-12-na-nogu-staggered-rdl-12-5be235', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-hip-thrust-20-single-leg-glute-bridge-15-na-nogu-banded-08087b', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-15-goblet-squats-min-2-12-walking-lunges-na-nogu-86af7a', 20, null::int, null::int, 60, 4, 'круг'),
    ('metabolic-finisher-6-min-2-30-sek-kazhdoe-squat-pulses-mountain-9b56ec', 30, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-e802fa', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 👑 BOSS FIGHT — LEVEL 4', 4, 'LEVEL 4.2 — CHAOS 🔥 (недели 15–16)', 8, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-goblet-squat-12-push-up-10-romanian-deadlift-12-reverse-fb2c91', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-dumbbell-thruster-10-bear-crawl-20-shagov-squat-to-knee-e853f7', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-walking-lunges-10-870cc6', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-challenge-6-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-8d3275', 30, null::int, 360, 60, 1, '6 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-7be596', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE OVERLOAD', 1, 'LEVEL 5.1 — OVERLOAD 🔥 (недели 17–18)', 9, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-marsh-s-vysokim-kolenom-bodyweight-squat-lateral-walk-f2b21a', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-front-squat-10-12-bulgarian-split-squat-10-na-nogu-1fa536', 10, null::int, null::int, 75, 4, 'круг'),
    ('block-2-posterior-chain-3-single-leg-romanian-deadlift-10-na-nogu-d1fd48', 20, null::int, null::int, 60, 3, 'круг'),
    ('glute-mechanical-drop-set-3-8-bulgarian-split-squats-10-reverse-1f06f0', 30, null::int, null::int, 75, 3, 'круг'),
    ('kardio-15-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet-7f7387', 40, null::int, 900, 60, 1, '15 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-e802fa', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY OVERLOAD', 2, 'LEVEL 5.1 — OVERLOAD 🔥 (недели 17–18)', 9, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-dumbbell-floor-press-10-12-one-arm-dumbbell-row-12-na-466578', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-arnold-press-10-12-lateral-raise-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-3-hammer-curl-12-overhead-triceps-extension-12-15', 20, null::int, null::int, 60, 3, 'круг'),
    ('superset-4-3-bent-over-reverse-fly-15-band-face-pull-20', 30, null::int, null::int, 60, 3, 'круг'),
    ('weighted-calisthenics-4-push-up-8-12-plank-shoulder-tap-20-bear-crawl-5927ab', 40, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-e20be0', 50, null::int, null::int, 60, 4, 'круг'),
    ('core-5-krugov-po-60-sek-leg-raise-v-ups-bicycle-hollow-hold-otdyh-60-e5fac3', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY OVERLOAD', 3, 'LEVEL 5.1 — OVERLOAD 🔥 (недели 17–18)', 9, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-goblet-squat-12-walking-lunge-10-na-nogu-dumbbell-romanian-812b88', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-s-gantelyami-10-na-nogu-hip-thrust-15-banded-ee581c', 10, null::int, null::int, 60, 4, 'круг'),
    ('static-strength-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-8e43c5', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-block-5-30-sek-kazhdoe-high-knees-squat-mountain-climbers-a4166c', 30, null::int, null::int, 60, 5, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-389d9d', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · FULL BODY — OVERLOAD CHALLENGE', 4, 'LEVEL 5.1 — OVERLOAD 🔥 (недели 17–18)', 9, 56)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-5-dumbbell-thruster-10-romanian-deadlift-12-reverse-lunge-10-35c494', 0, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-10-goblet-squats-min-2-10-push-ups-min-3-12-6ad7cb', 10, null::int, null::int, 60, 3, 'круг'),
    ('amrap-10-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-e1f864', 20, null::int, null::int, 60, 1, 'AMRAP 10 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-c17ffb', 30, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · GLUTE TURBO', 1, 'LEVEL 5.2 — TURBO ⚡ (недели 19–20)', 10, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-sumo-goblet-squat-12-posl-3-pauza-vnizu-deficit-reverse-358221', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-staggered-romanian-deadlift-12-na-nogu-frog-pumps-30-a4753b', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-burn-3-12-squats-12-reverse-lunges-15-frog-pumps-20-squat-d17dc8', 20, null::int, null::int, 60, 3, 'круг'),
    ('cardio-turbo-18-min-3-30-30-high-knees-skater-mountain-climbers-fast-ce07b9', 30, null::int, 1080, 60, 1, '18 мин'),
    ('core-5-krugov-po-60-sek-v-ups-reverse-crunch-bicycle-plank-otdyh-60-7a62a6', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · UPPER BODY TURBO', 2, 'LEVEL 5.2 — TURBO ⚡ (недели 19–20)', 10, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tri-set-1-3-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-dumbbell-514e43', 0, null::int, null::int, 75, 3, 'круг'),
    ('tri-set-2-3-lateral-raise-15-reverse-fly-15-band-face-pull-20', 10, null::int, null::int, 60, 3, 'круг'),
    ('arm-finisher-3-hammer-curl-12-triceps-kickback-15-biceps-hold-20-sek', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-circuit-5-8-12-push-ups-20-plank-shoulder-taps-20-bear-7571e4', 30, null::int, null::int, 45, 5, 'круг'),
    ('emom-16-min-4-min-1-12-push-ups-min-2-15-dumbbell-rows-min-3-12-0ee2e4', 40, null::int, null::int, 60, 4, 'круг'),
    ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-hollow-hold-otdyh-60-afe180', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · LOWER BODY TURBO', 3, 'LEVEL 5.2 — TURBO ⚡ (недели 19–20)', 10, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-dumbbell-front-squat-12-walking-lunge-12-na-nogu-single-leg-36208f', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-hip-thrust-15-bulgarian-split-squat-10-na-nogu-frog-pumps-7c0edc', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-12-goblet-squats-min-2-10-bulgarian-split-squats-b40a8c', 20, null::int, null::int, 60, 4, 'круг'),
    ('metabolic-finisher-8-min-20-sek-kazhdoe-squat-pulses-mountain-84bd7b', 30, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-e802fa', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 👑 BOSS FIGHT — LEVEL 5', 4, 'LEVEL 5.2 — TURBO ⚡ (недели 19–20)', 10, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-7c18c7', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-sumo-squat-12-dumbbell-shoulder-press-10-walking-lunge-10-0859ff', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-44d457', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-boss-6-min-20-sek-kazhdoe-high-knees-squat-pulses-mountain-5a367a', 30, null::int, 360, 60, 1, '6 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-7be596', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 LOWER BODY CONTROL', 1, 'LEVEL 6.1 — STRENGTH + CONTROL (недели 21–22)', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-march-high-knees-bodyweight-squat-hip-circle-glute-d6c934', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-sila-4-goblet-squat-12-temp-3-sek-vniz-romanian-deadlift-s-760be9', 10, null::int, null::int, 75, 4, 'круг'),
    ('block-2-yagoditsy-3-bulgarian-split-squat-10-na-nogu-single-leg-glute-13459a', 20, null::int, null::int, 60, 3, 'круг'),
    ('static-block-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-30-45d9dd', 30, null::int, null::int, 60, 3, 'круг'),
    ('glute-finisher-3-15-squats-15-frog-pumps-20-glute-bridge-20-squat-67f380', 40, null::int, null::int, 60, 3, 'круг'),
    ('kardio-12-min-3-40-20-high-knees-skater-mountain-climbers-fast-feet', 50, null::int, 720, 60, 1, '12 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-otdyh-389d9d', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY + CONDITIONING', 2, 'LEVEL 6.1 — STRENGTH + CONTROL (недели 21–22)', 11, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-8-15-one-arm-dumbbell-row-12-na-ruku', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-dumbbell-shoulder-press-10-12-lateral-raise-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-3-hammer-curl-12-triceps-extension-15-band-face-pull-20', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-block-4-push-up-10-bear-crawl-20-shagov-plank-shoulder-dc01ec', 30, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-bffd22', 40, null::int, null::int, 60, 4, 'круг'),
    ('cardio-finisher-8-min-2-30-30-high-knees-skater-mountain-climbers-228c03', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-hollow-hold-otdyh-60-afe180', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LOWER BODY + METABOLIC', 3, 'LEVEL 6.1 — STRENGTH + CONTROL (недели 21–22)', 11, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-sumo-goblet-squat-12-walking-lunge-10-na-nogu-dumbbell-5615ec', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-10-na-nogu-hip-thrust-15-banded-kickback-20-na-nogu-968c6a', 10, null::int, null::int, 60, 4, 'круг'),
    ('single-leg-challenge-3-single-leg-squat-to-chair-8-na-nogu-single-leg-a3685d', 20, null::int, null::int, 60, 3, 'круг'),
    ('metabolic-interval-10-min-40-20-squat-to-knee-drive-mountain-climbers-7833c3', 30, null::int, 600, 60, 1, '10 мин'),
    ('static-finisher-3-wall-sit-60-sek-glute-bridge-hold-60-sek-plank-60-30c19d', 40, null::int, null::int, 60, 3, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-side-plank-77345f', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 FULL BODY TRANSFORMATION', 4, 'LEVEL 6.1 — STRENGTH + CONTROL (недели 21–22)', 11, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-strength-circuit-4-goblet-squat-12-dumbbell-romanian-deadlift-4fd640', 0, null::int, null::int, 60, 4, 'круг'),
    ('round-2-athletic-4-squat-jump-8-bear-crawl-20-shagov-mountain-486354', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-push-ups-min-3-12-11ef68', 20, null::int, null::int, 60, 3, 'круг'),
    ('amrap-10-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-d4a8b3', 30, null::int, null::int, 60, 1, 'AMRAP 10 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-c17ffb', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE SPEED', 1, 'LEVEL 6.2 — SPEED + CONDITIONING (недели 23–24)', 12, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-sumo-squat-15-curtsy-lunge-12-na-nogu-staggered-rdl-12-na-ff1e2c', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-step-up-knee-drive-10-na-nogu-frog-pumps-30-banded-ad2bc1', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-ladder-10-15-20-25-30-squats-otdyh-20-sek-mezhdu-stupenyami-60-8272a6', 20, null::int, null::int, 60, 1, 'лестница'),
    ('interval-cardio-15-min-3-30-30-high-knees-skater-squat-jump-mountain-99d73a', 30, null::int, 900, 60, 1, '15 мин'),
    ('core-5-krugov-po-60-sek-bicycle-reverse-crunch-leg-raise-plank-otdyh-dc98f6', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 🔥 UPPER BODY CONDITIONING', 2, 'LEVEL 6.2 — SPEED + CONDITIONING (недели 23–24)', 12, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tri-set-1-4-push-up-10-15-renegade-row-8-na-ruku-arnold-press-10-3471ad', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-2-3-lateral-raise-15-bent-over-reverse-fly-15-band-face-pull-918a0a', 10, null::int, null::int, 60, 3, 'круг'),
    ('arms-3-hammer-curl-12-overhead-triceps-extension-15-biceps-hold-30-sek', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-circuit-5-10-push-ups-20-plank-shoulder-taps-20-bear-b37e29', 30, null::int, null::int, 45, 5, 'круг'),
    ('emom-16-min-4-min-1-12-push-ups-min-2-12-renegade-rows-min-3-12-97851b', 40, null::int, null::int, 60, 4, 'круг'),
    ('cardio-finisher-6-min-20-sek-kazhdoe-fast-feet-high-knees-skater-otdyh', 50, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-v-ups-bicycle-hollow-hold-plank-shoulder-tap-548020', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LEG CONDITIONING', 3, 'LEVEL 6.2 — SPEED + CONDITIONING (недели 23–24)', 12, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-goblet-squat-15-reverse-lunge-knee-drive-10-na-nogu-c4f2ce', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-20-frog-pumps-50fc4b', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-15-goblet-squats-min-2-10-bulgarian-split-squats-be4f58', 20, null::int, null::int, 60, 4, 'круг'),
    ('metabolic-finisher-8-min-20-sek-kazhdoe-squat-pulses-mountain-bd119d', 30, null::int, 480, 60, 1, '8 мин'),
    ('static-challenge-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-491ba9', 40, null::int, null::int, 60, 2, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-side-plank-77345f', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 👑 BOSS FIGHT — LEVEL 6', 4, 'LEVEL 6.2 — SPEED + CONDITIONING (недели 23–24)', 12, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-curtsy-0da472', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-sumo-squat-15-arnold-press-10-walking-lunge-10-na-nogu-bear-4db7f6', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-9b84d1', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-boss-8-min-30-30-high-knees-mountain-climbers-skater-squat-00ba44', 30, null::int, 480, 60, 1, '8 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-f774d8', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 ATHLETE GLUTES', 1, 'LEVEL 7.1 — ATHLETE STRENGTH (недели 25–26)', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-legkiy-beg-na-meste-hip-circle-bodyweight-squat-0fe248', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-sila-4-dumbbell-sumo-squat-12-posl-3-pauza-2-sek-vnizu-546e7e', 10, null::int, null::int, 75, 4, 'круг'),
    ('block-2-odnostoronnyaya-rabota-3-step-up-12-na-nogu-single-leg-48915f', 20, null::int, null::int, 60, 3, 'круг'),
    ('static-triangle-3-wall-sit-60-sek-glute-bridge-hold-45-sek-squat-hold-a49ab0', 30, null::int, null::int, 60, 3, 'круг'),
    ('glute-finisher-3-20-frog-pumps-15-squat-pulses-15-reverse-lunges-30-2580ca', 40, null::int, null::int, 45, 3, 'круг'),
    ('hiit-10-min-2-40-20-high-knees-skater-mountain-climbers-squat-to-knee-1deb2f', 50, null::int, 600, 60, 1, '10 мин'),
    ('core-5-krugov-po-60-sek-dead-bug-reverse-crunch-bicycle-plank-df89d8', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 ATHLETE UPPER BODY', 2, 'LEVEL 7.1 — ATHLETE STRENGTH (недели 25–26)', 13, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-arnold-press-10-bent-over-reverse-fly-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('superset-3-3-hammer-curl-12-dumbbell-triceps-extension-15-band-face-d28779', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-block-4-push-up-10-bear-crawl-20-shagov-plank-shoulder-dc01ec', 30, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-e20be0', 40, null::int, null::int, 60, 4, 'круг'),
    ('hiit-finisher-8-min-20-sek-kazhdoe-fast-feet-mountain-climbers-shadow-b54211', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-v-ups-leg-raise-bicycle-hollow-hold-otdyh-60-7f96e2', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 ATHLETE LEGS', 3, 'LEVEL 7.1 — ATHLETE STRENGTH (недели 25–26)', 13, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-front-foot-elevated-reverse-lunge-10-na-nogu-goblet-squat-19361a', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-knee-drive-10-na-nogu-hip-thrust-15-frog-pumps-30-fb06d8', 10, null::int, null::int, 60, 4, 'круг'),
    ('balance-challenge-3-single-leg-stand-30-sek-na-nogu-single-leg-rdl-10-7f7dee', 20, null::int, null::int, 60, 3, 'круг'),
    ('athletic-interval-12-min-30-30-squat-jump-skater-mountain-climbers-f3450d', 30, null::int, 720, 60, 1, '12 мин'),
    ('static-finisher-wall-sit-90-sek-glute-bridge-hold-60-sek-plank-60-sek-a223b2', 40, null::int, null::int, 60, 2, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-side-plank-77345f', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 🏆 ATHLETE BOSS FIGHT', 4, 'LEVEL 7.1 — ATHLETE STRENGTH (недели 25–26)', 13, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-7c18c7', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-sumo-squat-15-arnold-press-10-step-up-10-na-nogu-bear-crawl-234f2d', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-eecd0b', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-boss-8-min-30-30-high-knees-mountain-climbers-skater-squat-43787a', 30, null::int, 480, 60, 1, '8 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-c17ffb', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE POWER', 1, 'LEVEL 7.2 — ATHLETE SPEED (недели 27–28)', 14, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-sumo-squat-calf-raise-15-curtsy-lunge-12-na-nogu-single-87a857', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-reverse-lunge-knee-drive-10-na-nogu-frog-pumps-30-banded-011639', 10, null::int, null::int, 60, 4, 'круг'),
    ('glute-ladder-frog-pumps-10-15-20-25-30-otdyh-15-sek-mezhdu-stupenyami-46758d', 20, null::int, null::int, 60, 1, 'лестница'),
    ('power-interval-10-min-20-20-squat-jump-skater-high-knees', 30, null::int, 600, 60, 1, '10 мин'),
    ('core-5-krugov-po-60-sek-bicycle-reverse-crunch-leg-raise-plank-otdyh-dc98f6', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 🔥 UPPER BODY SPEED', 2, 'LEVEL 7.2 — ATHLETE SPEED (недели 27–28)', 14, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tri-set-1-4-push-up-10-15-renegade-row-8-na-ruku-dumbbell-push-press-82f4f2', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-2-3-lateral-raise-15-reverse-fly-15-band-face-pull-20', 10, null::int, null::int, 60, 3, 'круг'),
    ('arm-finisher-3-hammer-curl-12-triceps-kickback-15-biceps-hold-30-sek', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-circuit-5-10-push-ups-20-plank-shoulder-taps-20-bear-b37e29', 30, null::int, null::int, 45, 5, 'круг'),
    ('emom-16-min-4-min-1-12-push-ups-min-2-12-renegade-rows-min-3-12-push-c6b045', 40, null::int, null::int, 60, 4, 'круг'),
    ('cardio-finisher-8-min-20-sek-kazhdoe-fast-feet-high-knees-skater-1daca1', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-v-ups-bicycle-hollow-hold-plank-shoulder-tap-548020', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LOWER BODY SPEED', 3, 'LEVEL 7.2 — ATHLETE SPEED (недели 27–28)', 14, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-goblet-squat-15-walking-lunge-12-na-nogu-single-leg-rdl-ab61bb', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-pulses-25-65934e', 10, null::int, null::int, 60, 4, 'круг'),
    ('emom-16-min-4-min-1-15-goblet-squats-min-2-10-bulgarian-split-squats-78f9f1', 20, null::int, null::int, 60, 4, 'круг'),
    ('athletic-finisher-10-min-20-sek-kazhdoe-squat-jump-mountain-climbers-1d83b5', 30, null::int, 600, 60, 1, '10 мин'),
    ('static-challenge-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-cbc738', 40, null::int, null::int, 60, 2, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-side-plank-77345f', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · 👑 LEVEL 7 BOSS FIGHT', 4, 'LEVEL 7.2 — ATHLETE SPEED (недели 27–28)', 14, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-curtsy-17ef8e', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-sumo-squat-15-push-press-10-walking-lunge-10-na-nogu-bear-aff0c6', 10, null::int, null::int, 60, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-curtsy-lunges-10-renegade-1df5b1', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-athlete-test-10-min-30-30-high-knees-mountain-climbers-skater-f2d661', 30, null::int, 600, 60, 1, '10 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-f774d8', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 METABOLIC GLUTES', 1, 'LEVEL 8.1 — METABOLIC CONTROL (недели 29–30)', 15, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-shagi-s-vysokim-kolenom-bodyweight-good-morning-346c78', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-front-squat-12-posl-3-medlenno-reverse-lunge-knee-028a46', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-lateral-lunge-12-na-nogu-single-leg-glute-bridge-15-na-nogu-76caac', 20, null::int, null::int, 45, 4, 'круг'),
    ('metabolic-ladder-squats-10-20-30-40-50-otdyh-20-sek-mezhdu-urovnyami-cc206d', 30, null::int, null::int, 60, 1, 'лестница'),
    ('glute-burn-3-30-frog-pumps-20-glute-bridge-pulses-20-banded-e5e996', 40, null::int, null::int, 30, 3, 'круг'),
    ('hiit-10-min-30-30-squat-jack-skater-high-knees-mountain-climbers', 50, null::int, 600, 60, 1, '10 мин'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-dead-bug-plank-knee-to-b17653', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 METABOLIC UPPER BODY', 2, 'LEVEL 8.1 — METABOLIC CONTROL (недели 29–30)', 15, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-10-15-dumbbell-row-12-na-ruku-dumbbell-push-c986cf', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-floor-dumbbell-chest-press-12-lateral-raise-15-bent-over-90e043', 10, null::int, null::int, 60, 4, 'круг'),
    ('arm-tri-set-3-hammer-curl-12-triceps-kickback-15-band-face-pull-20', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-block-4-incline-push-up-12-bear-crawl-20-shagov-plank-cc0207', 30, null::int, null::int, 45, 4, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-push-464603', 40, null::int, null::int, 60, 4, 'круг'),
    ('cardio-finisher-8-min-20-sek-kazhdoe-fast-feet-mountain-climbers-e70829', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-leg-raise-bicycle-v-ups-plank-otdyh-60-sek', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🔥 LOWER BODY METABOLIC', 3, 'LEVEL 8.1 — METABOLIC CONTROL (недели 29–30)', 15, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-dumbbell-sumo-squat-15-walking-lunges-12-na-nogu-staggered-90daee', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-knee-drive-12-na-nogu-hip-thrust-pulses-25-banded-431863', 10, null::int, null::int, 60, 4, 'круг'),
    ('power-circuit-4-squat-jump-10-reverse-lunge-10-na-nogu-skater-20-99f335', 20, null::int, null::int, 60, 4, 'круг'),
    ('emom-12-min-4-min-1-15-goblet-squats-min-2-12-reverse-lunges-min-3-40-e7f959', 30, null::int, null::int, 60, 4, 'круг'),
    ('static-finisher-wall-sit-90-sek-glute-bridge-hold-60-sek-squat-hold-332ad6', 40, null::int, null::int, 60, 2, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-side-plank-dead-bug-494575', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ METABOLIC BOSS FIGHT', 4, 'LEVEL 8.1 — METABOLIC CONTROL (недели 29–30)', 15, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-95b8b7', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-sumo-squat-15-push-press-10-step-up-10-na-nogu-bear-crawl-40a19e', 10, null::int, null::int, 45, 4, 'круг'),
    ('amrap-12-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-e40934', 20, null::int, null::int, 60, 1, 'AMRAP 12 мин'),
    ('final-burn-8-min-30-30-high-knees-squat-jacks-mountain-climbers-6f5ea8', 30, null::int, 480, 60, 1, '8 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-c17ffb', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE CHAOS', 1, 'LEVEL 8.2 — METABOLIC CHAOS (недели 31–32)', 16, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-tempo-goblet-squat-12-temp-3-sek-vniz-curtsy-lunge-12-na-7854a3', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-lateral-lunge-12-na-nogu-single-leg-rdl-10-na-nogu-frog-b1c3d8', 10, null::int, null::int, 45, 4, 'круг'),
    ('glute-ladder-frog-pumps-20-25-30-35-40-otdyh-15-sek-mezhdu-urovnyami', 20, null::int, null::int, 60, 1, 'лестница'),
    ('power-finisher-4-squat-jump-10-curtsy-lunge-10-na-nogu-skater-20-28d8e0', 30, null::int, null::int, 45, 4, 'круг'),
    ('hiit-8-min-20-sek-kazhdoe-high-knees-squat-jump-mountain-climbers-05e1e7', 40, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-toe-touch-crunch-bicycle-reverse-crunch-plank-2a219f', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · ⚡ UPPER BODY CHAOS', 2, 'LEVEL 8.2 — METABOLIC CHAOS (недели 31–32)', 16, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tri-set-1-4-push-up-10-15-renegade-row-8-na-ruku-arnold-press-10-3471ad', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-2-4-floor-chest-fly-12-lateral-raise-15-reverse-fly-15', 10, null::int, null::int, 60, 4, 'круг'),
    ('arms-3-zottman-curl-10-overhead-triceps-extension-12-band-face-pull-20', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-5-incline-push-up-12-bear-crawl-20-shagov-plank-walk-10-4f3813', 30, null::int, null::int, 45, 5, 'круг'),
    ('emom-16-min-4-min-1-10-renegade-rows-min-2-12-push-ups-min-3-10-953b2b', 40, null::int, null::int, 60, 4, 'круг'),
    ('metabolic-finisher-6-min-30-sek-kazhdoe-shadow-boxing-mountain-d3fdf9', 50, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-v-ups-toe-touch-bicycle-hollow-hold-otdyh-60-3dfab3', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LOWER BODY CHAOS', 3, 'LEVEL 8.2 — METABOLIC CHAOS (недели 31–32)', 16, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-front-rack-squat-12-curtsy-lunge-12-na-nogu-single-leg-e80c3f', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-step-back-lunge-knee-drive-12-na-nogu-hip-thrust-15-frog-ad513b', 10, null::int, null::int, 60, 4, 'круг'),
    ('power-circuit-4-squat-jump-10-skater-20-reverse-lunge-10-na-nogu-b13366', 20, null::int, null::int, 45, 4, 'круг'),
    ('emom-15-min-3-min-1-15-squats-min-2-12-lunges-min-3-30-frog-pumps-min-229212', 30, null::int, null::int, 60, 3, 'круг'),
    ('static-challenge-wall-sit-120-sek-glute-bridge-hold-75-sek-squat-hold-84d6b9', 40, null::int, null::int, 60, 2, 'круг'),
    ('core-5-krugov-po-60-sek-reverse-crunch-bicycle-side-plank-dead-bug-494575', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ LEVEL 8 BOSS FIGHT', 4, 'LEVEL 8.2 — METABOLIC CHAOS (недели 31–32)', 16, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-squat-12-6feb5f', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-dumbbell-thruster-10-single-leg-rdl-10-na-nogu-push-up-10-1f54a5', 10, null::int, null::int, 45, 4, 'круг'),
    ('chaos-amrap-15-min-10-goblet-squats-8-push-ups-10-curtsy-lunges-8-df6b82', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('final-boss-10-min-30-30-high-knees-mountain-climbers-skater-squat-3df6c9', 30, null::int, 600, 60, 1, '10 мин'),
    ('final-core-5-krugov-po-60-sek-v-ups-bicycle-reverse-crunch-plank-knee-54568a', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE ARENA', 1, 'LEVEL 9.1 — TIME ATTACK (недели 33–34)', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-marching-high-knees-good-morning-bodyweight-squat-361c60', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-squat-to-press-12-reverse-lunge-12-na-nogu-200188', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-curtsy-lunge-12-na-nogu-single-leg-glute-bridge-15-na-nogu-a151b1', 20, null::int, null::int, 45, 4, 'круг'),
    ('time-attack-8-min-maksimum-krugov-10-goblet-squats-10-reverse-lunges-f8f21b', 30, null::int, 480, 60, 1, '8 мин'),
    ('mechanical-drop-set-3-squat-12-squat-pulses-20-wall-sit-30-sek-otdyh-ad7b62', 40, null::int, null::int, 60, 3, 'круг'),
    ('hiit-8-min-20-sek-kazhdoe-squat-jump-skater-mountain-climbers-otdyh', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-dead-92b431', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY ARENA', 2, 'LEVEL 9.1 — TIME ATTACK (недели 33–34)', 17, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-push-up-10-15-one-arm-dumbbell-row-12-na-ruku-push-press-b1d5c1', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-floor-dumbbell-press-12-lateral-raise-15-reverse-fly-15-d082b7', 10, null::int, null::int, 60, 4, 'круг'),
    ('arm-drop-set-3-hammer-curl-12-menshiy-ves-10-isometric-hold-30-sek-ee5404', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-arena-4-incline-push-up-12-bear-crawl-20-shagov-plank-c39d93', 30, null::int, null::int, 45, 4, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-push-464603', 40, null::int, null::int, 60, 4, 'круг'),
    ('time-attack-6-min-maksimum-krugov-5-push-ups-10-dumbbell-rows-10-c620e1', 50, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-toe-touch-crunch-701efb', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LOWER BODY SPEED', 3, 'LEVEL 9.1 — TIME ATTACK (недели 33–34)', 17, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-goblet-squat-15-walking-lunge-12-na-nogu-single-leg-rdl-10-358b03', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-knee-drive-10-na-nogu-hip-thrust-pulses-25-frog-15119f', 10, null::int, null::int, 60, 4, 'круг'),
    ('speed-circuit-5-20-sek-kazhdoe-fast-feet-squat-jump-skater-mountain-e8e38c', 20, null::int, null::int, 60, 5, 'круг'),
    ('emom-15-min-3-min-1-15-goblet-squats-min-2-12-reverse-lunges-min-3-30-2c02a8', 30, null::int, null::int, 60, 3, 'круг'),
    ('leg-drop-set-3-reverse-lunge-10-na-nogu-pulses-10-na-nogu-static-hold-1f05f8', 40, null::int, null::int, 60, 3, 'круг'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ FAT BURNER BOSS FIGHT', 4, 'LEVEL 9.1 — TIME ATTACK (недели 33–34)', 17, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-95b8b7', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-curtsy-lunge-10-na-nogu-push-press-10-step-up-10-na-nogu-a027b6', 10, null::int, null::int, 45, 4, 'круг'),
    ('time-attack-boss-15-min-maksimum-krugov-10-goblet-squats-8-push-ups-1e9ea1', 20, null::int, 900, 60, 1, '15 мин'),
    ('final-burn-8-min-30-30-high-knees-mountain-climbers-squat-jacks-6b4ab7', 30, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-2bdf80', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE POWER ARENA', 1, 'LEVEL 9.2 — ARENA CHAOS (недели 35–36)', 18, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-dumbbell-sumo-squat-pulse-12-5-pulsatsiy-cossack-squat-10-96a48e', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-front-foot-elevated-reverse-lunge-10-na-nogu-single-leg-97b52f', 10, null::int, null::int, 45, 4, 'круг'),
    ('glute-ladder-frog-pumps-20-25-30-35-40-50-otdyh-15-sek-mezhdu-e8e6bb', 20, null::int, null::int, 60, 1, 'лестница'),
    ('power-finisher-4-10-squat-jumps-10-cossack-squats-20-skaters-20-glute-668915', 30, null::int, null::int, 45, 4, 'круг'),
    ('hiit-8-min-30-sek-kazhdoe-skater-jump-high-knees-mountain-climbers-096c1d', 40, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-toe-touch-crunch-reverse-3afab1', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY CHAOS', 2, 'LEVEL 9.2 — ARENA CHAOS (недели 35–36)', 18, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('tri-set-4-renegade-row-8-na-ruku-push-up-10-15-arnold-press-10-otdyh-d27f64', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-2-4-dumbbell-pullover-12-bent-over-reverse-fly-15-lateral-cd75a5', 10, null::int, null::int, 60, 4, 'круг'),
    ('arm-complex-3-zottman-curl-10-overhead-triceps-extension-12-hammer-4e54fb', 20, null::int, null::int, 60, 3, 'круг'),
    ('calisthenics-circuit-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-755da5', 30, null::int, null::int, 45, 5, 'круг'),
    ('emom-16-min-4-min-1-10-renegade-rows-min-2-10-push-ups-min-3-10-8b5611', 40, null::int, null::int, 60, 4, 'круг'),
    ('metabolic-attack-6-min-20-sek-kazhdoe-fast-feet-shadow-boxing-771958', 50, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-hollow-hold-6492ee', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 LEG CHAOS', 3, 'LEVEL 9.2 — ARENA CHAOS (недели 35–36)', 18, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-tempo-goblet-squat-12-temp-3-sek-vniz-walking-lunge-12-na-59d084', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-bulgarian-split-squat-10-na-nogu-hip-thrust-15-frog-pumps-a2a2f4', 10, null::int, null::int, 60, 4, 'круг'),
    ('athlete-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-445a4e', 20, null::int, null::int, 45, 5, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-bulgarian-split-squats-dc9a71', 30, null::int, null::int, 60, 3, 'круг'),
    ('static-ladder-wall-sit-30-sek-45-sek-60-sek-75-sek-90-sek-otdyh-30-245e47', 40, null::int, null::int, 60, 1, 'лестница'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ LEVEL 9 FINAL BOSS', 4, 'LEVEL 9.2 — ARENA CHAOS (недели 35–36)', 18, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-squat-12-8a07b2', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-dumbbell-thruster-10-cossack-squat-10-na-nogu-single-leg-9e1af8', 10, null::int, null::int, 45, 4, 'круг'),
    ('arena-amrap-15-min-10-goblet-squats-8-push-ups-10-cossack-squats-8-4be4da', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('time-attack-dlya-sravneniya-progressa-8-min-10-squats-10-lunges-10-b5bcc9', 30, null::int, 480, 60, 1, '8 мин'),
    ('final-boss-10-min-30-30-high-knees-mountain-climbers-skater-jump-074c8a', 40, null::int, 600, 60, 1, '10 мин'),
    ('final-core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-918c86', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 LOWER BODY POWER', 1, 'LEVEL 10.1 — POWER CONDITIONING ⚡ (недели 37–38)', 19, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-march-in-place-bodyweight-good-morning-air-squat-dce581', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-front-squat-12-reverse-lunge-knee-drive-10-na-nogu-88a37d', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-bulgarian-split-squat-10-na-nogu-single-leg-rdl-10-na-nogu-c967ed', 20, null::int, null::int, 45, 4, 'круг'),
    ('power-ladder-squat-10-12-14-16-18-20-otdyh-15-sek-posle-kazhdogo-fc51d2', 30, null::int, null::int, 60, 1, 'лестница'),
    ('athletic-finisher-5-10-squat-jumps-10-reverse-lunges-20-skaters-20-e5708a', 40, null::int, null::int, 30, 5, 'круг'),
    ('wall-sit-challenge-30-sek-45-sek-60-sek-75-sek-90-sek-otdyh-30-sek', 50, null::int, null::int, 60, 1, 'лестница'),
    ('cardio-burst-6-min-20-sek-rabota-10-sek-otdyh-high-knees-skater-jump-2237d1', 60, null::int, 360, 60, 1, '6 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-dead-92b431', 70, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY CONDITIONING', 2, 'LEVEL 10.1 — POWER CONDITIONING ⚡ (недели 37–38)', 19, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-dumbbell-floor-press-12-one-arm-dumbbell-row-12-na-ruku-75cba8', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-arnold-press-10-bent-over-reverse-fly-15-lateral-raise-5a3865', 10, null::int, null::int, 45, 4, 'круг'),
    ('arm-complex-3-hammer-curl-12-overhead-triceps-extension-12-hammer-081251', 20, null::int, null::int, 45, 3, 'круг'),
    ('calisthenics-circuit-5-incline-push-up-12-bear-crawl-20-shagov-plank-9957cf', 30, null::int, null::int, 30, 5, 'круг'),
    ('emom-16-min-4-min-1-10-push-ups-min-2-12-dumbbell-rows-min-3-10-push-464603', 40, null::int, null::int, 60, 4, 'круг'),
    ('tabata-4-min-20-sek-rabota-10-sek-otdyh-punches-mountain-climbers', 50, null::int, 240, 60, 1, '4 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-toe-touch-crunch-b37daa', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 ATHLETIC LEGS', 3, 'LEVEL 10.1 — POWER CONDITIONING ⚡ (недели 37–38)', 19, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-goblet-squat-15-walking-lunge-12-na-nogu-staggered-rdl-12-a5cefb', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-step-up-knee-drive-12-na-nogu-hip-thrust-pulses-25-banded-7f0918', 10, null::int, null::int, 45, 4, 'круг'),
    ('speed-circuit-6-20-sek-kazhdoe-fast-feet-skater-squat-jump-otdyh', 20, null::int, null::int, 60, 6, 'круг'),
    ('emom-15-min-3-min-1-12-goblet-squats-min-2-10-bulgarian-split-squats-dc9a71', 30, null::int, null::int, 60, 3, 'круг'),
    ('leg-finisher-3-10-bulgarian-split-squats-10-pulses-20-sek-static-hold-a66f88', 40, null::int, null::int, 45, 3, 'круг'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ CONDITIONING BEAST', 4, 'LEVEL 10.1 — POWER CONDITIONING ⚡ (недели 37–38)', 19, 60)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-thruster-10-romanian-deadlift-12-push-up-10-9d217c', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-squat-jump-10-push-press-10-cossack-squat-10-na-nogu-bear-93977d', 10, null::int, null::int, 45, 4, 'круг'),
    ('amrap-15-min-10-goblet-squats-8-push-ups-10-reverse-lunges-10-30a41b', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('final-cardio-8-min-30-30-high-knees-mountain-climbers-skater-squat-e66f04', 30, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-ef343c', 40, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE BEAST', 1, 'LEVEL 10.2 — BEAST MODE 🐺 (недели 39–40)', 20, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-dumbbell-sumo-squat-15-cossack-squat-10-na-nogu-dumbbell-01ffc0', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-front-foot-elevated-reverse-lunge-10-na-nogu-single-leg-4c6a4c', 10, null::int, null::int, 45, 4, 'круг'),
    ('glute-ladder-frog-pumps-20-25-30-35-40-45-50-otdyh-15-sek', 20, null::int, null::int, 60, 1, 'лестница'),
    ('tempo-squat-4-12-povtoreniy-temp-4-sek-vniz-2-sek-pauza-obychnyy-e26348', 30, null::int, null::int, 45, 4, 'круг'),
    ('athletic-finisher-5-10-sumo-squat-jumps-10-cossack-squats-20-skater-64736a', 40, null::int, null::int, 30, 5, 'круг'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-toe-touch-crunch-reverse-3afab1', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 BEAST UPPER BODY', 2, 'LEVEL 10.2 — BEAST MODE 🐺 (недели 39–40)', 20, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('complex-4-renegade-row-8-na-ruku-dumbbell-clean-10-push-press-10-push-902c67', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-4-dumbbell-pullover-12-bent-over-reverse-fly-15-lateral-raise-ba69ca', 10, null::int, null::int, 45, 4, 'круг'),
    ('arms-3-zottman-curl-10-overhead-triceps-extension-12-hammer-curl-12-430bd2', 20, null::int, null::int, 45, 3, 'круг'),
    ('calisthenics-beast-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-de6a16', 30, null::int, null::int, 30, 5, 'круг'),
    ('emom-16-min-4-min-1-8-renegade-rows-min-2-10-push-ups-min-3-10-9daf77', 40, null::int, null::int, 60, 4, 'круг'),
    ('tabata-4-min-20-sek-rabota-10-sek-otdyh-fast-punches-mountain-252099', 50, null::int, 240, 60, 1, '4 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-hollow-hold-bicycle-fc03a3', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 BEAST LEGS', 3, 'LEVEL 10.2 — BEAST MODE 🐺 (недели 39–40)', 20, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-tempo-sumo-squat-12-bulgarian-split-squat-10-na-nogu-d9b439', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-step-up-12-na-nogu-hip-thrust-15-frog-pumps-35-banded-5e8a15', 10, null::int, null::int, 60, 4, 'круг'),
    ('athletic-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-673fed', 20, null::int, null::int, 30, 5, 'круг'),
    ('emom-15-min-3-min-1-12-sumo-squats-min-2-10-bulgarian-split-squats-na-8f8ed9', 30, null::int, null::int, 60, 3, 'круг'),
    ('static-ladder-wall-sit-30-45-60-75-90-sek-otdyh-30-sek', 40, null::int, null::int, 60, 1, 'лестница'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ LEVEL 10 FINAL BOSS', 4, 'LEVEL 10.2 — BEAST MODE 🐺 (недели 39–40)', 20, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('part-1-beast-complex-5-devil-press-8-ili-burpee-bez-pryzhka-10-goblet-e140cf', 0, null::int, null::int, 60, 5, 'круг'),
    ('part-2-athlete-mode-4-dumbbell-thruster-10-cossack-squat-10-na-nogu-4353b4', 10, null::int, null::int, 45, 4, 'круг'),
    ('beast-amrap-15-min-10-sumo-squats-8-push-ups-10-cossack-squats-8-33da78', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('time-cap-10-min-50-sumo-squats-40-mountain-climbers-30-reverse-lunges-3f4d11', 30, null::int, null::int, 60, 1, 'TIME CAP'),
    ('final-conditioning-10-min-30-30-high-knees-skater-jump-mountain-49405e', 40, null::int, 600, 60, 1, '10 мин'),
    ('final-core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-243cfa', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE SCULPT', 1, 'LEVEL 11.1 — SCULPT & POWER ⚡ (недели 41–42)', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-7-min-step-touch-good-morning-bodyweight-squat-alternating-4cfeb9', 0, null::int, 420, 60, 1, '7 мин'),
    ('block-1-4-dumbbell-sumo-squat-12-curtsy-lunge-12-na-nogu-dumbbell-628525', 10, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-bulgarian-split-squat-10-na-nogu-single-leg-glute-bridge-15-211175', 20, null::int, null::int, 45, 4, 'круг'),
    ('glute-mechanical-drop-set-3-hip-thrust-12-pulses-15-glute-bridge-20-5960fd', 30, null::int, null::int, 60, 3, 'круг'),
    ('lunge-challenge-4-10-reverse-lunges-10-pulses-20-sek-static-hold-na-01e60f', 40, null::int, null::int, 45, 4, 'круг'),
    ('cardio-burst-8-min-20-sek-rabota-10-sek-otdyh-skater-high-knees-ff49ce', 50, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-dead-97c48b', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY PEAK', 2, 'LEVEL 11.1 — SCULPT & POWER ⚡ (недели 41–42)', 21, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('superset-1-4-dumbbell-arnold-press-10-one-arm-dumbbell-row-12-na-ruku-ac5ba4', 0, null::int, null::int, 60, 4, 'круг'),
    ('superset-2-4-dumbbell-floor-fly-12-bent-over-reverse-fly-15-lateral-c8f1e8', 10, null::int, null::int, 45, 4, 'круг'),
    ('arm-complex-3-zottman-curl-10-alternating-curl-10-na-ruku-overhead-881d65', 20, null::int, null::int, 45, 3, 'круг'),
    ('calisthenics-circuit-5-incline-push-up-12-bear-crawl-20-shagov-plank-d8a5c7', 30, null::int, null::int, 30, 5, 'круг'),
    ('emom-16-min-4-min-1-10-arnold-press-min-2-12-dumbbell-rows-min-3-10-c53e70', 40, null::int, null::int, 60, 4, 'круг'),
    ('tabata-4-min-20-sek-rabota-10-sek-otdyh-shadow-boxing-mountain-7edd06', 50, null::int, 240, 60, 1, '4 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-toe-touch-crunch-701efb', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 ATHLETIC LEGS', 3, 'LEVEL 11.1 — SCULPT & POWER ⚡ (недели 41–42)', 21, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('block-1-4-front-foot-elevated-reverse-lunge-10-na-nogu-dumbbell-sumo-62eaee', 0, null::int, null::int, 60, 4, 'круг'),
    ('block-2-4-tempo-goblet-squat-12-temp-4-sek-vniz-single-leg-rdl-10-na-73cbef', 10, null::int, null::int, 45, 4, 'круг'),
    ('athletic-circuit-5-10-squat-jumps-10-reverse-lunges-20-skater-jumps-b637fc', 20, null::int, null::int, 30, 5, 'круг'),
    ('emom-15-min-3-min-1-12-sumo-deadlifts-min-2-10-step-ups-na-nogu-min-3-0b7465', 30, null::int, null::int, 60, 3, 'круг'),
    ('static-leg-ladder-wall-sit-30-45-60-75-90-sek-otdyh-30-sek', 40, null::int, null::int, 60, 1, 'лестница'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ PEAK SHAPE BOSS', 4, 'LEVEL 11.1 — SCULPT & POWER ⚡ (недели 41–42)', 21, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('round-1-5-dumbbell-sumo-squat-12-push-up-10-reverse-lunge-10-na-nogu-432b05', 0, null::int, null::int, 60, 5, 'круг'),
    ('round-2-4-arnold-press-10-step-up-10-na-nogu-cossack-squat-10-na-nogu-3b8358', 10, null::int, null::int, 45, 4, 'круг'),
    ('amrap-15-min-10-sumo-squats-8-push-ups-10-reverse-lunges-10-dumbbell-f02514', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('time-cap-10-min-40-sumo-squats-30-reverse-lunges-20-push-ups-30-step-5f19cb', 30, null::int, null::int, 60, 1, 'TIME CAP'),
    ('final-conditioning-8-min-30-30-high-knees-skater-mountain-climbers-25df91', 40, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-2bdf80', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Понедельник · 🍑 GLUTE POWER', 1, 'LEVEL 11.2 — PEAK PERFORMANCE (недели 43–44)', 22, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-dumbbell-sumo-deadlift-12-front-foot-elevated-split-squat-9eb6f5', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-curtsy-lunge-12-na-nogu-step-up-12-na-nogu-glute-bridge-4e7ddc', 10, null::int, null::int, 45, 4, 'круг'),
    ('tempo-glute-complex-3-glute-bridge-12-3-sek-uderzhanie-15-pulses-20-2cff37', 20, null::int, null::int, 45, 3, 'круг'),
    ('leg-burn-4-10-split-squats-10-pulses-20-sek-hold-na-nogu', 30, null::int, null::int, 60, 4, 'круг'),
    ('hiit-8-min-20-sek-rabota-10-sek-otdyh-skater-jump-high-knees-squat-d1b9e0', 40, null::int, 480, 60, 1, '8 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-toe-touch-crunch-reverse-d19780', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Вторник · 💪 UPPER BODY BEAST', 2, 'LEVEL 11.2 — PEAK PERFORMANCE (недели 43–44)', 22, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('complex-4-dumbbell-clean-10-push-press-10-renegade-row-8-na-ruku-push-d93aa4', 0, null::int, null::int, 60, 4, 'круг'),
    ('tri-set-4-dumbbell-pullover-12-rear-delt-fly-15-lateral-raise-15-6ed429', 10, null::int, null::int, 45, 4, 'круг'),
    ('arm-burn-3-hammer-curl-12-zottman-curl-10-overhead-triceps-extension-632a6d', 20, null::int, null::int, 45, 3, 'круг'),
    ('calisthenics-5-push-up-10-bear-crawl-20-shagov-plank-walk-10-sprawl-8-1f1281', 30, null::int, null::int, 30, 5, 'круг'),
    ('emom-16-min-4-min-1-8-dumbbell-cleans-min-2-10-push-ups-min-3-8-cad5b2', 40, null::int, null::int, 60, 4, 'круг'),
    ('tabata-4-min-20-sek-rabota-10-sek-otdyh-fast-punches-mountain-1860cd', 50, null::int, 240, 60, 1, '4 мин'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-hollow-hold-bicycle-fc03a3', 60, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Четверг · 🦵 PEAK LEGS', 3, 'LEVEL 11.2 — PEAK PERFORMANCE (недели 43–44)', 22, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('circuit-1-4-dumbbell-sumo-deadlift-15-bulgarian-split-squat-10-na-41c2eb', 0, null::int, null::int, 60, 4, 'круг'),
    ('circuit-2-4-step-up-12-na-nogu-single-leg-hip-thrust-12-na-nogu-frog-12e7ee', 10, null::int, null::int, 60, 4, 'круг'),
    ('athletic-circuit-5-squat-jump-10-cossack-squat-10-na-nogu-skater-jump-4fbf83', 20, null::int, null::int, 30, 5, 'круг'),
    ('emom-15-min-3-min-1-12-sumo-deadlifts-min-2-10-bulgarian-split-squats-d9f3c0', 30, null::int, null::int, 60, 3, 'круг'),
    ('static-challenge-wall-sit-45-60-75-90-120-sek-otdyh-30-sek', 40, null::int, null::int, 60, 1, 'лестница'),
    ('core-5-krugov-po-60-sek-15-sek-mezhdu-upr-reverse-crunch-bicycle-side-51d0f9', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Суббота · ☠️ PEAK PERFORMANCE FINAL BOSS', 4, 'LEVEL 11.2 — PEAK PERFORMANCE (недели 43–44)', 22, 64)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('part-1-beast-complex-5-devil-press-8-ili-burpee-bez-pryzhka-10-sumo-19ba75', 0, null::int, null::int, 60, 5, 'круг'),
    ('part-2-athlete-mode-4-dumbbell-clean-10-cossack-squat-10-na-nogu-step-de30dd', 10, null::int, null::int, 45, 4, 'круг'),
    ('peak-amrap-15-min-10-sumo-deadlifts-8-push-ups-10-cossack-squats-8-a6f0b9', 20, null::int, null::int, 60, 1, 'AMRAP 15 мин'),
    ('time-cap-12-min-50-sumo-squats-40-mountain-climbers-30-reverse-lunges-f525eb', 30, null::int, null::int, 60, 1, 'TIME CAP'),
    ('final-burn-10-min-30-30-high-knees-skater-mountain-climbers-squat-9ff558', 40, null::int, 600, 60, 1, '10 мин'),
    ('final-core-5-krugov-po-60-sek-15-sek-mezhdu-upr-v-ups-bicycle-reverse-243cfa', 50, null::int, null::int, 60, 5, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 1 · НОГИ + ЯГОДИЦЫ', 1, '🔥 МЕСЯЦ 12 — ФИНАЛЬНЫЙ УРОВЕНЬ (недели 1–2)', 23, 72)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('razminka-hodba-na-meste-s-vysokim-podemom-koleney-3-po-40-sek-otdyh-979a50', 0, null::int, 40, 20, 3, '40 сек'),
    ('prisedaniya-s-gantelyu-posl-podhod-15-10-pulsiruyuschih', 10, 15, null::int, 90, 4, '15'),
    ('bolgarskie-vypady-posl-podhod-12-10-korotkih-pulsatsiy', 20, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-vesom-pauza-2-sek-vverhu-posl-podhod-15-20-sek-d3a671', 30, 15, null::int, 90, 4, '15'),
    ('otvedenie-nogi-nazad-s-rezinkoy', 40, 20, null::int, 90, 3, '20 на ногу'),
    ('shagi-v-storonu-s-rezinkoy', 50, 20, null::int, 90, 3, '20 шагов'),
    ('prisedanie-podem-na-noski', 60, 15, null::int, 90, 3, '15'),
    ('finalnyy-krug-3-30-sek-prisedaniya-30-sek-jumping-jacks-30-sek-32d5e7', 70, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 2 · ВЕРХ ТЕЛА + КАРДИО', 2, '🔥 МЕСЯЦ 12 — ФИНАЛЬНЫЙ УРОВЕНЬ (недели 1–2)', 23, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-ot-pola-s-kolen', 0, 10, null::int, 90, 4, '10–15'),
    ('tyaga-rezinki-k-zhivotu', 10, 15, null::int, 90, 4, '15'),
    ('tyaga-ganteli-odnoy-rukoy', 20, 15, null::int, 90, 3, '15 на сторону'),
    ('zhim-ganteley-vverh', 30, 12, null::int, 90, 3, '12'),
    ('mahi-gantelyami-v-storony-posl-podhod-15-10-chastichnyh', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruki-s-rezinkoy-na-tritseps', 50, 15, null::int, 90, 3, '15'),
    ('bitseps-s-gantelyami', 60, 15, null::int, 90, 3, '15'),
    ('kardio-8-min-20-sek-bystro-40-sek-spokoyno-8-beg-na-meste-jumping-3b4bf4', 70, null::int, 480, 60, 1, '8 мин'),
    ('press-nedeli-1-3-3-kruga-po-60-sek-skruchivaniya-podem-sognutyh-nog-e7fb4e', 80, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 4 · ЯГОДИЦЫ + НОГИ', 3, '🔥 МЕСЯЦ 12 — ФИНАЛЬНЫЙ УРОВЕНЬ (недели 1–2)', 23, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('rumynskaya-tyaga-s-gantelyami', 0, 15, null::int, 90, 4, '15'),
    ('vypady-nazad', 10, 15, null::int, 90, 3, '15 на ногу'),
    ('yagodichnyy-most-s-uzkoy-postanovkoy-nog-posl-podhod-20-30-sek-10b3a5', 20, 20, null::int, 90, 4, '20'),
    ('pozharnyy-gidrant-s-rezinkoy', 30, 20, null::int, 90, 3, '20 на сторону'),
    ('otvedenie-nogi-v-storonu', 40, 20, null::int, 90, 3, '20'),
    ('sumo-prisedanie-posl-podhod-20-15-pulsatsiy', 50, 20, null::int, 90, 3, '20'),
    ('finisher-tabata-4-min-20-sek-rabota-10-sek-otdyh-prisedaniya-bystrye-52434e', 60, null::int, 240, 60, 1, '4 мин')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'День 6 · FULL BODY 🔥', 4, '🔥 МЕСЯЦ 12 — ФИНАЛЬНЫЙ УРОВЕНЬ (недели 1–2)', 23, 44)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('krug-4-prisedanie-zhim-ganteley-15-tyaga-ganteley-v-naklone-15-vypady-145f6b', 0, null::int, null::int, 90, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 1 · НОГИ + ЯГОДИЦЫ (новый уровень)', 1, '🔴 МЕСЯЦ 12 — НЕДЕЛЯ 3 (UP) + 🟠 НЕДЕЛЯ 4 (НОВЫЙ УРОВЕНЬ) + 🏆 FINAL BOSS', 24, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('goblet-squat-s-shirokoy-postanovkoy', 0, 12, null::int, 90, 4, '12'),
    ('vypady-v-storonu', 10, 12, null::int, 90, 3, '12 на сторону'),
    ('odnonogiy-yagodichnyy-most', 20, 15, null::int, 90, 3, '15 на ногу'),
    ('rumynskaya-tyaga-na-odnoy-noge', 30, 12, null::int, 90, 3, '12 на ногу'),
    ('lyagushka-frog-pumps', 40, 30, null::int, 90, 3, '30'),
    ('bokovye-shagi-s-rezinkoy', 50, null::int, 30, 90, 3, '30 сек'),
    ('finisher-4-raunda-20-sek-kazhdoe-squat-jumps-mountain-climbers-otdyh', 60, null::int, null::int, 60, 4, 'раунд')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 2 · ВЕРХ + КАРДИО (новый уровень)', 2, '🔴 МЕСЯЦ 12 — НЕДЕЛЯ 3 (UP) + 🟠 НЕДЕЛЯ 4 (НОВЫЙ УРОВЕНЬ) + 🏆 FINAL BOSS', 24, 76)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('otzhimaniya-s-uzkoy-postanovkoy', 0, 10, null::int, 90, 3, '10–15'),
    ('tyaga-rezinki-sverhu-k-grudi', 10, 15, null::int, 90, 4, '15'),
    ('tyaga-ganteli-k-poyasu-s-pauzoy', 20, 12, null::int, 90, 3, '12'),
    ('arnold-press', 30, 12, null::int, 90, 3, '12'),
    ('razvedenie-ganteley-v-naklone', 40, 15, null::int, 90, 3, '15'),
    ('razgibanie-ruk-s-rezinkoy', 50, 15, null::int, 90, 3, '15'),
    ('molotkovye-sgibaniya', 60, 12, null::int, 90, 3, '12'),
    ('kardio-12-min-40-sek-rabota-20-sek-otdyh-high-knees-jumping-jacks-6e11da', 70, null::int, 720, 60, 1, '12 мин'),
    ('press-nedelya-4-novyy-kompleks-4-kruga-po-60-sek-dead-bug-obratnye-aff6af', 80, null::int, null::int, 60, 4, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 4 · GLUTE ATTACK 🍑', 3, '🔴 МЕСЯЦ 12 — НЕДЕЛЯ 3 (UP) + 🟠 НЕДЕЛЯ 4 (НОВЫЙ УРОВЕНЬ) + 🏆 FINAL BOSS', 24, 68)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('step-up-na-ustoychivuyu-platformu-stupen', 0, 12, null::int, 90, 4, '12 на ногу'),
    ('curtsy-lunge', 10, 12, null::int, 90, 3, '12 на ногу'),
    ('yagodichnyy-most-s-shirokoy-postanovkoy', 20, 20, null::int, 90, 4, '20'),
    ('otvedenie-nogi-nazad-v-upore', 30, 20, null::int, 90, 3, '20'),
    ('otvedenie-nogi-v-storonu-lezha', 40, 20, null::int, 90, 3, '20'),
    ('wall-sit', 50, null::int, 45, 90, 3, '45 сек'),
    ('final-3-kruga-30-sek-kazhdoe-bystrye-step-up-jumping-jacks-squat-e0102f', 60, null::int, null::int, 60, 3, 'круг')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

  insert into public.workouts (program_id, title, "order", week_label, week_order, estimated_duration_minutes)
  values (v_program_id, 'Неделя 4, День 6 · 🔥 FINAL BOSS — ФИНАЛ ГОДА', 4, '🔴 МЕСЯЦ 12 — НЕДЕЛЯ 3 (UP) + 🟠 НЕДЕЛЯ 4 (НОВЫЙ УРОВЕНЬ) + 🏆 FINAL BOSS', 24, 52)
  returning id into v_workout_id;
  insert into public.workout_sets (workout_id, exercise_id, "order", reps, duration_seconds, rest_seconds, notes)
  select v_workout_id, e.id, s.base_order + gs.n - 1, s.reps, s.dur, s.rest, s.notes
  from (values
    ('5-krugov-goblet-squat-15-tyaga-ganteley-v-naklone-15-vypady-nazad-10-1975d1', 0, null::int, null::int, 60, 5, 'круг'),
    ('finalnyy-chellendzh-3-minuty-bez-ostanovki-30-sek-jumping-jacks-30-f5dcd7', 10, null::int, 180, 60, 1, '3 мин'),
    ('itogovyy-kontrol-goda-sravnit-ves-taliyu-bedra-foto-i-rezultat-amrap-39a783', 20, null::int, null::int, 60, 1, '—')
  ) as s(ex_slug, base_order, reps, dur, rest, num_sets, notes)
  join public.exercises e on e.slug = s.ex_slug
  cross join lateral generate_series(1, s.num_sets) as gs(n);

end $$;
