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
import type { User } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";
import i18n from "@/i18n";

interface AuthContextValue {
  session: Session | null;
  authUser: SupabaseUser | null;
  profile: User | null;
  loading: boolean;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

/** Флаг "вас выкинуло: вход на другом устройстве" — читает экран входа. */
export const KICKED_KEY = "donatellex-session-kicked";

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [profile, setProfile] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  async function loadProfile(userId: string) {
    // Гарантируем, что строка в public.users существует, ДО попытки её
    // прочитать — не полагаемся только на триггер регистрации, который
    // на практике иногда не срабатывает. Идемпотентно, безопасно вызывать
    // при каждой загрузке сессии.
    const { error: ensureError } = await supabase.rpc("ensure_user_profile");
    if (ensureError) {
      console.error("Не удалось убедиться в наличии профиля:", ensureError.message);
    }

    // Если пользователь пришёл по реферальной ссылке (код сохранён в
    // localStorage на странице регистрации), применяем его один раз.
    const pendingReferralCode = localStorage.getItem("donatellox-referral-code");
    if (pendingReferralCode) {
      const { error: referralError } = await supabase.rpc("apply_referral", {
        p_referral_code: pendingReferralCode,
      });
      if (referralError) {
        console.error("Не удалось применить реферальный код:", referralError.message);
      }
      localStorage.removeItem("donatellox-referral-code");
    }

    const { data, error } = await supabase
      .from("users")
      .select("*")
      .eq("id", userId)
      .single();

    if (error) {
      console.error("Не удалось загрузить профиль пользователя:", error.message);
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

  // Один аккаунт — одно устройство (0088). Действует только самый новый
  // вход: проверяем при запуске, при возврате на экран и раз в минуту.
  // Вошли на другом устройстве — выходим отсюда и на экране входа
  // объясняем почему (KICKED_KEY). Ошибка сети/сервера — не выкидываем.
  const sessionUserId = session?.user?.id;
  useEffect(() => {
    if (!sessionUserId) return;
    let stopped = false;
    async function check() {
      if (stopped || document.visibilityState !== "visible") return;
      const { data, error } = await supabase.rpc("touch_session");
      if (stopped || error || data !== false) return;
      stopped = true;
      try {
        localStorage.setItem(KICKED_KEY, "1");
      } catch {
        // не критично
      }
      await supabase.auth.signOut({ scope: "local" });
    }
    check();
    const timer = setInterval(check, 60_000);
    const onVisible = () => document.visibilityState === "visible" && check();
    document.addEventListener("visibilitychange", onVisible);
    return () => {
      stopped = true;
      clearInterval(timer);
      document.removeEventListener("visibilitychange", onVisible);
    };
  }, [sessionUserId]);

  // Язык интерфейса → в данные пользователя: по нему Supabase выбирает язык
  // писем (подтверждение, сброс пароля — supabase/email-templates), а
  // ежедневная задача — язык напоминаний (users.locale). Обновляем только
  // если язык реально отличается, чтобы не дёргать сервер при каждом входе.
  const userId = session?.user?.id;
  const metaLocale = (session?.user?.user_metadata as { locale?: string } | undefined)?.locale;
  useEffect(() => {
    if (!userId) return;
    function sync() {
      const lang = i18n.resolvedLanguage ?? i18n.language;
      if (!lang || lang === metaLocale) return;
      supabase.auth.updateUser({ data: { locale: lang } }).catch(() => {});
      supabase.from("users").update({ locale: lang }).eq("id", userId!).then(() => {});
    }
    sync();
    i18n.on("languageChanged", sync);
    return () => {
      i18n.off("languageChanged", sync);
    };
  }, [userId, metaLocale]);

  const value = useMemo<AuthContextValue>(
    () => ({
      session,
      authUser: session?.user ?? null,
      profile,
      loading,
      signOut: async () => {
        await supabase.auth.signOut();
      },
      refreshProfile: async () => {
        if (session?.user) await loadProfile(session.user.id);
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
