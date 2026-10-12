// Общее для оплаты через vPOS Америабанка (REST API vPOS 3.1) и для
// серверных запросов в Supabase.
//
// Переменные окружения проекта donatelloxpwa-web на Vercel:
//   VPOS_CLIENT_ID, VPOS_USERNAME, VPOS_PASSWORD — доступ мерчанта (от банка);
//   VPOS_BASE_URL   — по умолчанию тестовый шлюз
//                     https://servicestest.ameriabank.am/VPOS/ ; для боевого
//                     банк пришлёт свой адрес;
//   VPOS_TEST_MODE  — "true": тестовая среда банка. Платить могут только
//                     админы, сумма всегда 10 ֏ (требование тестовой среды),
//                     платежи помечаются is_test;
//   SUPABASE_URL (или VITE_SUPABASE_URL), SUPABASE_SERVICE_ROLE_KEY,
//   VITE_SUPABASE_ANON_KEY — уже заданы для cron.
//
// Пароли банка живут только в переменных Vercel — в коде и в браузере их нет.

export function env(name: string): string {
  return (process.env[name] ?? "").trim();
}

export function json(body: unknown, status = 200, headers: Record<string, string> = {}): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json; charset=utf-8", "cache-control": "no-store", ...headers },
  });
}

// ---------------------------------------------------------------------------
// vPOS
// ---------------------------------------------------------------------------

export function vposBaseUrl(): string {
  const base = env("VPOS_BASE_URL") || "https://servicestest.ameriabank.am/VPOS/";
  return base.endsWith("/") ? base : `${base}/`;
}

export function vposTestMode(): boolean {
  return env("VPOS_TEST_MODE") === "true";
}

export function vposConfigured(): boolean {
  return !!(env("VPOS_CLIENT_ID") && env("VPOS_USERNAME") && env("VPOS_PASSWORD"));
}

/** ISO 4217 (числовой код), как ждёт банк. */
export const VPOS_CURRENCY_CODE: Record<string, string> = {
  AMD: "051",
  EUR: "978",
  USD: "840",
  RUB: "643",
};

/** Язык страницы оплаты банка: am / ru / en */
export function vposLang(language: string | undefined): string {
  const lang = (language ?? "").toLowerCase();
  if (lang.startsWith("hy")) return "am";
  if (lang.startsWith("ru") || lang.startsWith("uk")) return "ru";
  return "en";
}

export interface VposPaymentDetails {
  Amount?: number;
  ApprovedAmount?: number;
  DepositedAmount?: number;
  RefundedAmount?: number;
  Currency?: string;
  OrderID?: string | number;
  PaymentID?: string;
  PaymentState?: string;
  OrderStatus?: string | number;
  ResponseCode?: string;
  Description?: string;
  CardNumber?: string;
  DateTime?: string;
  Opaque?: string;
  ApprovalCode?: string;
  rrn?: string;
  TrxnDescription?: string;
  [key: string]: unknown;
}

/** Вызов метода vPOS. Логин и пароль подставляются здесь. */
export async function vpos<T = Record<string, unknown>>(
  method: "InitPayment" | "GetPaymentDetails" | "ConfirmPayment" | "CancelPayment" | "RefundPayment",
  body: Record<string, unknown>,
): Promise<T> {
  const res = await fetch(`${vposBaseUrl()}api/VPOS/${method}`, {
    method: "POST",
    headers: { "Content-Type": "application/json", Accept: "application/json" },
    body: JSON.stringify({ Username: env("VPOS_USERNAME"), Password: env("VPOS_PASSWORD"), ...body }),
  });
  const text = await res.text();
  if (!res.ok) throw new Error(`vPOS ${method}: HTTP ${res.status} ${text.slice(0, 300)}`);
  try {
    return JSON.parse(text) as T;
  } catch {
    throw new Error(`vPOS ${method}: не JSON — ${text.slice(0, 300)}`);
  }
}

/** Платёж оплачен полностью: код "00" и статус "списано" (OrderStatus 2 / payment_deposited). */
export function isDeposited(d: VposPaymentDetails): boolean {
  return (
    String(d.ResponseCode ?? "") === "00" &&
    (String(d.OrderStatus ?? "") === "2" || String(d.PaymentState ?? "") === "payment_deposited")
  );
}

/** Двухстадийная оплата: сумма только заблокирована (OrderStatus 1) — нужно ConfirmPayment. */
export function isApprovedOnly(d: VposPaymentDetails): boolean {
  return (
    String(d.ResponseCode ?? "") === "00" &&
    (String(d.OrderStatus ?? "") === "1" || String(d.PaymentState ?? "") === "payment_approved")
  );
}

