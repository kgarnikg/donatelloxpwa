import { useEffect, useMemo, useState } from "react";
import { useTranslation } from "react-i18next";
import { ChevronDown } from "lucide-react";
import { DIAL_CODES, flagEmoji } from "@/lib/dialCodes";
import { detectCountry } from "@/lib/detectRegion";

interface PhoneInputProps {
  /** Номер в международном формате "+37491234567" ("" — пусто). */
  value: string | undefined;
  onChange: (e164: string) => void;
  /** Страна из формы: пока код не меняли руками, он следует за ней. */
  country?: string;
  invalid?: boolean;
  id?: string;
}

/**
 * Телефон: слева код страны (флаг + "+374", выпадающий список всех стран),
 * справа сам номер. Код подставляется по стране посетителя (IP) или по
 * выбранной в форме стране; поменять можно в любой момент. Наружу отдаём
 * номер в формате E.164: "+" + код + цифры (ведущий 0 национального формата
 * отбрасываем — "091 23 45 67" в Армении → +37491234567).
 */
export function PhoneInput({ value, onChange, country, invalid, id }: PhoneInputProps) {
  const { i18n } = useTranslation();
  const [iso, setIso] = useState<string>(() => (country && DIAL_CODES[country] ? country : ""));
  const [touchedCode, setTouchedCode] = useState(false);
  const [local, setLocal] = useState(() => {
    if (!value) return "";
    const dial = iso ? DIAL_CODES[iso] : "";
    return dial && value.startsWith(`+${dial}`) ? value.slice(dial.length + 1) : value;
  });

  const options = useMemo(() => {
    let names: Intl.DisplayNames | null = null;
    try {
      names = new Intl.DisplayNames([i18n.language], { type: "region" });
    } catch {
      names = null;
    }
    const collator = new Intl.Collator(i18n.language);
    return Object.keys(DIAL_CODES)
      .map((code) => ({ code, name: names?.of(code) ?? code }))
      .sort((a, b) => collator.compare(a.name, b.name));
  }, [i18n.language]);

  // Код ещё не выбран — по IP
  useEffect(() => {
    if (iso) return;
    let cancelled = false;
    detectCountry().then((code) => {
      if (!cancelled && code && DIAL_CODES[code]) setIso((prev) => prev || code);
    });
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps -- один раз
  }, []);

  // Выбрали страну в форме — код следует за ней, пока его не меняли руками
  useEffect(() => {
    if (!touchedCode && country && DIAL_CODES[country]) setIso(country);
  }, [country, touchedCode]);

  // Собираем номер при любом изменении кода или цифр
  useEffect(() => {
    const raw = local.trim();
    if (!raw) {
      if (value) onChange("");
      return;
    }
    let next: string;
    if (raw.startsWith("+")) {
      next = "+" + raw.replace(/\D/g, "");
    } else {
      let digits = raw.replace(/\D/g, "");
      if (iso !== "IT") digits = digits.replace(/^0+/, "");
      // код страны ещё не выбран — номер неполный (форма попросит выбрать код)
      next = iso ? `+${DIAL_CODES[iso]}${digits}` : "";
    }
    if (next !== value) onChange(next);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [iso, local]);

  return (
    <div className="flex gap-2">
      <div className="relative shrink-0">
        <div
          className={
            "input-field pointer-events-none flex h-full items-center gap-1.5 pe-7 tabular-nums" +
            (invalid ? " border-danger" : "")
          }
        >
          {iso ? (
            <>
              <span className="text-base leading-none">{flagEmoji(iso)}</span>
              <span>+{DIAL_CODES[iso]}</span>
            </>
          ) : (
            <span className="text-neutral-500">+…</span>
          )}
        </div>
        <ChevronDown size={14} className="pointer-events-none absolute end-2.5 top-1/2 -translate-y-1/2 text-neutral-500" />
        <select
          aria-label="Country code"
          value={iso}
          onChange={(e) => {
            setTouchedCode(true);
            setIso(e.target.value);
          }}
          className="absolute inset-0 cursor-pointer opacity-0"
        >
          {!iso && <option value="">+…</option>}
          {options.map((o) => (
            <option key={o.code} value={o.code}>
              {flagEmoji(o.code)} {o.name} +{DIAL_CODES[o.code]}
            </option>
          ))}
        </select>
      </div>
      <input
        id={id}
        type="tel"
        inputMode="tel"
        autoComplete="tel-national"
        value={local}
        onChange={(e) => setLocal(e.target.value)}
        aria-invalid={invalid || undefined}
        placeholder="91 234 567"
        className="input-field min-w-0 flex-1"
      />
    </div>
  );
}
