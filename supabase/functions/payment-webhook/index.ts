// supabase/functions/payment-webhook/index.ts
//
// Единая точка входа для вебхуков всех платежных провайдеров DonatelleX:
// Stripe, PayPal, ЮKassa и подтверждений собственного USDT-кошелька.
//
// Провайдер определяется query-параметром `?provider=` в URL вебхука,
// который нужно указать в настройках каждого платежного провайдера, например:
//   https://<project-ref>.supabase.co/functions/v1/payment-webhook?provider=stripe
//   https://<project-ref>.supabase.co/functions/v1/payment-webhook?provider=paypal
//   https://<project-ref>.supabase.co/functions/v1/payment-webhook?provider=yookassa
//   https://<project-ref>.supabase.co/functions/v1/payment-webhook?provider=usdt
//
// Каждый провайдер проверяется своим способом (см. verifyXxx ниже) ДО того,
// как тело запроса используется для изменения данных — это ключевое
// требование безопасности для вебхуков платежей.

import { createClient, type SupabaseClient } from "jsr:@supabase/supabase-js@2";

// ---------------------------------------------------------------------------
// Конфигурация окружения
// ---------------------------------------------------------------------------

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const STRIPE_WEBHOOK_SECRET = Deno.env.get("STRIPE_WEBHOOK_SECRET") ?? "";
const PAYPAL_WEBHOOK_ID = Deno.env.get("PAYPAL_WEBHOOK_ID") ?? "";
const PAYPAL_API_BASE = Deno.env.get("PAYPAL_API_BASE") ?? "https://api-m.paypal.com";
const PAYPAL_CLIENT_ID = Deno.env.get("PAYPAL_CLIENT_ID") ?? "";
const PAYPAL_CLIENT_SECRET = Deno.env.get("PAYPAL_CLIENT_SECRET") ?? "";
const YOOKASSA_SHOP_ID = Deno.env.get("YOOKASSA_SHOP_ID") ?? "";
const YOOKASSA_SECRET_KEY = Deno.env.get("YOOKASSA_SECRET_KEY") ?? "";
// Общий секрет, которым мы подписываем запросы с нашего собственного
// USDT-сервиса мониторинга кошелька (не с блокчейна напрямую).
const USDT_WEBHOOK_SECRET = Deno.env.get("USDT_WEBHOOK_SECRET") ?? "";

type PaymentProvider = "stripe" | "paypal" | "yookassa" | "usdt";

interface NormalizedPaymentEvent {
  /** Внешний ID платежа/транзакции у провайдера — используется как ключ идемпотентности. */
  providerPaymentId: string;
  provider: PaymentProvider;
  status: "pending" | "confirmed" | "failed" | "refunded" | "expired";
  amount: number;
  currency: "EUR" | "USD" | "RUB" | "USDT";
  /** ID пользователя из наших метаданных (передаётся при создании чекаута). */
  userId?: string;
  subscriptionId?: string;
  cryptoTxHash?: string;
  cryptoNetwork?: "TRC20" | "ERC20" | "BEP20";
  rawPayload: Record<string, unknown>;
}

// ---------------------------------------------------------------------------
// Вспомогательные функции проверки подписи
// ---------------------------------------------------------------------------

/** Конвертирует hex-строку в Uint8Array — нужно для сравнения HMAC-подписей. */
function hexToBytes(hex: string): Uint8Array {
  const clean = hex.replace(/[^0-9a-fA-F]/g, "");
  const bytes = new Uint8Array(clean.length / 2);
  for (let i = 0; i < bytes.length; i++) {
    bytes[i] = parseInt(clean.substr(i * 2, 2), 16);
  }
  return bytes;
}

/** Сравнение в постоянное время — защита от timing-атак при сверке подписей. */
function timingSafeEqual(a: Uint8Array, b: Uint8Array): boolean {
  if (a.length !== b.length) return false;
  let diff = 0;
  for (let i = 0; i < a.length; i++) diff |= a[i] ^ b[i];
  return diff === 0;
}

