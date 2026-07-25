import type { ReactNode } from "react";
import { NavLink } from "react-router-dom";
import { Home, Dumbbell, Apple, LineChart, User } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";

export function AppShell({ children }: { children: ReactNode }) {
  const { t } = useTranslation();
  const NAV_ITEMS = [
    { to: "/dashboard", label: t("nav.home"), icon: Home },
    { to: "/programs", label: t("nav.programs"), icon: Dumbbell },
    { to: "/nutrition", label: t("nav.nutrition"), icon: Apple },
    { to: "/progress", label: t("nav.progress"), icon: LineChart },
    { to: "/profile", label: t("nav.profile"), icon: User },
  ];
  return (
    <div className="flex min-h-dvh flex-col bg-ink-950">
      <main className="flex-1 pb-24">{children}</main>

      <nav
        className="fixed inset-x-0 bottom-0 z-40 border-t border-ink-700 bg-ink-900/95 backdrop-blur
          pb-[env(safe-area-inset-bottom)]"
      >
        <div className="mx-auto flex max-w-md items-stretch justify-around">
          {NAV_ITEMS.map(({ to, label, icon: Icon }) => (
            <NavLink
              key={to}
              to={to}
              className={({ isActive }) =>
                clsx(
                  "flex flex-1 flex-col items-center gap-1 py-3 text-xs font-medium transition-colors",
                  isActive ? "text-volt-400" : "text-neutral-400 hover:text-neutral-200",
                )
              }
            >
              <Icon size={22} strokeWidth={2} />
              {label}
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  );
}
