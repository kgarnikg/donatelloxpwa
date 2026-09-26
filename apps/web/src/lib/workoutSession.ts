import type { Exercise } from "@donatellox/types";

/**
 * Незаконченная тренировка — на телефоне (localStorage).
 *
 * Зачем: на iPhone Safari перезагружает страницу, когда человек уходит в
 * другое приложение (музыка, мессенджер) или телефон долго лежит
 * заблокированным. Раньше после этого пропадали отмеченные подходы и веса,
 * а время тренировки начинало считаться заново — часовая тренировка
 * записывалась как 10 минут, и калорий было в разы меньше.
 *
 * Храним: когда начали, отмеченные подходы, веса, порядок/замены
 * упражнений и идущий отдых. Через 12 часов без изменений — забываем.
 */

export interface WorkoutSession {
  userId: string;
  startedAt: number;
  completedIds: string[];
  weights: Record<string, string>;
  orderOverride: string[] | null;
  substitutions: Record<string, Exercise>;
  rest: { total: number; endAt: number; kind: "set" | "exercise" } | null;
  savedAt: number;
}

const PREFIX = "donatellex-workout-session:";
const MAX_AGE_MS = 12 * 60 * 60 * 1000;

export function loadWorkoutSession(workoutId: string | undefined, userId: string | undefined): WorkoutSession | null {
  if (!workoutId || !userId) return null;
  try {
    const raw = localStorage.getItem(PREFIX + workoutId);
    if (!raw) return null;
    const s = JSON.parse(raw) as WorkoutSession;
    if (s.userId !== userId || Date.now() - s.savedAt > MAX_AGE_MS) {
      localStorage.removeItem(PREFIX + workoutId);
      return null;
    }
    return s;
  } catch {
    return null;
  }
}

export function saveWorkoutSession(workoutId: string, session: Omit<WorkoutSession, "savedAt">) {
  try {
    localStorage.setItem(PREFIX + workoutId, JSON.stringify({ ...session, savedAt: Date.now() }));
  } catch {
    // переполнено / приватный режим — просто не сохраняем
  }
}

export function clearWorkoutSession(workoutId: string | undefined) {
  if (!workoutId) return;
  try {
    localStorage.removeItem(PREFIX + workoutId);
  } catch {
    // не критично
  }
}
