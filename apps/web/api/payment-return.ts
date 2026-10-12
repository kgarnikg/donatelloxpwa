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
    return new Response(JSON.stringify({ result: path.endsWith("success") ? "success" : "failed" }), {
      headers: { "content-type": "application/json; charset=utf-8", "cache-control": "no-store" },
    });
  }
  return Response.redirect(new URL(path, request.url).toString(), 303);
}

async function details(paymentId: string): Promise<VposPaymentDetails> {
  return vpos<VposPaymentDetails>("GetPaymentDetails", { PaymentID: paymentId });
}

export default async function handler(request: Request): Promise<Response> {
  const url = new URL(request.url);
  const q = (name: string) => url.searchParams.get(name) ?? url.searchParams.get(name.toLowerCase()) ?? "";
  const bankPaymentId = q("paymentID");
  if (!bankPaymentId) return redirect(request, "/payment/failed");

  try {
    const payment = await paymentBy("provider_payment_id", bankPaymentId);
    if (!payment) {
      console.error("payment-return: платёж не найден", bankPaymentId);
      return redirect(request, "/payment/failed");
    }
    if (payment.status === "confirmed") return redirect(request, "/payment/success");

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
    const paidMinor = Math.round(Number(d.DepositedAmount || d.Amount || 0) * 100);
    const sameOrder = d.OrderID === undefined || String(d.OrderID) === String(payment.bank_order_id);

    if (isDeposited(d) && paidMinor === expected && sameOrder) {
      await rpc("vpos_payment_paid", { p_payment_id: payment.id, p_details: detailsForLog(d) });
      return redirect(request, "/payment/success");
    }

    console.warn("payment-return: оплата не подтверждена", {
      payment: payment.id,
      responseCode: d.ResponseCode,
      orderStatus: d.OrderStatus,
      paidMinor,
      expected,
    });
    await rpc("vpos_payment_failed", { p_payment_id: payment.id, p_details: detailsForLog(d) });
    return redirect(request, "/payment/failed");
  } catch (err) {
    console.error("payment-return:", err);
    return redirect(request, "/payment/failed");
  }
}
