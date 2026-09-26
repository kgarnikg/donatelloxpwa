import type { ReactNode } from "react";
import { Navigate, useLocation } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { Lock } from "lucide-react";
import { useAuth } from "@/context/AuthContext";

export function ProtectedRoute({ children }: { children: ReactNode }) {
  const { session, loading, profile, signOut } = useAuth();
  const { t } = useTranslation();
  const location = useLocation();

  if (loading) {
    return (
      <div className="flex min-h-dvh items-center justify-center bg-ink-950">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
      </div>
    );
  }

  if (!session) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  // Аккаунт заблокирован в админке (0083): вход уже закрыт на стороне
  // Supabase, а если сессия ещё жива — показываем экран и выходим.
  if (profile?.isBlocked) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
        <div className="flex h-14 w-14 items-center justify-center rounded-full bg-danger/10 text-danger">
          <Lock size={24} />
        </div>
        <h1 className="mt-4 font-display text-xl font-bold">{t("auth.blocked.title")}</h1>
        <p className="mt-2 max-w-xs text-sm text-neutral-400">{t("auth.blocked.text")}</p>
        <a href="mailto:hello@donatellex.com" className="mt-4 text-sm font-semibold text-volt-400">
          hello@donatellex.com
        </a>
        <button onClick={() => signOut()} className="btn-secondary mt-6 w-full max-w-xs">
          {t("auth.blocked.signOut")}
        </button>
      </div>
    );
  }

  return <>{children}</>;
}
