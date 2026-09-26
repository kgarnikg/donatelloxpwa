import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, CheckCircle2, Clock, FileText, Info, XCircle } from "lucide-react";
import clsx from "clsx";
import {
  REFUND_POLICY_URL,
  formatMoney,
  useRequestWithdrawal,
  useWithdrawalInfo,
  type RefundStatus,
  type WithdrawalInfo,
} from "@/lib/withdrawal";
import { useActiveSubscription } from "@/lib/queries";

/**
 * "Кнопка отказа" (право на отказ 14 дней, 0086): показывает, до какого
 * числа можно отказаться и сколько вернём, принимает заявку и дальше —
 * её статус. Сумму считает сервер.
 */
export default function WithdrawalPage() {
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const { data: info, isLoading } = useWithdrawalInfo();
  const { data: subscription } = useActiveSubscription();
  const request = useRequestWithdrawal();
  const [reason, setReason] = useState("");
  const [confirming, setConfirming] = useState(false);

  const date = (iso?: string | null) =>
    iso ? new Date(iso).toLocaleDateString(i18n.language, { day: "numeric", month: "long" }) : "";

  const req = info?.request ?? null;
  const showForm = !!info?.eligible;
  const retained =
    info?.paid_amount != null && info.refund_amount != null ? Number(info.paid_amount) - Number(info.refund_amount) : 0;

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pb-10 pt-8">
      <button
        onClick={() => (window.history.length > 1 ? navigate(-1) : navigate("/profile"))}
        className="inline-flex items-center gap-1 text-sm text-neutral-400 hover:text-white"
      >
        <ArrowLeft size={16} /> {t("common.back")}
      </button>

      <h1 className="mt-6 font-display text-2xl font-bold">{t("withdrawal.title")}</h1>

      {isLoading || !info ? (
        <div className="mt-6 h-40 animate-pulse rounded-lg bg-ink-900" />
      ) : (
        <>
          {req && <RequestStatus status={req.status} req={req} date={date} />}

          {showForm && (
            <>
              <p className="mt-4 text-neutral-300">{t("withdrawal.eligibleText", { date: date(info.deadline) })}</p>

              <div className="card mt-5 space-y-2.5 text-sm">
                <Row label={t("withdrawal.paid")} value={formatMoney(info.paid_amount, info.currency)} />
                {info.consent_given && (
                  <>
                    <Row
                      label={t("withdrawal.used")}
                      value={t("withdrawal.usedValue", { used: info.days_used, period: info.period_days })}
                    />
                    <Row label={t("withdrawal.retained")} value={formatMoney(retained, info.currency)} />
                  </>
                )}
                <div className="border-t border-ink-700 pt-2.5">
                  <Row
                    label={t("withdrawal.refund")}
                    value={formatMoney(info.refund_amount, info.currency)}
                    strong
                  />
                </div>
                <p className="flex items-start gap-1.5 pt-1 text-xs leading-relaxed text-neutral-500">
                  <Info size={13} className="mt-0.5 shrink-0" />
                  {info.consent_given ? t("withdrawal.proportionalNote") : t("withdrawal.fullRefundNote")}
                </p>
              </div>

              <label className="mb-1.5 mt-5 block text-sm font-medium text-neutral-300" htmlFor="withdrawal-reason">
                {t("withdrawal.reasonLabel")}
              </label>
              <textarea
                id="withdrawal-reason"
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                maxLength={1000}
                rows={3}
                placeholder={t("withdrawal.reasonPlaceholder") as string}
                className="input-field w-full resize-none text-sm"
              />

              {request.isError && (
                <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
                  {t("withdrawal.error")}
                </div>
              )}

              <button
                onClick={() => setConfirming(true)}
                disabled={request.isPending}
                className="mt-5 w-full rounded-md border border-danger/40 bg-danger/10 px-5 py-3.5 font-semibold text-danger transition hover:bg-danger/20"
              >
                {t("withdrawal.submit")}
              </button>
            </>
          )}

          {!showForm && !req && info.reason === "window_passed" && (
            <div className="card mt-5 text-sm leading-relaxed text-neutral-300">
              <p>
                {t("withdrawal.windowPassed", {
                  date: date(info.deadline),
                  until: subscription ? date(subscription.currentPeriodEnd) : "",
                })}
              </p>
              <p className="mt-3 text-neutral-400">{t("withdrawal.problemHint")}</p>
              <Link to="/support" className="mt-3 inline-block font-semibold text-volt-400">
                {t("withdrawal.support")}
              </Link>
            </div>
          )}

          {!showForm && !req && info.reason === "no_paid" && (
            <div className="card mt-5 text-sm leading-relaxed text-neutral-300">{t("withdrawal.noPaid")}</div>
          )}

          <a
            href={REFUND_POLICY_URL}
            target="_blank"
            rel="noreferrer"
            className="mt-6 flex items-center justify-center gap-1.5 text-sm text-neutral-400 hover:text-neutral-200"
          >
            <FileText size={14} /> {t("withdrawal.policyLink")}
          </a>
        </>
      )}

      {confirming && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 px-4 animate-fade-in"
          onClick={() => setConfirming(false)}
        >
          <div
            className="w-full max-w-sm rounded-lg border border-ink-700 bg-ink-900 p-6 text-center"
            onClick={(e) => e.stopPropagation()}
            role="dialog"
            aria-modal="true"
          >
            <p className="font-semibold">{t("withdrawal.confirmTitle")}</p>
            <p className="mt-2 text-sm text-neutral-400">{t("withdrawal.confirmBody")}</p>
            <div className="mt-5 flex gap-3">
              <button onClick={() => setConfirming(false)} className="btn-secondary flex-1">
                {t("withdrawal.confirmNo")}
              </button>
              <button
                disabled={request.isPending}
                onClick={() =>
                  request.mutate(reason.trim(), {
                    onSettled: () => setConfirming(false),
                    onSuccess: () => setReason(""),
                  })
                }
                className="flex-1 rounded-md bg-danger px-4 py-3 font-medium text-neutral-0 transition hover:bg-danger/90"
              >
                {t("withdrawal.confirmYes")}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function Row({ label, value, strong }: { label: string; value: string; strong?: boolean }) {
  return (
    <div className="flex items-center justify-between gap-3">
      <span className={strong ? "font-semibold text-neutral-100" : "text-neutral-400"}>{label}</span>
      <span className={clsx("tabular-nums", strong ? "font-display text-lg font-bold text-volt-400" : "text-neutral-200")}>
        {value}
      </span>
    </div>
  );
}

function RequestStatus({
  status,
  req,
  date,
}: {
  status: RefundStatus;
  req: NonNullable<WithdrawalInfo["request"]>;
  date: (iso?: string | null) => string;
}) {
  const { t } = useTranslation();
  const amount = formatMoney(req.refund_amount, req.currency);
  const Icon = status === "refunded" ? CheckCircle2 : status === "rejected" ? XCircle : Clock;
  const text =
    status === "pending"
      ? t("withdrawal.statusPending", { date: date(req.requested_at), amount, payBy: date(req.pay_by) })
      : status === "approved"
        ? t("withdrawal.statusApproved", { amount, payBy: date(req.pay_by) })
        : status === "refunded"
          ? t("withdrawal.statusRefunded", { date: date(req.refunded_at), amount })
          : t("withdrawal.statusRejected");

  return (
    <div
      className={clsx(
        "card mt-5",
        status === "refunded" && "border-success/30 bg-success/5",
        status === "rejected" && "border-danger/30 bg-danger/5",
        (status === "pending" || status === "approved") && "border-volt-400/30 bg-volt-400/5",
      )}
    >
      <p className="flex items-center gap-2 font-semibold">
        <Icon
          size={18}
          className={status === "refunded" ? "text-success" : status === "rejected" ? "text-danger" : "text-volt-400"}
        />
        {t(`withdrawal.statusTitle.${status}`)}
      </p>
      <p className="mt-2 text-sm leading-relaxed text-neutral-300">{text}</p>
      {req.admin_comment && <p className="mt-2 text-sm italic text-neutral-400">{req.admin_comment}</p>}
    </div>
  );
}
