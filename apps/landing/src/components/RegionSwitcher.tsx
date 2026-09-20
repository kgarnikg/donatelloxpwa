import { useRef, useState } from "react";
import { MapPin, Check } from "lucide-react";
import clsx from "clsx";
import { useOnClickOutside } from "@/lib/useOnClickOutside";
import { useRegion } from "@/context/RegionContext";
import type { Region } from "@/lib/regionPricing";

const OPTIONS: { value: Region; label: string; flag: string }[] = [
  { value: "ru", label: "Россия", flag: "🇷🇺" },
  { value: "eu", label: "Европа", flag: "🇪🇺" },
  { value: "us", label: "США", flag: "🇺🇸" },
];

/**
 * variant="fixed" (по умолчанию, десктоп) — плавает внизу справа поверх
 * всей страницы, меню открывается вверх.
 * variant="inline" (мобильный хедер) — обычный элемент в потоке, рядом с
 * кнопкой гамбургер-меню, меню открывается вниз (иначе бы вылезало за
 * пределы экрана сверху). См. Header.tsx — там же лежит и LanguageSwitcher
 * с тем же паттерном, оба нужны были на мобильном раньше внизу справа, где
 * перекрывали контент Hero (кнопки/соц.доказательство/стрелку).
 */
export function RegionSwitcher({ variant = "fixed" }: { variant?: "fixed" | "inline" }) {
  const { region, setRegion } = useRegion();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);
  useOnClickOutside(ref, () => setOpen(false));

  const current = OPTIONS.find((o) => o.value === region) ?? OPTIONS[2];
  const isInline = variant === "inline";

  const menu = open && (
    <div
      className={clsx(
        "w-40 rounded-xl border border-ink-700 bg-ink-900/95 p-1.5 shadow-glow backdrop-blur",
        isInline ? "absolute right-0 top-full mt-2" : "mb-2",
      )}
    >
      {OPTIONS.map((opt) => (
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
      aria-label="Выбрать регион"
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
