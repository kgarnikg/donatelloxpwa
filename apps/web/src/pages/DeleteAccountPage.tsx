import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, Trash2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { ACCOUNT_DELETED_KEY, useAuth } from "@/context/AuthContext";
import { useActiveSubscription } from "@/lib/queries";

/**
 * Профиль → "Удалить аккаунт" (0092, право на удаление данных — GDPR ст. 17).
 * Удаляется всё личное; записи об оплатах остаются обезличенными (закон).
 * Чтобы не удалить случайно — нужно ввести слово-подтверждение.
 */
export default function DeleteAccountPage() {
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const { profile, signOut } = useAuth();
  const { data: subscription } = useActiveSubscription();
  const [typed, setTyped] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const word = t("deleteAccount.word");
  const normalized = typed.trim().toLocaleUpperCase();
  const confirmed = normalized === word.toLocaleUpperCase() || normalized === "DELETE";
  const isStaff = profile?.role === "admin" || profile?.role === "superadmin" || profile?.role === "coach";

  const periodEnd = subscription ? new Date(subscription.currentPeriodEnd) : null;
  const lifetime = periodEnd ? periodEnd.getFullYear() > new Date().getFullYear() + 50 : false;

  async function remove() {
    if (!confirmed || busy) return;
    setBusy(true);
    setError(null);
    const { error: err } = await supabase.rpc("delete_my_account");
    if (err) {
      setBusy(false);
      setError(t("deleteAccount.error"));
      return;
    }
    try {
      localStorage.setItem(ACCOUNT_DELETED_KEY, "1");
    } catch {
      // не критично — просто не покажем сообщение на экране входа
    }
    await signOut();
    navigate("/login", { replace: true });
  }

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-10">
      <div className="mx-auto w-full max-w-md">
        <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
          <ArrowLeft size={16} /> {t("common.back")}
        </Link>
        <h1 className="font-display text-2xl font-bold">{t("deleteAccount.title")}</h1>
        <p className="mt-2 text-neutral-300">{t("deleteAccount.intro")}</p>

        <div className="card mt-6 space-y-3 text-sm text-neutral-300">
          <p>{t("deleteAccount.whatDeleted")}</p>
          <p className="text-neutral-400">{t("deleteAccount.whatKept")}</p>
        </div>

        {periodEnd && !lifetime && (
          <div className="mt-4 rounded-md border border-ember-400/30 bg-ember-400/10 px-4 py-3 text-sm text-ember-300">
            {t("deleteAccount.subscriptionWarning", {
              date: periodEnd.toLocaleDateString(i18n.language, { day: "numeric", month: "long", year: "numeric" }),
            })}{" "}
            <Link to="/subscription" className="underline">
              {t("deleteAccount.subscriptionLink")}
            </Link>
          </div>
        )}

        {isStaff ? (
          <p className="mt-6 text-sm text-neutral-400">{t("deleteAccount.staff")}</p>
        ) : (
          <>
            <label htmlFor="delete-confirm" className="mt-6 block text-sm font-medium text-neutral-300">
              {t("deleteAccount.typeWord", { word })}
            </label>
            <input
              id="delete-confirm"
              value={typed}
              onChange={(e) => setTyped(e.target.value)}
              autoComplete="off"
              autoCapitalize="characters"
              spellCheck={false}
              className="input-field mt-1.5"
              placeholder={word}
            />
            {error && <p className="field-error">{error}</p>}
            <button
              type="button"
              onClick={remove}
              disabled={!confirmed || busy}
              className="mt-6 flex w-full items-center justify-center gap-2 rounded-md bg-danger px-5 py-3 font-semibold text-white transition hover:bg-danger/90 disabled:opacity-40"
            >
              <Trash2 size={18} aria-hidden />
              {busy ? t("deleteAccount.deleting") : t("deleteAccount.button")}
            </button>
          </>
        )}
      </div>
    </div>
  );
}
