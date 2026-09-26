import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useMutation } from "@tanstack/react-query";
import { Trans, useTranslation } from "react-i18next";
import { ArrowLeft, Check, CreditCard, Lock } from "lucide-react";
import clsx from "clsx";
import {
  PURCHASABLE_PLANS,
  REGIONS,
  formatRegionPrice,
  getPayableAmount,
  getRegionPrices,
  guessRegionFromDevice,
  isDiscountApplicable,
  isRegion,
  type PurchasablePlan,
  type Region,
} from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useActiveSubscription } from "@/lib/queries";
import { useAuth } from "@/context/AuthContext";
import { detectRegionByCountry } from "@/lib/detectRegion";
import { REFUND_POLICY_URL, TERMS_URL, useWithdrawalInfo } from "@/lib/withdrawal";

/**
 * Выбор периода и оплата (Фаза 3).
 *
 * - Цены — из общего `@donatellox/types` (pricing.ts), тот же источник,
 *   что у лендинга и у серверной функции. Сумма здесь — только для показа:
 *   сервер пересчитывает её сам по плану/региону/скидке из БД.
 * - Оплата разовая за период, без автосписаний (см. ARCHITECTURE.md, 4.3).
 * - Провайдер — vPOS Араратбанка. Пока серверная функция не подключена
 *   (ждём документацию и тестовый доступ от банка), кнопка оплаты
 *   выключена флагом VITE_PAYMENTS_ENABLED — честное "скоро", а не ошибка.
 */

const REGION_STORAGE_KEY = "donatellox-region";
const PAYMENTS_ENABLED = import.meta.env.VITE_PAYMENTS_ENABLED === "true";

function readStoredRegion(): Region | null {
  try {
    const stored = localStorage.getItem(REGION_STORAGE_KEY);
    if (isRegion(stored)) return stored;
  } catch {
    // localStorage недоступен (приватный режим и т.п.) — просто угадываем
  }
  return null;
}

