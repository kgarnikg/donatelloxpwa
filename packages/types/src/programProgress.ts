// ---------------------------------------------------------------------------
// Прогресс по программе с повторами недель (0089)
// ---------------------------------------------------------------------------
//
// Программы тренера собраны блоками ("Месяц 2 — LEVEL 2", "Недели 1–2 —
// Фундамент"). В блоке — недельный набор из 3–4 тренировок, который нужно
// повторить block_repeats раз (месяц — 4 недели, "недели 1–2" — 2).
// Раньше каждая тренировка проходилась один раз, и годовая программа
// заканчивалась в 2–4 раза быстрее.
//
// Здесь программа "разворачивается" в полную последовательность слотов:
// блок 1 × неделя 1 (Пн, Ср, Пт…), блок 1 × неделя 2, … блок 2 × неделя 1 …
// Выполненные слоты считаются по количеству записей workout_logs на каждую
// тренировку: 3 записи "Понедельник месяца 2" = пройдены 3 недели этого дня.
// Один и тот же расчёт — в приложении и в админке ("Догнать прогресс").

export interface ProgressWorkout {
  id: string;
  weekOrder: number;
  order: number;
  /** Сколько раз повторяется недельный набор блока (0089). По умолчанию 1. */
  blockRepeats?: number | null;
}

export interface ProgramSlot<W extends ProgressWorkout = ProgressWorkout> {
  workout: W;
  /** Порядковый номер слота во всей программе, с 0. */
  index: number;
  /** Неделя внутри блока: 1..repeats. */
  round: number;
  /** Сколько недель (повторов) в блоке. */
  repeats: number;
  /** Позиция тренировки внутри недельного набора блока: 1..blockSize. */
  positionInBlock: number;
  blockSize: number;
  done: boolean;
}

export interface ProgramProgress<W extends ProgressWorkout = ProgressWorkout> {
  slots: ProgramSlot<W>[];
  done: number;
  total: number;
  /** Следующий слот к выполнению; null — программа пройдена. */
  next: ProgramSlot<W> | null;
}

/**
 * @param workouts тренировки программы (любой порядок — отсортируем сами)
 * @param counts сколько раз выполнена каждая тренировка (workout_id → число записей)
 */
export function computeProgramProgress<W extends ProgressWorkout>(
  workouts: readonly W[],
  counts: ReadonlyMap<string, number>,
): ProgramProgress<W> {
  const sorted = [...workouts].sort((a, b) => a.weekOrder - b.weekOrder || a.order - b.order);
  const blocks: W[][] = [];
  for (const w of sorted) {
    const last = blocks[blocks.length - 1];
    if (last && last[0].weekOrder === w.weekOrder) last.push(w);
    else blocks.push([w]);
  }

  // Уже перешёл к более позднему блоку — значит, все блоки до него
  // пройдены, даже если их тренировки выполнены по одному разу. Так было
  // до повторов недель (0089): люди, ушедшие вперёд, не откатываются в
  // начало программы, а продолжают с того блока, где остановились.
  let lastTouchedBlock = -1;
  blocks.forEach((block, bi) => {
    if (block.some((w) => (counts.get(w.id) ?? 0) > 0)) lastTouchedBlock = bi;
  });

  const remaining = new Map(counts);
  const slots: ProgramSlot<W>[] = [];
  let next: ProgramSlot<W> | null = null;
  blocks.forEach((block, bi) => {
    const repeats = Math.max(1, Math.round(block[0].blockRepeats ?? 1));
    const passed = bi < lastTouchedBlock;
    for (let round = 1; round <= repeats; round++) {
      block.forEach((workout, i) => {
        const left = remaining.get(workout.id) ?? 0;
        const done = passed || left > 0;
        if (left > 0) remaining.set(workout.id, left - 1);
        const slot: ProgramSlot<W> = {
          workout,
          index: slots.length,
          round,
          repeats,
          positionInBlock: i + 1,
          blockSize: block.length,
          done,
        };
        if (!done && !next) next = slot;
        slots.push(slot);
      });
    }
  });
  return { slots, done: slots.filter((s) => s.done).length, total: slots.length, next };
}

/** Число выполнений каждой тренировки из строк workout_logs. */
export function countCompletions(rows: readonly { workout_id: string }[]): Map<string, number> {
  const counts = new Map<string, number>();
  for (const r of rows) counts.set(r.workout_id, (counts.get(r.workout_id) ?? 0) + 1);
  return counts;
}
