import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { Plus, X, PlayCircle, Search, CheckCircle2, Pencil } from "lucide-react";
import { supabase } from "@/lib/supabase";
import type { Exercise, MuscleGroup, ExerciseDifficulty } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

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

/**
 * Одна и та же форма используется для двух случаев:
 * - editingExercise = null → создаём совершенно новое упражнение (insert)
 * - editingExercise задан → просто прикрепляем/меняем видео у уже
 *   существующего упражнения из каталога (update) — это основной сценарий,
 *   на 2040 уже существующих упражнений, не создание новых с нуля.
 */
function ExerciseVideoModal({
  editingExercise,
  onClose,
}: {
  editingExercise: Exercise | null;
  onClose: () => void;
}) {
  const queryClient = useQueryClient();
  const isEditing = !!editingExercise;

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<ExerciseFormValues>({
    defaultValues: editingExercise
      ? {
          title: editingExercise.title,
          slug: editingExercise.slug,
          description: editingExercise.description ?? "",
          muscleGroups: (editingExercise.muscleGroups ?? []).join(", "),
          difficulty: editingExercise.difficulty,
          videoUrl: editingExercise.videoUrl ?? "",
          thumbnailUrl: editingExercise.thumbnailUrl ?? "",
          durationSeconds: editingExercise.durationSeconds ?? 60,
        }
      : { difficulty: "beginner", durationSeconds: 60 },
  });

  const saveExercise = useMutation({
    mutationFn: async (values: ExerciseFormValues) => {
      const muscleGroups = values.muscleGroups
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean) as MuscleGroup[];

      const payload = {
        title: values.title,
        slug: values.slug,
        description: values.description,
        muscle_groups: muscleGroups,
        difficulty: values.difficulty,
        video_url: values.videoUrl || null,
        thumbnail_url: values.thumbnailUrl || null,
        duration_seconds: values.durationSeconds,
      };

      if (isEditing) {
        const { error } = await supabase.from("exercises").update(payload).eq("id", editingExercise!.id);
        if (error) throw error;
      } else {
        const { error } = await supabase.from("exercises").insert(payload);
        if (error) throw error;
      }
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
          <h2 className="font-display text-lg font-bold">
            {isEditing ? "Прикрепить видео" : "Новое упражнение"}
          </h2>
          <button onClick={onClose} className="text-neutral-400 hover:text-neutral-100">
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit((v) => saveExercise.mutate(v))} className="space-y-4">
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Название</label>
            <input
              className="input-field"
              disabled={isEditing}
              {...register("title", { required: true })}
            />
            {errors.title && <p className="field-error">Обязательное поле</p>}
            {isEditing && (
              <p className="mt-1 text-xs text-neutral-500">
                Название нельзя менять здесь — оно совпадает с текстом в программах тренировок.
              </p>
            )}
          </div>

          {!isEditing && (
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Slug</label>
              <input className="input-field" {...register("slug", { required: true })} />
            </div>
          )}

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              Ссылка на видео
            </label>
            <input
              className="input-field"
              autoFocus={isEditing}
              placeholder="https://…  (YouTube или прямая ссылка на mp4)"
              {...register("videoUrl", { required: !isEditing })}
            />
            <p className="mt-1 text-xs text-neutral-500">
              Подходит и YouTube-ссылка, и прямая ссылка на файл (например, из Cloudflare
              R2/Bunny Storage) — приложение само определит, что перед ним.
            </p>
          </div>

          {!isEditing && (
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
          )}

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

          {saveExercise.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить.{!isEditing && " Проверьте, что slug уникален."}
            </div>
          )}

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">
              Отмена
            </button>
            <button type="submit" disabled={isSubmitting} className="btn-primary flex-1">
              {isSubmitting ? "Сохраняем…" : isEditing ? "Сохранить" : "Добавить"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default function VideosPage() {
  const [creatingNew, setCreatingNew] = useState(false);
  const [editingExercise, setEditingExercise] = useState<Exercise | null>(null);
  const [search, setSearch] = useState("");
  const [onlyMissing, setOnlyMissing] = useState(false);

  const { data: exercises, isLoading } = useQuery({
    queryKey: ["admin-exercises"],
    queryFn: async (): Promise<Exercise[]> => {
      const { data, error } = await supabase
        .from("exercises")
        .select("*")
        .order("title", { ascending: true });
      if (error) throw error;
      return toCamelCase<Exercise[]>(data ?? []);
    },
  });

  const withVideo = (exercises ?? []).filter((e) => e.videoUrl).length;
  const total = exercises?.length ?? 0;

  const filtered = (exercises ?? []).filter((e) => {
    if (onlyMissing && e.videoUrl) return false;
    return e.title.toLowerCase().includes(search.trim().toLowerCase());
  });

  const modalOpen = creatingNew || !!editingExercise;

  return (
    <div>
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold">Видео-упражнения</h1>
          <p className="mt-1 text-neutral-400">
            {isLoading ? "…" : `Видео прикреплено: ${withVideo} из ${total}`}
          </p>
        </div>
        <div className="flex flex-wrap gap-3">
          <button
            onClick={() => setOnlyMissing((v) => !v)}
            className={
              onlyMissing
                ? "rounded-full bg-volt-400/10 px-3.5 py-2 text-sm font-medium text-volt-400"
                : "rounded-full bg-ink-800 px-3.5 py-2 text-sm font-medium text-neutral-300 hover:bg-ink-700"
            }
          >
            Только без видео
          </button>
          <div className="relative">
            <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-neutral-500" />
            <input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Поиск…"
              className="input-field w-48 pl-9"
            />
          </div>
          <button onClick={() => setCreatingNew(true)} className="btn-primary whitespace-nowrap">
            <Plus size={16} /> Новое упражнение
          </button>
        </div>
      </div>

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {isLoading &&
          Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="card h-32 animate-pulse bg-ink-800" />
          ))}

        {filtered.map((exercise) => (
          <button
            key={exercise.id}
            onClick={() => setEditingExercise(exercise)}
            className="card group relative p-0 overflow-hidden text-left transition hover:border-ink-500"
          >
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
              {exercise.videoUrl && (
                <span className="absolute right-2 top-2 flex items-center gap-1 rounded-full bg-ink-950/80 px-2 py-0.5 text-[11px] font-semibold text-volt-400">
                  <CheckCircle2 size={12} /> есть видео
                </span>
              )}
              <span className="absolute inset-0 flex items-center justify-center bg-ink-950/0 opacity-0 transition group-hover:bg-ink-950/50 group-hover:opacity-100">
                <Pencil size={18} className="text-neutral-100" />
              </span>
            </div>
            <div className="p-3">
              <p className="truncate text-sm font-semibold">{exercise.title}</p>
              <p className="mt-0.5 text-xs text-neutral-500">
                {exercise.difficulty} · {exercise.durationSeconds ?? 0}с
              </p>
            </div>
          </button>
        ))}

        {!isLoading && filtered.length === 0 && (
          <p className="col-span-full py-8 text-center text-neutral-500">
            {onlyMissing ? "Видео прикреплено ко всем найденным упражнениям 🎉" : "Ничего не найдено."}
          </p>
        )}
      </div>

      {modalOpen && (
        <ExerciseVideoModal
          editingExercise={editingExercise}
          onClose={() => {
            setCreatingNew(false);
            setEditingExercise(null);
          }}
        />
      )}
    </div>
  );
}
