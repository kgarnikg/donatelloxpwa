import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { Plus, X, PlayCircle, Search } from "lucide-react";
import { supabase } from "@/lib/supabase";
import type { Exercise, MuscleGroup, ExerciseDifficulty } from "@donatellox/types";

interface ExerciseFormValues {
  title: string;
  slug: string;
  description: string;
  muscleGroups: string;
  difficulty: ExerciseDifficulty;
  videoUrl: string;
  thumbnailUrl: string;
  durationSeconds: number;
}

const DIFFICULTIES: ExerciseDifficulty[] = ["beginner", "intermediate", "advanced"];

function UploadExerciseModal({ onClose }: { onClose: () => void }) {
  const queryClient = useQueryClient();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<ExerciseFormValues>({
    defaultValues: { difficulty: "beginner", durationSeconds: 60 },
  });

  const createExercise = useMutation({
    mutationFn: async (values: ExerciseFormValues) => {
      const muscleGroups = values.muscleGroups
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean) as MuscleGroup[];

      const { error } = await supabase.from("exercises").insert({
        title: values.title,
        slug: values.slug,
        description: values.description,
        muscle_groups: muscleGroups,
        difficulty: values.difficulty,
        video_url: values.videoUrl,
        thumbnail_url: values.thumbnailUrl || null,
        duration_seconds: values.durationSeconds,
      });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-exercises"] });
      onClose();
    },
  });

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4">
      <div className="w-full max-w-lg rounded-lg border border-ink-700 bg-ink-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">Новое видео-упражнение</h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit((v) => createExercise.mutate(v))} className="space-y-4">
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Название</label>
            <input className="input-field" {...register("title", { required: true })} />
            {errors.title && <p className="field-error">Обязательное поле</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Slug</label>
            <input className="input-field" {...register("slug", { required: true })} />
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              Ссылка на видео (Supabase Storage)
            </label>
            <input
              className="input-field"
              placeholder="https://…/storage/v1/object/public/videos/…"
              {...register("videoUrl", { required: true })}
            />
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              Мышечные группы (через запятую)
            </label>
            <input
              className="input-field"
              placeholder="chest, arms"
              {...register("muscleGroups")}
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                Сложность
              </label>
              <select className="input-field" {...register("difficulty")}>
                {DIFFICULTIES.map((d) => (
                  <option key={d} value={d}>
                    {d}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                Длительность, сек.
              </label>
              <input
                type="number"
                min={1}
                className="input-field"
                {...register("durationSeconds", { valueAsNumber: true })}
              />
            </div>
          </div>

          {createExercise.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить. Проверьте, что slug уникален.
            </div>
          )}

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={isSubmitting} className="btn-primary flex-1">
              {isSubmitting ? "Сохраняем…" : "Добавить"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default function VideosPage() {
  const [modalOpen, setModalOpen] = useState(false);
  const [search, setSearch] = useState("");

  const { data: exercises, isLoading } = useQuery({
    queryKey: ["admin-exercises"],
    queryFn: async (): Promise<Exercise[]> => {
      const { data, error } = await supabase
        .from("exercises")
        .select("*")
        .order("title", { ascending: true });
      if (error) throw error;
      return (data ?? []) as unknown as Exercise[];
    },
  });

  const filtered = (exercises ?? []).filter((e) =>
    e.title.toLowerCase().includes(search.trim().toLowerCase()),
  );

  return (
    <div>
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold">Видео-упражнения</h1>
          <p className="mt-1 text-neutral-400">Библиотека контента для тренировок</p>
        </div>
        <div className="flex gap-3">
          <div className="relative">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-neutral-500" />
            <input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Поиск…"
              className="input-field w-48 pl-9"
            />
          </div>
          <button onClick={() => setModalOpen(true)} className="btn-primary whitespace-nowrap">
            <Plus size={16} /> Добавить видео
          </button>
        </div>
      </div>

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {isLoading &&
          Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="card h-32 animate-pulse bg-ink-800" />
          ))}

        {filtered.map((exercise) => (
          <div key={exercise.id} className="card p-0 overflow-hidden">
            <div className="relative flex h-24 items-center justify-center bg-ink-800">
              {exercise.thumbnailUrl ? (
                <img
                  src={exercise.thumbnailUrl}
                  alt={exercise.title}
                  className="h-full w-full object-cover"
                />
              ) : (
                <PlayCircle className="text-neutral-600" size={32} />
              )}
            </div>
            <div className="p-3">
              <p className="truncate text-sm font-semibold">{exercise.title}</p>
              <p className="mt-0.5 text-xs text-neutral-500">
                {exercise.difficulty} · {exercise.durationSeconds ?? 0}с
              </p>
            </div>
          </div>
        ))}

        {!isLoading && filtered.length === 0 && (
          <p className="col-span-full py-8 text-center text-neutral-500">
            Видео не найдены. Загрузите первое упражнение.
          </p>
        )}
      </div>

      {modalOpen && <UploadExerciseModal onClose={() => setModalOpen(false)} />}
    </div>
  );
}
