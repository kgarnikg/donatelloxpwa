import { useRef, useState } from "react";
import { useTranslation } from "react-i18next";
import { MapPin, Check } from "lucide-react";
import clsx from "clsx";
import { useOnClickOutside } from "@/lib/useOnClickOutside";
import { useRegion } from "@/context/RegionContext";
import type { Region } from "@/lib/regionPricing";

const REGION_KEYS: { value: Region; labelKey: string; flag: string }[] = [
  { value: "ru", labelKey: "regionSwitcher.russia", flag: "🇷🇺" },
  { value: "eu", labelKey: "regionSwitcher.europe", flag: "🇪🇺" },
  { value: "us", labelKey: "regionSwitcher.usa", flag: "🇺🇸" },
];

/**
 * variant="fixed" (по умолчанию, десктоп) — плавает внизу справа поверх
 * всей страницы, меню открывается вверх.
 * variant="inline" (мобильный хедер) — обычный элемент в потоке, рядом с
 * кнопкой гамбургер-меню, меню открывается вниз (иначе бы вылезало за
 * пределы экрана сверху). См. Header.tsx — там же лежит и LanguageSwitcher
 * с тем же паттерном, оба нужны были на мобильном раньше внизу справа, где
 * перекрывали контент Hero (кнопки/соц.доказательство/стрелку).
 *
 * Названия регионов — через t(), не зашиты на русском: раньше "Россия"/
 * "Европа"/"США" были литеральными русскими строками, посетитель из
 * испаноязычной страны видел баннер выбора региона по-русски, даже если
 * весь остальной сайт уже был на испанском (язык устройства). Баг найден
 * пользователем на реальном трафике.
 */
export function RegionSwitcher({ variant = "fixed" }: { variant?: "fixed" | "inline" }) {
  const { t } = useTranslation();
  const { region, setRegion } = useRegion();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);
  useOnClickOutside(ref, () => setOpen(false));

  const options = REGION_KEYS.map((o) => ({ ...o, label: t(o.labelKey) }));
  const current = options.find((o) => o.value === region) ?? options[2];
  const isInline = variant === "inline";

  const menu = open && (
    <div
      className={clsx(
        "w-40 rounded-xl border border-ink-700 bg-ink-900/95 p-1.5 shadow-glow backdrop-blur",
        isInline ? "absolute right-0 top-full mt-2" : "mb-2",
      )}
    >
      {options.map((opt) => (
        <button
          key={opt.value}
          onClick={() => {
            setRegion(opt.value);
            setOpen(false);
          }}
          className={clsx(
            "flex w-full items-center justify-between rounded-lg px-3 py-2 text-left text-sm transition",
            region === opt.value ? "bg-volt-400/10 text-volt-400" : "text-neutral-300 hover:bg-ink-800",
          )}
        >
          <span className="flex items-center gap-2">
            <span>{opt.flag}</span>
            {opt.label}
          </span>
          {region === opt.value && <Check size={14} />}
        </button>
      ))}
    </div>
  );

  const trigger = (
    <button
      onClick={() => setOpen((v) => !v)}
      className="flex items-center gap-1.5 rounded-full border border-ink-700 bg-ink-900/90 px-3.5 py-2.5 text-xs font-semibold text-neutral-200 shadow-lg backdrop-blur transition hover:border-volt-400/50"
      aria-label={t("regionSwitcher.ariaLabel")}
    >
      <MapPin size={14} className="text-volt-400" />
      {current.flag}
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
    <div ref={ref} className="fixed bottom-5 right-[4.75rem] z-50">
      {menu}
      {trigger}
    </div>
  );
}
