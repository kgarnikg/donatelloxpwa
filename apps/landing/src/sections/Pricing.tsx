import { Check, Flame } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import type { SubscriptionPlan } from "@donatellox/types";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

const PLAN_ORDER: { value: SubscriptionPlan; discountBadge?: string; highlight?: "popular" | "best-value" }[] = [
  { value: "monthly" },
  { value: "quarterly", discountBadge: "-25%" },
  { value: "semiannual", discountBadge: "-40%", highlight: "popular" },
  { value: "annual", discountBadge: "-60%", highlight: "best-value" },
];

export function Pricing() {
  const { t } = useTranslation();
  const baseFeatures = t("pricing.baseFeatures", { returnObjects: true }) as string[];
  const paymentMethods = t("pricing.paymentMethods", { returnObjects: true }) as string[];

  return (
    <section id="pricing" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("pricing.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("pricing.title")}</h2>
          <p className="mt-4 text-neutral-400">{t("pricing.subtitle")}</p>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {PLAN_ORDER.map((plan) => {
            const planData = t(`pricing.plans.${plan.value}`, { returnObjects: true }) as {
              label: string;
              perMonth: string;
              originalTotal?: string;
            };
            const features =
              plan.highlight === "best-value"
                ? [
                    ...baseFeatures,
                    t("pricing.extraFeatures.prioritySupport"),
                    t("pricing.extraFeatures.earlyAccess"),
                    t("pricing.extraFeatures.maxSavings"),
                  ]
                : plan.highlight === "popular"
                  ? [...baseFeatures, t("pricing.extraFeatures.prioritySupport"), t("pricing.extraFeatures.earlyAccess")]
                  : plan.value === "quarterly"
                    ? [...baseFeatures, t("pricing.extraFeatures.prioritySupport")]
                    : baseFeatures;

            return (
              <div
                key={plan.value}
                className={clsx(
                  "card relative flex flex-col",
                  plan.highlight === "popular" && "border-volt-400/60 shadow-glow",
                  plan.highlight === "best-value" && "border-ember-400/50",
                )}
              >
                {plan.highlight === "popular" && (
                  <span className="absolute -top-3 left-1/2 flex -translate-x-1/2 items-center gap-1 whitespace-nowrap rounded-full bg-volt-400 px-3 py-1 text-xs font-bold text-ink-950">
                    <Flame size={12} /> {t("pricing.popularBadge")}
                  </span>
                )}
                {plan.highlight === "best-value" && (
                  <span className="absolute -top-3 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-full bg-ember-400 px-3 py-1 text-xs font-bold text-ink-950">
                    {t("pricing.bestValueBadge")}
                  </span>
                )}

                {plan.discountBadge && (
                  <span className="mb-3 inline-block w-fit rounded-full bg-volt-400/10 px-2.5 py-1 text-xs font-semibold text-volt-400">
                    {plan.discountBadge}
                  </span>
                )}

                <h3 className="font-semibold">{planData.label}</h3>
                <p className="mt-2">
                  <span className="font-display text-3xl font-bold">
                    {plan.value === "monthly" ? "19,99 $" : planData.perMonth}
                  </span>
                </p>
                {plan.value !== "monthly" && <p className="text-sm text-neutral-400">{planData.perMonth}</p>}
                {plan.value === "monthly" && <p className="text-sm text-neutral-400">{planData.perMonth}</p>}
                {planData.originalTotal && (
                  <p className="mt-1 text-xs text-neutral-600 line-through">{planData.originalTotal}</p>
                )}

                <ul className="mt-6 flex-1 space-y-3">
                  {features.map((f) => (
                    <li key={f} className="flex items-start gap-2 text-sm text-neutral-300">
                      <Check size={16} className="mt-0.5 shrink-0 text-volt-400" />
                      {f}
                    </li>
                  ))}
                </ul>

                <a
                  href={`${APP_URL}/register`}
                  className={clsx("mt-8 w-full", plan.highlight ? "btn-primary" : "btn-secondary")}
                >
                  {t("pricing.choosePlan")}
                </a>
              </div>
            );
          })}
        </div>

        <div className="mt-10 flex flex-wrap items-center justify-center gap-x-6 gap-y-2 text-sm text-neutral-500">
          <span>{t("pricing.paymentMethodsLabel")}</span>
          {paymentMethods.map((m) => (
            <span key={m} className="rounded-full border border-ink-700 px-3 py-1">
              {m}
            </span>
          ))}
        </div>
      </div>
    </section>
  );
}
