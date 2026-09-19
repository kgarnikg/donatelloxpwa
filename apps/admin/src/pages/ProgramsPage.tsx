import { useState } from "react";
import { Link } from "react-router-dom";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { Plus, X, Lock } from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type { WorkoutProgram, FitnessGoal, ExerciseDifficulty, LocaleCode } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

interface ProgramFormValues {
  title: string;
  slug: string;
  description: string;
  goal: FitnessGoal;
  difficulty: ExerciseDifficulty;
  durationWeeks: number;
  workoutsPerWeek: number;
  isPremium: boolean;
  locale: LocaleCode;
}

const GOALS: FitnessGoal[] = [
  "lose_weight",
  "build_muscle",
  "improve_endurance",
  "general_fitness",
  "rehabilitation",
];
const DIFFICULTIES: ExerciseDifficulty[] = ["beginner", "intermediate", "advanced"];

function CreateProgramModal({ onClose }: { onClose: () => void }) {
  const queryClient = useQueryClient();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<ProgramFormValues>({
    defaultValues: {
      goal: "general_fitness",
      difficulty: "beginner",
      durationWeeks: 4,
      workoutsPerWeek: 3,
      isPremium: true,
      locale: "ru",
    },
  });

  const createProgram = useMutation({
    mutationFn: async (values: ProgramFormValues) => {
      const { error } = await supabase.from("workout_programs").insert({
        title: values.title,
        slug: values.slug,
        description: values.description,
        goal: values.goal,
        difficulty: values.difficulty,
        duration_weeks: values.durationWeeks,
        workouts_per_week: values.workoutsPerWeek,
        is_premium: values.isPremium,
        locale: values.locale,
      });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-programs"] });
      onClose();
    },
  });

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-lg rounded-lg border border-ink-700 bg-ink-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">Новая программа</h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>

        <form
          onSubmit={handleSubmit((values) => createProgram.mutate(values))}
          className="space-y-4"
        >
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Название</label>
            <input
              className="input-field"
              {...register("title", { required: "Обязательное поле" })}
            />
            {errors.title && <p className="field-error">{errors.title.message}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Slug (URL)</label>
            <input
              className="input-field"
              placeholder="strength-basics"
              {...register("slug", { required: "Обязательное поле" })}
            />
            {errors.slug && <p className="field-error">{errors.slug.message}</p>}
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
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Недель</label>
              <input
                type="number"
                min={1}
                className="input-field"
                {...register("durationWeeks", { valueAsNumber: true })}
              />
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                Тренировок/нед.
              </label>
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

          {createProgram.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить программу. Проверьте, что slug уникален.
            </div>
          )}

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={isSubmitting} className="btn-primary flex-1">
              {isSubmitting ? "Сохраняем…" : "Создать"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default function ProgramsPage() {
  const [modalOpen, setModalOpen] = useState(false);

  const { data: programs, isLoading } = useQuery({
    queryKey: ["admin-programs"],
    queryFn: async (): Promise<WorkoutProgram[]> => {
      const { data, error } = await supabase
        .from("workout_programs")
        .select("*")
        .order("created_at", { ascending: false });
      if (error) throw error;
      return toCamelCase<WorkoutProgram[]>(data ?? []);
    },
  });

  return (
    <div>
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold">Программы тренировок</h1>
          <p className="mt-1 text-neutral-400">Контент, доступный пользователям приложения</p>
        </div>
        <button onClick={() => setModalOpen(true)} className="btn-primary">
          <Plus size={16} /> Новая программа
        </button>
      </div>

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {isLoading &&
          Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="card h-40 animate-pulse bg-ink-800" />
          ))}

        {programs?.map((program) => (
          <Link key={program.id} to={`/programs/${program.id}`} className="card block transition hover:border-ink-500">
            <div className="flex items-start justify-between">
              <h3 className="font-semibold">{program.title}</h3>
              {program.isPremium && (
                <span className="badge bg-volt-400/10 text-volt-400">
                  <Lock size={11} className="mr-1" /> Премиум
                </span>
              )}
            </div>
            <p className="mt-2 line-clamp-2 text-sm text-neutral-400">{program.description}</p>
            <div className="mt-4 flex flex-wrap gap-2 text-xs text-neutral-500">
              <span className={clsx("badge bg-ink-800")}>{program.goal}</span>
              <span className={clsx("badge bg-ink-800")}>{program.difficulty}</span>
              <span className={clsx("badge bg-ink-800")}>{program.durationWeeks} нед.</span>
            </div>
          </Link>
        ))}

        {!isLoading && programs?.length === 0 && (
          <p className="col-span-full py-8 text-center text-neutral-500">
            Пока нет ни одной программы — создайте первую.
          </p>
        )}
      </div>

      {modalOpen && <CreateProgramModal onClose={() => setModalOpen(false)} />}
    </div>
  );
}
