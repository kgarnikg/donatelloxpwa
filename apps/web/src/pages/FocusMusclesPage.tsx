import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useQueryClient } from "@tanstack/react-query";
import { ArrowLeft } from "lucide-react";
import type { FocusMuscle, Gender } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { useUserProfile } from "@/lib/queries";
import { MusclePicker } from "@/components/MusclePicker";

/**
 * Профиль → "Акцент на мышцы": тот же выбор, что в анкете (3D-фигура +
 * список), чтобы акцент можно было поменять в любой момент.
 */
export default function FocusMusclesPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const { authUser } = useAuth();
  const { data: userProfile, isFetched } = useUserProfile();
  const [value, setValue] = useState<FocusMuscle[] | null>(null);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (isFetched && value === null) setValue(userProfile?.focusMuscles ?? []);
  }, [isFetched, userProfile, value]);

  async function save() {
    if (!authUser || value === null) return;
    setSaving(true);
    setError(null);
    const { error: err } = await supabase
      .from("user_profiles")
      .update({ focus_muscles: value, updated_at: new Date().toISOString() })
      .eq("user_id", authUser.id);
    setSaving(false);
    if (err) {
      setError(err.message);
      return;
    }
    await queryClient.invalidateQueries({ queryKey: ["user-profile"] });
    navigate(-1);
  }

  return (
    <div className="min-h-dvh bg-ink-950 px-6 pt-8">
      <div className="mx-auto w-full max-w-md">
        <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
          <ArrowLeft size={16} /> {t("common.back")}
        </Link>
        <h1 className="font-display text-2xl font-bold">{t("focus.title")}</h1>
        <p className="mt-1 text-neutral-400">{t("focus.subtitle")}</p>

        {value !== null && (
          <MusclePicker
            gender={(userProfile?.gender ?? "unspecified") as Gender}
            value={value}
            onChange={setValue}
          />
        )}

        {error && (
          <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
            {error}
          </div>
        )}

        <div className="sticky bottom-0 z-10 -mx-6 mt-6 bg-ink-950/90 px-6 pb-[max(0.75rem,env(safe-area-inset-bottom))] pt-3 backdrop-blur">
          <button type="button" onClick={save} disabled={saving || value === null} className="btn-primary w-full">
            {saving ? t("onboarding.savingButton") : t("common.save")}
          </button>
        </div>
      </div>
    </div>
  );
}
