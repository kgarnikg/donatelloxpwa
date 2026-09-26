import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import clsx from "clsx";
import { CURRENCY_SYMBOL, formatMinorAmount, type DisplayCurrency } from "@donatellox/types";
import { supabase } from "@/lib/supabase";

/**
 * Возвраты (0086). Человек нажимает в приложении "Отказаться и вернуть
 * деньги" (14 дней с оплаты) — заявка появляется здесь. По закону деньги
 * нужно вернуть не позже 14 дней после заявления.
 *
 *   Одобрить          → доступ за этот период сразу закрывается;
 *   (возврат в кабинете банка vPOS — пока вручную)
 *   Деньги возвращены → заявка закрыта, платёж помечен "Возврат".
 */

type Status = "pending" | "approved" | "refunded" | "rejected";

interface RefundRow {
  id: string;
  user_id: string | null;
  requested_at: string;
  reason: string | null;
  plan: string | null;
  paid_at: string | null;
  days_used: number | null;
  period_days: number | null;
  paid_amount: number | null;
  currency: string | null;
  refund_amount: number | null;
  consent_given: boolean;
  status: Status;
  admin_comment: string | null;
  decided_at: string | null;
  refunded_at: string | null;
  user: { email: string | null; first_name: string | null; last_name: string | null; full_name: string | null } | null;
}

const FILTERS: { key: "open" | "pending" | "approved" | "closed" | "all"; label: string }[] = [
  { key: "open", label: "Требуют действий" },
  { key: "pending", label: "Новые" },
  { key: "approved", label: "Ждут возврата денег" },
  { key: "closed", label: "Закрытые" },
  { key: "all", label: "Все" },
];

const STATUS_LABEL: Record<Status, string> = {
  pending: "Новая",
  approved: "Одобрена — вернуть деньги",
  refunded: "Деньги возвращены",
  rejected: "Отклонена",
};

const STATUS_BADGE: Record<Status, string> = {
  pending: "bg-warning/10 text-warning",
  approved: "bg-volt-400/10 text-volt-400",
  refunded: "bg-success/10 text-success",
  rejected: "bg-neutral-600/20 text-neutral-400",
};

const PLAN_LABEL: Record<string, string> = {
  monthly: "1 месяц",
  quarterly: "3 месяца",
  semiannual: "6 месяцев",
  annual: "12 месяцев",
};

const DAY = 24 * 60 * 60 * 1000;

function money(minor: number | null, currency: string | null) {
  if (minor == null) return "—";
  return `${formatMinorAmount(Number(minor))} ${CURRENCY_SYMBOL[currency as DisplayCurrency] ?? currency ?? ""}`;
}

function fmtDate(iso: string | null) {
  return iso ? new Date(iso).toLocaleDateString("ru-RU", { day: "numeric", month: "long", year: "numeric" }) : "—";
}

