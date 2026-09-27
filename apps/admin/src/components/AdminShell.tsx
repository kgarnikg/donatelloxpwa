import { useEffect, useState, type ReactNode } from "react";
import { NavLink, useLocation } from "react-router-dom";
import clsx from "clsx";
import {
  LayoutDashboard,
  Users,
  Dumbbell,
  CreditCard,
  Video,
  Settings,
  RotateCcw,
  LogOut,
  Undo2,
  Menu,
  X,
} from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";

const NAV_ITEMS = [
  { to: "/", label: "Обзор", icon: LayoutDashboard, end: true },
  { to: "/users", label: "Пользователи", icon: Users },
  { to: "/programs", label: "Программы", icon: Dumbbell },
  { to: "/videos", label: "Видео", icon: Video },
  { to: "/payments", label: "Платежи", icon: CreditCard },
  { to: "/refunds", label: "Возвраты", icon: Undo2 },
  { to: "/catch-up", label: "Догнать прогресс", icon: RotateCcw },
  { to: "/settings", label: "Настройки сайта", icon: Settings },
];

export function AdminShell({ children }: { children: ReactNode }) {
  const { profile, authUser, signOut } = useAuth();
  const location = useLocation();
  const [menuOpen, setMenuOpen] = useState(false);
  // Сколько заявок на возврат ждут действий — срок по закону 14 дней (0086)
  const { data: openRefunds } = useQuery({
    queryKey: ["admin-refunds-open"],
    refetchInterval: 5 * 60 * 1000,
    queryFn: async () => {
      const { count, error } = await supabase
        .from("refund_requests")
        .select("id", { count: "exact", head: true })
        .in("status", ["pending", "approved"]);
      if (error) return 0;
      return count ?? 0;
    },
  });

  // Телефон: меню закрывается при переходе в раздел; фон не скроллится, пока открыто
  useEffect(() => setMenuOpen(false), [location.pathname]);
  useEffect(() => {
    if (!menuOpen) return;
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && setMenuOpen(false);
    window.addEventListener("keydown", onKey);
    return () => {
      document.body.style.overflow = prev;
      window.removeEventListener("keydown", onKey);
    };
  }, [menuOpen]);

  const current =
    NAV_ITEMS.find((item) => (item.end ? location.pathname === item.to : location.pathname.startsWith(item.to))) ??
    NAV_ITEMS[0];

  const sidebar = (
    <>
      <div className="flex items-center gap-2 border-b border-ink-700 px-6 py-5">
        <div className="flex h-8 w-8 items-center justify-center rounded-md bg-volt-400 font-display font-bold text-ink-950">
          D
        </div>
        <span className="font-display text-lg font-bold">DonatelleX CMS</span>
      </div>

      <nav className="flex-1 space-y-1 overflow-y-auto px-3 py-4">
        {NAV_ITEMS.map(({ to, label, icon: Icon, end }) => (
          <NavLink
            key={to}
            to={to}
            end={end}
            className={({ isActive }) =>
              clsx(
                "flex items-center gap-3 rounded-md px-3 py-3 text-sm font-medium transition-colors md:py-2.5",
                isActive
                  ? "bg-volt-400/10 text-volt-400"
                  : "text-neutral-400 hover:bg-ink-800 hover:text-neutral-100",
              )
            }
          >
            <Icon size={18} />
            <span className="flex-1">{label}</span>
            {to === "/refunds" && !!openRefunds && (
              <span className="rounded-full bg-danger px-2 py-0.5 text-xs font-bold text-neutral-0">{openRefunds}</span>
            )}
          </NavLink>
        ))}
      </nav>

      <div className="border-t border-ink-700 px-4 py-4 pb-[max(1rem,env(safe-area-inset-bottom))]">
        <div className="mb-3 flex items-center gap-3">
          <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-volt-400/15 font-display font-bold text-volt-400">
            {(profile?.fullName ?? authUser?.email ?? "?").charAt(0).toUpperCase()}
          </div>
          <div className="min-w-0">
            <p className="truncate text-sm font-semibold">{profile?.fullName ?? "Администратор"}</p>
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
    </>
  );

  return (
    <div className="flex min-h-dvh bg-ink-950">
      {/* Компьютер: постоянное меню слева */}
      <aside className="sticky top-0 hidden h-dvh w-64 shrink-0 flex-col border-r border-ink-700 bg-ink-900 md:flex">
        {sidebar}
      </aside>

      {/* Телефон: меню выезжает слева по кнопке ☰ */}
      {menuOpen && (
        <div className="fixed inset-0 z-50 md:hidden">
          <div className="absolute inset-0 bg-black/60 animate-fade-in" onClick={() => setMenuOpen(false)} />
          <aside className="absolute inset-y-0 left-0 flex w-72 max-w-[85vw] flex-col border-r border-ink-700 bg-ink-900 pt-[env(safe-area-inset-top)] shadow-2xl">
            <button
              onClick={() => setMenuOpen(false)}
              aria-label="Закрыть меню"
              className="absolute right-3 top-[max(1rem,env(safe-area-inset-top))] rounded-md p-2 text-neutral-400 hover:bg-ink-800 hover:text-neutral-100"
            >
              <X size={20} />
            </button>
            {sidebar}
          </aside>
        </div>
      )}

      <div className="flex min-w-0 flex-1 flex-col">
        {/* Телефон: верхняя панель с названием раздела */}
        <header className="sticky top-0 z-40 flex items-center gap-3 border-b border-ink-700 bg-ink-950/95 px-4 pb-3 pt-[max(0.75rem,env(safe-area-inset-top))] backdrop-blur md:hidden">
          <button
            onClick={() => setMenuOpen(true)}
            aria-label="Открыть меню"
            className="relative -ml-1 rounded-md p-2 text-neutral-200 hover:bg-ink-800"
          >
            <Menu size={22} />
            {!!openRefunds && <span className="absolute right-1.5 top-1.5 h-2.5 w-2.5 rounded-full bg-danger" />}
          </button>
          <current.icon size={18} className="text-volt-400" />
          <span className="truncate font-display text-base font-bold">{current.label}</span>
        </header>

        <main className="min-w-0 flex-1 overflow-x-hidden">
          <div className="mx-auto max-w-6xl px-4 py-5 md:px-10 md:py-10">{children}</div>
        </main>
      </div>
    </div>
  );
}
