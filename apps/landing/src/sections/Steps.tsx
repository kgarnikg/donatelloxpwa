import { UserPlus, Gift, Dumbbell } from "lucide-react";
import { useTranslation } from "react-i18next";

const ICONS = [UserPlus, Gift, Dumbbell];

interface StepItem {
  title: string;
  description: string;
}

export function Steps() {
  const { t } = useTranslation();
  const items = t("steps.items", { returnObjects: true }) as StepItem[];

  return (
    <section id="how-it-works" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("steps.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("steps.title")}</h2>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-10 md:grid-cols-3">
          {items.map((item, index) => {
            const Icon = ICONS[index] ?? Dumbbell;
            return (
              <div key={item.title} className="relative text-center">
                <span className="font-display text-6xl font-extrabold leading-none text-volt-400 sm:text-7xl">
                  {String(index + 1).padStart(2, "0")}
                </span>
                <div className="mx-auto -mt-3 mb-5 flex h-12 w-12 items-center justify-center rounded-xl bg-volt-400/10 text-volt-400">
                  <Icon size={22} />
                </div>
                <h3 className="font-semibold">{item.title}</h3>
                <p className="mt-2 text-sm text-neutral-400">{item.description}</p>

                {index < items.length - 1 && (
                  <div className="absolute right-[-1.25rem] top-10 hidden h-px w-10 bg-ink-700 md:block" />
                )}
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
