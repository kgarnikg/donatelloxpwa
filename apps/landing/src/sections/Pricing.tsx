import { Check } from "lucide-react";
import clsx from "clsx";
import type { SubscriptionPlan } from "@donatellox/types";

const APP_URL = import.meta.env.VITE_WEB_APP_URL || "/";

interface PlanCard {
  value: SubscriptionPlan;
  label: string;
  price: string;
  period: string;
  note?: string;
  featured?: boolean;
  features: string[];
}

const PLANS: PlanCard[] = [
  {
    value: "monthly",
    label: "Месяц",
    price: "9,90 €",
    period: "/ мес.",
    features: ["Все программы тренировок", "Видео-инструкции", "Дневник прогресса"],
  },
  {
    value: "quarterly",
    label: "3 месяца",
    price: "24,90 €",
    period: "/ 3 мес.",
    note: "Экономия 16%",
    featured: true,
    features: [
      "Все программы тренировок",
      "Видео-инструкции",
      "Дневник прогресса",
      "Приоритетная поддержка",
    ],
  },
  {
    value: "annual",
    label: "Год",
    price: "79,90 €",
    period: "/ год",
    note: "Экономия 33%",
    features: [
      "Все программы тренировок",
      "Видео-инструкции",
      "Дневник прогресса",
      "Приоритетная поддержка",
      "Ранний доступ к новым модулям",
    ],
  },
];

const PAYMENT_METHODS = ["Банковская карта · Stripe", "PayPal", "ЮKassa (СБП, карты РФ)", "USDT"];

export function Pricing() {
  return (
    <section id="pricing" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Тарифы</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">
            Прозрачная цена, никаких сюрпризов
          </h2>
          <p className="mt-4 text-neutral-400">Отмена подписки в любой момент прямо в приложении.</p>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-6 md:grid-cols-3">
          {PLANS.map((plan) => (
            <div
              key={plan.value}
              className={clsx(
                "card flex flex-col",
                plan.featured && "border-volt-400/50 shadow-glow",
              )}
            >
              {plan.note && (
                <span className="mb-3 inline-block w-fit rounded-full bg-volt-400/10 px-2.5 py-1 text-xs font-semibold text-volt-400">
                  {plan.note}
                </span>
              )}
              <h3 className="font-semibold">{plan.label}</h3>
              <p className="mt-2">
                <span className="font-display text-3xl font-bold">{plan.price}</span>
                <span className="text-sm text-neutral-500"> {plan.period}</span>
              </p>

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
                className={clsx("mt-8 w-full", plan.featured ? "btn-primary" : "btn-secondary")}
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
