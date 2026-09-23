import type { ActivityLevel, Gender } from "@donatellox/types";

/**
 * Оценка суточного расхода калорий по данным профиля (рост/вес/возраст/пол)
 * и активности за день (тренировки). Формула Миффлина-Сан Жеора — самая
 * распространённая и достаточно точная для общей оценки (не медицинский
 * расчёт, метаболизм у каждого индивидуален).
 *
 * Пользователь всегда может переопределить итоговое число вручную (данными
 * со своих умных часов и т.п.) — см. useDailyCalories/useSetCalorieOverride
 * в lib/queries.ts. Здесь — только сама формула, без обращений к БД.
 */

const ACTIVITY_MULTIPLIER: Record<ActivityLevel, number> = {
  sedentary: 1.2,
  light: 1.375,
  moderate: 1.55,
  active: 1.725,
  very_active: 1.9,
};

/**
 * MET (metabolic equivalent) — интенсивность тренировки по типу программы:
 * программы на похудение — круговые, высокий темп, короткий отдых (~6);
 * набор массы — силовые с отдыхом между подходами (~5). Значения из
 * Compendium of Physical Activities (circuit training / resistance training).
 */
const WORKOUT_MET_BY_GOAL: Partial<Record<string, number>> = {
  lose_weight: 6,
  build_muscle: 5,
};
const DEFAULT_WORKOUT_MET = 5;

/** Во сколько раз фактическая длительность может превышать расчётную, прежде чем мы её обрежем. */
const MAX_DURATION_FACTOR = 1.5;
/** Если у тренировки нет расчётной длительности. */
const FALLBACK_ESTIMATED_MINUTES = 60;

export interface CalorieEstimateInput {
  weightKg: number;
  heightCm: number;
  age: number;
  gender: Gender;
  activityLevel: ActivityLevel;
  /**
   * Калории, сожжённые на тренировках за этот день (сумма
   * workout_logs.calories_burned, см. estimateWorkoutCalories). Раньше
   * здесь были минуты тренировок — и запись "догнать прогресс" за 20
   * тренировок разом превращалась в +11 000 ккал за день (миграция 0066).
   */
  workoutCalories: number;
}

export interface CalorieEstimate {
  bmr: number;
  activityCalories: number;
  workoutCalories: number;
  total: number;
}

/** Базовый метаболизм (BMR) по формуле Миффлина-Сан Жеора. */
export function calculateBMR(weightKg: number, heightCm: number, age: number, gender: Gender): number {
  const base = 10 * weightKg + 6.25 * heightCm - 5 * age;
  if (gender === "male") return base + 5;
  if (gender === "female") return base - 161;
  // Пол не указан — берём среднее между мужской и женской константой,
  // чтобы не завышать/занижать оценку в одну сторону без оснований.
  return base - 78;
}

export function estimateDailyCalories(input: CalorieEstimateInput): CalorieEstimate {
  const bmr = calculateBMR(input.weightKg, input.heightCm, input.age, input.gender);
  const withActivity = bmr * ACTIVITY_MULTIPLIER[input.activityLevel];
  const activityCalories = Math.round(withActivity - bmr);

  const workoutCalories = Math.round(input.workoutCalories);

  return {
    bmr: Math.round(bmr),
    activityCalories,
    workoutCalories,
    total: Math.round(bmr) + activityCalories + workoutCalories,
  };
}

export interface WorkoutCalorieInput {
  weightKg: number;
  /** Может отсутствовать в профиле — тогда 170 см. */
  heightCm?: number | null;
  /** Может отсутствовать в профиле — тогда 30 лет. */
  age?: number | null;
  gender: Gender;
  /** Сколько реально длилась тренировка (от открытия до завершения), минуты. */
  actualMinutes: number;
  /** Расчётная длительность тренировки по программе, минуты. */
  estimatedMinutes?: number | null;
  /** Цель программы (workout_programs.goal) — задаёт интенсивность (MET). */
  programGoal?: string | null;
  /** Доля выполненных подходов, 0..1 (1 — всё выполнено). */
  completionRatio?: number;
}

/**
 * Калории, сожжённые на ОДНОЙ тренировке.
 *
 * Формула "скорректированный MET": ккал = MET × (BMR / 1440) × минуты.
 * BMR по Миффлину-Сан Жеору учитывает вес, рост, возраст и пол — то есть
 * расход в покое именно этого человека за минуту, а не усреднённого
 * "70-килограммового взрослого", как в классической формуле MET × вес.
 *
 * Минуты — фактические, но с защитой от завышения: не больше 1.5 ×
 * расчётной длительности той части тренировки, что реально выполнена
 * (если сделано полтренировки — и потолок вдвое ниже). Так забытый
 * открытым на полдня плеер не превращается в тысячи калорий.
 *
 * Та же формула продублирована в SQL миграции 0066 (пересчёт старых
 * записей) — при изменении менять в обоих местах.
 */
export function estimateWorkoutCalories(input: WorkoutCalorieInput): number {
  const bmr = calculateBMR(input.weightKg, input.heightCm ?? 170, input.age ?? 30, input.gender);
  const met = (input.programGoal && WORKOUT_MET_BY_GOAL[input.programGoal]) || DEFAULT_WORKOUT_MET;
  const ratio = Math.min(Math.max(input.completionRatio ?? 1, 0), 1);
  const estimated = input.estimatedMinutes && input.estimatedMinutes > 0 ? input.estimatedMinutes : FALLBACK_ESTIMATED_MINUTES;
  const cap = estimated * MAX_DURATION_FACTOR * ratio;
  const minutes = Math.min(Math.max(input.actualMinutes, 0), cap);
  return Math.max(0, Math.round(met * (bmr / 1440) * minutes));
}

/** Возраст в годах на конкретную дату по дате рождения (YYYY-MM-DD). */
export function calculateAge(birthDate: string, onDate: Date = new Date()): number {
  const birth = new Date(birthDate);
  let age = onDate.getFullYear() - birth.getFullYear();
  const monthDiff = onDate.getMonth() - birth.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && onDate.getDate() < birth.getDate())) {
    age -= 1;
  }
  return age;
}
