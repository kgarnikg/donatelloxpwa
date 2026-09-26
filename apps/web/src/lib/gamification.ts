/**
 * Геймификация главной: опыт (XP), уровни, звания, серия недель.
 *
 * Всё считается на клиенте из уже сохранённых workout_logs — отдельных
 * таблиц не заводили: XP — производная от истории тренировок, её нельзя
 * "накрутить" иначе, чем тренируясь. Если правила поменяются, у всех
 * пересчитается сразу и одинаково.
 *
 * Здесь только чистые функции — без React и без запросов к базе.
 */

export const XP_RULES = {
  /** Тренировка, пройденная в приложении. */
  workout: 100,
  /** Тренировка, отмеченная тренером через "Догнать прогресс" — реальный прошлый прогресс, но без деталей. */
  catchUpWorkout: 40,
  /** Неделя (пн–вс), в которой выполнен план программы. */
  fullWeek: 150,
  /** Новый личный рекорд рабочего веса в упражнении. */
  personalRecord: 30,
} as const;

export type RankKey = "novice" | "fighter" | "athlete" | "champion" | "master" | "legend";

/** С какого уровня начинается звание (по возрастанию). */
const RANKS: { from: number; key: RankKey }[] = [
  { from: 1, key: "novice" },
  { from: 3, key: "fighter" },
  { from: 5, key: "athlete" },
  { from: 8, key: "champion" },
  { from: 12, key: "master" },
  { from: 17, key: "legend" },
];

/**
 * Сколько всего XP нужно, чтобы достичь уровня n. Каждый следующий
 * уровень дороже предыдущего на 250 XP: 2-й — 250, 3-й — 750, 4-й — 1500,
 * 5-й — 2500, 10-й — 11 250. Примерно: уровень за 2–3 недели регулярных
 * тренировок в начале, дальше — реже, как и положено.
 */
export function xpForLevel(level: number): number {
  return (250 * level * (level - 1)) / 2;
}

export interface LevelInfo {
  level: number;
  rank: RankKey;
  xp: number;
  /** XP с начала текущего уровня. */
  xpIntoLevel: number;
  /** Сколько XP занимает текущий уровень целиком. */
  xpLevelSpan: number;
  /** Сколько осталось до следующего уровня. */
  xpToNext: number;
  /** 0..1 — заполненность кольца/полосы. */
  progress: number;
}

export function rankForLevel(level: number): RankKey {
  return [...RANKS].reverse().find((r) => level >= r.from)?.key ?? "novice";
}

export function levelFromXp(xp: number): LevelInfo {
  let level = 1;
  while (xpForLevel(level + 1) <= xp) level += 1;
  const start = xpForLevel(level);
  const end = xpForLevel(level + 1);
  const rank = rankForLevel(level);
  return {
    level,
    rank,
    xp,
    xpIntoLevel: xp - start,
    xpLevelSpan: end - start,
    xpToNext: end - xp,
    progress: (xp - start) / (end - start),
  };
}

// ---------------------------------------------------------------------------
// Недели
// ---------------------------------------------------------------------------

/** Понедельник 00:00 (местное время) недели, в которую попадает дата. */
export function startOfWeek(date: Date): Date {
  const d = new Date(date.getFullYear(), date.getMonth(), date.getDate());
  const day = (d.getDay() + 6) % 7; // пн = 0 … вс = 6
  d.setDate(d.getDate() - day);
  return d;
}

function weekKey(date: Date): string {
  const s = startOfWeek(date);
  return `${s.getFullYear()}-${s.getMonth() + 1}-${s.getDate()}`;
}

export function localDayKey(date: Date): string {
  return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
}

// ---------------------------------------------------------------------------
// Основной расчёт
// ---------------------------------------------------------------------------

export interface GameLog {
  completedAt: string;
  isCatchUp: boolean;
  /** Рабочие веса по упражнениям в этой тренировке. */
  weights: { exerciseId: string; weightKg: number }[];
}

export interface GameSummary {
  level: LevelInfo;
  /** Разбивка XP — для подсказки "за что начислено". */
  breakdown: { workouts: number; catchUp: number; weeks: number; records: number };
  /** Недель подряд с выполненным планом (текущая неделя засчитывается, только если план уже выполнен). */
  weekStreak: number;
  /** Реальные тренировки на этой неделе. */
  thisWeekCount: number;
  /** Дни текущей недели (пн–вс), в которые была тренировка. */
  thisWeekDays: boolean[];
  /** Была ли сегодня тренировка в приложении. */
  trainedToday: boolean;
  /** Реальные тренировки за прошлую и позапрошлую неделю — [прошлая, позапрошлая]. */
  previousWeekCounts: [number, number];
}

export function summarize(logs: GameLog[], weeklyTarget: number, now = new Date()): GameSummary {
  const target = Math.max(1, weeklyTarget);
  const real = logs.filter((l) => !l.isCatchUp);
  const catchUp = logs.length - real.length;

  // Реальные тренировки по неделям
  const perWeek = new Map<string, number>();
  for (const l of real) {
    const k = weekKey(new Date(l.completedAt));
    perWeek.set(k, (perWeek.get(k) ?? 0) + 1);
  }
  const fullWeeks = [...perWeek.values()].filter((n) => n >= target).length;

  // Личные рекорды — в хронологическом порядке: рекорд = вес больше
  // лучшего предыдущего в этом упражнении. Самый первый записанный вес —
  // ещё не рекорд (не с чем сравнивать).
  const best = new Map<string, number>();
  let records = 0;
  const chronological = [...logs].sort(
    (a, b) => new Date(a.completedAt).getTime() - new Date(b.completedAt).getTime(),
  );
  for (const l of chronological) {
    for (const w of l.weights) {
      const prev = best.get(w.exerciseId);
      if (prev !== undefined && w.weightKg > prev) records += 1;
      if (prev === undefined || w.weightKg > prev) best.set(w.exerciseId, w.weightKg);
    }
  }

  const breakdown = {
    workouts: real.length * XP_RULES.workout,
    catchUp: catchUp * XP_RULES.catchUpWorkout,
    weeks: fullWeeks * XP_RULES.fullWeek,
    records: records * XP_RULES.personalRecord,
  };
  const xp = breakdown.workouts + breakdown.catchUp + breakdown.weeks + breakdown.records;

  // Серия недель: считаем назад от прошлой недели, пока план выполнен.
  // Текущая неделя ещё идёт — она не обрывает серию, но и добавляет +1
  // только когда план на ней уже выполнен.
  const thisWeekStart = startOfWeek(now);
  const thisWeekCount = perWeek.get(weekKey(now)) ?? 0;
  let weekStreak = thisWeekCount >= target ? 1 : 0;
  const cursor = new Date(thisWeekStart);
  for (;;) {
    cursor.setDate(cursor.getDate() - 7);
    if ((perWeek.get(weekKey(cursor)) ?? 0) >= target) weekStreak += 1;
    else break;
  }

  const days = new Set(real.map((l) => localDayKey(new Date(l.completedAt))));
  const thisWeekDays = Array.from({ length: 7 }, (_, i) => {
    const d = new Date(thisWeekStart);
    d.setDate(d.getDate() + i);
    return days.has(localDayKey(d));
  });

  return {
    level: levelFromXp(xp),
    breakdown,
    weekStreak,
    thisWeekCount,
    thisWeekDays,
    trainedToday: days.has(localDayKey(now)),
    previousWeekCounts: [1, 2].map((n) => {
      const d = new Date(thisWeekStart);
      d.setDate(d.getDate() - 7 * n);
      return perWeek.get(weekKey(d)) ?? 0;
    }) as [number, number],
  };
}
