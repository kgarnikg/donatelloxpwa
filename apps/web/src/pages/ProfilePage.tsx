import { useState } from "react";
import { Link } from "react-router-dom";
import { ChevronRight, LogOut, CreditCard, Globe, Bell, Pencil, Check, X } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/context/AuthContext";
import { supabase } from "@/lib/supabase";

export default function ProfilePage() {
  const { t } = useTranslation();
  const { profile, authUser, signOut, refreshProfile } = useAuth();
  const [editing, setEditing] = useState(false);
  const [nameDraft, setNameDraft] = useState(profile?.fullName ?? "");
  const [saving, setSaving] = useState(false);

  const displayName = profile?.fullName?.trim() || authUser?.email?.split("@")[0] || "Пользователь";

  const menuItems = [
    { to: "/subscription", label: t("profile.subscription"), icon: CreditCard },
    { to: "/profile/language", label: t("profile.language"), icon: Globe },
    { to: "/profile/notifications", label: t("profile.notifications"), icon: Bell },
  ];

  async function saveName() {
    if (!authUser || !nameDraft.trim()) return;
    setSaving(true);
    const { error } = await supabase
      .from("users")
      .update({ full_name: nameDraft.trim() })
      .eq("id", authUser.id);
    setSaving(false);
    if (!error) {
      await refreshProfile();
      setEditing(false);
    }
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
                }}
                className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md border border-ink-600 text-neutral-400"
              >
                <X size={16} />
              </button>
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
        {t("profile.logout")}
      </button>
    </div>
  );
}
