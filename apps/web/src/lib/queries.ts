import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import type {
  Subscription,
  WorkoutProgram,
  ProgressEntry,
  UserProfile,
  AchievementWithStatus,
  PersonalRecord,
} from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";
import { useAuth } from "@/context/AuthContext";
import { estimateDailyCalories, calculateAge, type CalorieEstimate } from "@/lib/calories";
import { localizedField } from "@/lib/localizedField";
import i18n from "@/i18n";

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
 * Подбор программы под анкету: сперва ищем точное совпадение по трём
 * измерениям (пол, первая указанная цель, формат тренировок), затем
 * постепенно ослабляем условия — на случай, если для какой-то комбинации
 * ещё нет специализированной программы. Последний fallback — первая
 * доступная программа, чтобы пользователь никогда не остался без плана.
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
        .select("gender, goals, training_format")
        .eq("user_id", authProfile.id)
        .maybeSingle();

      const parsed = toCamelCase<{ gender?: string; goals?: string[]; trainingFormat?: string } | null>(
        userProfile
      );
      const gender = parsed?.gender;
      const primaryGoal = parsed?.goals?.[0];
      const trainingFormat = parsed?.trainingFormat;

      if (!primaryGoal) return programs[0];

      // От самого точного совпадения к самому общему. Каждый следующий шаг
      // ослабляет одно условие за раз, а goal остаётся обязательным всегда —
      // это то единственное, что гарантированно есть у пользователя, раз он
      // прошёл онбординг.
      const candidates: Array<(p: WorkoutProgram) => boolean> = [
        // 1. Точное совпадение по всем трём измерениям.
        (p) => p.goal === primaryGoal && p.gender === gender && p.trainingFormat === trainingFormat,
        // 2. Формат не совпал (или не задан) — берём универсальную по формату.
        (p) => p.goal === primaryGoal && p.gender === gender && p.trainingFormat === "any",
        // 3. Пол не совпал (или не задан) — берём универсальную по полу.
        (p) => p.goal === primaryGoal && p.gender === "unspecified" && p.trainingFormat === trainingFormat,
        // 4. Универсальная и по полу, и по формату.
        (p) => p.goal === primaryGoal && p.gender === "unspecified" && p.trainingFormat === "any",
        // 5. Старое поведение — только цель, для программ без targeting-полей
        //    (например, добавленных до миграции 0012).
        (p) => p.goal === primaryGoal,
      ];

      for (const matches of candidates) {
        const found = programs.find(matches);
        if (found) return found;
      }

      return programs[0];
    },
  });
}

// ---------------------------------------------------------------------------
// Награды и достижения (0023). Разблокировка считается триггером на
// сервере — здесь только читаем каталог + свои разблокированные записи и
// сливаем их в один список для UI (см. AchievementsPage).
// ---------------------------------------------------------------------------
export function useAchievements() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["achievements", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<AchievementWithStatus[]> => {
      const [{ data: catalog, error: catalogError }, { data: unlocked, error: unlockedError }] =
        await Promise.all([
          supabase.from("achievements").select("*").order("sort_order", { ascending: true }),
          supabase
            .from("user_achievements")
            .select("achievement_id, unlocked_at")
            .eq("user_id", authUser!.id),
        ]);
      if (catalogError) throw catalogError;
      if (unlockedError) throw unlockedError;

      const unlockedMap = new Map<string, string>(
        (unlocked ?? []).map((row) => [row.achievement_id as string, row.unlocked_at as string]),
      );

      return (catalog ?? []).map((row) => {
        const camel = toCamelCase<Omit<AchievementWithStatus, "unlockedAt">>(row);
        return { ...camel, unlockedAt: unlockedMap.get(row.id as string) ?? null };
      });
    },
  });
}

/**
 * Личные рекорды по упражнениям — максимальный зафиксированный рабочий вес.
 * Считается на клиенте из уже существующих workout_logs.completed_sets,
 * отдельная таблица не нужна (см. комментарий в 0023).
 */
export function usePersonalRecords() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["personal-records", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<PersonalRecord[]> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("completed_at, completed_sets")
        .eq("user_id", authUser!.id)
        .order("completed_at", { ascending: true });
      if (error) throw error;

      const rows = (data ?? []) as { completed_at: string; completed_sets: unknown }[];
      const best = new Map<string, { weightKg: number; achievedAt: string }>();
      for (const row of rows) {
        const sets = (row.completed_sets ?? []) as Array<{ exerciseId?: string; weightKg?: number }>;
        for (const s of sets) {
          if (!s.exerciseId || typeof s.weightKg !== "number") continue;
          const current = best.get(s.exerciseId);
          if (!current || s.weightKg > current.weightKg) {
            best.set(s.exerciseId, { weightKg: s.weightKg, achievedAt: row.completed_at });
          }
        }
      }
      if (best.size === 0) return [];

      const { data: exercisesData, error: exercisesError } = await supabase
        .from("exercises")
        .select("id, title, title_en")
        .in("id", Array.from(best.keys()));
      if (exercisesError) throw exercisesError;

      const titleMap = new Map<string, string>(
        (exercisesData ?? []).map((e) => [
          e.id as string,
          localizedField(e.title as string, e.title_en as string | null, i18n.language),
        ]),
      );

      return Array.from(best.entries())
        .map(([exerciseId, v]) => ({
          exerciseId,
          exerciseTitle: titleMap.get(exerciseId) ?? "Упражнение",
          bestWeightKg: v.weightKg,
          achievedAt: v.achievedAt,
        }))
        .sort((a, b) => b.bestWeightKg - a.bestWeightKg);
    },
  });
}

