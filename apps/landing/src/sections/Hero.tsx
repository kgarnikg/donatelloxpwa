import { ArrowRight, PlayCircle, ChevronDown, Check, X } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useRegion } from "@/context/RegionContext";
import { getRegionAmounts, formatAmount } from "@/lib/regionPricing";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");
const SHOWREEL_URL = import.meta.env.VITE_SHOWREEL_URL as string | undefined;

const AVATAR_COLORS = ["bg-volt-400", "bg-ember-400", "bg-info", "bg-warning", "bg-success"];

export function Hero() {
  const { t } = useTranslation();
  const { region } = useRegion();
  const [showreelOpen, setShowreelOpen] = useState(false);

  const cheapest = getRegionAmounts(region).annual;
  // Целое число дней в месяце — достаточно точно для маркетингового "меньше X в день",
  // не претендует на бухгалтерскую точность.
  const perDay = (Number(cheapest.perMonthAmount.replace(/\s/g, "").replace(",", ".")) / 30).toFixed(2);

  const checklist = [
    t("hero.checklist.personalized"),
    t("hero.checklist.results"),
    t("hero.checklist.price", { price: formatAmount(region, cheapest.perMonthAmount), perDay: formatAmount(region, perDay) }),
    t("hero.checklist.flexible"),
  ];

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
      <div className="absolute inset-0 bg-gradient-to-b from-ink-950/85 via-ink-950/75 to-ink-950" />
      <div className="absolute inset-0 bg-grid-fade opacity-40" />

      <div className="section-container relative flex flex-col items-center py-20 text-center sm:py-28">
        <span className="eyebrow mb-4 animate-fade-in">{t("hero.eyebrow")}</span>

        <h1 className="max-w-4xl animate-fade-in font-display text-4xl uppercase leading-[1.05] tracking-tight sm:text-6xl lg:text-7xl">
          {t("hero.titleLine1")}
          <br />
          {t("hero.titleLine2Pre")} <span className="text-volt-400">{t("hero.titleLine2Highlight")}</span>
          <br />
          {t("hero.titleLine3")}
        </h1>

        <p className="mt-6 max-w-xl animate-fade-in text-lg text-neutral-300">{t("hero.subtitle")}</p>

        {/* Чек-лист в духе референса — коротко, по делу, каждый пункт правда. */}
        <ul className="mt-7 flex animate-fade-in flex-col gap-2.5 text-left sm:items-start">
          {checklist.map((item) => (
            <li key={item} className="flex items-center gap-2.5 text-neutral-200">
              <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-volt-400/15 text-volt-400">
                <Check size={13} strokeWidth={3} />
              </span>
              {item}
            </li>
          ))}
        </ul>

        <div className="mt-8 flex animate-fade-in flex-col gap-3 sm:flex-row">
          <a
            href={`${APP_URL}/register`}
            className="btn-primary transition-transform duration-200 hover:scale-105 hover:shadow-[0_0_36px_rgba(168,224,0,0.45)]"
          >
            {t("hero.ctaPrimary")} <ArrowRight size={18} />
          </a>
          {SHOWREEL_URL ? (
            <button onClick={() => setShowreelOpen(true)} className="btn-secondary">
              <PlayCircle size={18} /> {t("hero.ctaSecondary")}
            </button>
          ) : (
            <a href="#modules" className="btn-secondary">
              <PlayCircle size={18} /> {t("hero.ctaSecondary")}
            </a>
          )}
        </div>

        <p className="mt-6 text-sm text-neutral-400">{t("hero.disclaimer")}</p>

        {/* Социальное доказательство — стилизованные аватары (не выдаём себя за
            реальные фото пользователей без их согласия), число — по решению
            владельца продукта, не выдумано автоматически. */}
        <div className="mt-8 flex animate-fade-in items-center gap-3">
          <div className="flex -space-x-2">
            {AVATAR_COLORS.map((color, i) => (
              <div
                key={i}
                className={`flex h-8 w-8 items-center justify-center rounded-full border-2 border-ink-950 text-xs font-bold text-ink-950 ${color}`}
              >
                {String.fromCharCode(65 + i)}
              </div>
            ))}
          </div>
          <span className="text-sm text-neutral-400">{t("hero.socialProof")}</span>
        </div>
      </div>

      {SHOWREEL_URL && showreelOpen && (
        <div
          className="fixed inset-0 z-50 flex animate-fade-in items-center justify-center bg-black/85 p-4"
          onClick={() => setShowreelOpen(false)}
        >
          <div className="w-full max-w-2xl" onClick={(e) => e.stopPropagation()}>
            <button
              onClick={() => setShowreelOpen(false)}
              aria-label={t("common.close")}
              className="mb-2 ml-auto flex h-9 w-9 items-center justify-center rounded-full bg-ink-800 text-neutral-300 hover:bg-ink-700"
            >
              <X size={18} />
            </button>
            <video src={SHOWREEL_URL} controls autoPlay className="w-full rounded-lg" />
          </div>
        </div>
      )}

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
