import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import type { Subscription, WorkoutProgram, ProgressEntry, UserProfile } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";
import { useAuth } from "@/context/AuthContext";

const FREE_TRIAL_DAYS = 7;

export function useUserProfile() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["user-profile", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<UserProfile | null> => {
      const { data, error } = await supabase
        .from("user_profiles")
        .select("*")
        .eq("user_id", authUser!.id)
        .maybeSingle();
      if (error) throw error;
      return data ? toCamelCase<UserProfile>(data) : null;
    },
  });
}

/**
 * Первая программа ("Набор массы для начинающих") — бесплатный подарок на
 * первую неделю для мужчин с целью набора массы, тренирующихся в зале.
 * По истечении 7 дней с регистрации (или если профиль не подходит под
 * условия) программа перестаёт быть бесплатной — нужна подписка.
 */
export function useFreeProgramAccess() {
  const { profile } = useAuth();
  const { data: userProfile } = useUserProfile();

  const isEligible =
    userProfile?.gender === "male" &&
    userProfile?.trainingFormat === "gym" &&
    (userProfile?.goals ?? []).includes("build_muscle");

  const createdAtMs = profile?.createdAt ? new Date(profile.createdAt).getTime() : null;
  const withinWindow = createdAtMs != null && Date.now() - createdAtMs < FREE_TRIAL_DAYS * 24 * 60 * 60 * 1000;

  return { hasFreeAccess: Boolean(isEligible) && withinWindow };
}

export function usePrograms() {
  return useQuery({
    queryKey: ["programs"],
    queryFn: async (): Promise<WorkoutProgram[]> => {
      const { data, error } = await supabase
        .from("workout_programs")
        .select("*")
        .order("created_at", { ascending: false });
      if (error) throw error;
      return toCamelCase<WorkoutProgram[]>(data ?? []);
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
      return data ? toCamelCase<Subscription>(data) : null;
    },
  });
}

interface WorkoutHistoryEntry {
  id: string;
  completedAt: string;
  durationMinutes: number;
  workoutTitle: string;
}

/** История завершённых тренировок с названием — для раздела «Прогресс». */
export function useWorkoutHistory() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["workout-history", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<WorkoutHistoryEntry[]> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("id, completed_at, duration_minutes, workout:workouts(title)")
        .eq("user_id", authUser!.id)
        .order("completed_at", { ascending: false })
        .limit(20);
      if (error) throw error;

      return ((data ?? []) as unknown as Array<{
        id: string;
        completed_at: string;
        duration_minutes: number;
        workout: { title: string } | null;
      }>).map((row) => ({
        id: row.id,
        completedAt: row.completed_at,
        durationMinutes: row.duration_minutes,
        workoutTitle: row.workout?.title ?? "Тренировка",
      }));
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
      return toCamelCase<ProgressEntry[]>(data ?? []);
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

      const goals = toCamelCase<{ goals?: string[] } | null>(userProfile)?.goals ?? [];
      const primaryGoal = goals[0];

      const match = primaryGoal ? programs.find((p) => p.goal === primaryGoal) : undefined;
      return match ?? programs[0];
    },
  });
}
