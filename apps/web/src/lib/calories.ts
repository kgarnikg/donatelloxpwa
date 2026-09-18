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

/** MET (metabolic equivalent) для силовой тренировки умеренной интенсивности. */
const WORKOUT_MET = 5;

export interface CalorieEstimateInput {
  weightKg: number;
  heightCm: number;
  age: number;
  gender: Gender;
  activityLevel: ActivityLevel;
  /** Суммарная длительность тренировок за этот день, в минутах (0, если тренировок не было). */
  workoutMinutes: number;
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

  // ккал/мин = MET × 3.5 × вес(кг) / 200 — стандартная формула ACSM.
  const workoutCalories = Math.round((WORKOUT_MET * 3.5 * input.weightKg * input.workoutMinutes) / 200);

  return {
    bmr: Math.round(bmr),
    activityCalories,
    workoutCalories,
    total: Math.round(bmr) + activityCalories + workoutCalories,
  };
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
