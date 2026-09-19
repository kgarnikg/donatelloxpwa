import { useMemo, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useForm, useFieldArray } from "react-hook-form";
import {
  ChevronLeft,
  Plus,
  X,
  Pencil,
  Trash2,
  ChevronUp,
  ChevronDown,
  PlayCircle,
  Search,
  AlertTriangle,
} from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type {
  WorkoutProgram,
  FitnessGoal,
  ExerciseDifficulty,
  MuscleGroup,
  Exercise,
} from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

const GOALS: FitnessGoal[] = [
  "lose_weight",
  "build_muscle",
  "improve_endurance",
  "general_fitness",
  "rehabilitation",
];
const DIFFICULTIES: ExerciseDifficulty[] = ["beginner", "intermediate", "advanced"];
const WEEKDAYS = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"];

// ---------------------------------------------------------------------------
// Типы данных этой страницы
// ---------------------------------------------------------------------------

interface SetRow {
  id: string;
  order: number;
  reps: number | null;
  durationSeconds: number | null;
  restSeconds: number;
  notes: string | null;
  exercise: Exercise;
}

interface WorkoutRow {
  id: string;
  title: string;
  order: number;
  weekOrder: number;
  weekLabel: string | null;
  estimatedDurationMinutes: number;
  sets: SetRow[];
}

interface ExerciseGroup {
  exercise: Exercise;
  baseOrder: number;
  sets: SetRow[];
}

function groupByExercise(sets: SetRow[]): ExerciseGroup[] {
  const map = new Map<string, ExerciseGroup>();
  for (const s of sets) {
    const existing = map.get(s.exercise.id);
    if (existing) {
      existing.sets.push(s);
      existing.baseOrder = Math.min(existing.baseOrder, s.order);
    } else {
      map.set(s.exercise.id, { exercise: s.exercise, baseOrder: s.order, sets: [s] });
    }
  }
  return Array.from(map.values()).sort((a, b) => a.baseOrder - b.baseOrder);
}

/**
 * Следующий свободный "order" для нового упражнения в тренировке — округляем
 * максимальный существующий order вверх до следующего кратного 10 (та же
 * схема нумерации, что и в исходном генераторе программ: exerciseIndex*10),
 * оставляя каждому упражнению до 10 подходов без пересечения с соседним.
 */
function computeNextBaseOrder(sets: SetRow[]): number {
  if (sets.length === 0) return 0;
  const maxOrder = Math.max(...sets.map((s) => s.order));
  return maxOrder + 10 - (maxOrder % 10);
}

// ---------------------------------------------------------------------------
// Данные и мутации
// ---------------------------------------------------------------------------

function useProgram(programId: string) {
  return useQuery({
    queryKey: ["admin-program", programId],
    queryFn: async (): Promise<WorkoutProgram> => {
      const { data, error } = await supabase.from("workout_programs").select("*").eq("id", programId).single();
      if (error) throw error;
      return toCamelCase<WorkoutProgram>(data);
    },
  });
}

function useProgramWorkouts(programId: string) {
  return useQuery({
    queryKey: ["admin-program-workouts", programId],
    queryFn: async (): Promise<WorkoutRow[]> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*, exercise:exercises(*))")
        .eq("program_id", programId)
        .order("week_order", { ascending: true })
        .order("order", { ascending: true })
        .order("order", { referencedTable: "workout_sets", ascending: true });
      if (error) throw error;
      return toCamelCase<WorkoutRow[]>(data ?? []);
    },
  });
}

function useUpdateProgram(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (values: Record<string, unknown>) => {
      const { error } = await supabase.from("workout_programs").update(values).eq("id", programId);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-program", programId] });
      queryClient.invalidateQueries({ queryKey: ["admin-programs"] });
    },
  });
}

function useSaveWorkout(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: {
      id?: string;
      title: string;
      order: number;
      weekOrder: number;
      weekLabel: string;
      estimatedDurationMinutes: number;
    }) => {
      if (input.id) {
        const { error } = await supabase
          .from("workouts")
          .update({
            title: input.title,
            week_label: input.weekLabel,
            estimated_duration_minutes: input.estimatedDurationMinutes,
          })
          .eq("id", input.id);
        if (error) throw error;
      } else {
        const { error } = await supabase.from("workouts").insert({
          program_id: programId,
          title: input.title,
          order: input.order,
          week_order: input.weekOrder,
          week_label: input.weekLabel,
          estimated_duration_minutes: input.estimatedDurationMinutes,
        });
        if (error) throw error;
      }
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-program-workouts", programId] }),
  });
}

/** Удаление тренировки — сначала проверяем, нет ли у пользователей истории по ней (каскад иначе её сотрёт). */
function useDeleteWorkout(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (workoutId: string) => {
      const { count, error: countError } = await supabase
        .from("workout_logs")
        .select("id", { count: "exact", head: true })
        .eq("workout_id", workoutId);
      if (countError) throw countError;
      if (count && count > 0) {
        throw new Error(
          `Эту тренировку уже проходили ${count} раз(а) — удаление сотрёт эту историю у пользователей. Отмените, если это не то, что нужно.`,
        );
      }
      const { error } = await supabase.from("workouts").delete().eq("id", workoutId);
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-program-workouts", programId] }),
  });
}

