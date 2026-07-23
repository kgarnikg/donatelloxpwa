import type { ReactNode } from "react";
import { NavLink } from "react-router-dom";
import clsx from "clsx";
import {
  LayoutDashboard,
  Users,
  Dumbbell,
  CreditCard,
  Video,
  LogOut,
} from "lucide-react";
import { useAuth } from "@/context/AuthContext";

const NAV_ITEMS = [
  { to: "/", label: "Обзор", icon: LayoutDashboard, end: true },
  { to: "/users", label: "Пользователи", icon: Users },
  { to: "/programs", label: "Программы", icon: Dumbbell },
  { to: "/videos", label: "Видео", icon: Video },
  { to: "/payments", label: "Платежи", icon: CreditCard },
];

export function AdminShell({ children }: { children: ReactNode }) {
  const { profile, authUser, signOut } = useAuth();

  return (
    <div className="flex min-h-dvh bg-ink-950">
      <aside className="hidden w-64 shrink-0 flex-col border-r border-ink-700 bg-ink-900 md:flex">
        <div className="flex items-center gap-2 border-b border-ink-700 px-6 py-5">
          <div className="flex h-8 w-8 items-center justify-center rounded-md bg-volt-400 font-display font-bold text-ink-950">
            D
          </div>
          <span className="font-display text-lg font-bold">DonatelloX CMS</span>
        </div>

        <nav className="flex-1 space-y-1 px-3 py-4">
          {NAV_ITEMS.map(({ to, label, icon: Icon, end }) => (
            <NavLink
              key={to}
              to={to}
              end={end}
              className={({ isActive }) =>
                clsx(
                  "flex items-center gap-3 rounded-md px-3 py-2.5 text-sm font-medium transition-colors",
                  isActive
                    ? "bg-volt-400/10 text-volt-400"
                    : "text-neutral-400 hover:bg-ink-800 hover:text-neutral-100",
                )
              }
            >
              <Icon size={18} />
              {label}
            </NavLink>
          ))}
        </nav>

        <div className="border-t border-ink-700 px-4 py-4">
          <div className="mb-3 flex items-center gap-3">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-volt-400/15 font-display font-bold text-volt-400">
              {(profile?.fullName ?? authUser?.email ?? "?").charAt(0).toUpperCase()}
            </div>
            <div className="min-w-0">
              <p className="truncate text-sm font-semibold">
                {profile?.fullName ?? "Администратор"}
              </p>
              <p className="truncate text-xs text-neutral-500">{authUser?.email}</p>
            </div>
          </div>
          <button
            onClick={() => signOut()}
            className="flex w-full items-center gap-2 rounded-md px-3 py-2 text-sm text-neutral-400 transition hover:bg-ink-800 hover:text-neutral-100"
          >
            <LogOut size={16} /> Выйти
          </button>
        </div>
      </aside>

      <main className="min-w-0 flex-1">
        <div className="mx-auto max-w-6xl px-5 py-6 md:px-10 md:py-10">{children}</div>
      </main>
    </div>
  );
}
