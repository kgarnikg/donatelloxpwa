// Журнал ошибок серверных функций (таблица app_errors, миграция 0093).
//
//   await logServerError("payment-return", err, { payment: id }, "critical");
//
// Пишет через ключ service_role. Для уровня "critical" (сбои оплаты и т.п.)
// дополнительно шлёт письмо на ADMIN_NOTIFY_EMAIL — не чаще раза в час на
// одну и ту же ошибку. Никогда не бросает исключений.

type Level = "warning" | "error" | "critical";

function env(name: string): string {
  return (process.env[name] ?? "").trim();
}

function supabaseUrl(): string {
  return (env("SUPABASE_URL") || env("VITE_SUPABASE_URL")).replace(/\/$/, "");
}

function headers(): Record<string, string> {
  const key = env("SUPABASE_SERVICE_ROLE_KEY");
  return {
    apikey: key,
    ...(key.startsWith("eyJ") ? { Authorization: `Bearer ${key}` } : {}),
    "Content-Type": "application/json",
  };
}

function scrub(text: string): string {
  return text
    .replace(/("?(password|Password|token|apikey|Authorization)"?\s*[:=]\s*)"?[^",\s}]+"?/g, "$1[скрыто]")
    .replace(/Bearer\s+[A-Za-z0-9._-]+/g, "Bearer [скрыто]")
    .replace(/eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g, "[jwt]")
    .replace(/\b\d{12,19}\b/g, "[число]");
}

function describe(err: unknown): { message: string; stack: string | null } {
  if (err instanceof Error) return { message: err.message, stack: err.stack ?? null };
  if (typeof err === "string") return { message: err, stack: null };
  try {
    return { message: JSON.stringify(err), stack: null };
  } catch {
    return { message: String(err), stack: null };
  }
}

const VERSION = (env("VERCEL_GIT_COMMIT_SHA") || "dev").slice(0, 7);

export async function logServerError(
  source: string,
  err: unknown,
  context: Record<string, unknown> = {},
  level: Level = "error",
  userId: string | null = null,
): Promise<void> {
  // В логах Vercel тоже остаётся — как раньше
  console.error(`[${source}]`, err, context);
  try {
    if (!supabaseUrl() || !env("SUPABASE_SERVICE_ROLE_KEY")) return;
    const { message, stack } = describe(err);
    const row = {
      app: "api",
      source,
      level,
      message: scrub(message).slice(0, 1000),
      stack: stack ? scrub(stack).slice(0, 4000) : null,
      user_id: userId,
      app_version: VERSION,
      context: JSON.parse(scrub(JSON.stringify(context))),
    };
    const res = await fetch(`${supabaseUrl()}/rest/v1/app_errors`, {
      method: "POST",
      headers: { ...headers(), Prefer: "return=representation" },
      body: JSON.stringify(row),
    });
    if (!res.ok) {
      // user_id мог уже быть удалён — пробуем без него
      if (userId) return logServerError(source, err, context, level, null);
      return;
    }
    if (level === "critical") {
      const [saved] = (await res.json()) as Array<{ id: number; fingerprint: string }>;
      if (saved) await notifyAdmin(source, row.message, context, saved);
    }
  } catch (e) {
    console.error("logServerError failed:", e);
  }
}

async function notifyAdmin(
  source: string,
  message: string,
  context: Record<string, unknown>,
  saved: { id: number; fingerprint: string },
): Promise<void> {
  const to = env("ADMIN_NOTIFY_EMAIL");
  const resendKey = env("RESEND_API_KEY");
  if (!to || !resendKey) return;

  // Та же ошибка за последний час уже была — письмо не дублируем
  const since = new Date(Date.now() - 60 * 60 * 1000).toISOString();
  const prev = await fetch(
    `${supabaseUrl()}/rest/v1/app_errors?select=id&fingerprint=eq.${saved.fingerprint}&level=eq.critical&id=neq.${saved.id}&created_at=gte.${encodeURIComponent(since)}&limit=1`,
    { headers: headers() },
  );
  if (prev.ok && ((await prev.json()) as unknown[]).length > 0) return;

  const esc = (s: string) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]!);
  const html = `<div style="font-family:Arial,sans-serif;font-size:14px;color:#111">
<p><b>Критическая ошибка на сервере DonatelleX</b></p>
<p>Функция: <b>${esc(source)}</b><br>Время: ${new Date().toLocaleString("ru-RU", { timeZone: "Asia/Yerevan" })} (Ереван)</p>
<p style="background:#f4f4f4;padding:8px;border-radius:4px">${esc(message)}</p>
<pre style="font-size:12px;color:#444;white-space:pre-wrap">${esc(JSON.stringify(context, null, 2)).slice(0, 2000)}</pre>
<p>Подробности: <a href="https://admin.donatellex.com/errors">admin.donatellex.com/errors</a></p>
</div>`;
  await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: { Authorization: `Bearer ${resendKey}`, "Content-Type": "application/json" },
    body: JSON.stringify({
      from: "DonatelleX <noreply@donatellex.com>",
      to: [to],
      subject: `Ошибка: ${source} — ${message.slice(0, 60)}`,
      html,
    }),
  }).catch(() => {});
}
