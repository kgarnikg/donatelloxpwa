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

export type Region = "us" | "eu" | "ru";

export const REGIONS: readonly Region[] = ["eu", "us", "ru"];

/** Валюта ОТОБРАЖЕНИЯ цены в регионе. Валюта списания определяется банком (см. PROJECT_PLAN, Фаза 3). */
export const REGION_CURRENCY: Record<Region, "USD" | "EUR" | "RUB"> = {
  us: "USD",
  eu: "EUR",
  ru: "RUB",
};

export const CURRENCY_SYMBOL: Record<"USD" | "EUR" | "RUB", string> = {
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

export function getRegionPrices(
  region: Region,
): Record<PurchasablePlan, PlanPrice> {
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
 * Форматирует минорные единицы в строку вида "19,99", "45", "1 990":
 * десятичная запятая, пробел между тысячами, без лишних нулей после
 * запятой. Намеренно не Intl.NumberFormat — нужен один и тот же вид цены
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
    fraction = "," + String(cents).padStart(2, "0").replace(/0$/, "");
  }
  return `${negative ? "-" : ""}${wholeStr}${fraction}`;
}

export function formatRegionPrice(region: Region, minor: number): string {
  return `${formatMinorAmount(minor)} ${CURRENCY_SYMBOL[REGION_CURRENCY[region]]}`;
}

/** Определяет регион по языку браузера (эвристика, не геолокация). */
export function guessRegionFromLanguage(language: string | undefined): Region {
  const lang = language?.toLowerCase() ?? "";
  if (lang.startsWith("ru") || lang.startsWith("uk") || lang.startsWith("hy"))
    return "ru";
  const euLangs = ["de", "it", "es", "fr", "pt", "nl", "pl"];
  if (euLangs.some((l) => lang.startsWith(l))) return "eu";
  return "us";
}