// ---------------------------------------------------------------------------
// Калории — автоматическая оценка расхода (0025), с возможностью ручного
// переопределения на конкретный день (например, данными с умных часов).
// ---------------------------------------------------------------------------

export interface DailyCalories extends CalorieEstimate {
  /** true — пользователь переопределил наш расчёт вручную для этого дня. */
  isManual: boolean;
}

/** Автоматическая оценка расхода калорий за день + переопределение, если оно есть. */
export function useDailyCalories(date: string) {
  const { authUser } = useAuth();
  const { data: profile } = useUserProfile();

  return useQuery({
    queryKey: ["daily-calories", authUser?.id, date, profile?.updatedAt],
    enabled: !!authUser && !!profile,
    queryFn: async (): Promise<DailyCalories | null> => {
      if (!profile?.weightKg || !profile?.heightCm || !profile?.birthDate) return null;

      const [{ data: override }, { data: dayWorkouts, error: workoutsError }] = await Promise.all([
        supabase
          .from("calorie_overrides")
          .select("calories")
          .eq("user_id", authUser!.id)
          .eq("logged_at", date)
          .maybeSingle(),
        supabase
          .from("workout_logs")
          .select("duration_minutes")
          .eq("user_id", authUser!.id)
          .gte("completed_at", `${date}T00:00:00`)
          .lt("completed_at", `${date}T23:59:59.999`),
      ]);
      if (workoutsError) throw workoutsError;

      const workoutMinutes = (dayWorkouts ?? []).reduce(
        (sum, w) => sum + ((w as { duration_minutes: number }).duration_minutes ?? 0),
        0,
      );

      const estimate = estimateDailyCalories({
        weightKg: profile.weightKg,
        heightCm: profile.heightCm,
        age: calculateAge(profile.birthDate),
        gender: profile.gender,
        activityLevel: profile.activityLevel,
        workoutMinutes,
      });

      if (override?.calories != null) {
        return { ...estimate, total: override.calories, isManual: true };
      }
      return { ...estimate, isManual: false };
    },
  });
}

export function useSetCalorieOverride() {
  const { authUser } = useAuth();
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ loggedAt, calories }: { loggedAt: string; calories: number }) => {
      if (!authUser) throw new Error("Сессия истекла — войдите заново.");
      const { error } = await supabase
        .from("calorie_overrides")
        .upsert(
          { user_id: authUser.id, logged_at: loggedAt, calories, updated_at: new Date().toISOString() },
          { onConflict: "user_id,logged_at" },
        );
      if (error) throw error;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ["daily-calories", authUser?.id, variables.loggedAt] });
    },
  });
}

export function useClearCalorieOverride() {
  const { authUser } = useAuth();
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ loggedAt }: { loggedAt: string }) => {
      if (!authUser) return;
      const { error } = await supabase
        .from("calorie_overrides")
        .delete()
        .eq("user_id", authUser.id)
        .eq("logged_at", loggedAt);
      if (error) throw error;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ["daily-calories", authUser?.id, variables.loggedAt] });
    },
  });
}

// ---------------------------------------------------------------------------
// Поднятый вес — по тренировке/неделе/месяцу/году/всё время (0026), плюс
// достижения за суммарный объём (та же таблица achievements, категория
// 'volume', разблокируются триггером на сервере — см. useAchievements выше).
// ---------------------------------------------------------------------------

export type VolumePeriod = "workout" | "week" | "month" | "year" | "all";

export interface VolumeStats {
  /** Суммарный поднятый вес (кг) по каждому периоду, считая от текущего момента. */
  workout: number;
  week: number;
  month: number;
  year: number;
  all: number;
}

export function useVolumeStats() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["volume-stats", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<VolumeStats> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("completed_at, total_volume_kg")
        .eq("user_id", authUser!.id)
        .order("completed_at", { ascending: false });
      if (error) throw error;

      const rows = (data ?? []) as { completed_at: string; total_volume_kg: number }[];
      const now = Date.now();
      const DAY = 24 * 60 * 60 * 1000;

      const stats: VolumeStats = { workout: 0, week: 0, month: 0, year: 0, all: 0 };
      rows.forEach((row, i) => {
        const ageMs = now - new Date(row.completed_at).getTime();
        const volume = row.total_volume_kg ?? 0;
        if (i === 0) stats.workout = volume;
        if (ageMs <= 7 * DAY) stats.week += volume;
        if (ageMs <= 30 * DAY) stats.month += volume;
        if (ageMs <= 365 * DAY) stats.year += volume;
        stats.all += volume;
      });
      return stats;
    },
  });
}
