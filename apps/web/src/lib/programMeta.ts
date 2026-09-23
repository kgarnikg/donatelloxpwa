import { useQuery } from "@tanstack/react-query";
import type { WorkoutProgram } from "@donatellox/types";
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

// "Оборудование:" / "Equipment:" / "Equipo:" / "Սարքավորում…:" — в описаниях
// всех 8 программ оборудование идёт последним предложением.
const EQUIPMENT_RE = /(?:Оборудование|Equipment|Equipo|Սարքավորում\S*)\s*:\s*(.+)$/i;

/** Делит описание на основную часть и список оборудования. */
export function splitDescription(description: string | null | undefined): {
  summary: string;
  equipment: string[];
} {
  const text = (description ?? "").trim();
  const m = text.match(EQUIPMENT_RE);
  if (!m || m.index === undefined) return { summary: text, equipment: [] };
  const summary = text.slice(0, m.index).trim().replace(/[.\s]+$/, "");
  // Запятые внутри скобок ("тренажёры (Hip Thrust, Hack Squat)") не делим
  const equipment: string[] = [];
  let depth = 0;
  let current = "";
  for (const ch of m[1]) {
    if (ch === "(") depth += 1;
    if (ch === ")") depth = Math.max(0, depth - 1);
    if (ch === "," && depth === 0) {
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
        supabase.from("workouts").select("id, program_id"),
        supabase.from("workout_logs").select("workout_id").eq("user_id", authUser!.id),
      ]);
      if (wError) throw wError;
      if (lError) throw lError;

      const done = new Set((logs ?? []).map((l) => l.workout_id as string));
      const result: Record<string, ProgramProgress> = {};
      for (const w of (workouts ?? []) as { id: string; program_id: string }[]) {
        const p = (result[w.program_id] ??= { done: 0, total: 0 });
        p.total += 1;
        if (done.has(w.id)) p.done += 1;
      }
      return result;
    },
  });
}
