import type { ReactNode } from "react";
import { Navigate, useLocation } from "react-router-dom";
import { useAuth } from "@/context/AuthContext";

/**
 * Пропускает только авторизованных пользователей с ролью admin/superadmin.
 * Обычные пользователи с валидной сессией, но без нужной роли, получают
 * экран "доступ запрещён" вместо тихого редиректа — так яснее, что происходит.
 */
export function RequireAdmin({ children }: { children: ReactNode }) {
  const { session, isAuthorized, loading, signOut } = useAuth();
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

  if (!isAuthorized) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center gap-4 bg-ink-950 px-6 text-center">
        <h1 className="font-display text-xl font-bold">Доступ запрещён</h1>
        <p className="max-w-sm text-neutral-400">
          У вашей учётной записи нет прав администратора DonatelleX CMS.
        </p>
        <button onClick={() => signOut()} className="btn-secondary">
          Выйти и войти другим аккаунтом
        </button>
      </div>
    );
  }

  return <>{children}</>;
}
