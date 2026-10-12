import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type { Payment, PaymentProvider, PaymentStatus } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

const STATUS_BADGE: Record<PaymentStatus, string> = {
  pending: "bg-warning/10 text-warning",
  confirmed: "bg-success/10 text-success",
  failed: "bg-danger/10 text-danger",
  refunded: "bg-neutral-600/20 text-neutral-400",
  expired: "bg-neutral-600/20 text-neutral-400",
  canceled: "bg-neutral-600/20 text-neutral-400",
};

const STATUS_LABEL: Record<PaymentStatus, string> = {
  pending: "В обработке",
  confirmed: "Подтверждён",
  failed: "Ошибка",
  refunded: "Возврат",
  expired: "Истёк",
  canceled: "Отменён",
};

const PROVIDER_LABEL: Record<PaymentProvider, string> = {
  stripe: "Stripe",
  paypal: "PayPal",
  yookassa: "ЮKassa",
  usdt: "USDT",
  ararat: "Араратбанк",
  ameria: "Америабанк",
};

const PROVIDER_FILTERS: Array<PaymentProvider | "all"> = ["all", "ameria", "stripe", "paypal", "yookassa", "usdt"];

/**
 * Действия с платежом Америабанка — через серверную функцию приложения
 * (там логин/пароль банка; из админки их не видно).
 */
const APP_API = "https://app.donatellex.com/api/admin/vpos";
type VposAction = "check" | "cancel" | "refund";

async function callVpos(paymentId: string, action: VposAction, amount?: number): Promise<string> {
  const { data } = await supabase.auth.getSession();
  const token = data.session?.access_token;
  if (!token) throw new Error("Сессия истекла — войдите заново");
  const res = await fetch(APP_API, {
    method: "POST",
    headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
    body: JSON.stringify({ paymentId, action, amount }),
  });
  const body = (await res.json().catch(() => ({}))) as {
    message?: string;
    details?: { ResponseCode?: string; OrderStatus?: string | number; PaymentState?: string; CardNumber?: string };
  };
  if (!res.ok) throw new Error(body.message ?? `Ошибка ${res.status}`);
  const d = body.details;
  return d
    ? `${body.message}: код ${d.ResponseCode ?? "—"}, состояние ${d.PaymentState ?? d.OrderStatus ?? "—"}${d.CardNumber ? `, карта ${d.CardNumber}` : ""}`
    : (body.message ?? "Готово");
}

/** Минорные единицы → "10" / "79,90" */
function money(minor: number): string {
  const v = Math.round(minor) / 100;
  return Number.isInteger(v) ? String(v) : v.toFixed(2).replace(".", ",");
}

interface PaymentUser {
  email?: string | null;
  fullName?: string | null;
  firstName?: string | null;
  lastName?: string | null;
  phone?: string | null;
}
type PaymentWithUser = Payment & { user?: PaymentUser | null };

function userName(u?: PaymentUser | null): string {
  if (!u) return "";
  const byParts = [u.firstName, u.lastName].filter(Boolean).join(" ").trim();
  return byParts || u.fullName?.trim() || "";
}

const PLAN_LABEL: Record<string, string> = {
  monthly: "1 месяц",
  quarterly: "3 месяца",
  semiannual: "6 месяцев",
  annual: "12 месяцев",
};

