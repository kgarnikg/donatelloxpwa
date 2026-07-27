import { Dumbbell, Flame, Moon } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";

interface PlanDay {
  label: string;
  kind: "strength" | "cardio";
  meta: string;
  detail: string;
}

function DayCard({ day, cardioLabel, strengthLabel }: { day: PlanDay; cardioLabel: string; strengthLabel: string }) {
  return (
    <div
      className={clsx(
        "card flex min-h-[152px] flex-col justify-between p-4",
        day.kind === "strength" && "hover:border-volt-400/30",
      )}
    >
      <div className="flex items-center justify-between">
        <span className="text-xs font-semibold uppercase tracking-wide text-neutral-500">{day.label}</span>
        {day.kind === "strength" ? (
          <Dumbbell size={16} className="text-volt-400" />
        ) : (
          <Flame size={16} className="text-ember-400" />
        )}
      </div>

      <div className="mt-3">
        <p className="font-semibold">{day.kind === "strength" ? strengthLabel : cardioLabel}</p>
        {day.meta && <p className="mt-1 text-xs text-neutral-500">{day.meta}</p>}
      </div>

      <p className="mt-3 text-xs font-medium uppercase tracking-wide text-neutral-400">{day.detail}</p>
    </div>
  );
}

export function WeeklyPlan() {
  const { t } = useTranslation();
  const days = t("weeklyPlan.days", { returnObjects: true }) as PlanDay[];

  return (
    <section id="plan" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("weeklyPlan.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("weeklyPlan.title")}</h2>
          <p className="mt-4 text-neutral-400">{t("weeklyPlan.subtitle")}</p>
        </div>

        <div className="mt-10 grid grid-cols-2 gap-3 sm:grid-cols-4 lg:grid-cols-7">
          {days.map((day, i) => (
            <DayCard
              key={i}
              day={day}
              cardioLabel={t("weeklyPlan.cardioAbs") as string}
              strengthLabel={t("weeklyPlan.strength") as string}
            />
          ))}
        </div>

        <div className="mt-6 flex items-center justify-center gap-2 text-sm text-neutral-500">
          <Moon size={16} />
          {t("weeklyPlan.footerNote")}
        </div>
      </div>
    </section>
  );
}
