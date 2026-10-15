import { Mail, MapPin, Phone } from "lucide-react";
import { useTranslation } from "react-i18next";
import { COMPANY } from "@/lib/company";

/**
 * «Свяжитесь с нами»: email, телефон, физический адрес и реквизиты продавца
 * (требование банка для приёма оплаты картами). На главной — секция #contact,
 * отдельно — страница /contact.
 */
export function Contact({ asPage = false }: { asPage?: boolean }) {
  const { t } = useTranslation();

  const items = [
    {
      icon: Mail,
      label: t("contact.email"),
      value: COMPANY.email,
      href: `mailto:${COMPANY.email}`,
      action: t("contact.write"),
    },
    {
      icon: Phone,
      label: t("contact.phone"),
      value: COMPANY.phone,
      href: COMPANY.phoneHref,
      action: t("contact.call"),
      ltr: true,
    },
    {
      icon: MapPin,
      label: t("contact.address"),
      value: t("company.address"),
      href: COMPANY.mapUrl,
      action: t("contact.map"),
      external: true,
    },
  ];

  return (
    <section id="contact" className={asPage ? "" : "scroll-mt-20 py-20 sm:py-24"}>
      <div className={asPage ? "" : "section-container"}>
        {!asPage && (
          <div className="text-center">
            <p className="eyebrow">{t("contact.eyebrow")}</p>
            <h2 className="mt-2 font-display text-3xl font-bold sm:text-4xl">{t("contact.title")}</h2>
            <p className="mx-auto mt-3 max-w-md text-neutral-400">{t("contact.subtitle")}</p>
          </div>
        )}

        <div className={`grid gap-4 ${asPage ? "not-prose" : "mt-10 md:grid-cols-3"}`}>
          {items.map(({ icon: Icon, label, value, href, action, ltr, external }) => (
            <a
              key={label}
              href={href}
              {...(external ? { target: "_blank", rel: "noopener noreferrer" } : {})}
              className="card group flex flex-col rounded-xl border-ink-700 p-6 transition hover:border-volt-400/40"
            >
              <div className="flex h-11 w-11 items-center justify-center rounded-lg bg-volt-400/10 text-volt-400">
                <Icon size={20} />
              </div>
              <p className="mt-4 text-sm text-neutral-500">{label}</p>
              <p className="mt-1 break-words font-medium text-neutral-100" dir={ltr ? "ltr" : undefined}>
                {value}
              </p>
              <span className="mt-auto pt-4 text-sm font-semibold text-volt-400 group-hover:underline">{action} →</span>
            </a>
          ))}
        </div>

        <div className="not-prose mt-6 rounded-xl border border-ink-800 bg-ink-900/50 px-6 py-4 text-sm text-neutral-400">
          <span className="text-neutral-500">{t("contact.seller")}:</span>{" "}
          <span className="text-neutral-200">{t("company.name")}</span>
          <span className="mx-2 text-ink-600">·</span>
          {t("company.tinLabel")}: <span dir="ltr">{COMPANY.tin}</span>
          <span className="mx-2 text-ink-600">·</span>
          {t("company.regLabel")}: <span dir="ltr">{COMPANY.regNo}</span>
        </div>
      </div>
    </section>
  );
}
