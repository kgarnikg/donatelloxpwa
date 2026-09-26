// ---------------------------------------------------------------------------
// Цены — единственный источник правды
// ---------------------------------------------------------------------------
//
// Раньше цены жили только в `apps/landing/src/lib/regionPricing.ts` и
// отдельно (другими, захардкоженными строками) в `SubscriptionPage.tsx`
// приложения. Теперь все три места — лендинг, приложение и будущая
// серверная функция создания оплаты — берут цифры отсюда.
//
// ВАЖНО для сервера: сумма к оплате считается ТОЛЬКО на сервере по этой
// таблице (план + регион + скидка из БД). Сумму, пришедшую из браузера,
// не используем никогда — её можно подменить.
//
// Суммы хранятся в минорных единицах (центы/копейки), чтобы не ловить
// ошибки округления float (19.99 * 0.5 и т.п.).

import type { SubscriptionPlan } from "./index";

/**
 * "lifetime" — безлимитный доступ, выдаётся только вручную в CMS (подарок),
 * никогда не продаётся — поэтому в таблицах цен его нет.
 */
export type PurchasablePlan = Exclude<SubscriptionPlan, "lifetime">;

export const PURCHASABLE_PLANS: readonly PurchasablePlan[] = [
  "monthly",
  "quarterly",
  "semiannual",
  "annual",
];

/** Сколько месяцев доступа даёт каждый период. */
export const PLAN_MONTHS: Record<PurchasablePlan, number> = {
  monthly: 1,
  quarterly: 3,
  semiannual: 6,
  annual: 12,
};

/**
 * "am" — Армения, цены в драмах. Нужен для армянского банка (ИП в Армении,
 * эквайринг Араратбанка): на сайте обязана быть версия с ценами в AMD, и
 * посетители из Армении должны видеть её автоматически.
 */
export type Region = "am" | "us" | "eu" | "ru";

export const REGIONS: readonly Region[] = ["am", "eu", "us", "ru"];

export function isRegion(value: unknown): value is Region {
  return value === "am" || value === "us" || value === "eu" || value === "ru";
}

/** Валюта ОТОБРАЖЕНИЯ цены в регионе. Валюта списания определяется банком (см. PROJECT_PLAN, Фаза 3). */
export type DisplayCurrency = "USD" | "EUR" | "RUB" | "AMD";

export const REGION_CURRENCY: Record<Region, DisplayCurrency> = {
  am: "AMD",
  us: "USD",
  eu: "EUR",
  ru: "RUB",
};

export const CURRENCY_SYMBOL: Record<DisplayCurrency, string> = {
  AMD: "֏",
  USD: "$",
  EUR: "€",
  RUB: "₽",
};

export interface PlanPrice {
  /** Сумма за весь период, в минорных единицах. */
  total: number;
  /** Эквивалент за месяц — для подписи "N / мес.". */
  perMonth: number;
  /** Зачёркнутая "старая" цена, если период идёт со скидкой. */
  original?: number;
}

// Цифры одинаковые в $ и € (простая, предсказуемая локализация цены по
// образцу многих SaaS); для России — отдельная, психологически круглая
// рублёвая сетка вместо прямой конвертации по курсу.
const USD_EUR_PRICES: Record<PurchasablePlan, PlanPrice> = {
  monthly: { total: 1999, perMonth: 1999 },
  quarterly: { total: 4500, perMonth: 1500, original: 6000 },
  semiannual: { total: 7190, perMonth: 1190, original: 11990 },
  annual: { total: 9690, perMonth: 808, original: 24000 },
};

const RUB_PRICES: Record<PurchasablePlan, PlanPrice> = {
  monthly: { total: 199000, perMonth: 199000 },
  quarterly: { total: 449000, perMonth: 149700, original: 597000 },
  semiannual: { total: 719000, perMonth: 119800, original: 1199000 },
  annual: { total: 969000, perMonth: 80800, original: 2400000 },
};

// Армения — своя круглая сетка в драмах (не прямая конвертация по курсу),
// скидки те же: -25% / -40% / -60% от цены помесячной оплаты.
const AMD_PRICES: Record<PurchasablePlan, PlanPrice> = {
  monthly: { total: 790000, perMonth: 790000 },
  quarterly: { total: 1779000, perMonth: 593000, original: 2370000 },
  semiannual: { total: 2849000, perMonth: 475000, original: 4740000 },
  annual: { total: 3790000, perMonth: 316000, original: 9480000 },
};

