import { useQuery } from "@tanstack/react-query";
import type { ProgressWorkout, WorkoutProgram } from "@donatellox/types";
import { computeProgramProgress, countCompletions } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";

/**
 * Общее для каталога программ и экрана программы (Фаза 26):
 * цвет по цели, оборудование из описания, прогресс по каждой программе.
 */

/** Цвет по цели: похудение — оранжевый (ember), масса и остальное — лайм (volt). */
export function goalTone(goal: WorkoutProgram["goal"]): "ember" | "volt" {
  return goal === "lose_weight" ? "ember" : "volt";
}

// "Оборудование:" / "Equipment:" / "Equipo:" / … — в описаниях всех
// программ на всех языках контента оборудование идёт последним предложением.
const EQUIPMENT_RE =
  /(?:Оборудование|Обладнання|Equipment|Equipo|Ausrüstung|Attrezzatura|Սարքավորում\S*|المعدات|उपकरण|ਸਾਮਾਨ)\s*:\s*(.+)$/i;

/** Делит описание на основную часть и список оборудования. */
export function splitDescription(description: string | null | undefined): {
  summary: string;
  equipment: string[];
} {
  const text = (description ?? "").trim();
  const m = text.match(EQUIPMENT_RE);
  if (!m || m.index === undefined) return { summary: text, equipment: [] };
  const summary = text.slice(0, m.index).trim().replace(/[.।\s]+$/, "");
  // Запятые внутри скобок ("тренажёры (Hip Thrust, Hack Squat)") не делим
  const equipment: string[] = [];
  let depth = 0;
  let current = "";
  for (const ch of m[1]) {
    if (ch === "(") depth += 1;
    if (ch === ")") depth = Math.max(0, depth - 1);
    if ((ch === "," || ch === "،") && depth === 0) {
      equipment.push(current);
      current = "";
    } else current += ch;
  }
  equipment.push(current);
  // "Полный набор зала: штанги, …" — подпись до двоеточия не нужна
  if (equipment[0]?.includes(":")) equipment[0] = equipment[0].split(":").slice(1).join(":");
  return {
    summary,
    equipment: equipment
      .map((e) => e.trim().replace(/\.$/, ""))
      .filter(Boolean)
      .map((e) => e.charAt(0).toUpperCase() + e.slice(1)),
  };
}

export interface ProgramProgress {
  done: number;
  total: number;
}

/**
 * Прогресс по каждой программе: сколько тренировок пройдено из скольких.
 * Прогресс хранится по программам независимо — можно переключаться и
 * возвращаться туда, где остановился.
 */
export function useProgramsProgress() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["programs-progress", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<Record<string, ProgramProgress>> => {
      const [{ data: workouts, error: wError }, { data: logs, error: lError }] = await Promise.all([
        supabase.from("workouts").select("id, program_id, week_order, order, block_repeats"),
        supabase.from("workout_logs").select("workout_id").eq("user_id", authUser!.id),
      ]);
      if (wError) throw wError;
      if (lError) throw lError;

      // С повторами недель блока (0089) — тот же расчёт, что на главной
      const counts = countCompletions((logs ?? []) as { workout_id: string }[]);
      const byProgram = new Map<string, ProgressWorkout[]>();
      for (const w of (workouts ?? []) as {
        id: string;
        program_id: string;
        week_order: number;
        order: number;
        block_repeats: number | null;
      }[]) {
        const list = byProgram.get(w.program_id) ?? [];
        list.push({ id: w.id, weekOrder: w.week_order, order: w.order, blockRepeats: w.block_repeats });
        byProgram.set(w.program_id, list);
      }
      const result: Record<string, ProgramProgress> = {};
      for (const [programId, list] of byProgram) {
        const p = computeProgramProgress(list, counts);
        result[programId] = { done: p.done, total: p.total };
      }
      return result;
    },
  });
}
