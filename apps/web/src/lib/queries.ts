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
import { estimateDailyCalories, estimateWorkoutCalories, calculateAge, type CalorieEstimate } from "@/lib/calories";
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
        // Оплата разовая за период (без автопродления): по истечении
        // current_period_end доступ должен закрываться сам, даже если
        // статус в строке ещё не переведён в 'expired'.
        .gt("current_period_end", new Date().toISOString())
        .order("current_period_end", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (error) throw error;
      return data ? toCamelCase<Subscription>(data) : null;
    },
  });
}

export interface WorkoutHistoryEntry {
  id: string;
  completedAt: string;
  durationMinutes: number;
  workoutTitle: string;
  /** Блок недель, напр. "Недели 13–14" — различает одинаковые "Вторник · НОГИ" из разных недель. */
  weekLabel: string | null;
  /** Сожжённые калории (0066), null — не посчитаны (не было веса в профиле). */
  caloriesBurned: number | null;
}

export interface WorkoutHistory {
  entries: WorkoutHistoryEntry[];
  /** Сколько тренировок отмечено тренером через "Догнать прогресс" (в список не входят). */
  catchUpCount: number;
}

/**
 * История тренировок для раздела «Прогресс» — только реально пройденные
 * в приложении. Отметки "Догнать прогресс" из админки (is_catch_up, 0066)
 * в список не входят: это десятки записей с одной датой и расчётной, а не
 * реальной длительностью — выглядело как бессмысленный список. Вместо них
 * — одна строка-итог (catchUpCount).
 */
