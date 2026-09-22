import { useEffect, useState, type ReactNode } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { CheckCircle2, Loader2, XCircle, Clock } from "lucide-react";
import { useActiveSubscription } from "@/lib/queries";

/**
 * Страницы возврата после оплаты: /payment/success и /payment/failed.
 *
 * Сюда клиента возвращает НАША серверная функция после проверки статуса
 * заказа в банке (getOrderStatusExtended) — не сам банк напрямую и не по
 * параметрам в URL. Поэтому "успех" здесь — не вера на слово: страница
 * всё равно дожидается, пока в БД появится активный доступ, и только
 * тогда показывает "Доступ открыт".
 */

const POLL_INTERVAL_MS = 3000;
const POLL_TIMEOUT_MS = 45000;

export function PaymentSuccessPage() {
  const { t, i18n } = useTranslation();
  const { data: subscription, refetch } = useActiveSubscription();
  const [timedOut, setTimedOut] = useState(false);

  useEffect(() => {
    if (subscription) return;
    const interval = window.setInterval(() => void refetch(), POLL_INTERVAL_MS);
    const timeout = window.setTimeout(() => setTimedOut(true), POLL_TIMEOUT_MS);
    return () => {
      window.clearInterval(interval);
      window.clearTimeout(timeout);
    };
  }, [subscription, refetch]);

  if (subscription) {
    const until = new Date(subscription.currentPeriodEnd).toLocaleDateString(
      i18n.language,
    );
    return (
      <ResultLayout
        icon={<CheckCircle2 size={56} className="text-success" />}
        title={t("payment.result.successTitle")}
        text={t("payment.result.successText", { date: until })}
      >
        <Link to="/dashboard" className="btn-primary w-full">
          {t("payment.result.toDashboard")}
        </Link>
      </ResultLayout>
    );
  }

  if (timedOut) {
    return (
      <ResultLayout
        icon={<Clock size={56} className="text-volt-400" />}
        title={t("payment.result.pendingTitle")}
        text={t("payment.result.pendingText")}
      >
        <button onClick={() => void refetch()} className="btn-primary w-full">
          {t("payment.result.checkAgain")}
        </button>
        <Link
          to="/support"
          className="mt-3 block text-center text-sm text-volt-400 underline"
        >
          {t("payment.contactSupport")}
        </Link>
      </ResultLayout>
    );
  }

  return (
    <ResultLayout
      icon={<Loader2 size={56} className="animate-spin text-volt-400" />}
      title={t("payment.result.checkingTitle")}
      text={t("payment.result.checkingText")}
    />
  );
}

export function PaymentFailedPage() {
  const { t } = useTranslation();
  return (
    <ResultLayout
      icon={<XCircle size={56} className="text-danger" />}
      title={t("payment.result.failedTitle")}
      text={t("payment.result.failedText")}
    >
      <Link to="/subscription" className="btn-primary w-full">
        {t("payment.result.tryAgain")}
      </Link>
      <Link
        to="/support"
        className="mt-3 block text-center text-sm text-volt-400 underline"
      >
        {t("payment.contactSupport")}
      </Link>
    </ResultLayout>
  );
}

function ResultLayout({
  icon,
  title,
  text,
  children,
}: {
  icon: ReactNode;
  title: string;
  text: string;
  children?: ReactNode;
}) {
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
      {icon}
      <h1 className="mt-6 font-display text-2xl font-bold">{title}</h1>
      <p className="mt-2 max-w-sm text-neutral-400">{text}</p>
      {children && <div className="mt-8 w-full max-w-sm">{children}</div>}
    </div>
  );
}