export default function RefundsPage() {
  const [filter, setFilter] = useState<(typeof FILTERS)[number]["key"]>("open");

  const { data: rows, isLoading, error } = useQuery({
    queryKey: ["admin-refunds"],
    queryFn: async (): Promise<RefundRow[]> => {
      const { data, error } = await supabase
        .from("refund_requests")
        .select("*, user:users!refund_requests_user_id_fkey(email, first_name, last_name, full_name)")
        .order("requested_at", { ascending: false })
        .limit(300);
      if (error) throw error;
      return (data ?? []) as unknown as RefundRow[];
    },
  });

  const filtered = (rows ?? []).filter((r) => {
    if (filter === "all") return true;
    if (filter === "open") return r.status === "pending" || r.status === "approved";
    if (filter === "closed") return r.status === "refunded" || r.status === "rejected";
    return r.status === filter;
  });

  return (
    <div>
      <h1 className="font-display text-2xl font-bold">Возвраты</h1>
      <p className="mt-1 max-w-3xl text-neutral-400">
        Заявки на отказ от подписки (14 дней с оплаты). По закону деньги нужно вернуть{" "}
        <b className="text-neutral-200">не позже 14 дней</b> с даты заявки. «Одобрить» сразу закрывает доступ за
        этот период. Сам возврат делается в кабинете банка (vPOS), после него нажмите «Деньги возвращены».
      </p>

      <div className="mt-4 flex flex-wrap gap-2">
        {FILTERS.map((f) => (
          <button
            key={f.key}
            onClick={() => setFilter(f.key)}
            className={clsx(
              "rounded-full border px-3.5 py-1.5 text-sm font-medium transition",
              filter === f.key
                ? "border-volt-400 bg-volt-400/10 text-volt-400"
                : "border-ink-600 text-neutral-400 hover:border-ink-500",
            )}
          >
            {f.label}
          </button>
        ))}
      </div>

      {error && (
        <div className="mt-6 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
          Не удалось загрузить заявки. Проверьте, что миграция 0086 выполнена в Supabase.
        </div>
      )}

      <div className="mt-6 space-y-4">
        {isLoading && <div className="h-32 animate-pulse rounded-lg bg-ink-900" />}
        {!isLoading && filtered.length === 0 && <p className="py-10 text-center text-neutral-500">Заявок нет</p>}
        {filtered.map((r) => (
          <RefundCard key={r.id} row={r} />
        ))}
      </div>
    </div>
  );
}