export function useWorkoutHistory() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["workout-history", authUser?.id, i18n.language],
    enabled: !!authUser,
    queryFn: async (): Promise<WorkoutHistory> => {
      // Два запроса вместо вложенной выборки workout_logs → workouts —
      // см. комментарий у attachWorkoutInfo (отсутствовавший FK, 0067).
      const [{ data, error }, { count: catchUpCount, error: countError }] = await Promise.all([
        supabase
          .from("workout_logs")
          .select("id, completed_at, duration_minutes, workout_id, calories_burned")
          .eq("user_id", authUser!.id)
          .eq("is_catch_up", false)
          .order("completed_at", { ascending: false })
          .limit(20),
        supabase
          .from("workout_logs")
          .select("id", { count: "exact", head: true })
          .eq("user_id", authUser!.id)
          .eq("is_catch_up", true),
      ]);
      if (error) throw error;
      if (countError) throw countError;

      const rows = (data ?? []) as unknown as Array<{
        id: string;
        completed_at: string;
        duration_minutes: number;
        workout_id: string;
        calories_burned: number | null;
      }>;
      const ids = [...new Set(rows.map((r) => r.workout_id))];
      const info = new Map<string, { title: string; weekLabel: string | null }>();
      if (ids.length > 0) {
        const { data: workouts, error: workoutsError } = await supabase
          .from("workouts")
          .select("id, title, title_en, title_es, title_hy, week_label, week_label_en, week_label_es, week_label_hy")
          .in("id", ids);
        if (workoutsError) throw workoutsError;
        for (const w of (workouts ?? []) as Array<Record<string, string | null>>) {
          info.set(w.id as string, {
            title: localizedField(
              w.title ?? "",
              { en: w.title_en, es: w.title_es, hy: w.title_hy },
              i18n.language,
            ),
            weekLabel: w.week_label
              ? localizedField(
                  w.week_label,
                  { en: w.week_label_en, es: w.week_label_es, hy: w.week_label_hy },
                  i18n.language,
                )
              : null,
          });
        }
      }

      return {
        catchUpCount: catchUpCount ?? 0,
        entries: rows.map((row) => ({
          id: row.id,
          completedAt: row.completed_at,
          durationMinutes: row.duration_minutes,
          workoutTitle: info.get(row.workout_id)?.title || i18n.t("progress.workoutFallback"),
          weekLabel: info.get(row.workout_id)?.weekLabel ?? null,
          caloriesBurned: row.calories_burned,
        })),
      };
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
        .select("id, title, title_en, title_es, title_hy")
        .in("id", Array.from(best.keys()));
      if (exercisesError) throw exercisesError;

      const titleMap = new Map<string, string>(
        (exercisesData ?? []).map((e) => [
          e.id as string,
          localizedField(
            e.title as string,
            {
              en: e.title_en as string | null,
              es: e.title_es as string | null,
              hy: e.title_hy as string | null,
            },
            i18n.language,
          ),
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

/**
 * Строка workout_logs для подсчёта калорий + данные тренировки/программы,
 * нужные для запасного расчёта (если calories_burned ещё не заполнен —
 * например, в профиле не было веса на момент тренировки).
 */
interface CalorieLogRow {
  workout_id: string;
  completed_at: string;
  duration_minutes: number | null;
  calories_burned: number | null;
  workout: {
    estimated_duration_minutes: number | null;
    program: { goal: string | null } | null;
  } | null;
}

const CALORIE_LOG_COLUMNS = "workout_id, completed_at, duration_minutes, calories_burned";

/**
 * Намеренно ДВА запроса, а не вложенная выборка workout_logs → workouts:
 * в реальной базе у workout_logs долго не было внешнего ключа на
 * workouts (остаток старого черновика, чинит 0067), и вложенная выборка
 * падала с "Could not find a relationship". Так калории работают
 * независимо от того, применена ли 0067.
 */
async function attachWorkoutInfo(
  logs: Omit<CalorieLogRow, "workout">[],
): Promise<CalorieLogRow[]> {
  // Нужны только для записей без сохранённых калорий
  const ids = [...new Set(logs.filter((l) => l.calories_burned == null).map((l) => l.workout_id))];
  const info = new Map<string, CalorieLogRow["workout"]>();
  if (ids.length > 0) {
    const { data, error } = await supabase
      .from("workouts")
      .select("id, estimated_duration_minutes, program:workout_programs(goal)")
      .in("id", ids);
    if (error) throw error;
    for (const w of (data ?? []) as unknown as {
      id: string;
      estimated_duration_minutes: number | null;
      program: { goal: string | null } | null;
    }[]) {
      info.set(w.id, { estimated_duration_minutes: w.estimated_duration_minutes, program: w.program });
    }
  }
  return logs.map((l) => ({ ...l, workout: info.get(l.workout_id) ?? null }));
}

function caloriesOfLog(row: CalorieLogRow, profile: UserProfile | null | undefined): number {
  if (row.calories_burned != null) return row.calories_burned;
  if (!profile?.weightKg) return 0;
  return estimateWorkoutCalories({
    weightKg: profile.weightKg,
    heightCm: profile.heightCm,
    age: profile.birthDate ? calculateAge(profile.birthDate, new Date(row.completed_at)) : null,
    gender: profile.gender,
    actualMinutes: row.duration_minutes ?? 0,
    estimatedMinutes: row.workout?.estimated_duration_minutes,
    programGoal: row.workout?.program?.goal,
  });
}

/** Границы локального дня (YYYY-MM-DD) в ISO/UTC — чтобы тренировка в 00:30 по Мадриду не уехала во "вчера". */
function localDayRange(date: string): { from: string; to: string } {
  const [y, m, d] = date.split("-").map(Number);
  const start = new Date(y, m - 1, d);
  const end = new Date(y, m - 1, d + 1);
  return { from: start.toISOString(), to: end.toISOString() };
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

      const { from, to } = localDayRange(date);
      const [{ data: override }, { data: dayWorkouts, error: workoutsError }] = await Promise.all([
        supabase
          .from("calorie_overrides")
          .select("calories")
          .eq("user_id", authUser!.id)
          .eq("logged_at", date)
          .maybeSingle(),
        supabase
          .from("workout_logs")
          .select(CALORIE_LOG_COLUMNS)
          .eq("user_id", authUser!.id)
          // Записи "догнать прогресс" из админки — не тренировки сегодня (0066)
          .eq("is_catch_up", false)
          .gte("completed_at", from)
          .lt("completed_at", to),
      ]);
      if (workoutsError) throw workoutsError;

      const dayRows = await attachWorkoutInfo(
        (dayWorkouts ?? []) as unknown as Omit<CalorieLogRow, "workout">[],
      );
      const workoutCalories = dayRows.reduce(
        (sum, row) => sum + caloriesOfLog(row, profile),
        0,
      );

      const estimate = estimateDailyCalories({
        weightKg: profile.weightKg,
        heightCm: profile.heightCm,
        age: calculateAge(profile.birthDate),
        gender: profile.gender,
        activityLevel: profile.activityLevel,
        workoutCalories,
      });

      if (override?.calories != null) {
        return { ...estimate, total: override.calories, isManual: true };
      }
      return { ...estimate, isManual: false };
    },
  });
}

export interface WorkoutCalorieStats {
  /** Всего сожжено на тренировках в приложении, ккал. */
  total: number;
  /** За последние 7 дней. */
  week: number;
  /** С начала текущего месяца. */
  month: number;
  /** Сколько тренировок учтено. */
  workouts: number;
  /** Калории последней тренировки (null — тренировок ещё не было). */
  last: number | null;
}

/**
 * Счётчик калорий, сожжённых на тренировках — растёт с каждой завершённой
 * тренировкой. Учитываются только тренировки, пройденные в приложении
 * (записи "догнать прогресс" — нет: их реальная длительность/интенсивность
 * неизвестна).
 */
export function useWorkoutCalorieStats() {
  const { authUser } = useAuth();
  const { data: profile } = useUserProfile();

  return useQuery({
    queryKey: ["workout-calorie-stats", authUser?.id, profile?.updatedAt],
    enabled: !!authUser && profile !== undefined,
    queryFn: async (): Promise<WorkoutCalorieStats> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select(CALORIE_LOG_COLUMNS)
        .eq("user_id", authUser!.id)
        .eq("is_catch_up", false)
        .order("completed_at", { ascending: false });
      if (error) throw error;

      const rows = await attachWorkoutInfo((data ?? []) as unknown as Omit<CalorieLogRow, "workout">[]);
      const now = new Date();
      const weekAgo = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 6).getTime();
      const monthStart = new Date(now.getFullYear(), now.getMonth(), 1).getTime();

      const stats: WorkoutCalorieStats = { total: 0, week: 0, month: 0, workouts: rows.length, last: null };
      rows.forEach((row, i) => {
        const kcal = caloriesOfLog(row, profile);
        const at = new Date(row.completed_at).getTime();
        stats.total += kcal;
        if (at >= weekAgo) stats.week += kcal;
        if (at >= monthStart) stats.month += kcal;
        if (i === 0) stats.last = kcal;
      });
      return stats;
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
