// POST /api/vpos-call — единственное место, которое разговаривает с банком.
//
// Почему отдельная функция на Node.js, а не прямо из Edge: среда Edge у
// Vercel сама добавляет к каждому исходящему запросу служебный заголовок
// x-middleware-subrequest. Защита боевого шлюза Америабанка считает любые
// лишние заголовки нарушением документации и блокирует запрос («Request
// Rejected», ответ банка от 10.11.2026). Здесь запрос собирается вручную
// через node:https — уходят только Host, Content-Type, Content-Length,
// Accept и User-Agent.
//
// Вызывают её только наши функции (create-checkout, payment-return,
// admin/vpos) через _lib/vpos.ts. Пропуск — заголовок x-vpos-proxy, хэш от
// VPOS_PASSWORD (сам пароль по сети между функциями не передаётся).
// Логин и пароль банка подставляются только здесь.
//
// Файл без импортов из проекта: Node-функции Vercel не собираются в один
// бандл, как Edge, и импорты без расширения в ESM-проекте ломаются.
import { createHash } from "node:crypto";
import { request as httpsRequest } from "node:https";

const METHODS = new Set([
  "InitPayment",
  "GetPaymentDetails",
  "ConfirmPayment",
  "CancelPayment",
  "RefundPayment",
]);

interface ProxyRequest {
  method?: string;
  headers: Record<string, string | string[] | undefined>;
  body?: unknown;
}

interface ProxyResponse {
  status: (code: number) => ProxyResponse;
  json: (body: unknown) => void;
  setHeader: (name: string, value: string) => void;
}

function env(name: string): string {
  return (process.env[name] ?? "").trim();
}

function postJson(url: URL, payload: string): Promise<{ status: number; text: string }> {
  return new Promise((resolve, reject) => {
    const req = httpsRequest(
      url,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Content-Length": Buffer.byteLength(payload),
          Accept: "application/json",
          "User-Agent": "DonatelleX/1.0",
        },
      },
      (res) => {
        let data = "";
        res.setEncoding("utf8");
        res.on("data", (chunk: string) => (data += chunk));
        res.on("end", () => resolve({ status: res.statusCode ?? 0, text: data }));
      },
    );
    req.on("error", reject);
    req.setTimeout(25_000, () => req.destroy(new Error("vPOS: таймаут 25 с")));
    req.write(payload);
    req.end();
  });
}

export default async function handler(req: ProxyRequest, res: ProxyResponse): Promise<void> {
  res.setHeader("cache-control", "no-store");
  if (req.method !== "POST") {
    res.status(405).json({ message: "Method not allowed" });
    return;
  }

  const password = env("VPOS_PASSWORD");
  const expected = createHash("sha256").update(`vpos-proxy:${password}`).digest("hex");
  if (!password || req.headers["x-vpos-proxy"] !== expected) {
    res.status(401).json({ message: "Unauthorized" });
    return;
  }

  const input = (typeof req.body === "string" ? JSON.parse(req.body) : req.body) as {
    method?: string;
    body?: Record<string, unknown>;
  } | null;
  const method = input?.method ?? "";
  if (!METHODS.has(method)) {
    res.status(400).json({ message: "Unknown vPOS method" });
    return;
  }

  const base = env("VPOS_BASE_URL") || "https://servicestest.ameriabank.am/VPOS/";
  const url = new URL(`${base.endsWith("/") ? base : `${base}/`}api/VPOS/${method}`);
  const payload = JSON.stringify({
    Username: env("VPOS_USERNAME"),
    Password: password,
    ...(input?.body ?? {}),
  });

  try {
    const result = await postJson(url, payload);
    res.status(200).json(result);
  } catch (err) {
    res.status(502).json({ message: err instanceof Error ? err.message : String(err) });
  }
}
