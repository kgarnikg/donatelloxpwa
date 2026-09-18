import { ArrowRight } from "lucide-react";
import { useTranslation } from "react-i18next";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

export function CallToAction() {
  const { t } = useTranslation();

  return (
    <section className="py-20 sm:py-28">
      <div className="section-container">
        <div className="card relative overflow-hidden rounded-2xl border-volt-400/30 bg-gradient-to-br from-volt-400/15 via-ink-900 to-ink-900 px-8 py-16 text-center shadow-[0_0_60px_rgba(168,224,0,0.12)] sm:px-16">
          <h2 className="font-display text-3xl font-bold sm:text-5xl">{t("cta.title")}</h2>
          <p className="mx-auto mt-4 max-w-md text-neutral-400">{t("cta.subtitle")}</p>
          <a
            href={`${APP_URL}/register`}
            className="btn-primary mx-auto mt-8 w-fit shadow-[0_0_30px_rgba(168,224,0,0.3)]"
          >
            {t("cta.button")} <ArrowRight size={18} />
          </a>
          <p className="mt-4 text-xs text-neutral-500">{t("cta.noCard")}</p>
        </div>
      </div>
    </section>
  );
}
