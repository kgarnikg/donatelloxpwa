// POST /api/create-checkout — начать оплату через vPOS Америабанка.
//
// Браузер присылает только ВЫБОР человека (план, регион, язык, галочку
// оферты). Сумму считает сервер по тем же ценам, что на сайте
// (@donatellox/types → pricing.ts), со скидкой из базы, а не из браузера.
// Ответ: { redirectUrl } — страница оплаты банка.
//
// Тестовый режим (VPOS_TEST_MODE=true): платить могут только админы, сумма
// всегда 10 ֏ — так требует тестовая среда банка.
import { getPayableAmount, isRegion, PURCHASABLE_PLANS, REGION_CURRENCY, type PurchasablePlan } from "@donatellox/types";
import {
  authUser,
  env,
  json,
  rpc,
  toMajor,
  vpos,
  vposBaseUrl,
  vposConfigured,
  vposLang,
  vposTestMode,
  VPOS_CURRENCY_CODE,
} from "./_lib/vpos";

export const config = { runtime: "edge" };

const PLAN_TITLE: Record<PurchasablePlan, string> = {
  monthly: "1 month",
  quarterly: "3 months",
  semiannual: "6 months",
  annual: "12 months",
};

/** Сколько списывать в тестовой среде банка: 10 ֏ (в минорных единицах) */
const TEST_AMOUNT_MINOR = 1000;

export default async function handler(request: Request): Promise<Response> {
  if (request.method !== "POST") return json({ message: "Method not allowed" }, 405);
  if (!vposConfigured()) return json({ message: "Оплата ещё не подключена" }, 503);

  const user = await authUser(request);
  if (!user) return json({ message: "Войдите в аккаунт заново" }, 401);

  const testMode = vposTestMode();
  if (testMode && !user.isAdmin) {
    return json({ message: "Оплата скоро заработает" }, 403);
  }

  const body = (await request.json().catch(() => ({}))) as {
    plan?: string;
    region?: string;
    language?: string;
    acceptTerms?: boolean;
    immediateStartConsent?: boolean;
  };
  const plan = PURCHASABLE_PLANS.find((p) => p === body.plan);
  if (!plan || !isRegion(body.region)) return json({ message: "Неверный тариф" }, 400);
  if (body.acceptTerms !== true) return json({ message: "Нужно принять условия оферты" }, 400);

  const currency = testMode ? "AMD" : REGION_CURRENCY[body.region];
  const discount = user.pendingDiscountPercent;
  const amount = testMode ? TEST_AMOUNT_MINOR : getPayableAmount(body.region, plan, discount);

  try {
    const created = await rpc<{ payment_id: string; order_id: number }>("vpos_create_payment", {
      p_user_id: user.id,
      p_plan: plan,
      p_currency: currency,
      p_amount: amount,
      p_discount_percent: testMode ? 0 : discount,
      p_consent: body.immediateStartConsent === true,
      p_is_test: testMode,
    });

    const origin = env("APP_URL") || new URL(request.url).origin;
    const init = await vpos<{ PaymentID?: string; ResponseCode?: number | string; ResponseMessage?: string }>(
      "InitPayment",
      {
        ClientID: env("VPOS_CLIENT_ID"),
        Amount: toMajor(amount),
        Currency: VPOS_CURRENCY_CODE[currency],
        OrderID: created.order_id,
        BackURL: `${origin}/api/payment-return`,
        Description: `DonatelleX — ${PLAN_TITLE[plan]}${testMode ? " (test)" : ""}`,
        Opaque: created.payment_id,
      },
    );

    if (String(init.ResponseCode) !== "1" || !init.PaymentID) {
      await rpc("vpos_payment_failed", {
        p_payment_id: created.payment_id,
        p_details: { step: "InitPayment", ResponseCode: init.ResponseCode, ResponseMessage: init.ResponseMessage },
      });
      console.error("InitPayment отклонён:", init.ResponseCode, init.ResponseMessage);
      return json({ message: "Банк не принял платёж. Попробуйте ещё раз чуть позже." }, 502);
    }

    await rpc("vpos_attach_bank_payment", { p_payment_id: created.payment_id, p_bank_payment_id: init.PaymentID });

    const redirectUrl = `${vposBaseUrl()}Payments/Pay?id=${encodeURIComponent(init.PaymentID)}&lang=${vposLang(body.language)}`;
    return json({ redirectUrl });
  } catch (err) {
    console.error("create-checkout:", err);
    return json({ message: "Не удалось начать оплату. Попробуйте ещё раз." }, 500);
  }
}
