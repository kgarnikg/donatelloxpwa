import { useEffect, useMemo } from "react";
import { useTranslation } from "react-i18next";
import { detectCountry } from "@/lib/detectRegion";

/** ISO 3166-1 alpha-2 — названия стран берём из Intl на языке интерфейса. */
const COUNTRY_CODES = [
  "AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AR", "AS", "AT", "AU", "AW", "AX",
  "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BL", "BM", "BN", "BO",
  "BQ", "BR", "BS", "BT", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CH", "CI",
  "CK", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CW", "CX", "CY", "CZ", "DE", "DJ",
  "DK", "DM", "DO", "DY", "DZ", "EC", "EE", "EG", "EH", "ER", "ES", "ET", "FI", "FJ",
  "FK", "FM", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GG", "GH", "GI", "GL", "GM",
  "GN", "GP", "GQ", "GR", "GT", "GU", "GW", "GY", "HK", "HN", "HR", "HT", "HU", "HV",
  "ID", "IE", "IL", "IM", "IN", "IQ", "IR", "IS", "IT", "JE", "JM", "JO", "JP", "KE",
  "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LI",
  "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH",
  "MK", "ML", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX",
  "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NH", "NI", "NL", "NO", "NP", "NR", "NU",
  "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL", "PM", "PN", "PR", "PS", "PT",
  "PW", "PY", "QA", "RE", "RH", "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SE",
  "SG", "SH", "SI", "SJ", "SK", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX",
  "SY", "SZ", "TC", "TD", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TR", "TT",
  "TV", "TW", "TZ", "UA", "UG", "UK", "US", "UY", "UZ", "VA", "VC", "VD", "VE", "VG",
  "VI", "VN", "VU", "WF", "WS", "XK", "YE", "YT", "ZA", "ZM", "ZW",
];

interface CountrySelectProps {
  value: string | undefined;
  onChange: (code: string) => void;
  /** Подставить страну посетителя (по IP, api/geo.ts), если ещё не выбрана. */
  autoDetect?: boolean;
  invalid?: boolean;
  id?: string;
}

/**
 * Выбор страны (регистрация, анкета). Названия — на языке интерфейса через
 * Intl.DisplayNames, отсортированы по алфавиту этого языка; сохраняется
 * ISO-код ("ES", "AM"). Страна посетителя подставляется сама, но её можно
 * поменять.
 */
export function CountrySelect({ value, onChange, autoDetect = true, invalid, id }: CountrySelectProps) {
  const { t, i18n } = useTranslation();

  const options = useMemo(() => {
    let names: Intl.DisplayNames | null = null;
    try {
      names = new Intl.DisplayNames([i18n.language], { type: "region" });
    } catch {
      names = null;
    }
    const collator = new Intl.Collator(i18n.language);
    return COUNTRY_CODES.map((code) => ({ code, name: names?.of(code) ?? code })).sort((a, b) =>
      collator.compare(a.name, b.name),
    );
  }, [i18n.language]);

  useEffect(() => {
    if (!autoDetect || value) return;
    let cancelled = false;
    detectCountry().then((code) => {
      if (!cancelled && code && COUNTRY_CODES.includes(code)) onChange(code);
    });
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps -- один раз при открытии
  }, [autoDetect]);

  return (
    <select
      id={id}
      className={"input-field appearance-none" + (value ? "" : " text-neutral-500")}
      value={value ?? ""}
      aria-invalid={invalid || undefined}
      onChange={(e) => onChange(e.target.value)}
    >
      <option value="" disabled>
        {t("auth.register.countryPlaceholder")}
      </option>
      {options.map((o) => (
        <option key={o.code} value={o.code} className="text-neutral-0">
          {o.name}
        </option>
      ))}
    </select>
  );
}
