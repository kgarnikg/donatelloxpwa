import { ArrowRight, Flame, Dumbbell, Home, Sparkles, TrendingUp, Zap, Target } from "lucide-react";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { APP_URL } from "@/lib/appUrl";
import photo from "@/assets/women-men.webp";
import photoSmall from "@/assets/women-men-800.webp";

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
  // Телефон: одна колонка с переключателем «Для женщин / Для мужчин»
  const [active, setActive] = useState<"women" | "men">("women");
  const activeTags = active === "women" ? WOMEN_TAGS : MEN_TAGS;

  return (
    <section className="relative overflow-hidden bg-ink-950 pb-20 sm:pb-28 lg:flex lg:min-h-[760px] lg:items-center lg:py-24">
      {/* Фото тренеров: на компьютере — фоном по центру между колонками
          (женщина слева, мужчина справа — как и тексты), края растворяются
          в фоне. На телефоне — сверху секции, текст наезжает на низ фото. */}
      <div className="pointer-events-none relative mx-auto -mb-14 max-w-md sm:-mb-20 lg:absolute lg:inset-y-0 lg:left-1/2 lg:mb-0 lg:max-w-none lg:-translate-x-1/2">
        <img
          src={photo}
          srcSet={`${photoSmall} 800w, ${photo} 1600w`}
          sizes="(min-width: 1024px) 800px, 100vw"
          width={1600}
          height={1555}
          alt=""
          loading="lazy"
          decoding="async"
          className="block h-auto w-full lg:h-full lg:w-auto lg:max-w-none"
        />
        {/* Края фото растворяются в фоне секции */}
        <div
          className="absolute inset-0"
          style={{
            background: [
              "linear-gradient(to bottom, #0A0B0D 0%, transparent 16%, transparent 58%, #0A0B0D 100%)",
              "linear-gradient(to right, #0A0B0D 0%, transparent 18%, transparent 82%, #0A0B0D 100%)",
            ].join(","),
          }}
        />
      </div>
      {/* Подложка под тексты на компьютере, чтобы они читались поверх фото */}
      <div
        className="pointer-events-none absolute inset-0 hidden lg:block"
        style={{
          background:
            "linear-gradient(to right, rgb(10 11 13 / 0.85) 0%, rgb(10 11 13 / 0.55) 24%, transparent 36%, transparent 64%, rgb(10 11 13 / 0.55) 76%, rgb(10 11 13 / 0.85) 100%)",
        }}
      />

      <div className="section-container relative lg:max-w-7xl">
        {/* Телефон и планшет: вкладки поверх низа фото, под ними текст выбранной */}
        <div className="text-center lg:hidden">
          <div role="tablist" className="flex justify-center gap-3">
            {(["women", "men"] as const).map((key) => {
              const on = active === key;
              // Обе кнопки объёмные (заливка + свечение), выбранная — крупнее, с белой обводкой
              const color =
                key === "women"
                  ? "bg-gradient-to-r from-pink-500 to-fuchsia-500 shadow-[0_0_28px_rgba(236,72,153,0.55)]"
                  : "bg-gradient-to-r from-blue-500 to-sky-500 shadow-[0_0_28px_rgba(59,130,246,0.6)]";
              return (
                <button
                  key={key}
                  type="button"
                  role="tab"
                  aria-selected={on}
                  onClick={() => setActive(key)}
                  className={`rounded-full px-5 py-2.5 text-sm font-bold uppercase tracking-wide backdrop-blur transition-all duration-200 text-white ${color} ${on ? "scale-105 ring-2 ring-white/70" : ""}`}
                >
                  {t(`forWomenMen.${key}.badge`)}
                </button>
              );
            })}
          </div>

          <div key={active} className="animate-fade-in">
            <h2 className="mx-auto mt-6 max-w-md font-display text-3xl uppercase leading-tight tracking-tight">
              {t(`forWomenMen.${active}.title`)}
            </h2>
            <p className="mx-auto mt-3 max-w-md text-neutral-400">{t(`forWomenMen.${active}.description`)}</p>
            <div className="mt-6 flex flex-wrap justify-center gap-2">
              {activeTags.map(({ icon: Icon, key }) => (
                <span
                  key={key}
                  className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/60 px-3 py-1.5 text-sm text-neutral-200"
                >
                  <Icon size={14} className={active === "women" ? "text-pink-400" : "text-info"} />
                  {t(`forWomenMen.${active}.tags.${key}`)}
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Компьютер: две колонки по краям фото */}
        <div className="hidden lg:grid lg:grid-cols-2 lg:gap-16">
          {/* Для женщин */}
          <div className="lg:max-w-[23rem]">
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
          <div className="lg:ml-auto lg:max-w-[23rem] lg:text-right">
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

        <div className="mt-10 flex justify-center lg:mt-40">
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
