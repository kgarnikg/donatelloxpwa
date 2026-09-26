import { Check, Flame, Trophy } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { formatRegionPrice, getRegionPrices } from "@donatellox/types";
import { useRegion } from "@/context/RegionContext";
import { REGION_PAYMENT_METHODS, type PurchasablePlan } from "@/lib/regionPricing";
import { APP_URL } from "@/lib/appUrl";

type Highlight = "popular" | "best-value";

const PLAN_ORDER: { value: PurchasablePlan; highlight?: Highlight }[] = [
  { value: "monthly" },
  { value: "quarterly" },
  { value: "semiannual", highlight: "popular" },
  { value: "annual", highlight: "best-value" },
];

/**
 * Карточки цен по образцу "сильных" прайсингов фитнес-приложений:
 * крупная цена за месяц, крупно зачёркнутая старая цена рядом с итоговой,
 * диагональная лента со скидкой в углу и одна яркая кнопка на всю ширину.
 * Процент скидки и экономия считаются из тех же цифр, что и чекаут
 * (`@donatellox/types`, pricing.ts), — вручную их нигде не прописываем.
 */
export function Pricing() {
  const { t } = useTranslation();
  const { region } = useRegion();
  const prices = getRegionPrices(region);
  const baseFeatures = t("pricing.baseFeatures", { returnObjects: true }) as string[];
  const paymentMethods = REGION_PAYMENT_METHODS[region];
  const price = (minor: number) => formatRegionPrice(region, minor);

  return (
    <section id="pricing" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("pricing.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("pricing.title")}</h2>
          <p className="mt-4 text-neutral-400">{t("pricing.subtitle")}</p>
        </div>

        <div className="mt-14 grid grid-cols-1 items-stretch gap-6 sm:grid-cols-2 lg:grid-cols-4 lg:gap-5">
          {PLAN_ORDER.map((plan) => {
            const p = prices[plan.value];
            const label = t(`pricing.plans.${plan.value}.label`) as string;
            const discount = p.original ? Math.round((1 - p.total / p.original) * 100) : 0;
            const isPopular = plan.highlight === "popular";
            const isBest = plan.highlight === "best-value";

            const features = isBest
              ? [
                  ...baseFeatures,
                  t("pricing.extraFeatures.prioritySupport"),
                  t("pricing.extraFeatures.earlyAccess"),
                  t("pricing.extraFeatures.maxSavings"),
                ]
              : isPopular
                ? [...baseFeatures, t("pricing.extraFeatures.prioritySupport"), t("pricing.extraFeatures.earlyAccess")]
                : plan.value === "quarterly"
                  ? [...baseFeatures, t("pricing.extraFeatures.prioritySupport")]
                  : baseFeatures;

            return (
              <div
                key={plan.value}
                className={clsx(
                  "relative flex flex-col rounded-2xl border bg-ink-900 transition duration-200 hover:-translate-y-1",
                  isPopular &&
                    "border-volt-400 bg-gradient-to-b from-volt-400/[0.10] to-ink-900 shadow-[0_0_0_1px_rgba(168,224,0,0.5),0_0_48px_rgba(168,224,0,0.22)] lg:-my-2",
                  isBest && "border-ember-400/80 shadow-[0_0_0_1px_rgba(255,107,53,0.4),0_0_40px_rgba(255,107,53,0.16)]",
                  !plan.highlight && "border-ink-700 hover:border-ink-600",
                )}
              >
                {plan.highlight && (
                  <span
                    className={clsx(
                      "absolute -top-3.5 left-1/2 z-10 flex -translate-x-1/2 items-center gap-1.5 whitespace-nowrap rounded-full px-4 py-1.5 text-xs font-extrabold uppercase tracking-[0.1em] text-ink-950 shadow-lg",
                      isPopular ? "bg-volt-400" : "bg-ember-400",
                    )}
                  >
                    {isPopular ? <Flame size={14} /> : <Trophy size={14} />}
                    {isPopular ? t("pricing.popularBadge") : t("pricing.bestValueBadge")}
                  </span>
                )}

                {discount > 0 && (
                  <div className="pointer-events-none absolute end-0 top-0 h-28 w-28 overflow-hidden rounded-se-2xl" aria-hidden>
                    <div
                      className={clsx(
                        "absolute -end-9 top-[22px] w-40 rotate-45 py-1.5 text-center font-display text-lg font-extrabold shadow-lg rtl:-rotate-45",
                        isPopular ? "bg-ink-950 text-volt-400" : "bg-volt-400 text-ink-950",
                      )}
                    >
                      <span dir="ltr">−{discount}%</span>
                    </div>
                  </div>
                )}

                <div className="flex flex-1 flex-col p-6 pt-8">
                  <h3 className="pe-14 text-sm font-bold uppercase tracking-[0.14em] text-neutral-300">{label}</h3>

                  <div className="mt-4 flex flex-wrap items-end gap-x-1.5">
                    <span className="whitespace-nowrap font-display text-5xl font-extrabold leading-none tracking-tight lg:text-4xl">
                      {price(p.perMonth)}
                    </span>
                    <span className="whitespace-nowrap pb-0.5 text-base text-neutral-400">{t("pricing.perMonthSuffix")}</span>
                  </div>

                  <div className="mt-4 min-h-[64px]">
                    {p.original ? (
                      <>
                        <p className="flex flex-wrap items-baseline gap-x-2 gap-y-0.5">
                          <span className="text-xl font-semibold text-neutral-500 line-through decoration-ember-400 decoration-2">
                            {price(p.original)}
                          </span>
                          <span className="text-lg font-bold text-neutral-0">
                            {t("pricing.totalFor", { amount: price(p.total), label })}
                          </span>
                        </p>
                        <span className="mt-2 inline-block rounded-md bg-volt-400/15 px-2 py-0.5 text-sm font-bold text-volt-400">
                          {t("pricing.save", { amount: price(p.original - p.total) })}
                        </span>
                      </>
                    ) : (
                      <>
                        <p className="text-lg font-bold text-neutral-0">
                          {t("pricing.totalFor", { amount: price(p.total), label })}
                        </p>
                        <p className="mt-1 text-sm text-neutral-500">{t("pricing.oneTime")}</p>
                      </>
                    )}
                  </div>

                  <a
                    href={`${APP_URL}/register`}
                    className={clsx(
                      "mt-6 inline-flex w-full items-center justify-center rounded-lg px-6 py-4 text-base font-extrabold uppercase tracking-wide transition active:scale-[0.98]",
                      isPopular && "bg-volt-400 text-ink-950 hover:bg-volt-300",
                      isBest && "bg-ember-400 text-ink-950 hover:brightness-110",
                      !plan.highlight && "bg-neutral-0 text-ink-950 hover:bg-neutral-200",
                    )}
                  >
                    {t("pricing.getStarted")}
                  </a>

                  <ul className="mt-6 flex-1 space-y-2.5 border-t border-ink-700 pt-5">
                    {features.map((f) => (
                      <li key={f} className="flex items-start gap-2 text-sm text-neutral-300">
                        <Check size={16} className="mt-0.5 shrink-0 text-volt-400" />
                        {f}
                      </li>
                    ))}
                  </ul>
                </div>
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
