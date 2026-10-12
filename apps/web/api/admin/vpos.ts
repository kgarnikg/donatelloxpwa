// POST /api/admin/vpos — действия админа с платежом vPOS Америабанка.
// Вызывается из админки (admin.donatellex.com), поэтому с CORS.
//
// Тело: { paymentId, action, amount? }
//   action = "check"  — заново спросить банк (если человек оплатил, а доступ
//                        не открылся — например, закрыл вкладку до возврата);
//   action = "cancel" — отменить оплату целиком (CancelPayment; банк
//                        разрешает в течение 72 часов);
//   action = "refund" — вернуть деньги (RefundPayment); amount — сколько, в
//                        минорных единицах; без amount — весь остаток.
// После полной отмены/возврата доступ за этот период закрывается
// (vpos_payment_reversed), заявка на возврат помечается "деньги возвращены".
import {
  authUser,
  detailsForLog,
  isDeposited,
  json,
  paymentBy,
  rpc,
  toMajor,
  vpos,
  vposConfigured,
  type VposPaymentDetails,
} from "../_lib/vpos";

export const config = { runtime: "edge" };

const ALLOWED_ORIGINS = ["https://admin.donatellex.com", "http://localhost:5174", "http://localhost:5173"];

function cors(request: Request): Record<string, string> {
  const origin = request.headers.get("origin") ?? "";
  const ok = ALLOWED_ORIGINS.includes(origin) || /^https:\/\/donatelloxpwa-admin[\w-]*\.vercel\.app$/.test(origin);
  return ok
    ? {
        "access-control-allow-origin": origin,
        "access-control-allow-methods": "POST, OPTIONS",
        "access-control-allow-headers": "authorization, content-type",
        "access-control-max-age": "600",
        vary: "origin",
      }
    : { vary: "origin" };
}

export default async function handler(request: Request): Promise<Response> {
  const headers = cors(request);
  if (request.method === "OPTIONS") return new Response(null, { status: 204, headers });
  if (request.method !== "POST") return json({ message: "Method not allowed" }, 405, headers);
  if (!vposConfigured()) return json({ message: "vPOS не настроен (нет переменных VPOS_* на Vercel)" }, 503, headers);

  const admin = await authUser(request);
  if (!admin?.isAdmin) return json({ message: "Недостаточно прав" }, 403, headers);

  const body = (await request.json().catch(() => ({}))) as { paymentId?: string; action?: string; amount?: number };
  if (!body.paymentId || !["check", "cancel", "refund"].includes(body.action ?? "")) {
    return json({ message: "Неверный запрос" }, 400, headers);
  }

  try {
    const payment = await paymentBy("id", body.paymentId);
    if (!payment) return json({ message: "Платёж не найден" }, 404, headers);
    if (payment.provider_payment_id.startsWith("order-")) {
      return json({ message: "Платёж не дошёл до банка" }, 409, headers);
    }
    const bankId = payment.provider_payment_id;

    if (body.action === "check") {
      const d = await vpos<VposPaymentDetails>("GetPaymentDetails", { PaymentID: bankId });
      const paidMinor = Math.round(Number(d.DepositedAmount || d.Amount || 0) * 100);
      if (isDeposited(d) && paidMinor === Math.round(Number(payment.amount)) && payment.status !== "confirmed") {
        await rpc("vpos_payment_paid", { p_payment_id: payment.id, p_details: detailsForLog(d) });
        return json({ message: "Оплата подтверждена, доступ открыт", details: detailsForLog(d) }, 200, headers);
      }
      return json({ message: "Статус в банке", details: detailsForLog(d) }, 200, headers);
    }

    if (payment.status !== "confirmed") {
      return json({ message: "Отменить или вернуть можно только подтверждённый платёж" }, 409, headers);
    }

    if (body.action === "cancel") {
      const r = await vpos<{ ResponseCode?: string; ResponseMessage?: string }>("CancelPayment", { PaymentID: bankId });
      if (String(r.ResponseCode) !== "00") {
        return json({ message: `Банк не отменил платёж: ${r.ResponseMessage ?? r.ResponseCode}` }, 502, headers);
      }
      const res = await rpc("vpos_payment_reversed", {
        p_payment_id: payment.id,
        p_kind: "cancel",
        p_amount: payment.amount,
        p_details: { ResponseCode: r.ResponseCode, ResponseMessage: r.ResponseMessage, by: admin.id },
      });
      return json({ message: "Платёж отменён", result: res }, 200, headers);
    }

    // refund
    const left = Math.round(Number(payment.amount) - Number(payment.refunded_amount ?? 0));
    const amount = Math.round(Number(body.amount ?? left));
    if (!(amount > 0) || amount > left) {
      return json({ message: `Сумма возврата должна быть от 0 до ${left / 100}` }, 400, headers);
    }
    const r = await vpos<{ ResponseCode?: string; ResponseMessage?: string }>("RefundPayment", {
      PaymentID: bankId,
      Amount: toMajor(amount),
    });
    if (String(r.ResponseCode) !== "00") {
      return json({ message: `Банк не выполнил возврат: ${r.ResponseMessage ?? r.ResponseCode}` }, 502, headers);
    }
    const res = await rpc("vpos_payment_reversed", {
      p_payment_id: payment.id,
      p_kind: "refund",
      p_amount: amount,
      p_details: { ResponseCode: r.ResponseCode, ResponseMessage: r.ResponseMessage, amount, by: admin.id },
    });
    return json({ message: "Деньги возвращены", result: res }, 200, headers);
  } catch (err) {
    console.error("admin/vpos:", err);
    return json({ message: err instanceof Error ? err.message : "Ошибка" }, 500, headers);
  }
}
