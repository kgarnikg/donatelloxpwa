import { useState } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Plus, Dumbbell, Ruler } from "lucide-react";
import { useTranslation } from "react-i18next";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { useProgressHistory, useWorkoutHistory } from "@/lib/queries";

const MEASUREMENT_FIELDS = [
  { key: "chest", labelKey: "progress.chest" },
  { key: "waist", labelKey: "progress.waist" },
  { key: "hips", labelKey: "progress.hips" },
  { key: "biceps", labelKey: "progress.biceps" },
  { key: "thigh", labelKey: "progress.thigh" },
] as const;

export default function ProgressPage() {
  const { t } = useTranslation();
  const { authUser } = useAuth();
  const queryClient = useQueryClient();
  const { data: entries, isLoading } = useProgressHistory();
  const { data: workoutHistory, isLoading: historyLoading } = useWorkoutHistory();

  const [showForm, setShowForm] = useState(false);
  const [showMeasurements, setShowMeasurements] = useState(false);
  const [weight, setWeight] = useState("");
  const [measurements, setMeasurements] = useState<Record<string, string>>({});

  const addEntry = useMutation({
    mutationFn: async () => {
      if (!authUser) return;
      const measurementValues = Object.fromEntries(
        Object.entries(measurements)
          .filter(([, v]) => v.trim() !== "")
          .map(([k, v]) => [k, Number(v)]),
      );

      const { error } = await supabase.from("progress_entries").insert({
        user_id: authUser.id,
        recorded_at: new Date().toISOString(),
        weight_kg: weight ? Number(weight) : null,
        measurements: Object.keys(measurementValues).length ? measurementValues : null,
      });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["progress", authUser?.id] });
      setWeight("");
      setMeasurements({});
      setShowForm(false);
      setShowMeasurements(false);
    },
  });

  const weights = (entries ?? []).map((e) => e.weightKg).filter((w): w is number => !!w);
  const min = weights.length ? Math.min(...weights) - 2 : 0;
  const max = weights.length ? Math.max(...weights) + 2 : 100;
  const latest = weights.at(-1);
  const first = weights.at(0);
  const delta = latest && first ? latest - first : null;

  // Последнее и первое значение по каждому виду замера — для карточек с изменением.
  const measurementSeries: Record<string, number[]> = {};
  for (const entry of entries ?? []) {
    if (!entry.measurements) continue;
    for (const [key, value] of Object.entries(entry.measurements)) {
      if (!measurementSeries[key]) measurementSeries[key] = [];
      measurementSeries[key].push(value);
    }
  }
  const hasAnyMeasurements = Object.keys(measurementSeries).length > 0;

  return (
    <div className="px-5 pt-8 pb-6">
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold">{t("progress.title")}</h1>
          <p className="mt-1 text-neutral-400">{t("progress.subtitle")}</p>
        </div>
        <button onClick={() => setShowForm((s) => !s)} className="btn-primary !p-3">
          <Plus size={20} />
        </button>
      </div>

      {showForm && (
        <div className="card mb-6 animate-fade-in">
          <label className="mb-1.5 block text-sm font-medium text-neutral-300">{t("progress.currentWeight")}</label>
          <div className="flex gap-2">
            <input
              type="number"
              step="0.1"
              value={weight}
              onChange={(e) => setWeight(e.target.value)}
              className="input-field"
              placeholder="72.5"
              autoFocus
            />
          </div>

          <button
            onClick={() => setShowMeasurements((s) => !s)}
            className="mt-4 flex items-center gap-1.5 text-sm font-medium text-volt-400"
          >
            <Ruler size={14} />
            {t("progress.addMeasurements")}
          </button>

          {showMeasurements && (
            <div className="mt-3 grid grid-cols-2 gap-3 animate-fade-in">
              {MEASUREMENT_FIELDS.map((field) => (
                <div key={field.key}>
                  <label className="mb-1 block text-xs text-neutral-400">
                    {t(field.labelKey)}, {t("progress.cmUnit")}
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    value={measurements[field.key] ?? ""}
                    onChange={(e) =>
                      setMeasurements((prev) => ({ ...prev, [field.key]: e.target.value }))
                    }
                    className="input-field py-2 text-sm"
                  />
                </div>
              ))}
            </div>
          )}

          <button
            onClick={() => addEntry.mutate()}
            disabled={(!weight && Object.values(measurements).every((v) => !v)) || addEntry.isPending}
            className="btn-primary mt-4 w-full"
          >
            {t("common.save")}
          </button>
        </div>
      )}

      {latest !== undefined && (
        <div className="mb-6 grid grid-cols-2 gap-3">
          <div className="card">
            <p className="text-xs text-neutral-400">{t("progress.currentWeight")}</p>
            <p className="mt-1 text-2xl font-bold">{latest} кг</p>
          </div>
          <div className="card">
            <p className="text-xs text-neutral-400">{t("progress.change")}</p>
            <p
              className={`mt-1 text-2xl font-bold ${
                delta && delta < 0 ? "text-success" : delta && delta > 0 ? "text-ember-400" : ""
              }`}
            >
              {delta === null ? "—" : `${delta > 0 ? "+" : ""}${delta.toFixed(1)} кг`}
            </p>
          </div>
        </div>
      )}

      <div className="card mb-6">
        <p className="mb-4 text-sm font-medium text-neutral-300">{t("progress.weightDynamics")}</p>
        {isLoading ? (
          <div className="h-40 animate-pulse rounded bg-ink-800" />
        ) : weights.length < 2 ? (
          <p className="py-10 text-center text-sm text-neutral-500">{t("progress.needMoreEntries")}</p>
        ) : (
          <svg viewBox="0 0 300 120" className="h-32 w-full overflow-visible">
            <polyline
              fill="none"
              stroke="#A8E000"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              points={weights
                .map((w, i) => {
                  const x = (i / (weights.length - 1)) * 300;
                  const y = 110 - ((w - min) / (max - min || 1)) * 100;
                  return `${x},${y}`;
                })
                .join(" ")}
            />
          </svg>
        )}
      </div>

      {/* Замеры тела */}
      <div className="card mb-6">
        <p className="mb-4 flex items-center gap-1.5 text-sm font-medium text-neutral-300">
          <Ruler size={15} /> {t("progress.measurements")}
        </p>
        {!hasAnyMeasurements ? (
          <p className="py-6 text-center text-sm text-neutral-500">{t("progress.noMeasurementsYet")}</p>
        ) : (
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
            {MEASUREMENT_FIELDS.filter((f) => measurementSeries[f.key]?.length).map((field) => {
              const series = measurementSeries[field.key];
              const latestVal = series.at(-1)!;
              const firstVal = series.at(0)!;
              const change = series.length > 1 ? latestVal - firstVal : null;
              return (
                <div key={field.key} className="rounded-md border border-ink-700 p-3">
                  <p className="text-xs text-neutral-400">{t(field.labelKey)}</p>
                  <p className="mt-1 text-lg font-bold">
                    {latestVal} <span className="text-xs font-normal text-neutral-500">{t("progress.cmUnit")}</span>
                  </p>
                  {change !== null && change !== 0 && (
                    <p className={`text-xs ${change < 0 ? "text-success" : "text-ember-400"}`}>
                      {change > 0 ? "+" : ""}
                      {change.toFixed(1)} {t("progress.cmUnit")}
                    </p>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* История тренировок */}
      <div className="card">
        <p className="mb-4 flex items-center gap-1.5 text-sm font-medium text-neutral-300">
          <Dumbbell size={15} /> {t("progress.recentWorkouts")}
        </p>
        {historyLoading ? (
          <div className="space-y-2">
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="h-14 animate-pulse rounded-md bg-ink-800" />
            ))}
          </div>
        ) : !workoutHistory?.length ? (
          <p className="py-6 text-center text-sm text-neutral-500">{t("progress.noWorkoutsYet")}</p>
        ) : (
          <ul className="space-y-2">
            {workoutHistory.map((entry) => (
              <li
                key={entry.id}
                className="flex items-center justify-between rounded-md border border-ink-700 px-3.5 py-2.5"
              >
                <div className="min-w-0">
                  <p className="truncate text-sm font-medium">{entry.workoutTitle}</p>
                  <p className="text-xs text-neutral-500">
                    {new Date(entry.completedAt).toLocaleDateString("ru-RU", {
                      day: "numeric",
                      month: "short",
                    })}
                  </p>
                </div>
                <span className="shrink-0 rounded-full bg-volt-400/10 px-2.5 py-1 text-xs font-medium text-volt-400">
                  {entry.durationMinutes} {t("common.min")}
                </span>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}
