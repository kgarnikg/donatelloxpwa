import { useState } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Plus } from "lucide-react";
import { useTranslation } from "react-i18next";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { useProgressHistory } from "@/lib/queries";

export default function ProgressPage() {
  const { t } = useTranslation();
  const { authUser } = useAuth();
  const queryClient = useQueryClient();
  const { data: entries, isLoading } = useProgressHistory();
  const [showForm, setShowForm] = useState(false);
  const [weight, setWeight] = useState("");

  const addEntry = useMutation({
    mutationFn: async () => {
      if (!authUser || !weight) return;
      const { error } = await supabase.from("progress_entries").insert({
        user_id: authUser.id,
        recorded_at: new Date().toISOString(),
        weight_kg: Number(weight),
      });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["progress", authUser?.id] });
      setWeight("");
      setShowForm(false);
    },
  });

  const weights = (entries ?? []).map((e) => e.weightKg).filter((w): w is number => !!w);
  const min = weights.length ? Math.min(...weights) - 2 : 0;
  const max = weights.length ? Math.max(...weights) + 2 : 100;
  const latest = weights.at(-1);
  const first = weights.at(0);
  const delta = latest && first ? latest - first : null;

  return (
    <div className="px-5 pt-8">
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
            <button
              onClick={() => addEntry.mutate()}
              disabled={!weight || addEntry.isPending}
              className="btn-primary shrink-0"
            >
              {t("common.save")}
            </button>
          </div>
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

      <div className="card">
        <p className="mb-4 text-sm font-medium text-neutral-300">{t("progress.weightDynamics")}</p>
        {isLoading ? (
          <div className="h-40 animate-pulse rounded bg-ink-800" />
        ) : weights.length < 2 ? (
          <p className="py-10 text-center text-sm text-neutral-500">
            {t("progress.needMoreEntries")}
          </p>
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
    </div>
  );
}
