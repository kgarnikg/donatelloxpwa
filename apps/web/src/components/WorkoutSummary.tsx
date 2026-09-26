import { useTranslation } from "react-i18next";
import { Trophy, Clock, Dumbbell, Flame, Weight, Beef, Wheat, Droplets, Moon, Footprints } from "lucide-react";
import type { ReactNode } from "react";

export interface WorkoutSummaryData {
  title: string;
  minutes: number;
  exercises: number;
  sets: number;
  /** null — в профиле нет веса, калории не посчитать. */
  kcal: number | null;
  volumeKg: number;
  programGoal: string | null;
  weightKg: number | null;
}

const round = (n: number, step: number) => Math.round(n / step) * step;

/**
 * Итог тренировки — показывается после "Завершить тренировку": время,
 * упражнения, калории, поднятый вес и короткие советы по питанию и
 * восстановлению (под цель программы и вес человека).
 */
export function WorkoutSummary({ data, onDone }: { data: WorkoutSummaryData; onDone: () => void }) {
  const { t, i18n } = useTranslation();
  const lang = i18n.language;
  const w = data.weightKg;

  // Всегда в минутах: "1 ч 04 мин" не влезает в плитку на узком экране
  const time = `${data.minutes} ${t("common.min")}`;

  const lifted =
    data.volumeKg >= 1000
      ? `${(data.volumeKg / 1000).toLocaleString(lang, { maximumFractionDigits: 1 })} ${t("common.ton")}`
      : `${Math.round(data.volumeKg).toLocaleString(lang)} ${t("common.kg")}`;

  // Белок 0.3–0.4 г/кг после тренировки; углеводы ~1 г/кг на наборе массы;
  // вода — ~600 мл на час тренировки (400–1000 мл).
  const proteinFrom = w ? Math.max(20, round(w * 0.3, 5)) : 20;
  const proteinTo = w ? Math.max(proteinFrom + 5, round(w * 0.4, 5)) : 40;
  const carbs = w ? round(w * 1, 10) : 70;
  const water = Math.min(1000, Math.max(400, round((data.minutes / 60) * 600, 50)));
  const carbsText =
    data.programGoal === "lose_weight"
      ? t("workout.summary.carbsLoss")
      : data.programGoal === "build_muscle"
        ? t("workout.summary.carbsGain", { grams: carbs })
        : t("workout.summary.carbsBalanced");

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pb-10 pt-[max(2.5rem,env(safe-area-inset-top))] animate-fade-in">
      <div className="mx-auto max-w-md">
        <div className="flex flex-col items-center text-center">
          <div className="flex h-20 w-20 items-center justify-center rounded-full bg-volt-400 text-ink-950 shadow-[0_0_40px_rgba(190,242,0,0.35)]">
            <Trophy size={38} strokeWidth={2.2} />
          </div>
          <h1 className="mt-5 font-display text-2xl font-bold">{t("workout.summary.title")}</h1>
          <p className="mt-1 text-neutral-400">{data.title}</p>
        </div>

        <div className="mt-7 grid grid-cols-2 gap-3">
          <Stat icon={<Clock size={18} />} value={time} label={t("workout.summary.time")} />
          <Stat
            icon={<Dumbbell size={18} />}
            value={String(data.exercises)}
            label={t("workout.summary.exercises", { count: data.exercises })}
            hint={t("workout.sets", { count: data.sets })}
          />
          <Stat
            icon={<Flame size={18} />}
            value={data.kcal != null ? `~${data.kcal.toLocaleString(lang)}` : "—"}
            label={t("workout.summary.kcal")}
            hint={data.kcal == null ? t("workout.summary.kcalNoWeight") : undefined}
            accent
          />
          {data.volumeKg > 0 ? (
            <Stat icon={<Weight size={18} />} value={lifted} label={t("workout.summary.lifted")} />
          ) : (
            <Stat icon={<Dumbbell size={18} />} value={String(data.sets)} label={t("workout.summary.setsDone")} />
          )}
        </div>

        <Section title={t("workout.summary.nutritionTitle")}>
          <Tip icon={<Beef size={18} />}>{t("workout.summary.protein", { from: proteinFrom, to: proteinTo })}</Tip>
          <Tip icon={<Wheat size={18} />}>{carbsText}</Tip>
          <Tip icon={<Droplets size={18} />}>{t("workout.summary.water", { ml: water })}</Tip>
        </Section>

        <Section title={t("workout.summary.recoveryTitle")}>
          <Tip icon={<Moon size={18} />}>{t("workout.summary.sleep")}</Tip>
          <Tip icon={<Footprints size={18} />}>{t("workout.summary.rest")}</Tip>
        </Section>

        <p className="mt-4 text-center text-[11px] leading-relaxed text-neutral-600">{t("workout.summary.disclaimer")}</p>

        <button onClick={onDone} className="btn-primary mt-6 w-full py-4 text-base">
          {t("workout.summary.done")}
        </button>
      </div>
    </div>
  );
}

function Stat({
  icon,
  value,
  label,
  hint,
  accent,
}: {
  icon: ReactNode;
  value: string;
  label: string;
  hint?: string;
  accent?: boolean;
}) {
  return (
    <div className="card flex flex-col gap-1 p-4">
      <span className={accent ? "text-ember-400" : "text-volt-400"}>{icon}</span>
      <p className="mt-1 font-display text-2xl font-bold tabular-nums leading-tight">{value}</p>
      <p className="text-xs text-neutral-400">{label}</p>
      {hint && <p className="text-[11px] leading-snug text-neutral-500">{hint}</p>}
    </div>
  );
}

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div className="card mt-4">
      <p className="text-xs font-semibold uppercase tracking-wide text-neutral-500">{title}</p>
      <ul className="mt-3 space-y-3">{children}</ul>
    </div>
  );
}

function Tip({ icon, children }: { icon: ReactNode; children: ReactNode }) {
  return (
    <li className="flex items-start gap-3 text-sm leading-snug text-neutral-200">
      <span className="mt-0.5 shrink-0 text-volt-400">{icon}</span>
      <span>{children}</span>
    </li>
  );
}
