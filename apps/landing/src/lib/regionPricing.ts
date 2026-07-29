import type { SubscriptionPlan } from "@donatellox/types";

export type Region = "us" | "eu" | "ru";

export const REGION_STORAGE_KEY = "donatellox-region";

export const REGION_LABELS: Record<Region, string> = {
  us: "США",
  eu: "Европа",
  ru: "Россия",
};

interface PlanAmounts {
  /** Основная сумма (то, что списывается за период плана). */
  main: string;
  /** Число, которое подставляется в шаблон "{{amount}} / мес." и т.п. */
  perMonthAmount: string;
  /** Число для зачёркнутой "старой" цены, если есть скидка. */
  originalAmount?: string;
}

// Цифры одинаковые во всех валютах (простая, предсказуемая локализация цены
// по образцу многих SaaS) — для России взята отдельная, психологически
// круглая рублёвая сетка вместо прямой конвертации по курсу.
const US_EU_AMOUNTS: Record<SubscriptionPlan, PlanAmounts> = {
  monthly: { main: "19,99", perMonthAmount: "19,99" },
  quarterly: { main: "45", perMonthAmount: "15", originalAmount: "60" },
  semiannual: { main: "71,9", perMonthAmount: "11,9", originalAmount: "119,9" },
  annual: { main: "96,9", perMonthAmount: "8,08", originalAmount: "240" },
};

const RU_AMOUNTS: Record<SubscriptionPlan, PlanAmounts> = {
  monthly: { main: "1 990", perMonthAmount: "1 990" },
  quarterly: { main: "4 490", perMonthAmount: "1 497", originalAmount: "5 970" },
  semiannual: { main: "7 190", perMonthAmount: "1 198", originalAmount: "11 990" },
  annual: { main: "9 690", perMonthAmount: "808", originalAmount: "24 000" },
};

const CURRENCY_SYMBOL: Record<Region, string> = { us: "$", eu: "€", ru: "₽" };

export function formatAmount(region: Region, value: string): string {
  return `${value} ${CURRENCY_SYMBOL[region]}`;
}

export function getRegionAmounts(region: Region): Record<SubscriptionPlan, PlanAmounts> {
  return region === "ru" ? RU_AMOUNTS : US_EU_AMOUNTS;
}

export const REGION_PAYMENT_METHODS: Record<Region, string[]> = {
  us: ["Card · Stripe", "PayPal", "USDT"],
  eu: ["Card · Stripe", "PayPal", "USDT"],
  ru: ["ЮKassa · карты РФ", "СБП", "USDT"],
};

/** Определяет регион по языку браузера при самом первом визите (эвристика, не точная геолокация). */
export function guessRegionFromLocale(): Region {
  const lang = navigator.language?.toLowerCase() ?? "";
  if (lang.startsWith("ru") || lang.startsWith("uk") || lang.startsWith("hy")) return "ru";
  const euLangs = ["de", "it", "es", "fr", "pt", "nl", "pl"];
  if (euLangs.some((l) => lang.startsWith(l))) return "eu";
  return "us";
}
