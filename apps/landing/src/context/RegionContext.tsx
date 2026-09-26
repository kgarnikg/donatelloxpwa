import { createContext, useContext, useEffect, useState, type ReactNode } from "react";
import { useTranslation } from "react-i18next";
import { isRegion } from "@donatellox/types";
import { type Region, REGION_STORAGE_KEY, guessRegionFromLocale } from "@/lib/regionPricing";
import { detectRegionByCountry } from "@/lib/detectRegion";

interface RegionContextValue {
  region: Region;
  setRegion: (region: Region) => void;
  /** true, пока ещё не показали/не дождались выбора при первом визите. */
  isReady: boolean;
}

const RegionContext = createContext<RegionContextValue | undefined>(undefined);

export function RegionProvider({ children }: { children: ReactNode }) {
  // Стартовая догадка без сети (часовой пояс Asia/Yerevan → Армения, иначе
  // язык браузера), чтобы цены сразу были в правильной валюте.
  const [region, setRegionState] = useState<Region>(() => guessRegionFromLocale());
  const [isReady, setIsReady] = useState(false);
  const [showPicker, setShowPicker] = useState(false);

  useEffect(() => {
    let stored: string | null = null;
    try {
      stored = localStorage.getItem(REGION_STORAGE_KEY);
    } catch {
      // приватный режим и т.п. — определяем заново
    }
    if (isRegion(stored)) {
      setRegionState(stored);
      setIsReady(true);
      return;
    }

    // Первый визит: страна по IP (Vercel). Если определилась — ставим
    // регион сам, без модалки (сменить можно в переключателе региона).
    // Так гость из Армении сразу видит цены в драмах. Если страну узнать
    // не удалось — как раньше: модалка с предвыбранной догадкой.
    let cancelled = false;
    detectRegionByCountry().then((byCountry) => {
      if (cancelled) return;
      if (byCountry) {
        setRegionState(byCountry);
        try {
          localStorage.setItem(REGION_STORAGE_KEY, byCountry);
        } catch {
          // не критично
        }
      } else {
        setShowPicker(true);
      }
      setIsReady(true);
    });
    return () => {
      cancelled = true;
    };
  }, []);

  function setRegion(next: Region) {
    setRegionState(next);
    try {
      localStorage.setItem(REGION_STORAGE_KEY, next);
    } catch {
      // не критично — регион просто не запомнится
    }
    setShowPicker(false);
  }

  return (
    <RegionContext.Provider value={{ region, setRegion, isReady }}>
      {children}
      {isReady && showPicker && <RegionPickerModal current={region} onSelect={setRegion} />}
    </RegionContext.Provider>
  );
}

// eslint-disable-next-line react-refresh/only-export-components -- хук намеренно живёт рядом с провайдером
export function useRegion(): RegionContextValue {
  const ctx = useContext(RegionContext);
  if (!ctx) throw new Error("useRegion должен использоваться внутри <RegionProvider>");
  return ctx;
}

// Порядок и названия — общие с переключателем региона (RegionSwitcher).
const REGION_OPTIONS: { value: Region; labelKey: string; flag: string }[] = [
  { value: "am", labelKey: "regionSwitcher.armenia", flag: "🇦🇲" },
  { value: "eu", labelKey: "regionSwitcher.europe", flag: "🇪🇺" },
  { value: "us", labelKey: "regionSwitcher.usa", flag: "🇺🇸" },
  { value: "ru", labelKey: "regionSwitcher.russia", flag: "🇷🇺" },
];

function RegionPickerModal({
  current,
  onSelect,
}: {
  current: Region;
  onSelect: (region: Region) => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="fixed inset-0 z-[60] flex items-end justify-center bg-black/70 p-4 sm:items-center">
      <div className="w-full max-w-sm rounded-2xl border border-ink-700 bg-ink-900 p-6 text-center animate-fade-in">
        <h2 className="font-display text-lg font-bold">{t("regionSwitcher.pickerTitle")}</h2>
        <p className="mt-1.5 text-sm text-neutral-400">
          {t("regionSwitcher.pickerSubtitle")}
        </p>

        <div className="mt-5 space-y-2">
          {REGION_OPTIONS.map((opt) => (
            <button
              key={opt.value}
              onClick={() => onSelect(opt.value)}
              className={
                "flex w-full items-center gap-3 rounded-md border px-4 py-3 text-start font-medium transition " +
                (current === opt.value
                  ? "border-volt-400 bg-volt-400/10 text-volt-300"
                  : "border-ink-600 bg-ink-800 text-neutral-200 hover:border-ink-500")
              }
            >
              <span className="text-xl">{opt.flag}</span>
              {t(opt.labelKey)}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
