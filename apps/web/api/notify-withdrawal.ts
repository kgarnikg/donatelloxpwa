// POST /api/notify-withdrawal — письмо админу сразу после того, как
// человек нажал "Отказаться от договора" (заявка уже создана в базе
// функцией request_withdrawal). Раньше о заявках приходила только сводка
// раз в день (cron/daily.ts) — она остаётся как напоминание.
//
// Письмо уходит, только если у вызывающего действительно есть свежая
// заявка (последние 10 минут), — так эндпоинт нельзя использовать для спама.
// Переменные: ADMIN_NOTIFY_EMAIL, RESEND_API_KEY (+ доступ к Supabase).
import { authUser, env, json, selectRows } from "./_lib/vpos";
import { logServerError } from "./_lib/log";

export const config = { runtime: "edge" };

const FROM = "DonatelleX <noreply@donatellex.com>";
const ADMIN_URL = "https://admin.donatellex.com/refunds";

const PLAN_LABEL: Record<string, string> = {
  monthly: "1 месяц",
  quarterly: "3 месяца",
  semiannual: "6 месяцев",
  annual: "12 месяцев",
};

function esc(s: string): string {
  return s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]!);
}

function money(minor: number | null, currency: string | null): string {
  if (minor == null) return "—";
  const v = Math.round(Number(minor)) / 100;
  return `${Number.isInteger(v) ? v : v.toFixed(2)} ${currency ?? ""}`.trim();
}

export default async function handler(request: Request): Promise<Response> {
  if (request.method !== "POST") return json({ message: "Method not allowed" }, 405);
  const to = env("ADMIN_NOTIFY_EMAIL");
  if (!to || !env("RESEND_API_KEY")) return json({ sent: false, reason: "not_configured" });

  const user = await authUser(request);
  if (!user) return json({ sent: false }, 401);

  try {
    const since = new Date(Date.now() - 10 * 60 * 1000).toISOString();
    const [req] = await selectRows<{
      requested_at: string;
      reason: string | null;
      plan: string | null;
      paid_amount: number | null;
      refund_amount: number | null;
      currency: string | null;
      paid_at: string | null;
    }>(
      "refund_requests",
      `select=requested_at,reason,plan,paid_amount,refund_amount,currency,paid_at&user_id=eq.${user.id}&status=eq.pending&requested_at=gte.${encodeURIComponent(since)}&order=requested_at.desc&limit=1`,
    );
    if (!req) return json({ sent: false, reason: "no_recent_request" });

    const [u] = await selectRows<{ first_name: string | null; last_name: string | null; full_name: string | null; phone: string | null }>(
      "users",
      `select=first_name,last_name,full_name,phone&id=eq.${user.id}`,
    );
    const name = [u?.first_name, u?.last_name].filter(Boolean).join(" ") || u?.full_name || "—";
    const payBy = new Date(new Date(req.requested_at).getTime() + 14 * 86400000).toLocaleDateString("ru-RU");

    const rows: Array<[string, string]> = [
      ["Клиент", name],
      ["Email", user.email ?? "—"],
      ["Телефон", u?.phone ?? "—"],
      ["Тариф", PLAN_LABEL[req.plan ?? ""] ?? req.plan ?? "—"],
      ["Оплачено", `${money(req.paid_amount, req.currency)}${req.paid_at ? `, ${new Date(req.paid_at).toLocaleDateString("ru-RU")}` : ""}`],
      ["К возврату", money(req.refund_amount, req.currency)],
      ["Причина", req.reason?.trim() || "не указана"],
      ["Вернуть не позже", payBy],
    ];
    const html = `<div style="font-family:Arial,sans-serif;font-size:14px;color:#111">
<p><b>Новая заявка на отказ от договора и возврат</b></p>
<table cellpadding="4" style="border-collapse:collapse">${rows
      .map(([k, v]) => `<tr><td style="color:#666">${esc(k)}</td><td>${esc(v)}</td></tr>`)
      .join("")}</table>
<p>Одобрить или отклонить: <a href="${ADMIN_URL}">${ADMIN_URL}</a>. Деньги по закону нужно вернуть не позже 14 дней с заявки.</p>
</div>`;

    const res = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { Authorization: `Bearer ${env("RESEND_API_KEY")}`, "Content-Type": "application/json" },
      body: JSON.stringify({ from: FROM, to: [to], subject: `Заявка на возврат: ${name}`, html, reply_to: user.email ?? undefined }),
    });
    if (!res.ok) throw new Error(`resend: ${res.status} ${await res.text()}`);
    return json({ sent: true });
  } catch (err) {
    await logServerError("notify-withdrawal", err, {}, "critical", user.id);
    return json({ sent: false }, 500);
  }
}
