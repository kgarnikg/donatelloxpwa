import { Dumbbell, LineChart, Video, ClipboardList, UserCircle, Sparkles } from "lucide-react";
import { useTranslation } from "react-i18next";

const ICONS = [ClipboardList, Dumbbell, Video, LineChart, UserCircle, Sparkles];

interface ModuleItem {
  title: string;
  description: string;
}

export function Modules() {
  const { t } = useTranslation();
  const items = t("modules.items", { returnObjects: true }) as ModuleItem[];

  return (
    <section id="modules" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("modules.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("modules.title")}</h2>
          <p className="mt-4 text-neutral-400">{t("modules.subtitle")}</p>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {items.map((item, i) => {
            const Icon = ICONS[i] ?? Sparkles;
            return (
              <div key={item.title} className="card transition hover:border-volt-400/30 hover:shadow-glow">
                <div className="mb-4 flex h-11 w-11 items-center justify-center rounded-lg bg-volt-400/10 text-volt-400">
                  <Icon size={22} />
                </div>
                <h3 className="font-semibold">{item.title}</h3>
                <p className="mt-2 text-sm text-neutral-400">{item.description}</p>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
