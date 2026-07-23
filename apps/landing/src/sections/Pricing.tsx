import { Check, Flame } from "lucide-react";
import clsx from "clsx";
import type { SubscriptionPlan } from "@donatellox/types";

const APP_URL = import.meta.env.VITE_WEB_APP_URL || "/";

interface PlanCard {
  value: SubscriptionPlan;
  label: string;
  price: string;
  perMonth: string;
  originalTotal?: string;
  discountBadge?: string;
  highlightBadge?: "popular" | "best-value";
  features: string[];
}

const BASE_FEATURES = [
  "Все программы тренировок",
  "Видео-инструкции к каждому упражнению",
  "Дневник прогресса",
  "Персональный подбор программы",
];

const PLANS: PlanCard[] = [
  {
    value: "monthly",
    label: "1 месяц",
    price: "19,99 $",
    perMonth: "в месяц",
    features: BASE_FEATURES,
  },
  {
    value: "quarterly",
    label: "3 месяца",
    price: "45 $",
    perMonth: "15 $ / мес.",
    originalTotal: "60 $ за 3 мес.",
    discountBadge: "-25%",
    features: [...BASE_FEATURES, "Приоритетная поддержка"],
  },
  {
    value: "semiannual",
    label: "6 месяцев",
    price: "71,9 $",
    perMonth: "11,9 $ / мес.",
    originalTotal: "119,9 $ за 6 мес.",
    discountBadge: "-40%",
    highlightBadge: "popular",
    features: [...BASE_FEATURES, "Приоритетная поддержка", "Ранний доступ к новым программам"],
  },
  {
    value: "annual",
    label: "12 месяцев",
    price: "96,9 $",
    perMonth: "8,08 $ / мес.",
    originalTotal: "240 $ за год",
    discountBadge: "-60%",
    highlightBadge: "best-value",
    features: [
      ...BASE_FEATURES,
      "Приоритетная поддержка",
      "Ранний доступ к новым программам",
      "Максимальная экономия",
    ],
  },
];

const PAYMENT_METHODS = ["Банковская карта · Stripe", "PayPal", "ЮKassa (СБП, карты РФ)", "USDT"];

export function Pricing() {
  return (
    <section id="pricing" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Выбери свой план</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">
            Первые результаты уже через несколько недель
          </h2>
          <p className="mt-4 text-neutral-400">Отмена подписки в любой момент прямо в приложении.</p>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {PLANS.map((plan) => (
            <div
              key={plan.value}
              className={clsx(
                "card relative flex flex-col",
                plan.highlightBadge === "popular" && "border-volt-400/60 shadow-glow",
                plan.highlightBadge === "best-value" && "border-ember-400/50",
              )}
            >
              {plan.highlightBadge === "popular" && (
                <span className="absolute -top-3 left-1/2 flex -translate-x-1/2 items-center gap-1 whitespace-nowrap rounded-full bg-volt-400 px-3 py-1 text-xs font-bold text-ink-950">
                  <Flame size={12} /> САМЫЙ ПОПУЛЯРНЫЙ
                </span>
              )}
              {plan.highlightBadge === "best-value" && (
                <span className="absolute -top-3 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-full bg-ember-400 px-3 py-1 text-xs font-bold text-ink-950">
                  МАКСИМАЛЬНАЯ ВЫГОДА
                </span>
              )}

              {plan.discountBadge && (
                <span className="mb-3 inline-block w-fit rounded-full bg-volt-400/10 px-2.5 py-1 text-xs font-semibold text-volt-400">
                  {plan.discountBadge}
                </span>
              )}

              <h3 className="font-semibold">{plan.label}</h3>

              <p className="mt-2">
                <span className="font-display text-3xl font-bold">{plan.price}</span>
              </p>
              <p className="text-sm text-neutral-400">{plan.perMonth}</p>
              {plan.originalTotal && (
                <p className="mt-1 text-xs text-neutral-600 line-through">{plan.originalTotal}</p>
              )}

              <ul className="mt-6 flex-1 space-y-3">
                {plan.features.map((f) => (
                  <li key={f} className="flex items-start gap-2 text-sm text-neutral-300">
                    <Check size={16} className="mt-0.5 shrink-0 text-volt-400" />
                    {f}
                  </li>
                ))}
              </ul>

              <a
                href={`${APP_URL}#/register`}
                className={clsx(
                  "mt-8 w-full",
                  plan.highlightBadge ? "btn-primary" : "btn-secondary",
                )}
              >
                Выбрать план
              </a>
            </div>
          ))}
        </div>

        <div className="mt-10 flex flex-wrap items-center justify-center gap-x-6 gap-y-2 text-sm text-neutral-500">
          <span>Принимаем к оплате:</span>
          {PAYMENT_METHODS.map((m) => (
            <span key={m} className="rounded-full border border-ink-700 px-3 py-1">
              {m}
            </span>
          ))}
        </div>
      </div>
    </section>
  );
}