async function hmacSha256Hex(secret: string, payload: string): Promise<string> {
  const key = await crypto.subtle.importKey(
    "raw",
    new TextEncoder().encode(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(payload));
  return Array.from(new Uint8Array(signature))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

/**
 * Проверка подписи Stripe (заголовок `Stripe-Signature`).
 * Формат: `t=<timestamp>,v1=<signature>[,v0=<legacy>]`.
 * Подписываемая строка — `${timestamp}.${rawBody}`.
 */
async function verifyStripeSignature(rawBody: string, header: string | null): Promise<boolean> {
  if (!STRIPE_WEBHOOK_SECRET) {
    console.error("STRIPE_WEBHOOK_SECRET не задан — отклоняем вебхук Stripe.");
    return false;
  }
  if (!header) return false;

  const parts = Object.fromEntries(
    header.split(",").map((kv) => {
      const [k, v] = kv.split("=");
      return [k, v];
    }),
  );
  const timestamp = parts["t"];
  const expectedSig = parts["v1"];
  if (!timestamp || !expectedSig) return false;

  // Защита от replay-атак: отклоняем события старше 5 минут.
  const age = Math.abs(Date.now() / 1000 - Number(timestamp));
  if (Number.isNaN(age) || age > 300) {
    console.error("Вебхук Stripe отклонён: подпись просрочена");
    return false;
  }

  const signedPayload = `${timestamp}.${rawBody}`;
  const computedSig = await hmacSha256Hex(STRIPE_WEBHOOK_SECRET, signedPayload);

  return timingSafeEqual(hexToBytes(computedSig), hexToBytes(expectedSig));
}

/**
 * Проверка вебхука PayPal через официальный API верификации подписи.
 * PayPal не использует простой HMAC — требуется обратный вызов
 * `/v1/notifications/verify-webhook-signature` с ключами транспорта.
 */
async function verifyPaypalSignature(
  rawBody: string,
  headers: Headers,
): Promise<boolean> {
  if (!PAYPAL_CLIENT_ID || !PAYPAL_CLIENT_SECRET || !PAYPAL_WEBHOOK_ID) {
    console.error("PayPal не сконфигурирован — отклоняем вебхук.");
    return false;
  }

  try {
    const tokenRes = await fetch(`${PAYPAL_API_BASE}/v1/oauth2/token`, {
      method: "POST",
      headers: {
        Authorization: `Basic ${btoa(`${PAYPAL_CLIENT_ID}:${PAYPAL_CLIENT_SECRET}`)}`,
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: "grant_type=client_credentials",
    });
    if (!tokenRes.ok) return false;
    const { access_token } = await tokenRes.json();

    const verifyRes = await fetch(
      `${PAYPAL_API_BASE}/v1/notifications/verify-webhook-signature`,
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          transmission_id: headers.get("paypal-transmission-id"),
          transmission_time: headers.get("paypal-transmission-time"),
          cert_url: headers.get("paypal-cert-url"),
          auth_algo: headers.get("paypal-auth-algo"),
          transmission_sig: headers.get("paypal-transmission-sig"),
          webhook_id: PAYPAL_WEBHOOK_ID,
          webhook_event: JSON.parse(rawBody),
        }),
      },
    );
    if (!verifyRes.ok) return false;
    const result = await verifyRes.json();
    return result.verification_status === "SUCCESS";
  } catch (err) {
    console.error("Ошибка проверки подписи PayPal:", err);
    return false;
  }
}

/**
 * ЮKassa не подписывает тело запроса — рекомендованная схема защиты:
 * IP-allowlist (список публикуется ЮKassa) в сочетании с проверкой платежа
 * через обратный GET-запрос к их API по Basic Auth (shopId:secretKey).
 * Здесь мы делаем серверную проверку статуса объекта платежа/выплаты,
 * что надёжнее, чем доверять телу вебхука напрямую.
 */
async function verifyAndFetchYookassaPayment(
  paymentId: string,
): Promise<Record<string, unknown> | null> {
  if (!YOOKASSA_SHOP_ID || !YOOKASSA_SECRET_KEY) {
    console.error("ЮKassa не сконфигурирована — отклоняем вебхук.");
    return null;
  }
  try {
    const res = await fetch(`https://api.yookassa.ru/v3/payments/${paymentId}`, {
      headers: {
        Authorization: `Basic ${btoa(`${YOOKASSA_SHOP_ID}:${YOOKASSA_SECRET_KEY}`)}`,
      },
    });
    if (!res.ok) return null;
    return await res.json();
  } catch (err) {
    console.error("Ошибка проверки платежа ЮKassa:", err);
    return null;
  }
}

