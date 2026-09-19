import { ArrowRight, PlayCircle, ChevronDown } from "lucide-react";
import { useTranslation } from "react-i18next";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

export function Hero() {
  const { t } = useTranslation();

  return (
    <section id="top" className="relative flex min-h-dvh items-center overflow-hidden pt-20">
      <video
        className="absolute inset-0 h-full w-full object-cover"
        src="/video/hero-video.mp4"
        autoPlay
        muted
        loop
        playsInline
        preload="auto"
        aria-hidden="true"
      />
      <div className="absolute inset-0 bg-gradient-to-b from-ink-950/80 via-ink-950/70 to-ink-950" />
      <div className="absolute inset-0 bg-grid-fade opacity-40" />

      <div className="section-container relative flex flex-col items-center py-20 text-center sm:py-28">
        <span className="eyebrow mb-4 animate-fade-in">{t("hero.eyebrow")}</span>
        <h1 className="max-w-3xl animate-fade-in font-display text-4xl font-bold leading-tight sm:text-6xl">
          {t("hero.titleLine1")}
          <br />
          <span className="text-volt-400">{t("hero.titleLine2")}</span>
        </h1>
        <p className="mt-6 max-w-xl animate-fade-in text-lg text-neutral-300">{t("hero.subtitle")}</p>

        <div className="mt-8 flex animate-fade-in flex-col gap-3 sm:flex-row">
          <a href={`${APP_URL}/register`} className="btn-primary">
            {t("hero.ctaPrimary")} <ArrowRight size={18} />
          </a>
          <a href="#modules" className="btn-secondary">
            <PlayCircle size={18} /> {t("hero.ctaSecondary")}
          </a>
        </div>

        <p className="mt-6 text-sm text-neutral-400">{t("hero.disclaimer")}</p>
      </div>

      {/* Подсказка "листай дальше" — многие не понимают, что страница длинная.
          Кликабельна (скроллит к следующему блоку), анимация мягкая и медленная,
          чтобы не раздражала, но была явно живой, а не статичной иконкой. */}
      <a
        href="#modules"
        className="absolute bottom-6 left-1/2 flex -translate-x-1/2 flex-col items-center gap-1.5 text-neutral-400 transition hover:text-volt-400 animate-[bounce_2.2s_ease-in-out_infinite]"
        aria-label={t("hero.scrollHint")}
      >
        <span className="text-xs font-medium uppercase tracking-widest">{t("hero.scrollHint")}</span>
        <ChevronDown size={22} />
      </a>
    </section>
  );
}