export function getRegionPrices(
  region: Region,
): Record<PurchasablePlan, PlanPrice> {
  if (region === "am") return AMD_PRICES;
  return region === "ru" ? RUB_PRICES : USD_EUR_PRICES;
}

/**
 * Реферальная скидка (`users.pending_discount_percent`) по условиям
 * программы — "50% на первый месяц", поэтому применяется только к
 * месячному периоду. Если условия поменяются — менять здесь, это же
 * правило использует сервер.
 */
export function isDiscountApplicable(plan: PurchasablePlan): boolean {
  return plan === "monthly";
}

/** Итоговая сумма к оплате (минорные единицы) с учётом скидки. Округление вниз — в пользу клиента. */
export function getPayableAmount(
  region: Region,
  plan: PurchasablePlan,
  discountPercent = 0,
): number {
  const base = getRegionPrices(region)[plan].total;
  if (!discountPercent || !isDiscountApplicable(plan)) return base;
  const pct = Math.min(Math.max(Math.trunc(discountPercent), 0), 100);
  return Math.floor((base * (100 - pct)) / 100);
}

/**
 * Форматирует минорные единицы в строку вида "19,99", "11,90", "45", "1 990":
 * десятичная запятая, пробел между тысячами; ",00" у целых сумм не пишем,
 * но копейки/центы всегда двумя цифрами ("11,90", а не "11,9"). Намеренно не Intl.NumberFormat — нужен один и тот же вид цены
 * на всех 10 языках (так было на лендинге изначально).
 */
export function formatMinorAmount(minor: number): string {
  const negative = minor < 0;
  const abs = Math.abs(Math.round(minor));
  const whole = Math.floor(abs / 100);
  const cents = abs % 100;
  const wholeStr =
    whole >= 1000
      ? String(whole).replace(/\B(?=(\d{3})+(?!\d))/g, " ")
      : String(whole);
  let fraction = "";
  if (cents > 0) {
    fraction = "," + String(cents).padStart(2, "0");
  }
  return `${negative ? "-" : ""}${wholeStr}${fraction}`;
}

export function formatRegionPrice(region: Region, minor: number): string {
  return `${formatMinorAmount(minor)} ${CURRENCY_SYMBOL[REGION_CURRENCY[region]]}`;
}

/** Определяет регион по языку браузера (эвристика, не геолокация). */
export function guessRegionFromLanguage(language: string | undefined): Region {
  const lang = language?.toLowerCase() ?? "";
  if (lang.startsWith("hy")) return "am";
  if (lang.startsWith("ru") || lang.startsWith("uk")) return "ru";
  const euLangs = ["de", "it", "es", "fr", "pt", "nl", "pl"];
  if (euLangs.some((l) => lang.startsWith(l))) return "eu";
  return "us";
}

// Страны ЕС + ЕЭЗ/Швейцария/Великобритания — показываем цены в евро.
const EU_COUNTRIES = new Set([
  "AT", "BE", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
  "HU", "IE", "IT", "LV", "LT", "LU", "MT", "NL", "PL", "PT", "RO", "SK",
  "SI", "ES", "SE", "IS", "LI", "NO", "CH", "GB", "AD", "MC", "SM", "VA",
  "ME", "RS", "AL", "MK", "BA", "MD",
]);
// Страны, где привычнее цены в рублях.
const RUB_COUNTRIES = new Set(["RU", "BY", "KZ", "KG", "UZ", "TJ", "TM", "AZ", "GE", "UA"]);

/**
 * Регион по коду страны (ISO 3166-1 alpha-2, например из заголовка
 * Vercel `x-vercel-ip-country`). null — страну не знаем, решает эвристика.
 */
export function regionFromCountry(country: string | null | undefined): Region | null {
  const c = (country ?? "").trim().toUpperCase();
  if (!/^[A-Z]{2}$/.test(c)) return null;
  if (c === "AM") return "am";
  if (RUB_COUNTRIES.has(c)) return "ru";
  if (EU_COUNTRIES.has(c)) return "eu";
  return "us";
}

/**
 * Быстрая догадка без сети: часовой пояс устройства "Asia/Yerevan" —
 * почти наверняка Армения (язык браузера у армянских пользователей
 * часто русский или английский). Иначе — по языку браузера.
 */
export function guessRegionFromDevice(language: string | undefined): Region {
  try {
    const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    if (tz === "Asia/Yerevan") return "am";
  } catch {
    // Intl недоступен — просто идём по языку
  }
  return guessRegionFromLanguage(language);
}
