import { createContext, useContext, useEffect, useState, type ReactNode } from "react";
import { type Region, REGION_STORAGE_KEY, guessRegionFromLocale } from "@/lib/regionPricing";

interface RegionContextValue {
  region: Region;
  setRegion: (region: Region) => void;
  /** true, пока ещё не показали/не дождались выбора при первом визите. */
  isReady: boolean;
}

const RegionContext = createContext<RegionContextValue | undefined>(undefined);

export function RegionProvider({ children }: { children: ReactNode }) {
  const [region, setRegionState] = useState<Region>("us");
  const [isReady, setIsReady] = useState(false);
  const [showPicker, setShowPicker] = useState(false);

  useEffect(() => {
    const stored = localStorage.getItem(REGION_STORAGE_KEY) as Region | null;
    if (stored === "us" || stored === "eu" || stored === "ru") {
      setRegionState(stored);
      setIsReady(true);
    } else {
      // Ещё не выбирали — подставляем эвристику по языку браузера как
      // предзаполненный вариант в модалке, но просим подтвердить явно.
      setRegionState(guessRegionFromLocale());
      setShowPicker(true);
      setIsReady(true);
    }
  }, []);

  function setRegion(next: Region) {
    setRegionState(next);
    localStorage.setItem(REGION_STORAGE_KEY, next);
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

const REGION_OPTIONS: { value: Region; label: string; flag: string }[] = [
  { value: "ru", label: "Россия", flag: "🇷🇺" },
  { value: "eu", label: "Европа", flag: "🇪🇺" },
  { value: "us", label: "США", flag: "🇺🇸" },
];

function RegionPickerModal({
  current,
  onSelect,
}: {
  current: Region;
  onSelect: (region: Region) => void;
}) {
  return (
    <div className="fixed inset-0 z-[60] flex items-end justify-center bg-black/70 p-4 sm:items-center">
      <div className="w-full max-w-sm rounded-2xl border border-ink-700 bg-ink-900 p-6 text-center animate-fade-in">
        <h2 className="font-display text-lg font-bold">Выберите ваш регион</h2>
        <p className="mt-1.5 text-sm text-neutral-400">
          Чтобы показать цены и способы оплаты в правильной валюте
        </p>

        <div className="mt-5 space-y-2">
          {REGION_OPTIONS.map((opt) => (
            <button
              key={opt.value}
              onClick={() => onSelect(opt.value)}
              className={
                "flex w-full items-center gap-3 rounded-md border px-4 py-3 text-left font-medium transition " +
                (current === opt.value
                  ? "border-volt-400 bg-volt-400/10 text-volt-300"
                  : "border-ink-600 bg-ink-800 text-neutral-200 hover:border-ink-500")
              }
            >
              <span className="text-xl">{opt.flag}</span>
              {opt.label}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
