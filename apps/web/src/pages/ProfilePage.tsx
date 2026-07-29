import { useState } from "react";
import { Link } from "react-router-dom";
import { ChevronRight, LogOut, CreditCard, Globe, Bell, Pencil, Check, X, Gift } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useAuth } from "@/context/AuthContext";
import { supabase } from "@/lib/supabase";

export default function ProfilePage() {
  const { t } = useTranslation();
  const { profile, authUser, signOut, refreshProfile } = useAuth();
  const [editing, setEditing] = useState(false);
  const [nameDraft, setNameDraft] = useState(profile?.fullName ?? "");
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [copied, setCopied] = useState(false);

  const { data: referralCount } = useQuery({
    queryKey: ["referral-count", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<number> => {
      const { count, error } = await supabase
        .from("referrals")
        .select("id", { count: "exact", head: true })
        .eq("referrer_id", authUser!.id);
      if (error) throw error;
      return count ?? 0;
    },
  });

  const displayName = profile?.fullName?.trim() || authUser?.email?.split("@")[0] || "Пользователь";
  const referralLink = profile?.referralCode
    ? `${window.location.origin}/register?ref=${profile.referralCode}`
    : null;

  async function copyReferralLink() {
    if (!referralLink) return;
    await navigator.clipboard.writeText(referralLink);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  const menuItems = [
    { to: "/subscription", label: t("profile.subscription"), icon: CreditCard },
    { to: "/profile/language", label: t("profile.language"), icon: Globe },
    { to: "/profile/notifications", label: t("profile.notifications"), icon: Bell },
  ];

  async function saveName() {
    if (!authUser || !nameDraft.trim()) return;
    setSaving(true);
    setSaveError(null);
    const { error } = await supabase
      .from("users")
      .update({ full_name: nameDraft.trim() })
      .eq("id", authUser.id);
    setSaving(false);
    if (error) {
      console.error("Не удалось сохранить имя:", error);
      setSaveError(error.message);
      return;
    }
    await refreshProfile();
    setEditing(false);
  }

  return (
    <div className="px-5 pt-8">
      <h1 className="mb-6 font-display text-2xl font-bold">{t("profile.title")}</h1>

      <div className="card mb-6 flex items-center gap-4">
        {profile?.avatarUrl ? (
          <img
            src={profile.avatarUrl}
            alt=""
            className="h-14 w-14 shrink-0 rounded-full object-cover"
          />
        ) : (
          <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-full bg-volt-400/15 font-display text-xl font-bold text-volt-400">
            {displayName.charAt(0).toUpperCase()}
          </div>
        )}

        <div className="min-w-0 flex-1">
          {editing ? (
            <div>
              <div className="flex items-center gap-2">
                <input
                  autoFocus
                  value={nameDraft}
                  onChange={(e) => setNameDraft(e.target.value)}
                  className="input-field py-1.5 text-sm"
                  placeholder="Ваше имя"
                />
                <button
                  onClick={saveName}
                  disabled={saving}
                  className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-volt-400 text-ink-950"
                >
                  <Check size={16} />
                </button>
                <button
                  onClick={() => {
                    setEditing(false);
                    setNameDraft(profile?.fullName ?? "");
                    setSaveError(null);
                  }}
                  className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md border border-ink-600 text-neutral-400"
                >
                  <X size={16} />
                </button>
              </div>
              {saveError && <p className="field-error mt-1">{saveError}</p>}
            </div>
          ) : (
            <button
              onClick={() => setEditing(true)}
              className="flex items-center gap-1.5 truncate font-semibold"
            >
              {displayName}
              <Pencil size={13} className="shrink-0 text-neutral-500" />
            </button>
          )}
          <p className="truncate text-sm text-neutral-400">{authUser?.email}</p>
        </div>
      </div>

      <div className="card mb-6 divide-y divide-ink-700 p-0">
        {menuItems.map(({ to, label, icon: Icon }) => (
          <Link key={to} to={to} className="flex items-center gap-3 px-4 py-3.5 hover:bg-ink-800">
            <Icon size={18} className="text-neutral-400" />
            <span className="flex-1 font-medium">{label}</span>
            <ChevronRight size={18} className="text-neutral-500" />
          </Link>
        ))}
      </div>

      <div className="card mb-6">
        <div className="flex items-center gap-2">
          <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-volt-400/10 text-volt-400">
            <Gift size={18} />
          </div>
          <div>
            <p className="font-semibold">{t("referral.title")}</p>
            <p className="text-xs text-neutral-400">{t("referral.subtitle")}</p>
          </div>
        </div>

        {referralLink ? (
          <>
            <div className="mt-4 flex items-center gap-2 rounded-md border border-ink-700 bg-ink-800 px-3 py-2.5">
              <p className="min-w-0 flex-1 truncate text-sm text-neutral-300">{referralLink}</p>
              <button
                onClick={copyReferralLink}
                className="shrink-0 rounded-md bg-volt-400 px-3 py-1.5 text-xs font-semibold text-ink-950"
              >
                {copied ? t("referral.copied") : t("referral.copy")}
              </button>
            </div>
            {referralCount != null && referralCount > 0 && (
              <p className="mt-2 text-xs text-neutral-500">
                {t("referral.invitedCount", { count: referralCount })}
              </p>
            )}
          </>
        ) : (
          <p className="mt-3 text-sm text-neutral-500">{t("common.loading")}</p>
        )}
      </div>

      <button
        onClick={() => signOut()}
        className="mt-6 flex w-full items-center justify-center gap-2 rounded-md border border-danger/30 px-5 py-3 font-medium text-danger transition hover:bg-danger/10"
      >
        <LogOut size={18} />
        {t("profile.logout")}
      </button>
    </div>
  );
}
