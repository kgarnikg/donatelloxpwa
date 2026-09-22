// apps/web/api/send-support-request.ts
//
// "Помощь" в приложении — клиент пишет о проблеме (опционально со
// скриншотом), это письмом уходит тренеру. Email тренера нигде не
// фигурирует на клиенте — только здесь, на сервере, переменной окружения.
//
// Это Vercel Serverless Function, не Supabase Edge Function — деплоится
// автоматически вместе с обычным git push в Vercel (файлы в /api на
// корне проекта Vercel подхватываются сами), никакой отдельной команды
// в терминале не требуется. Секреты (см. ниже) задаются через
// Vercel Dashboard → Settings → Environment Variables — тот же способ,
// каким уже добавлялись VITE_SUPABASE_URL и другие переменные раньше.

import type { VercelRequest, VercelResponse } from "@vercel/node";
import { createClient } from "@supabase/supabase-js";

const SUPABASE_URL = process.env.VITE_SUPABASE_URL!;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;
const RESEND_API_KEY = process.env.RESEND_API_KEY!;
const RESEND_FROM_EMAIL = process.env.RESEND_FROM_EMAIL ?? "DonatelleX <onboarding@resend.dev>";
const SUPPORT_TO_EMAIL = process.env.SUPPORT_TO_EMAIL ?? "donatellex@gmail.com";

export default async function handler(req: VercelRequest, res: VercelResponse) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "method_not_allowed" });
  }

  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ error: "unauthorized" });
  }

  try {
    // Клиент вызывает со СВОИМ токеном (не service_role) — так мы точно
    // знаем, что запрос от реального залогиненного пользователя.
    const userClient = createClient(SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY!, {
      global: { headers: { Authorization: authHeader } },
    });
    const {
      data: { user },
      error: authError,
    } = await userClient.auth.getUser();
    if (authError || !user) {
      return res.status(401).json({ error: "unauthorized" });
    }

    const { message, screenshotPath } = req.body as { message: string; screenshotPath?: string };
    if (!message?.trim()) {
      return res.status(400).json({ error: "message_required" });
    }

    // service_role — дальше от имени сервиса (записать за пользователя,
    // скачать приватный файл из Storage), не полагаемся на RLS клиента.
    const adminClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    const { data: profile } = await adminClient.from("users").select("email, full_name").eq("id", user.id).single();

    const { data: inserted, error: insertError } = await adminClient
      .from("support_requests")
      .insert({ user_id: user.id, message: message.trim(), screenshot_path: screenshotPath ?? null })
      .select("id")
      .single();
    if (insertError) throw insertError;

    // Если есть скриншот — тянем файл из приватного бакета и отправляем
    // как base64-вложение (Resend поддерживает это напрямую в теле
    // запроса, не нужна отдельная публичная ссылка — бакет и не
    // публичный специально, могут быть личные данные на скрине).
    const attachments: { filename: string; content: string }[] = [];
    if (screenshotPath) {
      const { data: fileData } = await adminClient.storage.from("support-attachments").download(screenshotPath);
      if (fileData) {
        const buffer = Buffer.from(await fileData.arrayBuffer());
        attachments.push({ filename: screenshotPath.split("/").pop() ?? "screenshot.png", content: buffer.toString("base64") });
      }
    }

    const emailResponse = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { Authorization: `Bearer ${RESEND_API_KEY}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        from: RESEND_FROM_EMAIL,
        to: SUPPORT_TO_EMAIL,
        // reply_to — ответ тренера прямо из его почтового клиента уйдёт
        // клиенту напрямую, не нужен отдельный механизм "ответить в приложении".
        reply_to: profile?.email,
        subject: `Обращение в поддержку — ${profile?.full_name ?? user.email}`,
        text: `От: ${profile?.full_name ?? "—"} (${profile?.email ?? user.email})\nID обращения: ${inserted.id}\n\n${message}`,
        attachments: attachments.length > 0 ? attachments : undefined,
      }),
    });

    if (!emailResponse.ok) {
      // Письмо не ушло, но заявка УЖЕ сохранена в support_requests — не
      // теряем обращение только из-за сбоя почты, админ увидит его в базе.
      console.error("Resend error:", await emailResponse.text());
      return res.status(200).json({ ok: true, emailSent: false });
    }

    return res.status(200).json({ ok: true, emailSent: true });
  } catch (err) {
    console.error("send-support-request error:", err);
    return res.status(500).json({ error: "internal_error" });
  }
}
