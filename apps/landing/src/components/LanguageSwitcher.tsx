import { useEffect, useRef, useState } from "react";
import { Globe, Check } from "lucide-react";
import clsx from "clsx";

const LANGUAGE_STORAGE_KEY = "donatellox-language";

const LANGUAGES = [
  { code: "ru", label: "Русский" },
  { code: "en", label: "English" },
  { code: "es", label: "Español" },
  { code: "de", label: "Deutsch" },
  { code: "it", label: "Italiano" },
  { code: "uk", label: "Українська" },
  { code: "hy", label: "Հայերեն" },
  { code: "ar", label: "العربية" },
  { code: "hi", label: "हिन्दी" },
  { code: "pa", label: "ਪੰਜਾਬੀ" },
] as const;

/**
 * Лендинг сам остаётся на русском (это маркетинговая страница), но выбор
 * языка здесь сохраняется и подхватывается веб-приложением при переходе —
 * так человек сразу попадает в интерфейс на нужном ему языке.
 */
export function LanguageSwitcher() {
  const [open, setOpen] = useState(false);
  const [selected, setSelected] = useState<string>("ru");
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const stored = localStorage.getItem(LANGUAGE_STORAGE_KEY);
    if (stored) setSelected(stored);
  }, []);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  function selectLanguage(code: string) {
    setSelected(code);
    localStorage.setItem(LANGUAGE_STORAGE_KEY, code);
    setOpen(false);
  }

  const current = LANGUAGES.find((l) => l.code === selected) ?? LANGUAGES[0];

  return (
    <div ref={ref} className="fixed bottom-5 right-5 z-50">
      {open && (
        <div className="mb-2 max-h-72 w-44 overflow-y-auto rounded-xl border border-ink-700 bg-ink-900/95 p-1.5 shadow-glow backdrop-blur">
          {LANGUAGES.map((lang) => (
            <button
              key={lang.code}
              onClick={() => selectLanguage(lang.code)}
              className={clsx(
                "flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm transition",
                selected === lang.code
                  ? "bg-volt-400/10 text-volt-400"
                  : "text-neutral-300 hover:bg-ink-800",
              )}
            >
              {lang.label}
              {selected === lang.code && <Check size={14} />}
            </button>
          ))}
        </div>
      )}

      <button
        onClick={() => setOpen((v) => !v)}
        className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/90 px-3.5 py-2.5 text-xs font-semibold text-neutral-200 shadow-lg backdrop-blur transition hover:border-volt-400/50"
        aria-label="Выбрать язык приложения"
      >
        <Globe size={14} className="text-volt-400" />
        {current.code.toUpperCase()}
      </button>
    </div>
  );
}
