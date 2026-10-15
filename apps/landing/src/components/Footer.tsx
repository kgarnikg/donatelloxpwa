import { useLocation } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { COMPANY } from "@/lib/company";

const GROUP_KEYS = ["product", "company", "legal"] as const;
const GROUP_LINK_HREFS: Record<(typeof GROUP_KEYS)[number], Record<string, string>> = {
  product: { features: "#modules", pricing: "#pricing", faq: "#faq" },
  company: { about: "#top", contact: "/contact" },
  legal: { terms: "/terms", privacy: "/privacy", refund: "/refund" },
};

export function Footer() {
  const { t } = useTranslation();
  // На юридических страницах якоря (#pricing…) ведут на главную
  const onHome = useLocation().pathname === "/";
  const hrefOf = (href: string) => (href.startsWith("#") && !onHome ? `/${href}` : href);

  return (
    <footer className="border-t border-ink-800 bg-ink-950 py-12">
      <div className="section-container">
        <div className="grid grid-cols-2 gap-8 md:grid-cols-4">
          <div className="col-span-2 md:col-span-1">
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-md bg-volt-400 font-display font-bold text-ink-950">
                D
              </div>
              <span className="font-display text-lg font-bold">DonatelleX</span>
            </div>
            <p className="mt-3 max-w-xs text-sm text-neutral-500">{t("footer.description")}</p>
          </div>

          {GROUP_KEYS.map((groupKey) => {
            const group = t(`footer.groups.${groupKey}`, { returnObjects: true }) as {
              title: string;
              links: Record<string, string>;
            };
            return (
              <div key={groupKey}>
                <h3 className="mb-3 text-sm font-semibold text-neutral-200">{group.title}</h3>
                <ul className="space-y-2">
                  {Object.entries(group.links).map(([linkKey, label]) => (
                    <li key={linkKey}>
                      <a
                        href={hrefOf(GROUP_LINK_HREFS[groupKey][linkKey])}
                        className="text-sm text-neutral-500 hover:text-neutral-300"
                      >
                        {label}
                      </a>
                    </li>
                  ))}
                </ul>
              </div>
            );
          })}
        </div>

        {/* Реквизиты продавца и контакты — на каждой странице (требование банка) */}
        <div className="mt-10 border-t border-ink-800 pt-6 text-xs leading-relaxed text-neutral-500">
          <p>
            <span className="text-neutral-300">{t("company.name")}</span> · {t("company.tinLabel")}{" "}
            <span dir="ltr">{COMPANY.tin}</span> · {t("company.regLabel")} <span dir="ltr">{COMPANY.regNo}</span>
          </p>
          <p className="mt-1">
            {t("company.address")} ·{" "}
            <a href={COMPANY.phoneHref} className="hover:text-neutral-300" dir="ltr">
              {COMPANY.phone}
            </a>{" "}
            ·{" "}
            <a href={`mailto:${COMPANY.email}`} className="hover:text-neutral-300">
              {COMPANY.email}
            </a>
          </p>
        </div>

        <div className="mt-6 flex flex-col items-center justify-between gap-4 text-sm text-neutral-600 sm:flex-row">
          <p>{t("footer.copyright", { year: new Date().getFullYear() })}</p>
          <p>{t("footer.paymentLine")}</p>
        </div>
      </div>
    </footer>
  );
}
