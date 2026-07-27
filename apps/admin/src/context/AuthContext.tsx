import {
  createContext,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import type { Session, User as SupabaseUser } from "@supabase/supabase-js";
import { supabase } from "@/lib/supabase";
import type { User, UserRole } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

const ADMIN_ROLES: UserRole[] = ["admin", "superadmin"];

interface AuthContextValue {
  session: Session | null;
  authUser: SupabaseUser | null;
  profile: User | null;
  /** true, пока идёт первичное восстановление сессии и загрузка профиля. */
  loading: boolean;
  /** Есть сессия, но роль не admin/superadmin — доступ в CMS запрещён. */
  isAuthorized: boolean;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [profile, setProfile] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  async function loadProfile(userId: string) {
    const { error: ensureError } = await supabase.rpc("ensure_user_profile");
    if (ensureError) {
      console.error("Не удалось убедиться в наличии профиля:", ensureError.message);
    }

    const { data, error } = await supabase
      .from("users")
      .select("*")
      .eq("id", userId)
      .single();

    if (error) {
      console.error("Не удалось загрузить профиль администратора:", error.message);
      setProfile(null);
      return;
    }
    setProfile(toCamelCase<User>(data));
  }

  useEffect(() => {
    let mounted = true;

    supabase.auth.getSession().then(({ data }) => {
      if (!mounted) return;
      setSession(data.session);
      if (data.session?.user) {
        loadProfile(data.session.user.id).finally(() => setLoading(false));
      } else {
        setLoading(false);
      }
    });

    const { data: subscription } = supabase.auth.onAuthStateChange((_event, nextSession) => {
      setSession(nextSession);
      if (nextSession?.user) {
        loadProfile(nextSession.user.id);
      } else {
        setProfile(null);
      }
    });

    return () => {
      mounted = false;
      subscription.subscription.unsubscribe();
    };
  }, []);

  const value = useMemo<AuthContextValue>(
    () => ({
      session,
      authUser: session?.user ?? null,
      profile,
      loading,
      isAuthorized: !!profile && ADMIN_ROLES.includes(profile.role),
      signOut: async () => {
        await supabase.auth.signOut();
      },
    }),
    [session, profile, loading],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

// eslint-disable-next-line react-refresh/only-export-components -- хук намеренно живёт рядом с провайдером
export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth должен использоваться внутри <AuthProvider>");
  return ctx;
}
