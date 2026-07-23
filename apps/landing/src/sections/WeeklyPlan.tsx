import { Dumbbell, Flame, Moon } from "lucide-react";
import clsx from "clsx";

type DayKind = "strength" | "cardio" | "rest";

interface PlanDay {
  label: string;
  kind: DayKind;
  title: string;
  meta: string;
  detail: string;
}

const WEEK_PLAN: PlanDay[] = [
  {
    label: "Пн",
    kind: "strength",
    title: "Силовая",
    meta: "● 21 подх. | 6 упр.",
    detail: "Грудь, трицепс",
  },
  {
    label: "Вт",
    kind: "cardio",
    title: "Кардио",
    meta: "Кардио + пресс",
    detail: "30 мин",
  },
  {
    label: "Ср",
    kind: "strength",
    title: "Силовая",
    meta: "● 25 подх. | 7 упр.",
    detail: "Спина, бицепс, хват",
  },
  {
    label: "Чт",
    kind: "cardio",
    title: "Кардио",
    meta: "Кардио + пресс",
    detail: "30 мин",
  },
  {
    label: "Пт",
    kind: "strength",
    title: "Силовая",
    meta: "● 14 подх. | 4 упр.",
    detail: "Ноги",
  },
  {
    label: "Сб",
    kind: "cardio",
    title: "Кардио",
    meta: "Кардио + пресс",
    detail: "30 мин",
  },
  {
    label: "Вс",
    kind: "strength",
    title: "Силовая",
    meta: "● 17 подх. | 5 упр.",
    detail: "Плечи",
  },
];

function DayCard({ day }: { day: PlanDay }) {
  return (
    <div
      className={clsx(
        "card flex min-h-[152px] flex-col justify-between p-4",
        day.kind === "strength" && "hover:border-volt-400/30",
      )}
    >
      <div className="flex items-center justify-between">
        <span className="text-xs font-semibold uppercase tracking-wide text-neutral-500">
          {day.label}
        </span>
        {day.kind === "strength" ? (
          <Dumbbell size={16} className="text-volt-400" />
        ) : (
          <Flame size={16} className="text-ember-400" />
        )}
      </div>

      <div className="mt-3">
        <p className="font-semibold">{day.title}</p>
        <p className="mt-1 text-xs text-neutral-500">{day.meta}</p>
      </div>

      <p className="mt-3 text-xs font-medium uppercase tracking-wide text-neutral-400">
        {day.detail}
      </p>
    </div>
  );
}

export function WeeklyPlan() {
  return (
    <section id="plan" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Твой недельный план</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">
            Знай точно, что делать каждый день
          </h2>
          <p className="mt-4 text-neutral-400">
            Первая программа — «Набор массы для начинающих»: 4 силовые тренировки и 3 дня лёгкого
            кардио с прессом. Каждое упражнение — с числом подходов, повторений и видео-техникой.
          </p>
        </div>

        <div className="mt-10 grid grid-cols-2 gap-3 sm:grid-cols-4 lg:grid-cols-7">
          {WEEK_PLAN.map((day) => (
            <DayCard key={day.label} day={day} />
          ))}
        </div>

        <div className="mt-6 flex items-center justify-center gap-2 text-sm text-neutral-500">
          <Moon size={16} />
          Восстановление и сон — часть программы, а не пауза в ней.
        </div>
      </div>
    </section>
  );
}
