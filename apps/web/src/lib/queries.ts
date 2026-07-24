import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import type { Subscription, WorkoutProgram, ProgressEntry } from "@donatellox/types";
import { useAuth } from "@/context/AuthContext";

export function usePrograms() {
  return useQuery({
    queryKey: ["programs"],
    queryFn: async (): Promise<WorkoutProgram[]> => {
      const { data, error } = await supabase
        .from("workout_programs")
        .select("*")
        .order("created_at", { ascending: false });
      if (error) throw error;
      return (data ?? []) as unknown as WorkoutProgram[];
    },
  });
}

export function useActiveSubscription() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["subscription", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<Subscription | null> => {
      const { data, error } = await supabase
        .from("subscriptions")
        .select("*")
        .eq("user_id", authUser!.id)
        .in("status", ["active", "trialing", "past_due"])
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (error) throw error;
      return data as unknown as Subscription | null;
    },
  });
}

export function useProgressHistory() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["progress", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<ProgressEntry[]> => {
      const { data, error } = await supabase
        .from("progress_entries")
        .select("*")
        .eq("user_id", authUser!.id)
        .order("recorded_at", { ascending: true });
      if (error) throw error;
      return (data ?? []) as unknown as ProgressEntry[];
    },
  });
}

interface WorkoutStats {
  totalWorkouts: number;
  currentStreakDays: number;
}

/** Считает общее число завершённых тренировок и текущую серию дней подряд. */
export function useWorkoutStats() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["workout-stats", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<WorkoutStats> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("completed_at")
        .eq("user_id", authUser!.id)
        .order("completed_at", { ascending: false });
      if (error) throw error;

      const rows = (data ?? []) as { completed_at: string }[];
      const daySet = new Set(rows.map((r) => r.completed_at.slice(0, 10)));

      let streak = 0;
      const cursor = new Date();
      cursor.setHours(0, 0, 0, 0);
      // Если сегодня ещё не тренировались, даём "грейс-период" — считаем
      // серию от вчерашнего дня, чтобы она не обнулялась раньше времени.
      if (!daySet.has(cursor.toISOString().slice(0, 10))) {
        cursor.setDate(cursor.getDate() - 1);
      }
      while (daySet.has(cursor.toISOString().slice(0, 10))) {
        streak += 1;
        cursor.setDate(cursor.getDate() - 1);
      }

      return { totalWorkouts: rows.length, currentStreakDays: streak };
    },
  });
}

/**
 * Простой подбор программы под анкету: сперва ищем совпадение по первой
 * указанной цели, иначе показываем первую доступную программу.
 * Полноценный алгоритм подбора (уровень + формат + дни/нед) можно нарастить
 * поверх этой же функции, когда программ станет больше одной.
 */
export function useRecommendedProgram() {
  const { profile: authProfile } = useAuth();
  const { data: programs } = usePrograms();

  return useQuery({
    queryKey: ["recommended-program", authProfile?.id, programs?.map((p) => p.id).join(",")],
    enabled: !!programs,
    queryFn: async (): Promise<WorkoutProgram | null> => {
      if (!programs?.length) return null;
      if (!authProfile) return programs[0];

      const { data: userProfile } = await supabase
        .from("user_profiles")
        .select("goals")
        .eq("user_id", authProfile.id)
        .maybeSingle();

      const goals = (userProfile as { goals?: string[] } | null)?.goals ?? [];
      const primaryGoal = goals[0];

      const match = primaryGoal ? programs.find((p) => p.goal === primaryGoal) : undefined;
      return match ?? programs[0];
    },
  });
}
