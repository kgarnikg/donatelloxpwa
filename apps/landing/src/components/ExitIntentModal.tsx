import { X } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useExitIntent } from "@/hooks/useExitIntent";
import { APP_URL } from "@/lib/appUrl";

export function ExitIntentModal() {
  const { t } = useTranslation();
  const { show, dismiss } = useExitIntent();

  if (!show) return null;

  return (
    <div
      className="fixed inset-0 z-[60] flex animate-fade-in items-center justify-center bg-black/70 px-4"
      onClick={dismiss}
    >
      <div
        className="card relative w-full max-w-sm rounded-2xl border-volt-400/40 bg-gradient-to-br from-volt-400/10 via-ink-900 to-ink-900 p-8 text-center shadow-[0_0_60px_rgba(168,224,0,0.15)]"
        onClick={(e) => e.stopPropagation()}
      >
        <button
          onClick={dismiss}
          aria-label={t("common.close")}
          className="absolute right-4 top-4 flex h-8 w-8 items-center justify-center rounded-full bg-ink-800 text-neutral-400 transition hover:bg-ink-700 hover:text-neutral-100"
        >
          <X size={16} />
        </button>

        <span className="eyebrow">{t("exitIntent.eyebrow")}</span>
        <h2 className="mt-2 font-display text-2xl font-bold">{t("exitIntent.title")}</h2>
        <p className="mt-3 text-neutral-400">{t("exitIntent.subtitle")}</p>

        <a
          href={`${APP_URL}/register`}
          className="btn-primary mx-auto mt-6 w-full justify-center shadow-[0_0_30px_rgba(168,224,0,0.3)]"
        >
          {t("exitIntent.button")}
        </a>
        <button onClick={dismiss} className="mt-3 text-sm text-neutral-500 hover:text-neutral-300">
          {t("exitIntent.noThanks")}
        </button>
      </div>
    </div>
  );
}
