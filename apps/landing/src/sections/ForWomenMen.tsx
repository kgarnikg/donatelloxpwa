import { ArrowRight, Flame, Dumbbell, Home, Sparkles, TrendingUp, Zap, Target } from "lucide-react";
import { useTranslation } from "react-i18next";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

const WOMEN_TAGS = [
  { icon: Sparkles, key: "toneShape" },
  { icon: Target, key: "lowerCore" },
  { icon: Flame, key: "fatBurn" },
  { icon: Dumbbell, key: "strengthNoBulk" },
];

const MEN_TAGS = [
  { icon: TrendingUp, key: "strengthProgression" },
  { icon: Zap, key: "muscleGrowth" },
  { icon: Home, key: "homeOrGym" },
  { icon: Flame, key: "shredded" },
];

export function ForWomenMen() {
  const { t } = useTranslation();

  return (
    <section className="relative overflow-hidden py-20 sm:py-28">
      {/* Декоративный фон вместо конкретной фотографии — секция не завязана
          на отсутствующий у нас фотоассет тренера/моделей. Если позже
          появятся реальные фото — сюда просто добавляется <img>/<video>
          с тем же object-cover поверх этого градиента. */}
      <div className="absolute inset-0 bg-gradient-to-br from-ink-900 via-ink-950 to-ink-900" />
      <div className="absolute inset-0 bg-grid-fade opacity-30" />

      <div className="section-container relative">
        <div className="grid grid-cols-1 gap-10 lg:grid-cols-2 lg:gap-16">
          {/* Для женщин */}
          <div>
            <span className="inline-flex items-center rounded-full bg-pink-500 px-4 py-1.5 text-xs font-bold uppercase tracking-wide text-white">
              {t("forWomenMen.women.badge")}
            </span>
            <h2 className="mt-4 font-display text-2xl uppercase leading-tight tracking-tight sm:text-3xl">
              {t("forWomenMen.women.title")}
            </h2>
            <p className="mt-3 text-neutral-400">{t("forWomenMen.women.description")}</p>
            <div className="mt-5 flex flex-wrap gap-2">
              {WOMEN_TAGS.map(({ icon: Icon, key }) => (
                <span
                  key={key}
                  className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/60 px-3 py-1.5 text-sm text-neutral-200"
                >
                  <Icon size={14} className="text-pink-400" />
                  {t(`forWomenMen.women.tags.${key}`)}
                </span>
              ))}
            </div>
          </div>

          {/* Для мужчин */}
          <div className="lg:text-right">
            <span className="inline-flex items-center rounded-full bg-info px-4 py-1.5 text-xs font-bold uppercase tracking-wide text-white lg:ml-auto">
              {t("forWomenMen.men.badge")}
            </span>
            <h2 className="mt-4 font-display text-2xl uppercase leading-tight tracking-tight sm:text-3xl">
              {t("forWomenMen.men.title")}
            </h2>
            <p className="mt-3 text-neutral-400">{t("forWomenMen.men.description")}</p>
            <div className="mt-5 flex flex-wrap gap-2 lg:justify-end">
              {MEN_TAGS.map(({ icon: Icon, key }) => (
                <span
                  key={key}
                  className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/60 px-3 py-1.5 text-sm text-neutral-200"
                >
                  <Icon size={14} className="text-info" />
                  {t(`forWomenMen.men.tags.${key}`)}
                </span>
              ))}
            </div>
          </div>
        </div>

        <div className="mt-12 flex justify-center">
          <a
            href={`${APP_URL}/register`}
            className="btn-primary transition-transform duration-200 hover:scale-105 hover:shadow-[0_0_36px_rgba(168,224,0,0.45)]"
          >
            {t("forWomenMen.cta")} <ArrowRight size={18} />
          </a>
        </div>
      </div>
    </section>
  );
}
