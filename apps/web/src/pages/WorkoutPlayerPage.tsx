import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { useQuery, useMutation } from "@tanstack/react-query";
import { Check, ChevronLeft } from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import type { Workout } from "@donatellox/types";

export default function WorkoutPlayerPage() {
  const { workoutId } = useParams<{ workoutId: string }>();
  const navigate = useNavigate();
  const { authUser } = useAuth();
  const [completedIdx, setCompletedIdx] = useState<Set<number>>(new Set());
  const [startedAt] = useState(() => Date.now());

  const { data: workout, isLoading } = useQuery({
    queryKey: ["workout", workoutId],
    queryFn: async (): Promise<Workout> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*)")
        .eq("id", workoutId)
        .single();
      if (error) throw error;
      return data as unknown as Workout;
    },
    enabled: !!workoutId,
  });

  const finishMutation = useMutation({
    mutationFn: async () => {
      if (!authUser || !workout) return;
      const durationMinutes = Math.max(1, Math.round((Date.now() - startedAt) / 60_000));
      const { error } = await supabase.from("workout_log_entries").insert({
        user_id: authUser.id,
        workout_id: workout.id,
        completed_at: new Date().toISOString(),
        duration_minutes: durationMinutes,
        completed_sets: workout.sets.map((s) => ({ exerciseId: s.exerciseId })),
      });
      if (error) throw error;
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

  const allDone = completedIdx.size === workout.sets.length;

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pb-32 pt-6">
      <button
        onClick={() => navigate(-1)}
        className="mb-4 flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200"
      >
        <ChevronLeft size={18} /> Назад
      </button>

      <h1 className="font-display text-2xl font-bold">{workout.title}</h1>
      <p className="mt-1 text-neutral-400">~{workout.estimatedDurationMinutes} мин</p>

      <div className="mt-6 space-y-3">
        {workout.sets.map((set, idx) => {
          const done = completedIdx.has(idx);
          return (
            <button
              key={`${set.exerciseId}-${idx}`}
              onClick={() =>
                setCompletedIdx((prev) => {
                  const next = new Set(prev);
                  next.has(idx) ? next.delete(idx) : next.add(idx);
                  return next;
                })
              }
              className={clsx(
                "card flex w-full items-center justify-between text-left transition",
                done && "border-volt-400/40 bg-volt-400/5",
              )}
            >
              <div>
                <p className="font-medium">Упражнение {idx + 1}</p>
                <p className="mt-1 text-sm text-neutral-400">
                  {set.reps ? `${set.reps} повторений` : `${set.durationSeconds}с`} · отдых{" "}
                  {set.restSeconds}с
                  {set.weightKg ? ` · ${set.weightKg} кг` : ""}
                </p>
              </div>
              <div
                className={clsx(
                  "flex h-7 w-7 shrink-0 items-center justify-center rounded-full border",
                  done ? "border-volt-400 bg-volt-400 text-ink-950" : "border-ink-600",
                )}
              >
                {done && <Check size={16} strokeWidth={3} />}
              </div>
            </button>
          );
        })}
      </div>

      <div className="fixed inset-x-0 bottom-0 border-t border-ink-700 bg-ink-950/95 p-5 backdrop-blur">
        <button
          onClick={() => finishMutation.mutate()}
          disabled={!allDone || finishMutation.isPending}
          className="btn-primary mx-auto block w-full max-w-md"
        >
          {finishMutation.isPending ? "Сохраняем…" : allDone ? "Завершить тренировку" : `Осталось ${workout.sets.length - completedIdx.size}`}
        </button>
      </div>
    </div>
  );
}
