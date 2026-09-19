import { useEffect, useMemo, useRef, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { useQuery, useMutation } from "@tanstack/react-query";
import { Check, ChevronLeft, PlayCircle, Video, TrendingUp, X, Timer } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { localizedField } from "@/lib/localizedField";
import type { Exercise, WorkoutSet } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

interface SetRow extends WorkoutSet {
  id: string;
  exercise: Exercise;
}

interface WorkoutWithSets {
  id: string;
  title: string;
  titleEn?: string;
  titleEs?: string;
  titleHy?: string;
  estimatedDurationMinutes: number;
  sets: SetRow[];
  /** Формат тренировок программы, к которой относится эта тренировка ("зал"/"дома") — см. комментарий у REST_BETWEEN_EXERCISES_SECONDS ниже. */
  trainingFormat: "home" | "gym";
}

interface CompletedSetEntry {
  exerciseId: string;
  weightKg?: number;
}

/**
 * Отдых между УПРАЖНЕНИЯМИ (не между подходами одного упражнения) — только
 * для программ в зале, по просьбе: смена станции/тренажёра в зале требует
 * больше времени, чем просто отдых между подходами. Для домашних программ
 * между упражнениями по-прежнему действует обычный set.restSeconds —
 * специально не трогаем, дома обычно нет очереди к оборудованию.
 */
const REST_BETWEEN_EXERCISES_SECONDS = 180;

/** Группирует подходы по упражнению, сохраняя порядок первого появления. */
function groupByExercise(sets: SetRow[]) {
  const groups: { exercise: Exercise; sets: SetRow[] }[] = [];
  for (const set of sets) {
    const last = groups[groups.length - 1];
    if (last && last.exercise.id === set.exercise.id) {
      last.sets.push(set);
    } else {
      groups.push({ exercise: set.exercise, sets: [set] });
    }
  }
  return groups;
}

export default function WorkoutPlayerPage() {
  const { t, i18n } = useTranslation();
  const { workoutId } = useParams<{ workoutId: string }>();
  const navigate = useNavigate();
  const { authUser } = useAuth();
  const [completedIds, setCompletedIds] = useState<Set<string>>(new Set());
  const [weights, setWeights] = useState<Record<string, string>>({});
  const [startedAt] = useState(() => Date.now());
  const [activeVideo, setActiveVideo] = useState<Exercise | null>(null);

  // ---- Таймер отдыха между подходами ------------------------------------
  // Запускается после отметки подхода выполненным, на set.restSeconds.
  // Отдельный ref для setInterval — чтобы не плодить утечки/дублирующиеся
  // таймеры при быстрых повторных нажатиях, и корректно чистить при
  // размонтировании страницы.
  const [restState, setRestState] = useState<{ total: number; remaining: number; kind: "set" | "exercise" } | null>(
    null,
  );
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  function clearRestInterval() {
    if (intervalRef.current !== null) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
  }

  function startRestTimer(seconds: number, kind: "set" | "exercise") {
    clearRestInterval();
    if (seconds <= 0) return;
    setRestState({ total: seconds, remaining: seconds, kind });
    intervalRef.current = setInterval(() => {
      setRestState((prev) => {
        if (!prev) return prev;
        if (prev.remaining <= 1) {
          clearRestInterval();
          if (typeof navigator !== "undefined" && "vibrate" in navigator) {
            navigator.vibrate?.(200);
          }
          return null;
        }
        return { ...prev, remaining: prev.remaining - 1 };
      });
    }, 1000);
  }

  function skipRestTimer() {
    clearRestInterval();
    setRestState(null);
  }

  // Чистим интервал при уходе со страницы — иначе он продолжит тикать
  // в фоне и попытается обновлять состояние размонтированного компонента.
  useEffect(() => clearRestInterval, []);

  const { data: workout, isLoading } = useQuery({
    queryKey: ["workout", workoutId],
    queryFn: async (): Promise<WorkoutWithSets> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*, exercise:exercises(*)), program:workout_programs(training_format)")
        .eq("id", workoutId)
        .order("order", { referencedTable: "workout_sets", ascending: true })
        .single();
      if (error) throw error;
      const camel = toCamelCase<WorkoutWithSets & { program?: { trainingFormat: "home" | "gym" } }>(data);
      return { ...camel, trainingFormat: camel.program?.trainingFormat ?? "home" };
    },
    enabled: !!workoutId,
  });

  const groups = useMemo(() => (workout ? groupByExercise(workout.sets) : []), [workout]);

  /** Последние зафиксированные рабочие веса по этой тренировке — для подсказки "в прошлый раз". */
  const { data: lastWeights } = useQuery({
    queryKey: ["last-weights", workoutId, authUser?.id],
    enabled: !!workoutId && !!authUser,
    queryFn: async (): Promise<Record<string, number>> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("completed_sets, completed_at")
        .eq("user_id", authUser!.id)
        .eq("workout_id", workoutId)
        .order("completed_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (error || !data) return {};

      const entries = (data.completed_sets ?? []) as CompletedSetEntry[];
      const map: Record<string, number> = {};
      for (const e of entries) {
        if (e.exerciseId && typeof e.weightKg === "number") map[e.exerciseId] = e.weightKg;
      }
      return map;
    },
  });

  const finishMutation = useMutation({
    mutationFn: async () => {
      if (!authUser) throw new Error("Сессия истекла — войдите заново, чтобы сохранить тренировку.");
      if (!workout) throw new Error("Не удалось определить тренировку.");

      const durationMinutes = Math.max(1, Math.round((Date.now() - startedAt) / 60_000));
      const completedSets: CompletedSetEntry[] = groups.map((g) => ({
        exerciseId: g.exercise.id,
        weightKg: weights[g.exercise.id] ? Number(weights[g.exercise.id]) : undefined,
      }));

      // Суммарный поднятый вес (вес × повторения по всем подходам) — для
      // достижений и статистики "сколько поднято" (0026). Считаем только
      // по упражнениям, где реально указан рабочий вес — иначе это не вес,
      // который "подняли", а просто выполненные повторения.
      const totalVolumeKg = groups.reduce((sum, g) => {
        const weight = weights[g.exercise.id] ? Number(weights[g.exercise.id]) : 0;
        if (!weight) return sum;
        const totalReps = g.sets.reduce((s, set) => s + (set.reps ?? 0), 0);
        return sum + weight * totalReps;
      }, 0);

      const { data, error } = await supabase
        .from("workout_logs")
        .insert({
          user_id: authUser.id,
          workout_id: workout.id,
          completed_at: new Date().toISOString(),
          duration_minutes: durationMinutes,
          completed_sets: completedSets,
          total_volume_kg: totalVolumeKg,
        })
        .select()
        .single();

      if (error) {
        console.error("Не удалось сохранить тренировку:", error);
        throw new Error(error.message || "Не удалось сохранить тренировку. Попробуйте ещё раз.");
      }
      return data;
    },
    onSuccess: () => navigate("/dashboard", { replace: true }),
  });

  if (isLoading || !workout) {
    return (
      <div className="flex min-h-dvh items-center justify-center bg-ink-950">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
      </div>
    );
  }

  const allDone = completedIds.size === workout.sets.length;

  return (
    <div className={clsx("min-h-dvh bg-ink-950 px-5 pt-6", restState ? "pb-48" : "pb-32")}>
      <button
        onClick={() => navigate(-1)}
        className="mb-4 flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200"
      >
        <ChevronLeft size={18} /> {t("workout.back")}
      </button>

      <h1 className="font-display text-2xl font-bold">
        {localizedField(workout.title, { en: workout.titleEn, es: workout.titleEs, hy: workout.titleHy }, i18n.language)}
      </h1>
      <p className="mt-1 text-neutral-400">~{workout.estimatedDurationMinutes} {t("common.min")}</p>

      <div className="mt-6 space-y-4">
        {groups.map((group, groupIndex) => {
          const lastWeight = lastWeights?.[group.exercise.id];
          const isWeighted = !group.sets[0].durationSeconds;
          const exerciseTitle = localizedField(
            group.exercise.title,
            { en: group.exercise.titleEn, es: group.exercise.titleEs, hy: group.exercise.titleHy },
            i18n.language,
          );
          const firstSetNotes = localizedField(
            group.sets[0].notes ?? "",
            { en: group.sets[0].notesEn, es: group.sets[0].notesEs, hy: group.sets[0].notesHy },
            i18n.language,
          );
          return (
            <div key={group.exercise.id} className="card">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="font-semibold">{exerciseTitle}</p>
                  <p className="mt-0.5 text-xs text-neutral-500">
                    {t("workout.sets", { count: group.sets.length })}
                    {firstSetNotes ? ` · ${firstSetNotes}` : ""}
                  </p>
                </div>

                {group.exercise.videoUrl ? (
                  <button
                    onClick={() => setActiveVideo(group.exercise)}
                    className="flex shrink-0 items-center gap-1.5 rounded-full bg-volt-400/10 px-3 py-1.5 text-xs font-semibold text-volt-400 transition hover:bg-volt-400/20"
                  >
                    <PlayCircle size={14} /> {t("workout.video")}
                  </button>
                ) : (
                  <span className="flex shrink-0 items-center gap-1.5 rounded-full bg-ink-800 px-3 py-1.5 text-xs font-medium text-neutral-500">
                    <Video size={14} /> {t("workout.videoSoon")}
                  </span>
                )}
              </div>

              <div className="mt-3 space-y-2">
                {group.sets.map((set, i) => {
                  const done = completedIds.has(set.id);
                  // Последний подход этого упражнения, и после него есть ещё
                  // упражнения — значит, дальше не просто отдых между
                  // подходами, а переход к следующему упражнению.
                  const isLastSetOfGroup = i === group.sets.length - 1;
                  const hasNextGroup = groupIndex < groups.length - 1;
                  const locked = !!restState && !done;
                  return (
                    <button
                      key={set.id}
                      disabled={locked}
                      onClick={() =>
                        setCompletedIds((prev) => {
                          const next = new Set(prev);
                          if (next.has(set.id)) {
                            next.delete(set.id);
                          } else {
                            next.add(set.id);
                            if (isLastSetOfGroup && hasNextGroup && workout.trainingFormat === "gym") {
                              startRestTimer(REST_BETWEEN_EXERCISES_SECONDS, "exercise");
                            } else {
                              startRestTimer(set.restSeconds, "set");
                            }
                          }
                          return next;
                        })
                      }
                      className={clsx(
                        "flex w-full items-center justify-between rounded-md border px-3.5 py-2.5 text-left transition",
                        done
                          ? "border-volt-400/40 bg-volt-400/5"
                          : locked
                            ? "cursor-not-allowed border-ink-800 opacity-40"
                            : "border-ink-700 hover:border-ink-500",
                      )}
                    >
                      <p className="text-sm">
                        <span className="text-neutral-500">{t("workout.set", { number: i + 1 })}:</span>{" "}
                        {set.reps ? t("workout.reps", { count: set.reps }) : `${set.durationSeconds}s`}
                        <span className="text-neutral-500"> · {t("workout.rest", { count: set.restSeconds })}</span>
                      </p>
                      <div
                        className={clsx(
                          "flex h-6 w-6 shrink-0 items-center justify-center rounded-full border",
                          done ? "border-volt-400 bg-volt-400 text-ink-950" : "border-ink-600",
                        )}
                      >
                        {done && <Check size={14} strokeWidth={3} />}
                      </div>
                    </button>
                  );
                })}
              </div>

              {isWeighted && (
                <div className="mt-3 border-t border-ink-700 pt-3">
                  <label className="mb-1.5 block text-xs font-medium text-neutral-400">
                    {t("workout.workingWeight")}
                  </label>
                  <input
                    type="number"
                    inputMode="decimal"
                    placeholder={lastWeight ? String(lastWeight) : (t("workout.weightPlaceholder") as string)}
                    value={weights[group.exercise.id] ?? ""}
                    onChange={(e) =>
                      setWeights((prev) => ({ ...prev, [group.exercise.id]: e.target.value }))
                    }
                    className="input-field w-28 py-1.5 text-sm"
                  />
                  {lastWeight != null && (
                    <p className="mt-1.5 flex items-center gap-1 text-xs text-volt-400">
                      <TrendingUp size={12} />
                      {t("workout.lastTime", {
                        weight: lastWeight,
                        next: (lastWeight + 2.5).toString().replace(".", ","),
                      })}
                    </p>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {activeVideo && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 p-4"
          onClick={() => setActiveVideo(null)}
        >
          <div className="w-full max-w-md" onClick={(e) => e.stopPropagation()}>
            <p className="mb-2 font-semibold text-neutral-100">{activeVideo.title}</p>
            <video
              src={activeVideo.videoUrl}
              controls
              autoPlay
              className="w-full rounded-lg border border-ink-700"
            />
          </div>
        </div>
      )}

      <div className="fixed inset-x-0 bottom-0 z-40">
        {restState && (
          <div className="border-t border-ink-700 bg-ink-900/95 px-5 py-3 backdrop-blur animate-fade-in">
            <div className="mx-auto flex max-w-md items-center gap-3">
              <Timer size={18} className="shrink-0 text-volt-400" />
              <div className="min-w-0 flex-1">
                <div className="flex items-center justify-between text-sm">
                  <span className="font-medium text-neutral-200">
                    {restState.kind === "exercise" ? t("workout.restingNextExercise") : t("workout.resting")}
                  </span>
                  <span className="font-display text-lg font-bold tabular-nums text-volt-400">
                    {Math.floor(restState.remaining / 60)}:{String(restState.remaining % 60).padStart(2, "0")}
                  </span>
                </div>
                <div className="mt-1.5 h-1.5 overflow-hidden rounded-full bg-ink-700">
                  <div
                    className="h-full rounded-full bg-volt-400 transition-all duration-1000 ease-linear"
                    style={{ width: `${(restState.remaining / restState.total) * 100}%` }}
                  />
                </div>
              </div>
              <button
                onClick={skipRestTimer}
                className="shrink-0 rounded-full p-1.5 text-neutral-400 hover:bg-ink-800 hover:text-neutral-200"
                aria-label={t("workout.skipRest")}
              >
                <X size={16} />
              </button>
            </div>
          </div>
        )}

        <div className="border-t border-ink-700 bg-ink-950/95 p-5 backdrop-blur">
          {finishMutation.isError && (
            <div className="mx-auto mb-3 max-w-md rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              {finishMutation.error instanceof Error
                ? finishMutation.error.message
                : "Не удалось сохранить тренировку. Попробуйте ещё раз."}
            </div>
          )}
          <button
            onClick={() => finishMutation.mutate()}
            disabled={!allDone || finishMutation.isPending}
            className="btn-primary mx-auto block w-full max-w-md"
          >
            {finishMutation.isPending
              ? t("workout.saving")
              : allDone
                ? t("workout.finishWorkout")
                : t("workout.remaining", { count: workout.sets.length - completedIds.size })}
          </button>
        </div>
      </div>
    </div>
  );
}
