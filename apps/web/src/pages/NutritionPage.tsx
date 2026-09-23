import { useMemo, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Link } from "react-router-dom";
import { Beef, Wheat, Droplet, Info, Lock, Pencil, RotateCcw, Watch, Flame, Dumbbell } from "lucide-react";
import { useTranslation } from "react-i18next";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import {
  useActiveSubscription,
  useDailyCalories,
  useSetCalorieOverride,
  useClearCalorieOverride,
  useWorkoutCalorieStats,
} from "@/lib/queries";
import type { FitnessGoal } from "@donatellox/types";

interface NutritionGuidance {
  title: string;
  calorieNote: string;
  macros: { protein: string; carbs: string; fat: string };
  mealStructure: string[];
  tips: string[];
}

/**
 * Рекомендации по питанию — раньше были литеральными русскими строками
 * прямо в этом файле (не через t()), поэтому не переводились на другие
 * языки вообще. Теперь берутся из i18n (nutrition.guidance.<goal>.*),
 * массивы (mealStructure/tips) — через { returnObjects: true }.
 */
function useNutritionGuidance(goal: FitnessGoal): NutritionGuidance {
  const { t } = useTranslation();
  return {
    title: t(`nutrition.guidance.${goal}.title`),
    calorieNote: t(`nutrition.guidance.${goal}.calorieNote`),
    macros: {
      protein: t(`nutrition.guidance.${goal}.macros.protein`),
      carbs: t(`nutrition.guidance.${goal}.macros.carbs`),
      fat: t(`nutrition.guidance.${goal}.macros.fat`),
    },
    mealStructure: t(`nutrition.guidance.${goal}.mealStructure`, { returnObjects: true }) as string[],
    tips: t(`nutrition.guidance.${goal}.tips`, { returnObjects: true }) as string[],
  };
}