function RefundCard({ row }: { row: RefundRow }) {
  const queryClient = useQueryClient();
  const [amount, setAmount] = useState(() =>
    row.refund_amount != null ? String(Number(row.refund_amount) / 100).replace(".", ",") : "",
  );
  const [comment, setComment] = useState(row.admin_comment ?? "");
  const [rejecting, setRejecting] = useState(false);

  const act = useMutation({
    mutationFn: async (action: "approve" | "refunded" | "reject") => {
      const parsed = Number(amount.replace(/\s/g, "").replace(",", "."));
      const minor = amount.trim() && Number.isFinite(parsed) ? Math.round(parsed * 100) : null;
      if (action !== "reject" && minor != null && row.paid_amount != null && minor > Number(row.paid_amount)) {
        throw new Error("Сумма возврата больше оплаченной");
      }
      const { error } = await supabase.rpc("admin_update_refund", {
        p_id: row.id,
        p_action: action,
        p_refund_amount: action === "reject" ? null : minor,
        p_comment: comment.trim() || null,
      });
      if (error) throw error;
    },
    onSuccess: () => {
      setRejecting(false);
      queryClient.invalidateQueries({ queryKey: ["admin-refunds"] });
      queryClient.invalidateQueries({ queryKey: ["admin-refunds-open"] });
      queryClient.invalidateQueries({ queryKey: ["admin-payments"] });
    },
  });

  const name =
    [row.user?.first_name, row.user?.last_name].filter(Boolean).join(" ") || row.user?.full_name || "—";
  const payBy = new Date(new Date(row.requested_at).getTime() + 14 * DAY);
  const daysLeft = Math.ceil((payBy.getTime() - Date.now()) / DAY);
  const open = row.status === "pending" || row.status === "approved";

  return (
    <div className="card">
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <p className="font-semibold">{name}</p>
          <p className="text-sm text-neutral-400">{row.user?.email ?? "пользователь удалён"}</p>
        </div>
        <div className="flex flex-col items-end gap-1.5">
          <span className={clsx("rounded-full px-2.5 py-1 text-xs font-semibold", STATUS_BADGE[row.status])}>
            {STATUS_LABEL[row.status]}
          </span>
          {open && (
            <span
              className={clsx(
                "text-xs font-semibold",
                daysLeft <= 3 ? "text-danger" : daysLeft <= 7 ? "text-warning" : "text-neutral-400",
              )}
            >
              Вернуть до {fmtDate(payBy.toISOString())} ({daysLeft > 0 ? `осталось ${daysLeft} дн.` : "срок истёк!"})
            </span>
          )}
        </div>
      </div>

      <div className="mt-4 grid grid-cols-2 gap-x-6 gap-y-2 text-sm md:grid-cols-4">
        <Info label="Заявка" value={fmtDate(row.requested_at)} />
        <Info label="Оплата" value={fmtDate(row.paid_at)} />
        <Info label="Период" value={row.plan ? PLAN_LABEL[row.plan] ?? row.plan : "—"} />
        <Info label="Оплачено" value={money(row.paid_amount, row.currency)} />
        <Info
          label="Использовано"
          value={row.days_used != null ? `${row.days_used} из ${row.period_days} дн.` : "—"}
        />
        <Info
          label="Согласие «сразу»"
          value={row.consent_given ? "Да — удерживаем дни" : "Нет — возврат полностью"}
        />
        <Info label="К возврату (расчёт)" value={money(row.refund_amount, row.currency)} strong />
        {row.refunded_at && <Info label="Возвращено" value={fmtDate(row.refunded_at)} />}
      </div>

      {row.reason && (
        <p className="mt-3 rounded-md bg-ink-800 px-3 py-2 text-sm text-neutral-300">
          <span className="text-neutral-500">Причина: </span>
          {row.reason}
        </p>
      )}
      {!open && row.admin_comment && (
        <p className="mt-2 text-sm text-neutral-400">Комментарий: {row.admin_comment}</p>
      )}

      {open && (
        <div className="mt-4 border-t border-ink-700 pt-4">
          <div className="flex flex-wrap items-end gap-3">
            <label className="text-sm">
              <span className="mb-1 block text-xs text-neutral-500">Сумма возврата, {CURRENCY_SYMBOL[row.currency as DisplayCurrency] ?? row.currency}</span>
              <input
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
                inputMode="decimal"
                className="input-field w-40 py-2 text-sm"
              />
            </label>
            <label className="min-w-[200px] flex-1 text-sm">
              <span className="mb-1 block text-xs text-neutral-500">
                Комментарий {rejecting ? "(увидит пользователь — причина отказа)" : "(необязательно, видит пользователь)"}
              </span>
              <input value={comment} onChange={(e) => setComment(e.target.value)} className="input-field w-full py-2 text-sm" />
            </label>
          </div>

          {act.isError && (
            <p className="mt-3 text-sm text-danger">
              {act.error instanceof Error ? act.error.message : "Ошибка"}
            </p>
          )}

          <div className="mt-4 flex flex-wrap gap-2">
            {row.status === "pending" && !rejecting && (
              <>
                <button disabled={act.isPending} onClick={() => act.mutate("approve")} className="btn-primary py-2 text-sm">
                  Одобрить (закрыть доступ)
                </button>
                <button
                  disabled={act.isPending}
                  onClick={() => act.mutate("refunded")}
                  className="btn-secondary py-2 text-sm"
                >
                  Одобрить и деньги уже вернули
                </button>
                <button
                  onClick={() => setRejecting(true)}
                  className="rounded-md border border-danger/40 px-4 py-2 text-sm font-medium text-danger hover:bg-danger/10"
                >
                  Отклонить
                </button>
              </>
            )}
            {row.status === "pending" && rejecting && (
              <>
                <button
                  disabled={act.isPending || !comment.trim()}
                  onClick={() => act.mutate("reject")}
                  className="rounded-md bg-danger px-4 py-2 text-sm font-medium text-neutral-0 disabled:opacity-50"
                >
                  Подтвердить отказ
                </button>
                <button onClick={() => setRejecting(false)} className="btn-secondary py-2 text-sm">
                  Отмена
                </button>
                <p className="w-full text-xs text-neutral-500">
                  Отказать в течение 14 дней с оплаты по закону почти нельзя — только если заявка ошибочная или
                  дублирует другую. Напишите причину.
                </p>
              </>
            )}
            {row.status === "approved" && (
              <button disabled={act.isPending} onClick={() => act.mutate("refunded")} className="btn-primary py-2 text-sm">
                Деньги возвращены
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

function Info({ label, value, strong }: { label: string; value: string; strong?: boolean }) {
  return (
    <div>
      <p className="text-xs text-neutral-500">{label}</p>
      <p className={strong ? "font-semibold text-volt-400" : "text-neutral-200"}>{value}</p>
    </div>
  );
}
