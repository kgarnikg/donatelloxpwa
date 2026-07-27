import { ClipboardList, Sparkles, TrendingUp } from "lucide-react";
import { useTranslation } from "react-i18next";

const ICONS = [ClipboardList, Sparkles, TrendingUp];

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

        <div className="mt-14 grid grid-cols-1 gap-8 md:grid-cols-3">
          {items.map((item, index) => {
            const Icon = ICONS[index] ?? Sparkles;
            return (
              <div key={item.title} className="relative text-center">
                <div className="mx-auto mb-5 flex h-16 w-16 items-center justify-center rounded-2xl bg-volt-400/10 text-volt-400">
                  <Icon size={26} />
                </div>
                <span className="font-display text-sm font-bold text-neutral-600">
                  {String(index + 1).padStart(2, "0")}
                </span>
                <h3 className="mt-2 font-semibold">{item.title}</h3>
                <p className="mt-2 text-sm text-neutral-400">{item.description}</p>

                {index < items.length - 1 && (
                  <div className="absolute right-[-1rem] top-8 hidden h-px w-8 bg-ink-700 md:block" />
                )}
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