/** Поменять местами order двух тренировок внутри одной недели — через временное значение, чтобы не пересекаться. */
function useReorderWorkout(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ a, b }: { a: { id: string; order: number }; b: { id: string; order: number } }) => {
      const { error: e1 } = await supabase.from("workouts").update({ order: -1 }).eq("id", a.id);
      if (e1) throw e1;
      const { error: e2 } = await supabase.from("workouts").update({ order: a.order }).eq("id", b.id);
      if (e2) throw e2;
      const { error: e3 } = await supabase.from("workouts").update({ order: b.order }).eq("id", a.id);
      if (e3) throw e3;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-program-workouts", programId] }),
  });
}

function useUpdateExercise() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, values }: { id: string; values: Record<string, unknown> }) => {
      const { error } = await supabase.from("exercises").update(values).eq("id", id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-program-workouts"] });
      queryClient.invalidateQueries({ queryKey: ["admin-exercises"] });
    },
  });
}

function useCreateExercise() {
  return useMutation({
    mutationFn: async (values: {
      title: string;
      muscleGroups: MuscleGroup[];
      difficulty: ExerciseDifficulty;
      videoUrl: string;
    }): Promise<Exercise> => {
      const slug =
        values.title
          .toLowerCase()
          .replace(/[^a-zа-яё0-9]+/gi, "-")
          .replace(/^-+|-+$/g, "") +
        "-" +
        Math.random().toString(36).slice(2, 7);
      const { data, error } = await supabase
        .from("exercises")
        .insert({
          title: values.title,
          slug,
          muscle_groups: values.muscleGroups,
          difficulty: values.difficulty,
          video_url: values.videoUrl || null,
        })
        .select()
        .single();
      if (error) throw error;
      return toCamelCase<Exercise>(data);
    },
  });
}

/** Заменяет все подходы этого упражнения в этой тренировке на новый набор (проще и надёжнее, чем построчный diff). */
function useSaveExerciseSets(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: {
      workoutId: string;
      exerciseId: string;
      baseOrder: number;
      sets: { reps: number | null; durationSeconds: number | null; restSeconds: number; notes: string }[];
    }) => {
      const { error: delError } = await supabase
        .from("workout_sets")
        .delete()
        .eq("workout_id", input.workoutId)
        .eq("exercise_id", input.exerciseId);
      if (delError) throw delError;

      if (input.sets.length === 0) return; // «Удалить упражнение из тренировки» — просто не вставляем ничего заново

      const rows = input.sets.map((s, i) => ({
        workout_id: input.workoutId,
        exercise_id: input.exerciseId,
        order: input.baseOrder + i,
        reps: s.reps,
        duration_seconds: s.durationSeconds,
        rest_seconds: s.restSeconds,
        notes: s.notes || null,
      }));
      const { error: insError } = await supabase.from("workout_sets").insert(rows);
      if (insError) throw insError;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-program-workouts", programId] }),
  });
}

function useAddExerciseToWorkout(programId: string) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: {
      workoutId: string;
      exerciseId: string;
      baseOrder: number;
      numSets: number;
      reps: number | null;
      durationSeconds: number | null;
      restSeconds: number;
      notes: string;
    }) => {
      const rows = Array.from({ length: input.numSets }, (_, i) => ({
        workout_id: input.workoutId,
        exercise_id: input.exerciseId,
        order: input.baseOrder + i,
        reps: input.reps,
        duration_seconds: input.durationSeconds,
        rest_seconds: input.restSeconds,
        notes: input.notes || null,
      }));
      const { error } = await supabase.from("workout_sets").insert(rows);
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-program-workouts", programId] }),
  });
}

function useSearchExercises(query: string) {
  return useQuery({
    queryKey: ["exercise-search", query],
    enabled: query.trim().length >= 2,
    queryFn: async (): Promise<Exercise[]> => {
      const { data, error } = await supabase
        .from("exercises")
        .select("*")
        .ilike("title", `%${query.trim()}%`)
        .order("title", { ascending: true })
        .limit(20);
      if (error) throw error;
      return toCamelCase<Exercise[]>(data ?? []);
    },
  });
}

// ---------------------------------------------------------------------------
// Модалка: редактирование программы целиком
// ---------------------------------------------------------------------------