export default function NutritionPage() {
  const { t, i18n } = useTranslation();
  const { authUser } = useAuth();
  const { data: subscription, isLoading: subLoading } = useActiveSubscription();

  const { data: goals, isLoading } = useQuery({
    queryKey: ["nutrition-goals", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<FitnessGoal[]> => {
      const { data, error } = await supabase
        .from("user_profiles")
        .select("goals")
        .eq("user_id", authUser!.id)
        .maybeSingle();
      if (error) throw error;
      return (data as { goals?: FitnessGoal[] } | null)?.goals ?? [];
    },
  });

  const primaryGoal: FitnessGoal = goals?.[0] ?? "general_fitness";
  const guidance = useNutritionGuidance(primaryGoal);

  // ---- Автоматический расчёт калорий (0025) ------------------------------
  const todayStr = useMemo(() => {
    const d = new Date();
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  }, []);

  const { data: daily, isLoading: dailyLoading, error: dailyError } = useDailyCalories(todayStr);
  const { data: burnStats, isLoading: burnStatsLoading, error: burnStatsError } = useWorkoutCalorieStats();
  const setOverride = useSetCalorieOverride();
  const clearOverride = useClearCalorieOverride();

  const [editingOverride, setEditingOverride] = useState(false);
  const [overrideValue, setOverrideValue] = useState("");

  function startEditingOverride() {
    setOverrideValue(daily ? String(daily.total) : "");
    setEditingOverride(true);
  }

  function saveOverride() {
    const value = Math.round(Number(overrideValue));
    if (!value || value <= 0) return;
    setOverride.mutate({ loggedAt: todayStr, calories: value }, { onSuccess: () => setEditingOverride(false) });
  }

  if (isLoading || subLoading) {
    return (
      <div className="px-5 pt-8">
        <div className="card h-40 animate-pulse bg-ink-800" />
      </div>
    );
  }

  if (!subscription) {
    return (
      <div className="px-5 pt-8">
        <h1 className="mb-6 font-display text-2xl font-bold">{t("nutrition.title")}</h1>
        <div className="card flex flex-col items-center py-10 text-center">
          <div className="mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
            <Lock size={24} />
          </div>
          <p className="font-semibold">{t("nutrition.locked")}</p>
          <p className="mt-1.5 max-w-xs text-sm text-neutral-400">
            {t("nutrition.lockedDesc")}
          </p>
          <Link to="/subscription" className="btn-primary mt-6">
            {t("nutrition.subscribe")}
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="px-5 pt-8 pb-6">
      <h1 className="mb-1 font-display text-2xl font-bold">{t("nutrition.title")}</h1>
      <p className="mb-6 text-neutral-400">{t("nutrition.subtitle", { goal: guidance.title.toLowerCase() })}</p>

      <div className="card mb-4 flex items-start gap-3 border-info/30 bg-info/5">
        <Info size={18} className="mt-0.5 shrink-0 text-info" />
        <p className="text-sm text-neutral-300">{t("nutrition.disclaimer")}</p>
      </div>

      {/* Автоматическая оценка расхода калорий за сегодня */}
      <div className="card mb-4">
        <div className="mb-3 flex items-center justify-between">
          <h2 className="flex items-center gap-1.5 font-semibold">
            <Flame size={16} className="text-ember-400" />
            {t("nutrition.calorieBurn.title")}
          </h2>
          {!editingOverride && !dailyLoading && daily && (
            <button
              onClick={startEditingOverride}
              className="flex items-center gap-1 rounded-full bg-ink-800 px-3 py-1.5 text-xs font-semibold text-neutral-300 transition hover:bg-ink-700"
            >
              <Pencil size={12} /> {t("nutrition.calorieBurn.edit")}
            </button>
          )}
        </div>

        {dailyLoading && <div className="h-16 animate-pulse rounded-md bg-ink-800" />}

        {/* Ошибка загрузки — показываем честно, а не "заполните профиль" */}
        {!dailyLoading && dailyError && (
          <div className="rounded-md border border-danger/30 bg-danger/10 px-3 py-2 text-sm text-danger">
            {t("nutrition.loadError")} ({(dailyError as Error).message})
          </div>
        )}

        {!dailyLoading && !dailyError && !daily && (
          <div className="py-2 text-sm text-neutral-400">
            {t("nutrition.calorieBurn.incompleteProfile")}{" "}
            <Link to="/profile/body" className="font-medium text-volt-400">
              {t("nutrition.calorieBurn.completeProfile")}
            </Link>
          </div>
        )}

        {!dailyLoading && daily && !editingOverride && (
          <>
            <p className="font-display text-3xl font-bold text-volt-400">
              {daily.total} <span className="text-base font-normal text-neutral-500">{t("nutrition.log.kcal")}</span>
            </p>
            <p className="mt-2 text-sm text-neutral-300">{t("nutrition.calorieBurn.explainer")}</p>

            {daily.isManual ? (
              <div className="mt-2 flex items-center gap-1.5 text-xs text-neutral-400">
                <Watch size={12} />
                {t("nutrition.calorieBurn.manualNote")}
                <button
                  onClick={() => clearOverride.mutate({ loggedAt: todayStr })}
                  className="ml-1 flex items-center gap-1 font-medium text-volt-400"
                >
                  <RotateCcw size={11} /> {t("nutrition.calorieBurn.reset")}
                </button>
              </div>
            ) : (
              <p className="mt-1.5 text-xs text-neutral-500">
                {t("nutrition.calorieBurn.breakdown", {
                  bmr: daily.bmr,
                  activity: daily.activityCalories,
                  workout: daily.workoutCalories,
                })}
              </p>
            )}
          </>
        )}

        {editingOverride && (
          <div className="mt-1 flex items-center gap-2">
            <input
              type="number"
              inputMode="numeric"
              min={0}
              autoFocus
              value={overrideValue}
              onChange={(e) => setOverrideValue(e.target.value)}
              className="input-field flex-1 py-2 text-sm"
              placeholder="0"
            />
            <button
              onClick={saveOverride}
              disabled={!overrideValue || setOverride.isPending}
              className="btn-primary px-4 py-2 text-sm"
            >
              {t("common.save")}
            </button>
            <button
              onClick={() => setEditingOverride(false)}
              className="px-3 py-2 text-sm text-neutral-400"
            >
              {t("common.cancel")}
            </button>
          </div>
        )}

        <p className="mt-3 text-xs text-neutral-500">{t("nutrition.calorieBurn.disclaimer")}</p>
      </div>

      {/* Счётчик: сколько всего сожжено на тренировках — растёт с каждой тренировкой */}
      <div className="card mb-4">
        <h2 className="mb-3 flex items-center gap-1.5 font-semibold">
          <Dumbbell size={16} className="text-volt-400" />
          {t("nutrition.workoutBurn.title")}
        </h2>

        {burnStatsLoading && <div className="h-16 animate-pulse rounded-md bg-ink-800" />}

        {!burnStatsLoading && burnStatsError && (
          <div className="rounded-md border border-danger/30 bg-danger/10 px-3 py-2 text-sm text-danger">
            {t("nutrition.loadError")} ({(burnStatsError as Error).message})
          </div>
        )}

        {!burnStatsLoading && burnStats && burnStats.workouts === 0 && (
          <p className="text-sm text-neutral-400">{t("nutrition.workoutBurn.empty")}</p>
        )}

        {!burnStatsLoading && burnStats && burnStats.workouts > 0 && (
          <>
            <p className="font-display text-3xl font-bold text-volt-400">
              {burnStats.total.toLocaleString(i18n.language)}{" "}
              <span className="text-base font-normal text-neutral-500">{t("nutrition.log.kcal")}</span>
            </p>
            <p className="mt-1 text-sm text-neutral-400">
              {t("nutrition.workoutBurn.subtitle", { count: burnStats.workouts })}
            </p>

            <div className="mt-4 grid grid-cols-3 gap-2 text-center">
              {[
                { label: t("nutrition.workoutBurn.last"), value: burnStats.last ?? 0, plus: true },
                { label: t("nutrition.workoutBurn.week"), value: burnStats.week },
                { label: t("nutrition.workoutBurn.month"), value: burnStats.month },
              ].map((item) => (
                <div key={item.label} className="rounded-md bg-ink-800 px-2 py-2.5">
                  <p className="font-display text-lg font-bold">
                    {item.plus ? "+" : ""}
                    {item.value.toLocaleString(i18n.language)}
                  </p>
                  <p className="mt-0.5 text-[11px] leading-tight text-neutral-500">{item.label}</p>
                </div>
              ))}
            </div>
          </>
        )}

        <p className="mt-3 text-xs text-neutral-500">{t("nutrition.workoutBurn.how")}</p>
      </div>

      <div className="card mb-4">
        <h2 className="font-semibold">{t("nutrition.calories")}</h2>
        <p className="mt-1 text-sm text-neutral-400">{guidance.calorieNote}</p>
      </div>

      <div className="card mb-4">
        <h2 className="mb-3 font-semibold">{t("nutrition.macros")}</h2>
        <div className="space-y-3">
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-danger/10 text-danger">
              <Beef size={16} />
            </div>
            <p className="text-sm text-neutral-300">{guidance.macros.protein}</p>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-volt-400/10 text-volt-400">
              <Wheat size={16} />
            </div>
            <p className="text-sm text-neutral-300">{guidance.macros.carbs}</p>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-info/10 text-info">
              <Droplet size={16} />
            </div>
            <p className="text-sm text-neutral-300">{guidance.macros.fat}</p>
          </div>
        </div>
      </div>

      <div className="card mb-4">
        <h2 className="mb-3 font-semibold">{t("nutrition.mealStructure")}</h2>
        <ul className="space-y-2">
          {guidance.mealStructure.map((item) => (
            <li key={item} className="flex items-start gap-2 text-sm text-neutral-300">
              <span className="mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full bg-volt-400" />
              {item}
            </li>
          ))}
        </ul>
      </div>

      <div className="card">
        <h2 className="mb-3 font-semibold">{t("nutrition.tips")}</h2>
        <ul className="space-y-2">
          {guidance.tips.map((tip) => (
            <li key={tip} className="flex items-start gap-2 text-sm text-neutral-300">
              <span className="mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full bg-neutral-500" />
              {tip}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