export default function SubscriptionPage() {
  const { t, i18n } = useTranslation();
  const { profile } = useAuth();
  const { data: activeSubscription } = useActiveSubscription();
  const [plan, setPlan] = useState<PurchasablePlan>("quarterly");
  const [region, setRegionState] = useState<Region>(
    () =>
      readStoredRegion() ??
      guessRegionFromDevice(i18n.language || navigator.language),
  );

  // Регион ещё не выбирали — уточняем по стране (IP, api/geo.ts): гость из
  // Армении сразу видит цены в драмах. Выбор человека не перетираем.
  useEffect(() => {
    if (readStoredRegion()) return;
    let cancelled = false;
    detectRegionByCountry().then((byCountry) => {
      if (!cancelled && byCountry && !readStoredRegion()) setRegionState(byCountry);
    });
    return () => {
      cancelled = true;
    };
  }, []);
  const [error, setError] = useState<string | null>(null);
  // Одна галочка "Принимаю условия оферты" (0086). В оферте прописано, что
  // доступ открывается сразу после оплаты и при отказе в 14 дней
  // удерживаются использованные дни; то же коротко написано под кнопкой.
  // Без галочки оплатить нельзя.
  const [acceptTerms, setAcceptTerms] = useState(false);
  const consentsGiven = acceptTerms;
  const { data: withdrawal } = useWithdrawalInfo();

  const discountPercent = profile?.pendingDiscountPercent ?? 0;
  const prices = getRegionPrices(region);

  function setRegion(next: Region) {
    setRegionState(next);
    try {
      localStorage.setItem(REGION_STORAGE_KEY, next);
    } catch {
      // не критично — регион просто не запомнится
    }
  }

  const checkout = useMutation({
    mutationFn: async () => {
      setError(null);
      const { data: sessionData } = await supabase.auth.getSession();
      const accessToken = sessionData.session?.access_token;
      if (!accessToken) throw new Error(t("payment.errors.noSession"));

      // Vercel Serverless Function (apps/web/api/create-checkout.ts) —
      // появится вместе с интеграцией банка. Передаём только ВЫБОР
      // пользователя (план + регион), сумму считает сервер.
      const response = await fetch("/api/create-checkout", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${accessToken}`,
        },
        // Согласия сервер сохраняет в платёж (payments.withdrawal_consent_at)
        body: JSON.stringify({
          plan,
          region,
          language: i18n.language,
          acceptTerms,
          // принимая оферту, человек просит открыть доступ сразу (п. «Оплата и доступ»)
          immediateStartConsent: acceptTerms,
        }),
      });

      if (!response.ok) {
        const body = (await response.json().catch(() => ({}))) as {
          message?: string;
        };
        throw new Error(body.message ?? t("payment.errors.createFailed"));
      }

      return response.json() as Promise<{ redirectUrl: string }>;
    },
    onSuccess: (data) => {
      window.location.href = data.redirectUrl;
    },
    onError: (err: Error) => setError(err.message),
  });

  if (activeSubscription) {
    // Безлимитные (gift) подписки заведены с датой окончания далеко в
    // будущем (+100 лет, см. 0022/0027) — для человека это "навсегда".
    const periodEnd = new Date(activeSubscription.currentPeriodEnd);
    const isEffectivelyLifetime =
      activeSubscription.plan === "lifetime" ||
      periodEnd.getFullYear() > new Date().getFullYear() + 50;

    return (
      <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-8">
        <BackLink />
        <div className="card mt-6 border-success/30 bg-success/5 text-center">
          <p className="font-semibold text-success">
            {t("payment.active.title")}
          </p>
          <p className="mt-1 text-sm text-neutral-400">
            {isEffectivelyLifetime
              ? t("payment.active.lifetime")
              : t("payment.active.until", {
                  date: periodEnd.toLocaleDateString(i18n.language),
                })}
          </p>
        </div>
        {withdrawal?.payment_id && (
          <Link
            to="/subscription/withdraw"
            className="mt-4 block text-center text-sm text-neutral-400 underline hover:text-neutral-200"
          >
            {t("withdrawal.profileItem")}
          </Link>
        )}
      </div>
    );
  }

  const payable = getPayableAmount(region, plan, discountPercent);

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-10">
      <BackLink />

      <h1 className="mt-6 font-display text-2xl font-bold">
        {t("payment.title")}
      </h1>
      <p className="mt-1 text-neutral-400">{t("payment.subtitle")}</p>

      {/* Регион — определяет валюту показа цены */}
      <div className="mt-6">
        <p className="mb-2 text-xs uppercase tracking-wide text-neutral-500">
          {t("payment.regionLabel")}
        </p>
        <div className="flex flex-wrap gap-2">
          {REGIONS.map((r) => (
            <button
              key={r}
              onClick={() => setRegion(r)}
              className={clsx(
                "rounded-full border px-4 py-1.5 text-sm transition",
                region === r
                  ? "border-volt-400 bg-volt-400/10 text-volt-400"
                  : "border-ink-600 text-neutral-300 hover:border-ink-500",
              )}
            >
              {t(`payment.regions.${r}`)}
            </button>
          ))}
        </div>
      </div>

      {discountPercent > 0 && (
        <div className="mt-5 rounded-md border border-volt-400/30 bg-volt-400/10 px-4 py-3 text-sm text-volt-400">
          {t("payment.referralBanner", { percent: discountPercent })}
        </div>
      )}

      <div className="mt-5 space-y-3">
        {PURCHASABLE_PLANS.map((p) => {
          const price = prices[p];
          const discounted = discountPercent > 0 && isDiscountApplicable(p);
          const finalAmount = getPayableAmount(region, p, discountPercent);
          const strikeAmount = discounted ? price.total : price.original;
          const savingsPercent = price.original
            ? Math.round((1 - price.total / price.original) * 100)
            : 0;

          return (
            <button
              key={p}
              onClick={() => setPlan(p)}
              className={clsx(
                "card flex w-full items-center justify-between text-left transition",
                plan === p
                  ? "border-volt-400 bg-volt-400/5"
                  : "hover:border-ink-500",
              )}
            >
              <div className="flex items-center gap-3">
                <div
                  className={clsx(
                    "flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2",
                    plan === p
                      ? "border-volt-400 bg-volt-400"
                      : "border-ink-600",
                  )}
                >
                  {plan === p && (
                    <Check size={12} strokeWidth={4} className="text-ink-950" />
                  )}
                </div>
                <div>
                  <p className="font-semibold">{t(`payment.plans.${p}`)}</p>
                  {p !== "monthly" && (
                    <p className="text-xs text-volt-400">
                      {t("payment.perMonth", {
                        amount: formatRegionPrice(region, price.perMonth),
                      })}
                      {savingsPercent > 0 &&
                        ` · ${t("payment.savings", { percent: savingsPercent })}`}
                    </p>
                  )}
                  {discounted && (
                    <p className="text-xs text-volt-400">
                      {t("payment.referralApplied", {
                        percent: discountPercent,
                      })}
                    </p>
                  )}
                </div>
              </div>
              <div className="text-right">
                {strikeAmount !== undefined && (
                  <p className="text-xs text-neutral-500 line-through">
                    {formatRegionPrice(region, strikeAmount)}
                  </p>
                )}
                <p className="font-display text-lg font-bold">
                  {formatRegionPrice(region, finalAmount)}
                </p>
              </div>
            </button>
          );
        })}
      </div>

      <h2 className="mb-3 mt-8 font-display text-lg font-semibold">
        {t("payment.methodTitle")}
      </h2>
      <div className="card flex items-center justify-between border-volt-400/40">
        <div className="flex items-center gap-3">
          <CreditCard size={20} className="text-volt-400" />
          <div>
            <p className="font-medium">{t("payment.methodCard")}</p>
            <p className="mt-0.5 text-xs text-neutral-400">
              {t("payment.methodCardHint")}
            </p>
          </div>
        </div>
        <div className="flex gap-1.5">
          {["Visa", "Mastercard", "ArCa"].map((brand) => (
            <span
              key={brand}
              className="rounded border border-ink-600 px-1.5 py-0.5 text-[10px] font-semibold text-neutral-300"
            >
              {brand}
            </span>
          ))}
        </div>
      </div>

      {error && (
        <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
          {error}
        </div>
      )}

      <div className="mt-6 space-y-3">
        <ConsentCheckbox checked={acceptTerms} onChange={setAcceptTerms}>
          <Trans
            i18nKey="payment.consentTerms"
            components={{
              terms: <a href={TERMS_URL} target="_blank" rel="noreferrer" className="text-volt-400 underline" />,
              refund: <a href={REFUND_POLICY_URL} target="_blank" rel="noreferrer" className="text-volt-400 underline" />,
            }}
          />
        </ConsentCheckbox>
      </div>

      {PAYMENTS_ENABLED ? (
        <button
          onClick={() => checkout.mutate()}
          disabled={checkout.isPending || !consentsGiven}
          className="btn-primary mt-8 w-full"
        >
          {checkout.isPending
            ? t("payment.preparing")
            : t("payment.payButton", {
                amount: formatRegionPrice(region, payable),
              })}
        </button>
      ) : (
        <>
          <button
            disabled
            className="btn-primary mt-8 w-full cursor-not-allowed opacity-60"
          >
            {t("payment.comingSoon")}
          </button>
          <p className="mt-3 text-center text-xs text-neutral-400">
            {t("payment.comingSoonHint")}{" "}
            <Link to="/support" className="text-volt-400 underline">
              {t("payment.contactSupport")}
            </Link>
          </p>
        </>
      )}

      <p className="mt-4 flex items-center justify-center gap-1.5 text-center text-xs text-neutral-500">
        <Lock size={12} />
        {t("payment.secureNote")}
      </p>
      <p className="mt-2 text-center text-xs text-neutral-500">
        {t("payment.oneTimeNote")}
      </p>
      <p className="mt-2 text-center text-xs text-neutral-500">
        {t("payment.accessNote")}
      </p>
    </div>
  );
}

function ConsentCheckbox({
  checked,
  onChange,
  children,
}: {
  checked: boolean;
  onChange: (v: boolean) => void;
  children: React.ReactNode;
}) {
  return (
    <label className="flex cursor-pointer items-start gap-3 text-sm leading-snug text-neutral-300">
      <input type="checkbox" checked={checked} onChange={(e) => onChange(e.target.checked)} className="peer sr-only" />
      <span
        aria-hidden
        className={clsx(
          "mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded border-2 transition peer-focus-visible:ring-2 peer-focus-visible:ring-volt-400/50",
          checked ? "border-volt-400 bg-volt-400 text-ink-950" : "border-ink-500",
        )}
      >
        {checked && <Check size={12} strokeWidth={4} />}
      </span>
      <span>{children}</span>
    </label>
  );
}

function BackLink() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  return (
    <button
      onClick={() =>
        window.history.length > 1 ? navigate(-1) : navigate("/dashboard")
      }
      className="inline-flex items-center gap-1 text-sm text-neutral-400 hover:text-white"
    >
      <ArrowLeft size={16} />
      {t("common.back")}
    </button>
  );
}