function EditProgramModal({ program, onClose }: { program: WorkoutProgram; onClose: () => void }) {
  const updateProgram = useUpdateProgram(program.id);
  const { register, handleSubmit } = useForm({
    defaultValues: {
      title: program.title,
      description: program.description,
      goal: program.goal,
      difficulty: program.difficulty,
      durationWeeks: program.durationWeeks,
      workoutsPerWeek: program.workoutsPerWeek,
      isPremium: program.isPremium,
    },
  });

  function onSubmit(values: {
    title: string;
    description: string;
    goal: FitnessGoal;
    difficulty: ExerciseDifficulty;
    durationWeeks: number;
    workoutsPerWeek: number;
    isPremium: boolean;
  }) {
    updateProgram.mutate(
      {
        title: values.title,
        description: values.description,
        goal: values.goal,
        difficulty: values.difficulty,
        duration_weeks: Number(values.durationWeeks),
        workouts_per_week: Number(values.workoutsPerWeek),
        is_premium: values.isPremium,
      },
      { onSuccess: onClose },
    );
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-lg rounded-lg border border-ink-700 bg-ink-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">Редактировать программу</h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Название</label>
            <input className="input-field" {...register("title", { required: true })} />
          </div>
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Описание</label>
            <textarea className="input-field" rows={3} {...register("description")} />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Цель</label>
              <select className="input-field" {...register("goal")}>
                {GOALS.map((g) => (
                  <option key={g} value={g}>
                    {g}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Сложность</label>
              <select className="input-field" {...register("difficulty")}>
                {DIFFICULTIES.map((d) => (
                  <option key={d} value={d}>
                    {d}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Недель всего</label>
              <input
                type="number"
                min={1}
                className="input-field"
                {...register("durationWeeks", { valueAsNumber: true })}
              />
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Тренировок/нед.</label>
              <input
                type="number"
                min={1}
                className="input-field"
                {...register("workoutsPerWeek", { valueAsNumber: true })}
              />
            </div>
          </div>
          <label className="flex items-center gap-2 text-sm text-neutral-300">
            <input type="checkbox" className="h-4 w-4 rounded" {...register("isPremium")} />
            Премиум-программа (только по подписке)
          </label>
          {updateProgram.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить изменения.
            </div>
          )}
          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={updateProgram.isPending} className="btn-primary flex-1">
              {updateProgram.isPending ? "Сохраняем…" : "Сохранить"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Модалка: добавить/редактировать тренировку (день), и заодно — новую неделю
// ---------------------------------------------------------------------------

function WorkoutModal({
  programId,
  workout,
  weekOrder,
  weekLabel,
  nextOrder,
  onClose,
}: {
  programId: string;
  workout: WorkoutRow | null;
  weekOrder: number;
  weekLabel: string;
  nextOrder: number;
  onClose: () => void;
}) {
  const saveWorkout = useSaveWorkout(programId);
  const isEditing = !!workout;
  const { register, handleSubmit } = useForm({
    defaultValues: {
      dayName: workout ? workout.title.split(" · ")[0] : WEEKDAYS[0],
      dayTitle: workout ? workout.title.split(" · ").slice(1).join(" · ") : "",
      weekLabel: workout?.weekLabel ?? weekLabel,
      estimatedDurationMinutes: workout?.estimatedDurationMinutes ?? 45,
    },
  });

  function onSubmit(values: {
    dayName: string;
    dayTitle: string;
    weekLabel: string;
    estimatedDurationMinutes: number;
  }) {
    const title = values.dayTitle ? `${values.dayName} · ${values.dayTitle}` : values.dayName;
    saveWorkout.mutate(
      {
        id: workout?.id,
        title,
        order: workout?.order ?? nextOrder,
        weekOrder: workout?.weekOrder ?? weekOrder,
        weekLabel: values.weekLabel,
        estimatedDurationMinutes: Number(values.estimatedDurationMinutes),
      },
      { onSuccess: onClose },
    );
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-md rounded-lg border border-ink-700 bg-ink-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">
            {isEditing ? "Редактировать тренировку" : "Новая тренировка"}
          </h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              Подпись недельного блока
            </label>
            <input
              className="input-field"
              placeholder="Недели 1–2 — Фундамент"
              {...register("weekLabel")}
            />
            {!isEditing && (
              <p className="mt-1 text-xs text-neutral-500">
                Одна и та же подпись у нескольких тренировок объединяет их в один блок — так и добавляются
                новые недели/месяцы.
              </p>
            )}
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">День недели</label>
              <select className="input-field" {...register("dayName")}>
                {WEEKDAYS.map((d) => (
                  <option key={d} value={d}>
                    {d}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Длительность, мин.</label>
              <input
                type="number"
                min={1}
                className="input-field"
                {...register("estimatedDurationMinutes", { valueAsNumber: true })}
              />
            </div>
          </div>
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              Группа мышц / название дня
            </label>
            <input className="input-field" placeholder="ГРУДЬ + ТРИЦЕПС" {...register("dayTitle")} />
          </div>
          {saveWorkout.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить.
            </div>
          )}
          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={saveWorkout.isPending} className="btn-primary flex-1">
              {saveWorkout.isPending ? "Сохраняем…" : "Сохранить"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Модалка: добавить упражнение в тренировку (из каталога или новое)
// ---------------------------------------------------------------------------

function AddExerciseModal({
  programId,
  workoutId,
  nextBaseOrder,
  onClose,
}: {
  programId: string;
  workoutId: string;
  nextBaseOrder: number;
  onClose: () => void;
}) {
  const [tab, setTab] = useState<"catalog" | "new">("catalog");
  const [search, setSearch] = useState("");
  const [picked, setPicked] = useState<Exercise | null>(null);

  const { data: results, isLoading: searching } = useSearchExercises(search);
  const createExercise = useCreateExercise();
  const addToWorkout = useAddExerciseToWorkout(programId);

  const {
    register: registerNew,
    handleSubmit: handleSubmitNew,
    formState: { errors: newErrors },
  } = useForm({ defaultValues: { title: "", difficulty: "beginner" as ExerciseDifficulty, muscleGroups: "", videoUrl: "" } });

  const {
    register: registerSets,
    handleSubmit: handleSubmitSets,
  } = useForm({
    defaultValues: { numSets: 4, reps: 12, durationSeconds: undefined as number | undefined, restSeconds: 60, notes: "" },
  });

  function finalizeAdd(exercise: Exercise) {
    setPicked(exercise);
  }

  function onSubmitSets(values: {
    numSets: number;
    reps?: number;
    durationSeconds?: number;
    restSeconds: number;
    notes: string;
  }) {
    if (!picked) return;
    addToWorkout.mutate(
      {
        workoutId,
        exerciseId: picked.id,
        baseOrder: nextBaseOrder,
        numSets: Number(values.numSets),
        reps: values.reps ? Number(values.reps) : null,
        durationSeconds: values.durationSeconds ? Number(values.durationSeconds) : null,
        restSeconds: Number(values.restSeconds),
        notes: values.notes,
      },
      { onSuccess: onClose },
    );
  }

  async function onSubmitNew(values: {
    title: string;
    difficulty: ExerciseDifficulty;
    muscleGroups: string;
    videoUrl: string;
  }) {
    const muscleGroups = values.muscleGroups
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean) as MuscleGroup[];
    const exercise = await createExercise.mutateAsync({
      title: values.title,
      difficulty: values.difficulty,
      muscleGroups,
      videoUrl: values.videoUrl,
    });
    finalizeAdd(exercise);
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-lg rounded-lg border border-ink-700 bg-ink-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">
            {picked ? `Добавить «${picked.title}»` : "Добавить упражнение"}
          </h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>

        {!picked && (
          <>
            <div className="mb-4 flex gap-2">
              <button
                onClick={() => setTab("catalog")}
                className={clsx(
                  "flex-1 rounded-md py-2 text-sm font-medium",
                  tab === "catalog" ? "bg-volt-400/10 text-volt-400" : "bg-ink-800 text-neutral-400",
                )}
              >
                Из каталога
              </button>
              <button
                onClick={() => setTab("new")}
                className={clsx(
                  "flex-1 rounded-md py-2 text-sm font-medium",
                  tab === "new" ? "bg-volt-400/10 text-volt-400" : "bg-ink-800 text-neutral-400",
                )}
              >
                Новое упражнение
              </button>
            </div>

            {tab === "catalog" && (
              <div>
                <div className="relative mb-3">
                  <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-neutral-500" />
                  <input
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                    placeholder="Начните вводить название…"
                    className="input-field pl-9"
                    autoFocus
                  />
                </div>
                <div className="max-h-64 space-y-1 overflow-y-auto">
                  {searching && <p className="py-4 text-center text-sm text-neutral-500">Ищем…</p>}
                  {!searching && search.trim().length >= 2 && results?.length === 0 && (
                    <p className="py-4 text-center text-sm text-neutral-500">Ничего не найдено — можно создать новое.</p>
                  )}
                  {results?.map((ex) => (
                    <button
                      key={ex.id}
                      onClick={() => finalizeAdd(ex)}
                      className="flex w-full items-center justify-between rounded-md px-3 py-2 text-left text-sm hover:bg-ink-800"
                    >
                      <span className="truncate">{ex.title}</span>
                      {ex.videoUrl && <PlayCircle size={14} className="shrink-0 text-volt-400" />}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {tab === "new" && (
              <form onSubmit={handleSubmitNew(onSubmitNew)} className="space-y-4">
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">Название</label>
                  <input className="input-field" {...registerNew("title", { required: true })} />
                  {newErrors.title && <p className="field-error">Обязательное поле</p>}
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="mb-1.5 block text-sm font-medium text-neutral-300">Сложность</label>
                    <select className="input-field" {...registerNew("difficulty")}>
                      {DIFFICULTIES.map((d) => (
                        <option key={d} value={d}>
                          {d}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                      Мышечные группы
                    </label>
                    <input className="input-field" placeholder="chest, arms" {...registerNew("muscleGroups")} />
                  </div>
                </div>
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                    Видео (необязательно)
                  </label>
                  <input className="input-field" placeholder="https://…" {...registerNew("videoUrl")} />
                </div>
                {createExercise.isError && (
                  <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
                    Не удалось создать упражнение.
                  </div>
                )}
                <button type="submit" disabled={createExercise.isPending} className="btn-primary w-full">
                  {createExercise.isPending ? "Создаём…" : "Создать и продолжить"}
                </button>
              </form>
            )}
          </>
        )}

        {picked && (
          <form onSubmit={handleSubmitSets(onSubmitSets)} className="space-y-4">
            <p className="text-sm text-neutral-400">Сколько подходов и с каким описанием — для этой тренировки.</p>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">Подходов</label>
                <input
                  type="number"
                  min={1}
                  className="input-field"
                  {...registerSets("numSets", { valueAsNumber: true })}
                />
              </div>
              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">Отдых, сек.</label>
                <input
                  type="number"
                  min={0}
                  className="input-field"
                  {...registerSets("restSeconds", { valueAsNumber: true })}
                />
              </div>
              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">Повторений</label>
                <input
                  type="number"
                  min={0}
                  className="input-field"
                  {...registerSets("reps", { valueAsNumber: true })}
                />
              </div>
              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  Или время, сек.
                </label>
                <input
                  type="number"
                  min={0}
                  className="input-field"
                  {...registerSets("durationSeconds", { valueAsNumber: true })}
                />
              </div>
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Заметка (как в тексте)</label>
              <input className="input-field" placeholder="12 повторений" {...registerSets("notes")} />
            </div>
            {addToWorkout.isError && (
              <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
                Не удалось добавить.
              </div>
            )}
            <div className="flex gap-3 pt-2">
              <button type="button" onClick={() => setPicked(null)} className="btn-secondary flex-1">
                Назад
              </button>
              <button type="submit" disabled={addToWorkout.isPending} className="btn-primary flex-1">
                {addToWorkout.isPending ? "Добавляем…" : "Добавить в тренировку"}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Модалка: редактировать упражнение внутри тренировки (само упражнение + подходы)
// ---------------------------------------------------------------------------

function EditExerciseGroupModal({
  programId,
  workoutId,
  group,
  onClose,
}: {
  programId: string;
  workoutId: string;
  group: ExerciseGroup;
  onClose: () => void;
}) {
  const updateExercise = useUpdateExercise();
  const saveSets = useSaveExerciseSets(programId);

  const {
    register: registerExercise,
    handleSubmit: handleSubmitExercise,
  } = useForm({
    defaultValues: {
      title: group.exercise.title,
      videoUrl: group.exercise.videoUrl ?? "",
      difficulty: group.exercise.difficulty,
      muscleGroups: (group.exercise.muscleGroups ?? []).join(", "),
    },
  });

  const { register: registerSets, control, handleSubmit: handleSubmitSets } = useForm({
    defaultValues: {
      sets: group.sets.map((s) => ({
        reps: s.reps ?? undefined,
        durationSeconds: s.durationSeconds ?? undefined,
        restSeconds: s.restSeconds,
        notes: s.notes ?? "",
      })),
    },
  });
  const { fields, append, remove } = useFieldArray({ control, name: "sets" });

  function onSubmitExercise(values: {
    title: string;
    videoUrl: string;
    difficulty: ExerciseDifficulty;
    muscleGroups: string;
  }) {
    const muscleGroups = values.muscleGroups
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean) as MuscleGroup[];
    updateExercise.mutate({
      id: group.exercise.id,
      values: {
        title: values.title,
        video_url: values.videoUrl || null,
        difficulty: values.difficulty,
        muscle_groups: muscleGroups,
      },
    });
  }

  function onSubmitSets(values: {
    sets: { reps?: number; durationSeconds?: number; restSeconds: number; notes: string }[];
  }) {
    saveSets.mutate(
      {
        workoutId,
        exerciseId: group.exercise.id,
        baseOrder: group.baseOrder,
        sets: values.sets.map((s) => ({
          reps: s.reps ? Number(s.reps) : null,
          durationSeconds: s.durationSeconds ? Number(s.durationSeconds) : null,
          restSeconds: Number(s.restSeconds),
          notes: s.notes,
        })),
      },
      { onSuccess: onClose },
    );
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4 py-8">
      <div className="w-full max-w-lg overflow-y-auto rounded-lg border border-ink-700 bg-ink-900 p-6" style={{ maxHeight: "90vh" }}>
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">Редактировать упражнение</h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>

        <div className="mb-5 rounded-md border border-ink-700 p-4">
          <div className="mb-3 flex items-start gap-2 rounded-md border border-volt-400/20 bg-volt-400/5 p-2.5 text-xs text-neutral-300">
            <AlertTriangle size={14} className="mt-0.5 shrink-0 text-volt-400" />
            Это само упражнение из общего каталога — изменения затронут все программы, где оно используется,
            не только эту тренировку.
          </div>
          <form onSubmit={handleSubmitExercise(onSubmitExercise)} className="space-y-3">
            <div>
              <label className="mb-1 block text-xs font-medium text-neutral-400">Название</label>
              <input className="input-field py-2 text-sm" {...registerExercise("title", { required: true })} />
            </div>
            <div>
              <label className="mb-1 block text-xs font-medium text-neutral-400">Видео</label>
              <input className="input-field py-2 text-sm" placeholder="https://…" {...registerExercise("videoUrl")} />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="mb-1 block text-xs font-medium text-neutral-400">Сложность</label>
                <select className="input-field py-2 text-sm" {...registerExercise("difficulty")}>
                  {DIFFICULTIES.map((d) => (
                    <option key={d} value={d}>
                      {d}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="mb-1 block text-xs font-medium text-neutral-400">Мышечные группы</label>
                <input className="input-field py-2 text-sm" {...registerExercise("muscleGroups")} />
              </div>
            </div>
            <button type="submit" disabled={updateExercise.isPending} className="btn-secondary w-full py-2 text-sm">
              {updateExercise.isPending ? "Сохраняем…" : "Сохранить упражнение"}
            </button>
          </form>
        </div>

        <form onSubmit={handleSubmitSets(onSubmitSets)} className="space-y-3">
          <p className="text-sm font-semibold text-neutral-200">Подходы в этой тренировке</p>
          {fields.map((field, i) => (
            <div key={field.id} className="rounded-md border border-ink-700 p-3">
              <div className="mb-2 flex items-center justify-between">
                <span className="text-xs font-medium text-neutral-500">Подход {i + 1}</span>
                <button
                  type="button"
                  onClick={() => remove(i)}
                  className="text-neutral-500 hover:text-danger"
                  aria-label="Удалить подход"
                >
                  <Trash2 size={14} />
                </button>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <input
                  type="number"
                  placeholder="Повт."
                  className="input-field py-1.5 text-xs"
                  {...registerSets(`sets.${i}.reps`, { valueAsNumber: true })}
                />
                <input
                  type="number"
                  placeholder="Время, с"
                  className="input-field py-1.5 text-xs"
                  {...registerSets(`sets.${i}.durationSeconds`, { valueAsNumber: true })}
                />
                <input
                  type="number"
                  placeholder="Отдых, с"
                  className="input-field py-1.5 text-xs"
                  {...registerSets(`sets.${i}.restSeconds`, { valueAsNumber: true })}
                />
              </div>
              <input
                className="input-field mt-2 py-1.5 text-xs"
                placeholder="Заметка"
                {...registerSets(`sets.${i}.notes`)}
              />
            </div>
          ))}

          <button
            type="button"
            onClick={() => append({ reps: 12, durationSeconds: undefined, restSeconds: 60, notes: "" })}
            className="flex w-full items-center justify-center gap-1.5 rounded-md border border-dashed border-ink-600 py-2 text-sm text-neutral-400 hover:border-ink-500 hover:text-neutral-200"
          >
            <Plus size={14} /> Добавить подход
          </button>

          {saveSets.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить подходы.
            </div>
          )}

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={saveSets.isPending} className="btn-primary flex-1">
              {saveSets.isPending ? "Сохраняем…" : "Сохранить подходы"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

function ConfirmDeleteExerciseModal({
  programId,
  workoutId,
  group,
  onClose,
}: {
  programId: string;
  workoutId: string;
  group: ExerciseGroup;
  onClose: () => void;
}) {
  const saveSets = useSaveExerciseSets(programId);
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-sm rounded-lg border border-ink-700 bg-ink-900 p-6 text-center">
        <p className="font-semibold">Убрать «{group.exercise.title}» из этой тренировки?</p>
        <p className="mt-1.5 text-sm text-neutral-400">
          Само упражнение останется в каталоге — уберутся только его подходы отсюда.
        </p>
        {saveSets.isError && (
          <p className="mt-3 text-sm text-danger">
            {saveSets.error instanceof Error ? saveSets.error.message : "Не удалось удалить."}
          </p>
        )}
        <div className="mt-5 flex gap-3">
          <button onClick={onClose} className="btn-secondary flex-1">
            Отмена
          </button>
          <button
            onClick={() =>
              saveSets.mutate(
                { workoutId, exerciseId: group.exercise.id, baseOrder: group.baseOrder, sets: [] },
                { onSuccess: onClose },
              )
            }
            disabled={saveSets.isPending}
            className="flex-1 rounded-md bg-danger px-5 py-3 font-medium text-neutral-0 transition hover:bg-danger/90"
          >
            {saveSets.isPending ? "Удаляем…" : "Убрать"}
          </button>
        </div>
      </div>
    </div>
  );
}

function ConfirmDeleteWorkoutModal({
  programId,
  workout,
  onClose,
}: {
  programId: string;
  workout: WorkoutRow;
  onClose: () => void;
}) {
  const deleteWorkout = useDeleteWorkout(programId);
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-sm rounded-lg border border-ink-700 bg-ink-900 p-6 text-center">
        <p className="font-semibold">Удалить тренировку «{workout.title}»?</p>
        <p className="mt-1.5 text-sm text-neutral-400">Все её упражнения тоже удалятся.</p>
        {deleteWorkout.isError && (
          <div className="mt-3 flex items-start gap-2 rounded-md border border-danger/30 bg-danger/10 p-3 text-left text-sm text-danger">
            <AlertTriangle size={16} className="mt-0.5 shrink-0" />
            {deleteWorkout.error instanceof Error ? deleteWorkout.error.message : "Не удалось удалить."}
          </div>
        )}
        <div className="mt-5 flex gap-3">
          <button onClick={onClose} className="btn-secondary flex-1">
            Отмена
          </button>
          <button
            onClick={() => deleteWorkout.mutate(workout.id, { onSuccess: onClose })}
            disabled={deleteWorkout.isPending}
            className="flex-1 rounded-md bg-danger px-5 py-3 font-medium text-neutral-0 transition hover:bg-danger/90"
          >
            {deleteWorkout.isPending ? "Удаляем…" : "Удалить"}
          </button>
        </div>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Основная страница
// ---------------------------------------------------------------------------

export default function ProgramDetailPage() {
  const { programId } = useParams<{ programId: string }>();
  const { data: program, isLoading: programLoading } = useProgram(programId!);
  const { data: workouts, isLoading: workoutsLoading } = useProgramWorkouts(programId!);
  const reorderWorkout = useReorderWorkout(programId!);

  const [editingProgram, setEditingProgram] = useState(false);
  const [workoutModal, setWorkoutModal] = useState<{
    workout: WorkoutRow | null;
    weekOrder: number;
    weekLabel: string;
    nextOrder: number;
  } | null>(null);
  const [deletingWorkout, setDeletingWorkout] = useState<WorkoutRow | null>(null);
  const [addingExerciseTo, setAddingExerciseTo] = useState<WorkoutRow | null>(null);
  const [editingGroup, setEditingGroup] = useState<{ workoutId: string; group: ExerciseGroup } | null>(null);
  const [deletingGroup, setDeletingGroup] = useState<{ workoutId: string; group: ExerciseGroup } | null>(null);

  const weekBlocks = useMemo(() => {
    if (!workouts) return [];
    const seen = new Map<number, string>();
    for (const w of workouts) {
      if (!seen.has(w.weekOrder)) seen.set(w.weekOrder, w.weekLabel || `Блок ${w.weekOrder}`);
    }
    return Array.from(seen, ([order, label]) => ({ order, label })).sort((a, b) => a.order - b.order);
  }, [workouts]);

  const [activeWeekOrder, setActiveWeekOrder] = useState<number | null>(null);
  const effectiveWeekOrder = activeWeekOrder ?? weekBlocks[0]?.order ?? 1;

  const weekWorkouts = useMemo(
    () => (workouts ?? []).filter((w) => w.weekOrder === effectiveWeekOrder).sort((a, b) => a.order - b.order),
    [workouts, effectiveWeekOrder],
  );

  if (programLoading || workoutsLoading) {
    return <div className="card h-40 animate-pulse bg-ink-800" />;
  }

  if (!program) {
    return <p className="text-neutral-400">Программа не найдена.</p>;
  }

  const nextWeekOrder = (weekBlocks[weekBlocks.length - 1]?.order ?? 0) + 1;

  return (
    <div>
      <Link to="/programs" className="mb-4 inline-flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200">
        <ChevronLeft size={16} /> Все программы
      </Link>

      <div className="flex items-start justify-between gap-4">
        <div>
          <h1 className="font-display text-2xl font-bold">{program.title}</h1>
          <p className="mt-1 max-w-2xl text-neutral-400">{program.description}</p>
        </div>
        <button onClick={() => setEditingProgram(true)} className="btn-secondary shrink-0">
          <Pencil size={14} /> Редактировать
        </button>
      </div>

      {/* Недели/месяцы — выбор блока + добавление нового */}
      <div className="mt-6 flex items-center gap-2 overflow-x-auto pb-2">
        {weekBlocks.map((wk) => (
          <button
            key={wk.order}
            onClick={() => setActiveWeekOrder(wk.order)}
            className={clsx(
              "shrink-0 whitespace-nowrap rounded-full px-4 py-2 text-sm font-medium transition",
              wk.order === effectiveWeekOrder ? "bg-volt-400 text-ink-950" : "bg-ink-800 text-neutral-300 hover:bg-ink-700",
            )}
          >
            {wk.label}
          </button>
        ))}
        <button
          onClick={() =>
            setWorkoutModal({ workout: null, weekOrder: nextWeekOrder, weekLabel: `Неделя ${nextWeekOrder}`, nextOrder: 1 })
          }
          className="flex shrink-0 items-center gap-1.5 whitespace-nowrap rounded-full border border-dashed border-ink-600 px-4 py-2 text-sm text-neutral-400 hover:border-ink-500 hover:text-neutral-200"
        >
          <Plus size={14} /> Новая неделя/месяц
        </button>
      </div>

      {/* Тренировки в выбранной неделе */}
      <div className="mt-6 space-y-4">
        {weekWorkouts.map((workout, wi) => {
          const groups = groupByExercise(workout.sets);
          return (
            <div key={workout.id} className="card">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-xs text-neutral-500">Тренировка {wi + 1}</p>
                  <p className="font-semibold">{workout.title}</p>
                  <p className="mt-0.5 text-xs text-neutral-500">
                    {workout.estimatedDurationMinutes} мин · {groups.length} упражнений
                  </p>
                </div>
                <div className="flex shrink-0 items-center gap-1">
                  <button
                    disabled={wi === 0}
                    onClick={() =>
                      reorderWorkout.mutate({
                        a: { id: workout.id, order: workout.order },
                        b: { id: weekWorkouts[wi - 1].id, order: weekWorkouts[wi - 1].order },
                      })
                    }
                    className="rounded-md p-1.5 text-neutral-500 hover:bg-ink-800 hover:text-neutral-200 disabled:opacity-30"
                    aria-label="Переместить выше"
                  >
                    <ChevronUp size={16} />
                  </button>
                  <button
                    disabled={wi === weekWorkouts.length - 1}
                    onClick={() =>
                      reorderWorkout.mutate({
                        a: { id: workout.id, order: workout.order },
                        b: { id: weekWorkouts[wi + 1].id, order: weekWorkouts[wi + 1].order },
                      })
                    }
                    className="rounded-md p-1.5 text-neutral-500 hover:bg-ink-800 hover:text-neutral-200 disabled:opacity-30"
                    aria-label="Переместить ниже"
                  >
                    <ChevronDown size={16} />
                  </button>
                  <button
                    onClick={() =>
                      setWorkoutModal({ workout, weekOrder: workout.weekOrder, weekLabel: workout.weekLabel ?? "", nextOrder: 0 })
                    }
                    className="rounded-md p-1.5 text-neutral-500 hover:bg-ink-800 hover:text-neutral-200"
                    aria-label="Редактировать тренировку"
                  >
                    <Pencil size={16} />
                  </button>
                  <button
                    onClick={() => setDeletingWorkout(workout)}
                    className="rounded-md p-1.5 text-neutral-500 hover:bg-danger/10 hover:text-danger"
                    aria-label="Удалить тренировку"
                  >
                    <Trash2 size={16} />
                  </button>
                </div>
              </div>

              <div className="mt-4 space-y-2">
                {groups.map((group) => (
                  <div
                    key={group.exercise.id}
                    className="flex items-center justify-between rounded-md border border-ink-700 px-3.5 py-2.5"
                  >
                    <div className="min-w-0">
                      <p className="truncate text-sm font-medium">{group.exercise.title}</p>
                      <p className="text-xs text-neutral-500">
                        {group.sets.length} подхода
                        {group.sets[0]?.notes ? ` · ${group.sets[0].notes}` : ""}
                        {group.exercise.videoUrl && (
                          <span className="ml-1.5 inline-flex items-center gap-0.5 text-volt-400">
                            <PlayCircle size={11} /> видео
                          </span>
                        )}
                      </p>
                    </div>
                    <div className="flex shrink-0 items-center gap-1">
                      <button
                        onClick={() => setEditingGroup({ workoutId: workout.id, group })}
                        className="rounded-md p-1.5 text-neutral-500 hover:bg-ink-800 hover:text-neutral-200"
                        aria-label="Редактировать упражнение"
                      >
                        <Pencil size={14} />
                      </button>
                      <button
                        onClick={() => setDeletingGroup({ workoutId: workout.id, group })}
                        className="rounded-md p-1.5 text-neutral-500 hover:bg-danger/10 hover:text-danger"
                        aria-label="Убрать из тренировки"
                      >
                        <Trash2 size={14} />
                      </button>
                    </div>
                  </div>
                ))}

                <button
                  onClick={() => setAddingExerciseTo(workout)}
                  className="flex w-full items-center justify-center gap-1.5 rounded-md border border-dashed border-ink-600 py-2 text-sm text-neutral-400 hover:border-ink-500 hover:text-neutral-200"
                >
                  <Plus size={14} /> Добавить упражнение
                </button>
              </div>
            </div>
          );
        })}

        <button
          onClick={() =>
            setWorkoutModal({
              workout: null,
              weekOrder: effectiveWeekOrder,
              weekLabel: weekBlocks.find((w) => w.order === effectiveWeekOrder)?.label ?? "",
              nextOrder: (weekWorkouts[weekWorkouts.length - 1]?.order ?? 0) + 1,
            })
          }
          className="flex w-full items-center justify-center gap-1.5 rounded-md border border-dashed border-ink-600 py-3 text-sm text-neutral-400 hover:border-ink-500 hover:text-neutral-200"
        >
          <Plus size={14} /> Добавить тренировку в этот блок
        </button>
      </div>

      {editingProgram && <EditProgramModal program={program} onClose={() => setEditingProgram(false)} />}

      {workoutModal && (
        <WorkoutModal
          programId={program.id}
          workout={workoutModal.workout}
          weekOrder={workoutModal.weekOrder}
          weekLabel={workoutModal.weekLabel}
          nextOrder={workoutModal.nextOrder}
          onClose={() => setWorkoutModal(null)}
        />
      )}

      {deletingWorkout && (
        <ConfirmDeleteWorkoutModal programId={program.id} workout={deletingWorkout} onClose={() => setDeletingWorkout(null)} />
      )}

      {addingExerciseTo && (
        <AddExerciseModal
          programId={program.id}
          workoutId={addingExerciseTo.id}
          nextBaseOrder={computeNextBaseOrder(addingExerciseTo.sets)}
          onClose={() => setAddingExerciseTo(null)}
        />
      )}

      {editingGroup && (
        <EditExerciseGroupModal
          programId={program.id}
          workoutId={editingGroup.workoutId}
          group={editingGroup.group}
          onClose={() => setEditingGroup(null)}
        />
      )}

      {deletingGroup && (
        <ConfirmDeleteExerciseModal
          programId={program.id}
          workoutId={deletingGroup.workoutId}
          group={deletingGroup.group}
          onClose={() => setDeletingGroup(null)}
        />
      )}
    </div>
  );
}
