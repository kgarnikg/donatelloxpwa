import { Link } from "react-router-dom";
import { ChevronRight, LogOut, CreditCard, Globe, Bell } from "lucide-react";
import { useAuth } from "@/context/AuthContext";

export default function ProfilePage() {
  const { profile, authUser, signOut } = useAuth();

  const menuItems = [
    { to: "/subscription", label: "Подписка и оплата", icon: CreditCard },
    { to: "/profile/language", label: "Язык интерфейса", icon: Globe },
    { to: "/profile/notifications", label: "Уведомления", icon: Bell },
  ];

  return (
    <div className="px-5 pt-8">
      <h1 className="mb-6 font-display text-2xl font-bold">Профиль</h1>

      <div className="card mb-6 flex items-center gap-4">
        <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-full bg-volt-400/15 font-display text-xl font-bold text-volt-400">
          {(profile?.fullName ?? authUser?.email ?? "?").charAt(0).toUpperCase()}
        </div>
        <div className="min-w-0">
          <p className="truncate font-semibold">{profile?.fullName ?? "Пользователь"}</p>
          <p className="truncate text-sm text-neutral-400">{authUser?.email}</p>
        </div>
      </div>

      <div className="card divide-y divide-ink-700 p-0">
        {menuItems.map(({ to, label, icon: Icon }) => (
          <Link key={to} to={to} className="flex items-center gap-3 px-4 py-3.5 hover:bg-ink-800">
            <Icon size={18} className="text-neutral-400" />
            <span className="flex-1 font-medium">{label}</span>
            <ChevronRight size={18} className="text-neutral-500" />
          </Link>
        ))}
      </div>

      <button
        onClick={() => signOut()}
        className="mt-6 flex w-full items-center justify-center gap-2 rounded-md border border-danger/30 px-5 py-3 font-medium text-danger transition hover:bg-danger/10"
      >
        <LogOut size={18} />
        Выйти
      </button>
    </div>
  );
}
