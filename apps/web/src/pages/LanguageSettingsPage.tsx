import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, Check } from "lucide-react";
import clsx from "clsx";
import { SUPPORTED_LANGUAGES, LANGUAGE_LABELS, type SupportedLanguage } from "@/i18n";

export default function LanguageSettingsPage() {
  const { t, i18n } = useTranslation();
  const current = i18n.language as SupportedLanguage;

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8">
      <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ArrowLeft size={16} /> {t("common.back")}
      </Link>

      <h1 className="mb-1 font-display text-2xl font-bold">{t("language.title")}</h1>
      <p className="mb-6 text-neutral-400">{t("language.subtitle")}</p>

      <div className="card divide-y divide-ink-700 p-0">
        {SUPPORTED_LANGUAGES.map((lang) => (
          <button
            key={lang}
            onClick={() => i18n.changeLanguage(lang)}
            className="flex w-full items-center justify-between px-4 py-3.5 text-left hover:bg-ink-800"
          >
            <span className={clsx("font-medium", current === lang && "text-volt-400")}>
              {LANGUAGE_LABELS[lang]}
            </span>
            {current === lang && <Check size={18} className="text-volt-400" />}
          </button>
        ))}
      </div>
    </div>
  );
}