/**
 * Подтверждения USDT приходят не из блокчейна напрямую, а от нашего
 * внутреннего сервиса-наблюдателя за кошельком (см. `usdtConfirmationSchema`
 * в @donatellox/validation), который сам проверяет транзакцию в сети
 * (TRC20/ERC20/BEP20) и подписывает свой запрос общим секретом.
 */
async function verifyUsdtSignature(rawBody: string, header: string | null): Promise<boolean> {
  if (!USDT_WEBHOOK_SECRET) {
    console.error("USDT_WEBHOOK_SECRET не задан — отклоняем вебхук USDT.");
    return false;
  }
  if (!header) return false;
  const expected = await hmacSha256Hex(USDT_WEBHOOK_SECRET, rawBody);
  return timingSafeEqual(hexToBytes(expected), hexToBytes(header));
}

// ---------------------------------------------------------------------------
// Парсинг событий каждого провайдера в единый формат
// ---------------------------------------------------------------------------

function mapStripeStatus(eventType: string): NormalizedPaymentEvent["status"] {
  if (eventType === "checkout.session.completed" || eventType === "payment_intent.succeeded") {
    return "confirmed";
  }
  if (eventType === "payment_intent.payment_failed") return "failed";
  if (eventType === "charge.refunded") return "refunded";
  return "pending";
}

function parseStripeEvent(payload: any): NormalizedPaymentEvent {
  const obj = payload.data?.object ?? {};
  return {
    provider: "stripe",
    providerPaymentId: obj.id,
    status: mapStripeStatus(payload.type),
    amount: (obj.amount_total ?? obj.amount ?? 0) / 100,
    currency: (obj.currency ?? "eur").toUpperCase() as NormalizedPaymentEvent["currency"],
    userId: obj.metadata?.user_id ?? obj.client_reference_id,
    subscriptionId: obj.metadata?.subscription_id,
    rawPayload: payload,
  };
}

function mapPaypalStatus(eventType: string): NormalizedPaymentEvent["status"] {
  if (eventType === "PAYMENT.CAPTURE.COMPLETED" || eventType === "CHECKOUT.ORDER.APPROVED") {
    return "confirmed";
  }
  if (eventType === "PAYMENT.CAPTURE.DENIED") return "failed";
  if (eventType === "PAYMENT.CAPTURE.REFUNDED") return "refunded";
  return "pending";
}

function parsePaypalEvent(payload: any): NormalizedPaymentEvent {
  const resource = payload.resource ?? {};
  const amount = resource.amount ?? resource.purchase_units?.[0]?.amount ?? {};
  return {
    provider: "paypal",
    providerPaymentId: resource.id,
    status: mapPaypalStatus(payload.event_type),
    amount: Number(amount.value ?? 0),
    currency: (amount.currency_code ?? "EUR") as NormalizedPaymentEvent["currency"],
    userId: resource.custom_id ?? payload.resource?.purchase_units?.[0]?.custom_id,
    rawPayload: payload,
  };
}

function mapYookassaStatus(status: string): NormalizedPaymentEvent["status"] {
  if (status === "succeeded") return "confirmed";
  if (status === "canceled") return "failed";
  return "pending";
}

function parseYookassaEvent(paymentObject: any): NormalizedPaymentEvent {
  return {
    provider: "yookassa",
    providerPaymentId: paymentObject.id,
    status: mapYookassaStatus(paymentObject.status),
    amount: Number(paymentObject.amount?.value ?? 0),
    currency: (paymentObject.amount?.currency ?? "RUB") as NormalizedPaymentEvent["currency"],
    userId: paymentObject.metadata?.user_id,
    subscriptionId: paymentObject.metadata?.subscription_id,
    rawPayload: paymentObject,
  };
}

function parseUsdtEvent(payload: any): NormalizedPaymentEvent {
  return {
    provider: "usdt",
    providerPaymentId: payload.txHash,
    status: payload.confirmed ? "confirmed" : "pending",
    amount: Number(payload.amount ?? 0),
    currency: "USDT",
    userId: payload.userId,
    subscriptionId: payload.subscriptionId,
    cryptoTxHash: payload.txHash,
    cryptoNetwork: payload.network,
    rawPayload: payload,
  };
}

