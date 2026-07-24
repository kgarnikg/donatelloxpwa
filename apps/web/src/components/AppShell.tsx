import type { ReactNode } from "react";
import { NavLink } from "react-router-dom";
import { Home, Dumbbell, Apple, LineChart, User } from "lucide-react";
import clsx from "clsx";

const NAV_ITEMS = [
  { to: "/dashboard", label: "Главная", icon: Home },
  { to: "/programs", label: "Программы", icon: Dumbbell },
  { to: "/nutrition", label: "Питание", icon: Apple },
  { to: "/progress", label: "Прогресс", icon: LineChart },
  { to: "/profile", label: "Профиль", icon: User },
];

export function AppShell({ children }: { children: ReactNode }) {
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