export default function PaymentsPage() {
  const queryClient = useQueryClient();
  const [notice, setNotice] = useState<{ ok: boolean; text: string } | null>(null);
  const vposAction = useMutation({
    mutationFn: async (args: { payment: Payment; action: VposAction }) => {
      const { payment, action } = args;
      const left = payment.amount - (payment.refundedAmount ?? 0);
      if (action === "cancel") {
        if (!window.confirm(`Отменить платёж на ${money(payment.amount)} ${payment.currency} целиком? Доступ за этот период закроется.`)) return null;
        return callVpos(payment.id, "cancel");
      }
      if (action === "refund") {
        const input = window.prompt(
          `Сколько вернуть, ${payment.currency}? (максимум ${money(left)}; вся сумма — доступ за период закроется)`,
          money(left),
        );
        if (input == null) return null;
        const amount = Math.round(Number(input.replace(",", ".").replace(/\s/g, "")) * 100);
        if (!(amount > 0) || amount > left) throw new Error("Неверная сумма");
        return callVpos(payment.id, "refund", amount);
      }
      return callVpos(payment.id, "check");
    },
    onSuccess: (text) => {
      if (text) setNotice({ ok: true, text });
      void queryClient.invalidateQueries({ queryKey: ["admin-payments"] });
    },
    onError: (err: Error) => setNotice({ ok: false, text: err.message }),
  });

  const [providerFilter, setProviderFilter] = useState<PaymentProvider | "all">("all");
  const [search, setSearch] = useState("");

  const { data: payments, isLoading } = useQuery({
    queryKey: ["admin-payments"],
    queryFn: async (): Promise<PaymentWithUser[]> => {
      const { data, error } = await supabase
        .from("payments")
        // кто платил — из public.users (payments.user_id → users.id)
        .select("*, user:users(email, full_name, first_name, last_name, phone)")
        .order("created_at", { ascending: false })
        .limit(200);
      if (error) throw error;
      return toCamelCase<PaymentWithUser[]>(data ?? []);
    },
  });

  const query = search.trim().toLowerCase();
  const filtered = (payments ?? []).filter((p) => {
    if (providerFilter !== "all" && p.provider !== providerFilter) return false;
    if (!query) return true;
    return [userName(p.user), p.user?.email, p.user?.phone, p.orderNumber, p.providerPaymentId]
      .filter(Boolean)
      .some((v) => String(v).toLowerCase().includes(query));
  });

  return (
    <div>
      <div>
        <h1 className="font-display text-2xl font-bold">Платежи</h1>
        <p className="mt-1 text-neutral-400">
          История оплат. Платежи Америабанка можно проверить в банке, отменить (в течение
          72 часов) или вернуть — деньги уйдут на карту, доступ за период закроется.
        </p>
      </div>

      {notice && (
        <div
          className={clsx(
            "mt-4 rounded-md border px-4 py-3 text-sm",
            notice.ok ? "border-success/30 bg-success/10 text-success" : "border-danger/30 bg-danger/10 text-danger",
          )}
        >
          {notice.text}
        </div>
      )}

      <div className="mt-4 flex flex-wrap gap-2">
        {PROVIDER_FILTERS.map((p) => (
          <button
            key={p}
            onClick={() => setProviderFilter(p)}
            className={clsx(
              "rounded-full border px-3.5 py-1.5 text-sm font-medium transition",
              providerFilter === p
                ? "border-volt-400 bg-volt-400/10 text-volt-400"
                : "border-ink-600 text-neutral-400 hover:border-ink-500",
            )}
          >
            {p === "all" ? "Все" : PROVIDER_LABEL[p]}
          </button>
        ))}
        <input
          type="search"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Имя, email, телефон или номер заказа"
          className="input-field ml-auto w-full py-1.5 text-sm sm:w-72"
        />
      </div>

      <div className="card mt-6 overflow-x-auto p-0">
        <table className="w-full min-w-[1080px] border-collapse">
          <thead>
            <tr className="border-b border-ink-700">
              <th className="table-th">Дата</th>
              <th className="table-th">Пользователь</th>
              <th className="table-th">Провайдер</th>
              <th className="table-th">Сумма</th>
              <th className="table-th">Статус</th>
              <th className="table-th">ID транзакции</th>
              <th className="table-th">Действия</th>
            </tr>
          </thead>
          <tbody>
            {isLoading &&
              Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} className="border-b border-ink-800">
                  <td className="table-td" colSpan={7}>
                    <div className="h-4 w-full animate-pulse rounded bg-ink-800" />
                  </td>
                </tr>
              ))}

            {!isLoading && filtered.length === 0 && (
              <tr>
                <td className="table-td py-8 text-center text-neutral-500" colSpan={7}>
                  Платежи не найдены
                </td>
              </tr>
            )}

            {filtered.map((p) => (
              <tr key={p.id} className="border-b border-ink-800 last:border-0">
                <td className="table-td text-neutral-400">
                  {new Date(p.createdAt).toLocaleString("ru-RU")}
                </td>
                <td className="table-td">
                  {p.user ? (
                    <div className="max-w-[220px]">
                      <p className="truncate font-medium">{userName(p.user) || "—"}</p>
                      <p className="truncate text-xs text-neutral-500">{p.user.email}</p>
                      {p.user.phone && <p className="text-xs text-neutral-500">{p.user.phone}</p>}
                    </div>
                  ) : (
                    <span className="text-neutral-600">удалён</span>
                  )}
                </td>
                <td className="table-td">
                  <span className="font-medium">{PROVIDER_LABEL[p.provider]}</span>
                  {p.plan && <span className="block text-xs text-neutral-500">{PLAN_LABEL[p.plan] ?? p.plan}</span>}
                </td>
                <td className="table-td whitespace-nowrap">
                  {p.provider === "ameria" ? money(p.amount) : p.amount.toFixed(2)} {p.currency}
                  {!!p.refundedAmount && p.status === "confirmed" && (
                    <span className="block text-xs text-neutral-500">возвращено {money(p.refundedAmount)}</span>
                  )}
                  {p.isTest && <span className="badge ml-1.5 bg-warning/10 text-warning">тест</span>}
                </td>
                <td className="table-td">
                  <span className={clsx("badge", STATUS_BADGE[p.status])}>
                    {STATUS_LABEL[p.status]}
                  </span>
                </td>
                <td className="table-td font-mono text-xs text-neutral-500">
                  {p.cryptoTxHash ? `${p.cryptoTxHash.slice(0, 10)}…` : p.providerPaymentId}
                  {p.bankOrderId != null && <span className="block">заказ {p.bankOrderId}</span>}
                </td>
                <td className="table-td whitespace-nowrap">
                  {p.provider === "ameria" && !p.providerPaymentId.startsWith("order-") && (
                    <div className="flex gap-1.5">
                      {(["check", "cancel", "refund"] as const)
                        .filter((a) => a === "check" || p.status === "confirmed")
                        .filter((a) => a !== "cancel" || Date.now() - new Date(p.createdAt).getTime() < 72 * 3600 * 1000)
                        .map((a) => (
                          <button
                            key={a}
                            disabled={vposAction.isPending}
                            onClick={() => {
                              setNotice(null);
                              vposAction.mutate({ payment: p, action: a });
                            }}
                            className={clsx(
                              "badge border-0 transition disabled:opacity-50",
                              a === "check"
                                ? "bg-ink-700 text-neutral-300 hover:bg-ink-600"
                                : "bg-danger/10 text-danger hover:bg-danger/20",
                            )}
                          >
                            {a === "check" ? "Проверить" : a === "cancel" ? "Отменить" : "Вернуть"}
                          </button>
                        ))}
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