// ---------------------------------------------------------------------------
// Запись в базу данных (идемпотентно, по provider_payment_id)
// ---------------------------------------------------------------------------

async function upsertPaymentEvent(supabase: SupabaseClient, event: NormalizedPaymentEvent) {
  const { data: payment, error: upsertError } = await supabase
    .from("payments")
    .upsert(
      {
        provider: event.provider,
        provider_payment_id: event.providerPaymentId,
        user_id: event.userId ?? null,
        subscription_id: event.subscriptionId ?? null,
        amount: event.amount,
        currency: event.currency,
        status: event.status,
        crypto_tx_hash: event.cryptoTxHash ?? null,
        crypto_network: event.cryptoNetwork ?? null,
        raw_payload: event.rawPayload,
        confirmed_at: event.status === "confirmed" ? new Date().toISOString() : null,
      },
      { onConflict: "provider,provider_payment_id" },
    )
    .select()
    .single();

  if (upsertError) {
    throw new Error(`Не удалось сохранить платёж: ${upsertError.message}`);
  }

  // При подтверждённом платеже продлеваем/активируем подписку.
  if (event.status === "confirmed" && event.subscriptionId) {
    const { error: subError } = await supabase.rpc("activate_subscription_from_payment", {
      p_subscription_id: event.subscriptionId,
      p_payment_id: payment.id,
    });
    if (subError) {
      // Не бросаем ошибку дальше: платёж уже надёжно сохранён и его можно
      // обработать вручную/повторно — провайдеру не нужно повторять вебхук.
      console.error("Не удалось активировать подписку после оплаты:", subError.message);
    }
  }

  return payment;
}

// ---------------------------------------------------------------------------
// Обработчик HTTP-запроса
// ---------------------------------------------------------------------------

Deno.serve(async (req: Request) => {
  if (req.method !== "POST") {
    return new Response("Method Not Allowed", { status: 405 });
  }

  const url = new URL(req.url);
  const provider = url.searchParams.get("provider") as PaymentProvider | null;

  if (!provider || !["stripe", "paypal", "yookassa", "usdt"].includes(provider)) {
    return new Response(
      JSON.stringify({ error: "Неизвестный или отсутствующий параметр ?provider=" }),
      { status: 400, headers: { "Content-Type": "application/json" } },
    );
  }

  const rawBody = await req.text();
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  try {
    let event: NormalizedPaymentEvent;

    switch (provider) {
      case "stripe": {
        const signature = req.headers.get("stripe-signature");
        const valid = await verifyStripeSignature(rawBody, signature);
        if (!valid) return new Response("Invalid signature", { status: 400 });
        event = parseStripeEvent(JSON.parse(rawBody));
        break;
      }

      case "paypal": {
        const valid = await verifyPaypalSignature(rawBody, req.headers);
        if (!valid) return new Response("Invalid signature", { status: 400 });
        event = parsePaypalEvent(JSON.parse(rawBody));
        break;
      }

      case "yookassa": {
        // ЮKassa шлёт объект уведомления с вложенным `object` (данными платежа).
        // Мы не доверяем телу вебхука напрямую — перепроверяем платёж через API.
        const notification = JSON.parse(rawBody);
        const paymentId = notification.object?.id;
        if (!paymentId) return new Response("Missing payment id", { status: 400 });

        const verifiedPayment = await verifyAndFetchYookassaPayment(paymentId);
        if (!verifiedPayment) return new Response("Could not verify payment", { status: 400 });

        event = parseYookassaEvent(verifiedPayment);
        break;
      }

      case "usdt": {
        const signature = req.headers.get("x-usdt-signature");
        const valid = await verifyUsdtSignature(rawBody, signature);
        if (!valid) return new Response("Invalid signature", { status: 400 });
        event = parseUsdtEvent(JSON.parse(rawBody));
        break;
      }
    }

    if (!event.providerPaymentId) {
      return new Response("Missing provider payment id", { status: 400 });
    }

    const payment = await upsertPaymentEvent(supabase, event);

    return new Response(JSON.stringify({ received: true, paymentId: payment.id }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    console.error(`Ошибка обработки вебхука ${provider}:`, err);
    return new Response(JSON.stringify({ error: "Internal error" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
