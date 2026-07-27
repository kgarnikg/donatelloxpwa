import { useEffect, useState } from "react";
import { Menu, X } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

export function Header() {
  const { t } = useTranslation();
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 8);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  const navLinks = [
    { href: "#modules", label: t("header.nav.modules") },
    { href: "#plan", label: t("header.nav.plan") },
    { href: "#pricing", label: t("header.nav.pricing") },
    { href: "#how-it-works", label: t("header.nav.howItWorks") },
    { href: "#faq", label: t("header.nav.faq") },
  ];

  return (
    <header
      className={clsx(
        "fixed inset-x-0 top-0 z-50 transition-colors",
        scrolled ? "border-b border-ink-700 bg-ink-950/90 backdrop-blur" : "bg-transparent",
      )}
    >
      <div className="section-container flex h-16 items-center justify-between">
        <a href="#top" className="flex items-center gap-2">
          <div className="flex h-8 w-8 items-center justify-center rounded-md bg-volt-400 font-display font-bold text-ink-950">
            D
          </div>
          <span className="font-display text-lg font-bold">DonatelloX</span>
        </a>

        <nav className="hidden items-center gap-8 md:flex">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-sm font-medium text-neutral-300 transition hover:text-neutral-0"
            >
              {link.label}
            </a>
          ))}
        </nav>

        <div className="hidden items-center gap-3 md:flex">
          <a href={APP_URL} className="text-sm font-medium text-neutral-300 hover:text-neutral-0">
            {t("header.login")}
          </a>
          <a href={`${APP_URL}/register`} className="btn-primary py-2.5 text-sm">
            {t("header.startFree")}
          </a>
        </div>

        <button
          className="text-neutral-300 md:hidden"
          onClick={() => setMenuOpen((v) => !v)}
          aria-label={t("header.menuAriaLabel") ?? undefined}
        >
          {menuOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>

      {menuOpen && (
        <div className="border-t border-ink-700 bg-ink-950 px-6 py-4 md:hidden">
          <nav className="flex flex-col gap-4">
            {navLinks.map((link) => (
              <a
                key={link.href}
                href={link.href}
                onClick={() => setMenuOpen(false)}
                className="text-sm font-medium text-neutral-300"
              >
                {link.label}
              </a>
            ))}
            <a href={APP_URL} className="text-sm font-medium text-neutral-300">
              {t("header.login")}
            </a>
            <a href={`${APP_URL}/register`} className="btn-primary text-sm">
              {t("header.startFree")}
            </a>
          </nav>
        </div>
      )}
    </header>
  );
}
