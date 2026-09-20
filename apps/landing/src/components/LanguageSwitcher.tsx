import { useRef, useState } from "react";
import { useTranslation } from "react-i18next";
import { Globe, Check } from "lucide-react";
import clsx from "clsx";
import { useOnClickOutside } from "@/lib/useOnClickOutside";
import { SUPPORTED_LANGUAGES, LANGUAGE_LABELS, type SupportedLanguage } from "@/i18n";

/** См. комментарий в RegionSwitcher.tsx — тот же паттерн fixed/inline. */
export function LanguageSwitcher({ variant = "fixed" }: { variant?: "fixed" | "inline" }) {
  const { i18n } = useTranslation();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);
  useOnClickOutside(ref, () => setOpen(false));

  const current = (i18n.language as SupportedLanguage) || "ru";
  const isInline = variant === "inline";

  function selectLanguage(code: SupportedLanguage) {
    i18n.changeLanguage(code);
    setOpen(false);
  }

  const menu = open && (
    <div
      className={clsx(
        "max-h-72 w-44 overflow-y-auto rounded-xl border border-ink-700 bg-ink-900/95 p-1.5 shadow-glow backdrop-blur",
        isInline ? "absolute right-0 top-full mt-2" : "mb-2",
      )}
    >
      {SUPPORTED_LANGUAGES.map((lang) => (
        <button
          key={lang}
          onClick={() => selectLanguage(lang)}
          className={clsx(
            "flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm transition",
            current === lang ? "bg-volt-400/10 text-volt-400" : "text-neutral-300 hover:bg-ink-800",
          )}
        >
          {LANGUAGE_LABELS[lang]}
          {current === lang && <Check size={14} />}
        </button>
      ))}
    </div>
  );

  const trigger = (
    <button
      onClick={() => setOpen((v) => !v)}
      className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/90 px-3.5 py-2.5 text-xs font-semibold text-neutral-200 shadow-lg backdrop-blur transition hover:border-volt-400/50"
      aria-label="Выбрать язык"
    >
      <Globe size={14} className="text-volt-400" />
      {current.toUpperCase()}
    </button>
  );

  if (isInline) {
    return (
      <div ref={ref} className="relative">
        {trigger}
        {menu}
      </div>
    );
  }

  return (
    <div ref={ref} className="fixed bottom-5 right-5 z-50">
      {menu}
      {trigger}
    </div>
  );
}
