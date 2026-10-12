// GET /api/payment-return — проверка оплаты после возврата из банка.
// Банк возвращает человека на /payment/return (страница приложения), она
// вызывает эту функцию; прямой переход сюда тоже работает (редирект).
//
// Банк добавляет в адрес orderID, resposneCode (sic), paymentID, opaque.
// Им НЕ верим: по paymentID спрашиваем банк (GetPaymentDetails) и сверяем
// сумму с нашей записью. Только тогда открываем доступ (vpos_payment_paid)
// и отправляем на /payment/success; иначе — /payment/failed.
// Повторный заход (обновили страницу) доступ второй раз не продлевает.
import {
  detailsForLog,
  isApprovedOnly,
  isDeposited,
  paymentBy,
  rpc,
  vpos,
  type VposPaymentDetails,
} from "./_lib/vpos";

export const config = { runtime: "edge" };

// ?format=json — ответ для страницы приложения /payment/return (она зовёт
// эту функцию через fetch; так проверка работает даже у тех, у кого старый
// офлайн-кэш приложения перехватывал переход на /api/*).
function redirect(request: Request, path: string): Response {
  if (new URL(request.url).searchParams.get("format") === "json") {
    return new Response(
      JSON.stringify({
        result: path.endsWith("success") ? "success" : "failed",
      }),
      {
        headers: {
          "content-type": "application/json; charset=utf-8",
          "cache-control": "no-store",
        },
      },
    );
  }
  return Response.redirect(new URL(path, request.url).toString(), 303);
}

async function details(paymentId: string): Promise<VposPaymentDetails> {
  return vpos<VposPaymentDetails>("GetPaymentDetails", {
    PaymentID: paymentId,
  });
}

export default async function handler(request: Request): Promise<Response> {
  const url = new URL(request.url);
  // Имена параметров у банка пишутся по-разному (paymentID, PaymentID,
  // resposneCode…) — ищем без учёта регистра.
  const params = new Map<string, string>();
  url.searchParams.forEach((value, key) =>
    params.set(key.toLowerCase(), value),
  );
  const opaque = params.get("opaque") ?? "";
  const orderId = params.get("orderid") ?? "";
  const urlPaymentId = params.get("paymentid") ?? "";

  try {
    // Ищем наш платёж: по opaque (там наш id), по номеру заказа, по PaymentID
    // банка (без учёта регистра — банк может вернуть его строчными буквами).
    let payment = /^[0-9a-f-]{36}$/i.test(opaque)
      ? await paymentBy("id", opaque)
      : null;
    if (!payment && /^\d+$/.test(orderId))
      payment = await paymentBy("bank_order_id", orderId);
    if (!payment && urlPaymentId)
      payment = await paymentBy("provider_payment_id", urlPaymentId);
    if (!payment) {
      console.error(
        "payment-return: платёж не найден",
        Object.fromEntries(params),
      );
      return redirect(request, "/payment/failed");
    }
    if (payment.status === "confirmed")
      return redirect(request, "/payment/success");

    // Статус спрашиваем по PaymentID, который банк дал нам сам (InitPayment)
    const bankPaymentId = payment.provider_payment_id.startsWith("order-")
      ? urlPaymentId
      : payment.provider_payment_id;
    if (!bankPaymentId) return redirect(request, "/payment/failed");

    let d = await details(bankPaymentId);

    // Двухстадийная оплата: сумма заблокирована — списываем её
    if (isApprovedOnly(d)) {
      const confirm = await vpos<{ ResponseCode?: string }>("ConfirmPayment", {
        PaymentID: bankPaymentId,
        Amount: d.ApprovedAmount ?? d.Amount,
      });
      console.log("ConfirmPayment:", confirm.ResponseCode);
      d = await details(bankPaymentId);
    }

    const expected = Math.round(Number(payment.amount));
    const paidMinor = Math.round(
      Number(d.DepositedAmount || d.Amount || 0) * 100,
    );
    const sameOrder =
      d.OrderID === undefined ||
      String(d.OrderID) === String(payment.bank_order_id);

    if (isDeposited(d) && paidMinor === expected && sameOrder) {
      await rpc("vpos_payment_paid", {
        p_payment_id: payment.id,
        p_details: detailsForLog(d),
      });
      return redirect(request, "/payment/success");
    }

    console.warn("payment-return: оплата не подтверждена", {
      payment: payment.id,
      responseCode: d.ResponseCode,
      orderStatus: d.OrderStatus,
      paidMinor,
      expected,
    });
    await rpc("vpos_payment_failed", {
      p_payment_id: payment.id,
      p_details: detailsForLog(d),
    });
    return redirect(request, "/payment/failed");
  } catch (err) {
    console.error("payment-return:", err);
    return redirect(request, "/payment/failed");
  }
}