/** Только то, что стоит хранить в нашей базе (без лишнего). */
export function detailsForLog(d: VposPaymentDetails): Record<string, unknown> {
  const keep = [
    "PaymentID", "OrderID", "Amount", "ApprovedAmount", "DepositedAmount", "RefundedAmount",
    "Currency", "PaymentState", "OrderStatus", "ResponseCode", "CardNumber", "DateTime",
    "ApprovalCode", "rrn", "TrxnDescription", "ResponseMessage",
  ];
  const out: Record<string, unknown> = {};
  for (const k of keep) if (d[k] !== undefined && d[k] !== null) out[k] = d[k];
  return out;
}

/** Минорные единицы (как в pricing.ts и payments.amount) → сумма для банка. */
export function toMajor(minor: number): number {
  return Math.round(minor) / 100;
}

// ---------------------------------------------------------------------------
// Supabase (ключ service_role — только на сервере)
// ---------------------------------------------------------------------------

function supabaseUrl(): string {
  return (env("SUPABASE_URL") || env("VITE_SUPABASE_URL")).replace(/\/$/, "");
}

function serviceHeaders(): Record<string, string> {
  const key = env("SUPABASE_SERVICE_ROLE_KEY");
  return {
    apikey: key,
    // Старый service_role key — JWT (eyJ…), его передают и в Authorization.
    // Новый секретный ключ (sb_secret_…) — только в apikey.
    ...(key.startsWith("eyJ") ? { Authorization: `Bearer ${key}` } : {}),
    "Content-Type": "application/json",
  };
}

export async function rpc<T>(fn: string, body: Record<string, unknown>): Promise<T> {
  const res = await fetch(`${supabaseUrl()}/rest/v1/rpc/${fn}`, {
    method: "POST",
    headers: serviceHeaders(),
    body: JSON.stringify(body),
  });
  const text = await res.text();
  if (!res.ok) throw new Error(`${fn}: ${res.status} ${text}`);
  return (text ? JSON.parse(text) : null) as T;
}

/** select из таблицы с правами сервера; query — строка PostgREST (select=…&id=eq.…) */
export async function selectRows<T>(table: string, query: string): Promise<T[]> {
  const res = await fetch(`${supabaseUrl()}/rest/v1/${table}?${query}`, { headers: serviceHeaders() });
  const text = await res.text();
  if (!res.ok) throw new Error(`${table}: ${res.status} ${text}`);
  return (text ? JSON.parse(text) : []) as T[];
}

export interface AuthedUser {
  id: string;
  email: string | null;
  role: string;
  pendingDiscountPercent: number;
  isAdmin: boolean;
}

/** Кто вызывает: проверяем токен пользователя в Supabase Auth, роль — из public.users. */
export async function authUser(request: Request): Promise<AuthedUser | null> {
  const token = (request.headers.get("authorization") ?? "").replace(/^Bearer\s+/i, "");
  if (!token) return null;
  const anon = env("VITE_SUPABASE_ANON_KEY") || env("SUPABASE_ANON_KEY") || env("SUPABASE_SERVICE_ROLE_KEY");
  const res = await fetch(`${supabaseUrl()}/auth/v1/user`, {
    headers: { apikey: anon, Authorization: `Bearer ${token}` },
  });
  if (!res.ok) return null;
  const user = (await res.json()) as { id?: string; email?: string };
  if (!user.id) return null;
  const rows = await selectRows<{ role: string; pending_discount_percent: number | null; is_blocked: boolean | null }>(
    "users",
    `select=role,pending_discount_percent,is_blocked&id=eq.${encodeURIComponent(user.id)}`,
  );
  const row = rows[0];
  if (!row || row.is_blocked) return null;
  return {
    id: user.id,
    email: user.email ?? null,
    role: row.role,
    pendingDiscountPercent: row.pending_discount_percent ?? 0,
    isAdmin: row.role === "admin" || row.role === "superadmin",
  };
}

export interface PaymentRow {
  id: string;
  user_id: string;
  provider: string;
  provider_payment_id: string;
  amount: number;
  currency: string;
  status: string;
  plan: string | null;
  bank_order_id: number | null;
  is_test: boolean;
  refunded_amount: number | null;
  created_at: string;
}

export async function paymentBy(field: "id" | "provider_payment_id", value: string): Promise<PaymentRow | null> {
  const rows = await selectRows<PaymentRow>(
    "payments",
    `select=id,user_id,provider,provider_payment_id,amount,currency,status,plan,bank_order_id,is_test,refunded_amount,created_at&provider=eq.ameria&${field}=eq.${encodeURIComponent(value)}&limit=1`,
  );
  return rows[0] ?? null;
}
