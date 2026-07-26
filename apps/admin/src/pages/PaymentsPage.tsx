import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
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
};

const STATUS_LABEL: Record<PaymentStatus, string> = {
  pending: "В обработке",
  confirmed: "Подтверждён",
  failed: "Ошибка",
  refunded: "Возврат",
  expired: "Истёк",
};

const PROVIDER_LABEL: Record<PaymentProvider, string> = {
  stripe: "Stripe",
  paypal: "PayPal",
  yookassa: "ЮKassa",
  usdt: "USDT",
};

const PROVIDER_FILTERS: Array<PaymentProvider | "all"> = ["all", "stripe", "paypal", "yookassa", "usdt"];

export default function PaymentsPage() {
  const [providerFilter, setProviderFilter] = useState<PaymentProvider | "all">("all");

  const { data: payments, isLoading } = useQuery({
    queryKey: ["admin-payments"],
    queryFn: async (): Promise<Payment[]> => {
      const { data, error } = await supabase
        .from("payments")
        .select("*")
        .order("created_at", { ascending: false })
        .limit(200);
      if (error) throw error;
      return toCamelCase<Payment[]>(data ?? []);
    },
  });

  const filtered = (payments ?? []).filter(
    (p) => providerFilter === "all" || p.provider === providerFilter,
  );

  return (
    <div>
      <div>
        <h1 className="font-display text-2xl font-bold">Платежи</h1>
        <p className="mt-1 text-neutral-400">
          История транзакций по всем платёжным провайдерам (Stripe, PayPal, ЮKassa, USDT)
        </p>
      </div>

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
      </div>

      <div className="card mt-6 overflow-x-auto p-0">
        <table className="w-full min-w-[720px] border-collapse">
          <thead>
            <tr className="border-b border-ink-700">
              <th className="table-th">Дата</th>
              <th className="table-th">Провайдер</th>
              <th className="table-th">Сумма</th>
              <th className="table-th">Статус</th>
              <th className="table-th">ID транзакции</th>
            </tr>
          </thead>
          <tbody>
            {isLoading &&
              Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} className="border-b border-ink-800">
                  <td className="table-td" colSpan={5}>
                    <div className="h-4 w-full animate-pulse rounded bg-ink-800" />
                  </td>
                </tr>
              ))}

            {!isLoading && filtered.length === 0 && (
              <tr>
                <td className="table-td py-8 text-center text-neutral-500" colSpan={5}>
                  Платежи не найдены
                </td>
              </tr>
            )}

            {filtered.map((p) => (
              <tr key={p.id} className="border-b border-ink-800 last:border-0">
                <td className="table-td text-neutral-400">
                  {new Date(p.createdAt).toLocaleString("ru-RU")}
                </td>
                <td className="table-td font-medium">{PROVIDER_LABEL[p.provider]}</td>
                <td className="table-td">
                  {p.amount.toFixed(2)} {p.currency}
                </td>
                <td className="table-td">
                  <span className={clsx("badge", STATUS_BADGE[p.status])}>
                    {STATUS_LABEL[p.status]}
                  </span>
                </td>
                <td className="table-td font-mono text-xs text-neutral-500">
                  {p.cryptoTxHash ? `${p.cryptoTxHash.slice(0, 10)}…` : p.providerPaymentId}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
