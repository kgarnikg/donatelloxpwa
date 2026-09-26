import { useQuery } from "@tanstack/react-query";
import type { WorkoutProgram } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { withTranslations } from "@/lib/localizedField";
import { useAuth } from "@/context/AuthContext";
import { usePrograms, useRecommendedProgram, useUserProfile } from "@/lib/queries";
import { summarize, type GameLog, type GameSummary } from "@/lib/gamification";

/**
 * Данные для главной (DashboardPage): текущая программа и следующая
 * тренировка в ней, путь по программе, XP/уровень, серия недель, объём.
 *
 * Один хук вместо пяти разрозненных запросов на главной — вся история
 * тренировок загружается один раз и из неё считается всё остальное.
 */

export interface DashboardWorkout {
  id: string;
  title: string;
  titleEn?: string | null;
  titleEs?: string | null;
  titleHy?: string | null;
  weekLabel?: string | null;
  weekLabelEn?: string | null;
  weekLabelEs?: string | null;
  weekLabelHy?: string | null;
  weekOrder: number;
  order: number;
  estimatedDurationMinutes: number;
}

export interface DashboardData {
  /** Программа, по которой человек реально идёт (последняя тренировка), иначе — рекомендованная. */
  program: WorkoutProgram | null;
  /** true — человек уже тренировался по этой программе. */
  isActiveProgram: boolean;
  nextWorkout: DashboardWorkout | null;
  /** Номер следующей тренировки внутри её блока недель и размер блока. */
  nextPositionInBlock: { n: number; total: number } | null;
  programDone: number;
  programTotal: number;
  game: GameSummary;
  /**
   * Сколько тренировок в неделю человек выбрал в анкете (2–6); по нему
   * считаются план недели и серия. Нет ответа — как в программе.
   */
  weeklyTarget: number;
  totalWorkouts: number;
  totalVolumeKg: number;
  hasAnyWorkouts: boolean;
}

interface LogRow {
  workout_id: string;
  completed_at: string;
  is_catch_up: boolean | null;
  total_volume_kg: number | null;
  completed_sets: { exerciseId?: string; weightKg?: number }[] | null;
}

export function useDashboard() {
  const { authUser } = useAuth();
  const { data: programs } = usePrograms();
  const { data: recommended, isFetched: recommendedFetched } = useRecommendedProgram();
  const { data: userProfile, isFetched: profileFetched } = useUserProfile();
  const chosenDays = userProfile?.daysPerWeek ?? null;

  return useQuery({
    queryKey: ["dashboard", authUser?.id, programs?.length, recommended?.id, chosenDays],
    enabled: !!authUser && !!programs && recommendedFetched && profileFetched,
    queryFn: async (): Promise<DashboardData> => {
      const { data: logData, error: logError } = await supabase
        .from("workout_logs")
        .select("workout_id, completed_at, is_catch_up, total_volume_kg, completed_sets")
        .eq("user_id", authUser!.id)
        .order("completed_at", { ascending: false });
      if (logError) throw logError;
      const logs = (logData ?? []) as LogRow[];

      // Текущая программа — та, к которой относится последняя тренировка
      let program: WorkoutProgram | null = null;
      if (logs.length > 0) {
        const { data: lastWorkout, error } = await supabase
          .from("workouts")
          .select("program_id")
          .eq("id", logs[0].workout_id)
          .maybeSingle();
        if (error) throw error;
        program = programs!.find((p) => p.id === lastWorkout?.program_id) ?? null;
      }
      const isActiveProgram = !!program;
      program = program ?? recommended ?? null;

      let workouts: DashboardWorkout[] = [];
      if (program) {
        const { data, error } = await supabase
          .from("workouts")
          .select(`id, ${withTranslations("title", "week_label")}, week_order, order, estimated_duration_minutes`)
          .eq("program_id", program.id)
          .order("week_order", { ascending: true })
          .order("order", { ascending: true });
        if (error) throw error;
        workouts = toCamelCase<DashboardWorkout[]>(data ?? []);
      }

      // Следующая = первая по порядку непройденная (та же логика, что в ProgramDetailPage)
      const doneIds = new Set(logs.map((l) => l.workout_id));
      const nextWorkout = workouts.find((w) => !doneIds.has(w.id)) ?? null;
      let nextPositionInBlock: DashboardData["nextPositionInBlock"] = null;
      if (nextWorkout) {
        const block = workouts.filter((w) => w.weekOrder === nextWorkout.weekOrder);
        nextPositionInBlock = { n: block.indexOf(nextWorkout) + 1, total: block.length };
      }

      const gameLogs: GameLog[] = logs.map((l) => ({
        completedAt: l.completed_at,
        isCatchUp: !!l.is_catch_up,
        weights: (l.completed_sets ?? [])
          .filter((s) => s.exerciseId && typeof s.weightKg === "number" && s.weightKg > 0)
          .map((s) => ({ exerciseId: s.exerciseId!, weightKg: s.weightKg! })),
      }));

      return {
        program,
        isActiveProgram,
        nextWorkout,
        nextPositionInBlock,
        programDone: workouts.filter((w) => doneIds.has(w.id)).length,
        programTotal: workouts.length,
        game: summarize(gameLogs, chosenDays ?? program?.workoutsPerWeek ?? 3),
        weeklyTarget: chosenDays ?? program?.workoutsPerWeek ?? 3,
        totalWorkouts: logs.length,
        totalVolumeKg: logs.reduce((sum, l) => sum + (Number(l.total_volume_kg) || 0), 0),
        hasAnyWorkouts: logs.length > 0,
      };
    },
  });
}
