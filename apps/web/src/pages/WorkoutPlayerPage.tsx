import { useMemo, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { useQuery, useMutation } from "@tanstack/react-query";
import { Check, ChevronLeft, PlayCircle, Video, TrendingUp } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import type { Exercise, WorkoutSet } from "@donatellox/types";

interface SetRow extends WorkoutSet {
  id: string;
  exercise: Exercise;
}

interface WorkoutWithSets {
  id: string;
  title: string;
  estimatedDurationMinutes: number;
  sets: SetRow[];
}

interface CompletedSetEntry {
  exerciseId: string;
  weightKg?: number;
}

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
  const { t } = useTranslation();
  const { workoutId } = useParams<{ workoutId: string }>();
  const navigate = useNavigate();
  const { authUser } = useAuth();
  const [completedIds, setCompletedIds] = useState<Set<string>>(new Set());
  const [weights, setWeights] = useState<Record<string, string>>({});
  const [startedAt] = useState(() => Date.now());
  const [activeVideo, setActiveVideo] = useState<Exercise | null>(null);

  const { data: workout, isLoading } = useQuery({
    queryKey: ["workout", workoutId],
    queryFn: async (): Promise<WorkoutWithSets> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*, exercise:exercises(*))")
        .eq("id", workoutId)
        .order("order", { referencedTable: "workout_sets", ascending: true })
        .single();
      if (error) throw error;
      return data as unknown as WorkoutWithSets;
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

      const { data, error } = await supabase
        .from("workout_logs")
        .insert({
          user_id: authUser.id,
          workout_id: workout.id,
          completed_at: new Date().toISOString(),
          duration_minutes: durationMinutes,
          completed_sets: completedSets,
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
    <div className="min-h-dvh bg-ink-950 px-5 pb-32 pt-6">
      <button
        onClick={() => navigate(-1)}
        className="mb-4 flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200"
      >
        <ChevronLeft size={18} /> {t("workout.back")}
      </button>

      <h1 className="font-display text-2xl font-bold">{workout.title}</h1>
      <p className="mt-1 text-neutral-400">~{workout.estimatedDurationMinutes} {t("common.min")}</p>

      <div className="mt-6 space-y-4">
        {groups.map((group) => {
          const lastWeight = lastWeights?.[group.exercise.id];
          const isWeighted = !group.sets[0].durationSeconds;
          return (
            <div key={group.exercise.id} className="card">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="font-semibold">{group.exercise.title}</p>
                  <p className="mt-0.5 text-xs text-neutral-500">
                    {t("workout.sets", { count: group.sets.length })}
                    {group.sets[0].notes ? ` · ${group.sets[0].notes}` : ""}
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
                  return (
                    <button
                      key={set.id}
                      onClick={() =>
                        setCompletedIds((prev) => {
                          const next = new Set(prev);
                          next.has(set.id) ? next.delete(set.id) : next.add(set.id);
                          return next;
                        })
                      }
                      className={clsx(
                        "flex w-full items-center justify-between rounded-md border px-3.5 py-2.5 text-left transition",
                        done
                          ? "border-volt-400/40 bg-volt-400/5"
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

      <div className="fixed inset-x-0 bottom-0 border-t border-ink-700 bg-ink-950/95 p-5 backdrop-blur">
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
  );
}
