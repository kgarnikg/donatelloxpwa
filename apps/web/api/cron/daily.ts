// Ежедневная задача (Vercel Cron, расписание — в apps/web/vercel.json).
//
// 1) Награды за приглашённых друзей: grant_referral_rewards() (0082) сама
//    продлевает/выдаёт месяц доступа и возвращает, кому написать.
// 2) Напоминания "доступ заканчивается через 3 дня": due_subscription_reminders()
//    → письмо → mark_subscription_reminded().
//
// Переменные окружения проекта donatelloxpwa-web на Vercel:
//   SUPABASE_URL (или VITE_SUPABASE_URL), SUPABASE_SERVICE_ROLE_KEY,
//   RESEND_API_KEY, CRON_SECRET (Vercel сам присылает его в заголовке
//   Authorization — так чужой запрос на /api/cron/daily ничего не запустит).
import { buildEmail, formatDate, pickLang } from "../_lib/email";

export const config = { runtime: "edge" };

const APP_URL = "https://app.donatellex.com";
const FROM = "DonatelleX <noreply@donatellex.com>";

interface ReminderRow {
  subscription_id: string;
  email: string;
  first_name: string | null;
  full_name: string | null;
  locale: string | null;
  period_end: string;
}

interface RewardRow {
  email: string | null;
  first_name: string | null;
  full_name: string | null;
  locale: string | null;
  friend_name: string | null;
  access_until: string;
}

function env(name: string): string {
  return (process.env[name] ?? "").trim();
}

async function rpc<T>(fn: string, body: Record<string, unknown>): Promise<T> {
  const url = (env("SUPABASE_URL") || env("VITE_SUPABASE_URL")).replace(/\/$/, "");
  const key = env("SUPABASE_SERVICE_ROLE_KEY");
  const res = await fetch(`${url}/rest/v1/rpc/${fn}`, {
    method: "POST",
    headers: {
      apikey: key,
      // Старый service_role key — JWT (eyJ…), его передают и в Authorization.
      // Новый секретный ключ (sb_secret_…) — только в apikey.
      ...(key.startsWith("eyJ") ? { Authorization: `Bearer ${key}` } : {}),
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });
  const text = await res.text();
  if (!res.ok) throw new Error(`${fn}: ${res.status} ${text}`);
  return (text ? JSON.parse(text) : null) as T;
}

async function sendEmail(to: string, subject: string, html: string): Promise<void> {
  const res = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env("RESEND_API_KEY")}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ from: FROM, to: [to], subject, html }),
  });
  if (!res.ok) throw new Error(`resend: ${res.status} ${await res.text()}`);
}

const pause = (ms: number) => new Promise((r) => setTimeout(r, ms));

function firstNameOf(row: { first_name: string | null; full_name: string | null }): string {
  return (row.first_name ?? "").trim() || (row.full_name ?? "").trim().split(/\s+/)[0] || "";
}

export default async function handler(request: Request): Promise<Response> {
  const secret = env("CRON_SECRET");
  if (!secret || request.headers.get("authorization") !== `Bearer ${secret}`) {
    return new Response("Unauthorized", { status: 401 });
  }
  const missing = ["SUPABASE_SERVICE_ROLE_KEY", "RESEND_API_KEY"].filter((n) => !env(n));
  if (missing.length || !(env("SUPABASE_URL") || env("VITE_SUPABASE_URL"))) {
    return Response.json({ error: `missing env: ${missing.join(", ") || "SUPABASE_URL"}` }, { status: 500 });
  }

  const report = { rewards: 0, rewardEmails: 0, reminders: 0, errors: [] as string[] };

  // 1. Награды за друзей (месяц уже начислен в базе — письмо лишь сообщает)
  try {
    const rewards = await rpc<RewardRow[]>("grant_referral_rewards", {});
    report.rewards = rewards.length;
    for (const r of rewards) {
      if (!r.email) continue;
      const lang = pickLang(r.locale);
      const { subject, html } = buildEmail("reward", lang, {
        firstName: firstNameOf(r),
        friend: r.friend_name,
        date: formatDate(r.access_until, lang),
        url: `${APP_URL}/dashboard`,
      });
      try {
        await sendEmail(r.email, subject, html);
        report.rewardEmails++;
      } catch (e) {
        report.errors.push(String(e));
      }
      await pause(600); // лимит Resend — 2 письма в секунду
    }
  } catch (e) {
    report.errors.push(String(e));
  }

  // 2. Напоминания об окончании доступа
  try {
    const due = await rpc<ReminderRow[]>("due_subscription_reminders", { p_days: 3 });
    const sent: string[] = [];
    for (const r of due) {
      const lang = pickLang(r.locale);
      const { subject, html } = buildEmail("reminder", lang, {
        firstName: firstNameOf(r),
        date: formatDate(r.period_end, lang),
        url: `${APP_URL}/subscription`,
      });
      try {
        await sendEmail(r.email, subject, html);
        sent.push(r.subscription_id);
      } catch (e) {
        report.errors.push(String(e));
      }
      await pause(600);
    }
    if (sent.length) await rpc("mark_subscription_reminded", { p_ids: sent });
    report.reminders = sent.length;
  } catch (e) {
    report.errors.push(String(e));
  }

  // В логах Vercel (Logs → /api/cron/daily) видно, что именно сделано и что сломалось
  if (report.errors.length) console.error("cron/daily", JSON.stringify(report));
  else console.log("cron/daily", JSON.stringify(report));
  return Response.json(report, { status: report.errors.length ? 207 : 200 });
}
