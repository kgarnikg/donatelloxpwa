import {
  CURRENCY_SYMBOL,
  PURCHASABLE_PLANS,
  REGION_CURRENCY,
  formatMinorAmount,
  getRegionPrices,
  guessRegionFromLanguage,
  type PurchasablePlan,
  type Region,
} from "@donatellox/types";

export type { PurchasablePlan, Region };

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

// Сами цифры живут в общем пакете (`@donatellox/types`, pricing.ts) —
// тот же источник использует приложение и серверная функция оплаты,
// чтобы цена на лендинге не могла разойтись с суммой на чекауте.
function toDisplayAmounts(region: Region): Record<PurchasablePlan, PlanAmounts> {
  const prices = getRegionPrices(region);
  const out = {} as Record<PurchasablePlan, PlanAmounts>;
  for (const plan of PURCHASABLE_PLANS) {
    const p = prices[plan];
    out[plan] = {
      main: formatMinorAmount(p.total),
      perMonthAmount: formatMinorAmount(p.perMonth),
      ...(p.original !== undefined ? { originalAmount: formatMinorAmount(p.original) } : {}),
    };
  }
  return out;
}

export function formatAmount(region: Region, value: string): string {
  return `${value} ${CURRENCY_SYMBOL[REGION_CURRENCY[region]]}`;
}

export function getRegionAmounts(region: Region): Record<PurchasablePlan, PlanAmounts> {
  return toDisplayAmounts(region);
}

// Оплата — через vPOS Араратбанка (Фаза 3): карты Visa / Mastercard / ArCa.
// Принимаются ли российские карты — открытый вопрос к банку, поэтому для
// региона "ru" пока показываем то же самое, без обещаний про СБП/ЮKassa.
export const REGION_PAYMENT_METHODS: Record<Region, string[]> = {
  us: ["Visa", "Mastercard", "ArCa"],
  eu: ["Visa", "Mastercard", "ArCa"],
  ru: ["Visa", "Mastercard", "ArCa"],
};

/** Определяет регион по языку браузера при самом первом визите (эвристика, не точная геолокация). */
export function guessRegionFromLocale(): Region {
  return guessRegionFromLanguage(navigator.language);
}
