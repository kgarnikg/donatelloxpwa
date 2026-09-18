import { useState } from "react";
import { useMutation } from "@tanstack/react-query";
import { Check } from "lucide-react";
import clsx from "clsx";
import type { SubscriptionPlan, PaymentProvider } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useActiveSubscription } from "@/lib/queries";

const PLANS: { value: SubscriptionPlan; label: string; price: string; note?: string }[] = [
  { value: "monthly", label: "1 месяц", price: "19,99 $" },
  { value: "quarterly", label: "3 месяца", price: "45 $", note: "15 $/мес · экономия 25%" },
  { value: "semiannual", label: "6 месяцев", price: "71,9 $", note: "11,9 $/мес · экономия 40%" },
  { value: "annual", label: "12 месяцев", price: "96,9 $", note: "8,08 $/мес · экономия 60%" },
];

const PROVIDERS: { value: PaymentProvider; label: string; hint: string }[] = [
  { value: "stripe", label: "Банковская карта", hint: "Stripe · Европа/мир" },
  { value: "paypal", label: "PayPal", hint: "Быстрая оплата без карты" },
  { value: "yookassa", label: "ЮKassa", hint: "Карты РФ, СБП" },
  { value: "usdt", label: "USDT", hint: "TRC20 / ERC20 / BEP20" },
];

export default function SubscriptionPage() {
  const { data: activeSubscription } = useActiveSubscription();
  const [plan, setPlan] = useState<SubscriptionPlan>("quarterly");
  const [provider, setProvider] = useState<PaymentProvider>("stripe");
  const [error, setError] = useState<string | null>(null);

  const checkout = useMutation({
    mutationFn: async () => {
      setError(null);
      const { data: sessionData } = await supabase.auth.getSession();
      const accessToken = sessionData.session?.access_token;
      if (!accessToken) throw new Error("Не удалось получить сессию. Войдите заново.");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/create-checkout`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${accessToken}`,
          },
          body: JSON.stringify({
            plan,
            provider,
            successUrl: `${window.location.origin}/dashboard?checkout=success`,
            cancelUrl: `${window.location.origin}/subscription?checkout=cancelled`,
          }),
        },
      );

      if (!response.ok) {
        const body = await response.json().catch(() => ({}));
        throw new Error(body.message ?? "Не удалось создать платёж");
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
    // будущем (+100 лет, см. 0022/0027) — для человека это "навсегда",
    // показывать конкретную дату через 100 лет неинформативно и странно.
    const periodEnd = new Date(activeSubscription.currentPeriodEnd);
    const isEffectivelyLifetime =
      activeSubscription.plan === "lifetime" ||
      periodEnd.getFullYear() > new Date().getFullYear() + 50;

    return (
      <div className="px-5 pt-8">
        <div className="card border-success/30 bg-success/5 text-center">
          <p className="font-semibold text-success">Доступ активен</p>
          <p className="mt-1 text-sm text-neutral-400">
            {isEffectivelyLifetime ? "Бессрочный доступ" : `Действует до ${periodEnd.toLocaleDateString("ru-RU")}`}
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="px-5 pt-8">
      <h1 className="font-display text-2xl font-bold">Выбери период</h1>
      <p className="mt-1 text-neutral-400">
        Оплата разовая — доступ ко всем программам и видео ровно на выбранный срок, без автосписаний.
      </p>

      <div className="mt-6 space-y-3">
        {PLANS.map((p) => (
          <button
            key={p.value}
            onClick={() => setPlan(p.value)}
            className={clsx(
              "card flex w-full items-center justify-between text-left transition",
              plan === p.value ? "border-volt-400 bg-volt-400/5" : "hover:border-ink-500",
            )}
          >
            <div className="flex items-center gap-3">
              <div
                className={clsx(
                  "flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2",
                  plan === p.value ? "border-volt-400 bg-volt-400" : "border-ink-600",
                )}
              >
                {plan === p.value && <Check size={12} strokeWidth={4} className="text-ink-950" />}
              </div>
              <div>
                <p className="font-semibold">{p.label}</p>
                {p.note && <p className="text-xs text-volt-400">{p.note}</p>}
              </div>
            </div>
            <p className="font-display text-lg font-bold">{p.price}</p>
          </button>
        ))}
      </div>

      <h2 className="mb-3 mt-8 font-display text-lg font-semibold">Способ оплаты</h2>
      <div className="grid grid-cols-2 gap-3">
        {PROVIDERS.map((p) => (
          <button
            key={p.value}
            onClick={() => setProvider(p.value)}
            className={clsx(
              "card text-left transition",
              provider === p.value ? "border-volt-400 bg-volt-400/5" : "hover:border-ink-500",
            )}
          >
            <p className="font-medium">{p.label}</p>
            <p className="mt-0.5 text-xs text-neutral-400">{p.hint}</p>
          </button>
        ))}
      </div>

      {error && (
        <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
          {error}
        </div>
      )}

      <button
        onClick={() => checkout.mutate()}
        disabled={checkout.isPending}
        className="btn-primary mt-8 w-full"
      >
        {checkout.isPending ? "Готовим оплату…" : "Оплатить и получить доступ"}
      </button>
      <p className="mt-3 text-center text-xs text-neutral-500">
        Без подписки и автосписаний — платишь один раз за выбранный период.
      </p>

      <p className="mt-4 text-center text-xs text-neutral-500">
        Оплата обрабатывается партнёром безопасно. Отменить подписку можно в любой момент в личном
        кабинете.
      </p>
    </div>
  );
}
