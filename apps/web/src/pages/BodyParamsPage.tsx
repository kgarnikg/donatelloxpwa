import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { ArrowLeft, Check } from "lucide-react";
import clsx from "clsx";
import type { ActivityLevel, Gender } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { useUserProfile } from "@/lib/queries";

/**
 * "Параметры тела" (/profile/body) — пол, дата рождения, рост, вес,
 * активность. Раньше эти данные вводились только один раз на онбординге,
 * и изменить их было негде: ссылка "Заполнить профиль" со страницы
 * "Питание" вела в профиль, где таких полей не было.
 */

const ACTIVITY_LEVELS: ActivityLevel[] = ["sedentary", "light", "moderate", "active", "very_active"];
const GENDERS: Gender[] = ["male", "female", "unspecified"];

export default function BodyParamsPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const { authUser } = useAuth();
  const { data: profile, isLoading } = useUserProfile();

  const [gender, setGender] = useState<Gender>("unspecified");
  const [birthDate, setBirthDate] = useState("");
  const [heightCm, setHeightCm] = useState("");
  const [weightKg, setWeightKg] = useState("");
  const [activityLevel, setActivityLevel] = useState<ActivityLevel>("moderate");
  const [formError, setFormError] = useState<string | null>(null);
  const [saved, setSaved] = useState(false);

  // Подставляем текущие значения, когда профиль загрузился
  useEffect(() => {
    if (!profile) return;
    setGender(profile.gender ?? "unspecified");
    setBirthDate(profile.birthDate ? String(profile.birthDate).slice(0, 10) : "");
    setHeightCm(profile.heightCm != null ? String(profile.heightCm) : "");
    setWeightKg(profile.weightKg != null ? String(profile.weightKg) : "");
    setActivityLevel(profile.activityLevel ?? "moderate");
  }, [profile]);

  const save = useMutation({
    mutationFn: async () => {
      if (!authUser) throw new Error(t("payment.errors.noSession"));
      const height = heightCm ? Number(heightCm.replace(",", ".")) : null;
      const weight = weightKg ? Number(weightKg.replace(",", ".")) : null;

      if (height !== null && (!Number.isFinite(height) || height < 100 || height > 250)) {
        throw new Error(t("bodyParams.errors.height"));
      }
      if (weight !== null && (!Number.isFinite(weight) || weight < 30 || weight > 300)) {
        throw new Error(t("bodyParams.errors.weight"));
      }
      if (birthDate) {
        const year = new Date(birthDate).getFullYear();
        const now = new Date().getFullYear();
        if (!year || year < now - 100 || year > now - 10) throw new Error(t("bodyParams.errors.birthDate"));
      }

      const { error } = await supabase.from("user_profiles").upsert(
        {
          user_id: authUser.id,
          gender,
          birth_date: birthDate || null,
          height_cm: height,
          weight_kg: weight,
          activity_level: activityLevel,
          updated_at: new Date().toISOString(),
        },
        { onConflict: "user_id" },
      );
      if (error) throw new Error(error.message);
    },
    onMutate: () => {
      setFormError(null);
      setSaved(false);
    },
    onSuccess: () => {
      setSaved(true);
      queryClient.invalidateQueries({ queryKey: ["user-profile"] });
      queryClient.invalidateQueries({ queryKey: ["daily-calories"] });
      queryClient.invalidateQueries({ queryKey: ["workout-calorie-stats"] });
    },
    onError: (err: Error) => setFormError(err.message),
  });

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-10">
      <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ArrowLeft size={16} /> {t("common.back")}
      </Link>

      <h1 className="mb-1 font-display text-2xl font-bold">{t("bodyParams.title")}</h1>
      <p className="mb-6 text-neutral-400">{t("bodyParams.subtitle")}</p>

      {isLoading ? (
        <div className="card h-64 animate-pulse bg-ink-800" />
      ) : (
        <form
          className="space-y-5"
          onSubmit={(e) => {
            e.preventDefault();
            save.mutate();
          }}
        >
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">{t("onboarding.gender")}</label>
            <div className="grid grid-cols-3 gap-2">
              {GENDERS.map((g) => (
                <button
                  type="button"
                  key={g}
                  onClick={() => setGender(g)}
                  className={clsx(
                    "rounded-md border px-2 py-2.5 text-sm font-medium transition",
                    gender === g
                      ? "border-volt-400 bg-volt-400/10 text-volt-300"
                      : "border-ink-600 bg-ink-800 text-neutral-300",
                  )}
                >
                  {t(`onboarding.genderOptions.${g}`)}
                </button>
              ))}
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">{t("onboarding.birthDate")}</label>
            <input
              type="date"
              className="input-field"
              value={birthDate}
              onChange={(e) => setBirthDate(e.target.value)}
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">{t("onboarding.height")}</label>
              <input
                type="number"
                inputMode="decimal"
                className="input-field"
                value={heightCm}
                onChange={(e) => setHeightCm(e.target.value)}
              />
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">{t("onboarding.weight")}</label>
              <input
                type="number"
                inputMode="decimal"
                step="0.1"
                className="input-field"
                value={weightKg}
                onChange={(e) => setWeightKg(e.target.value)}
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("onboarding.activityLevel")}
            </label>
            <p className="mb-1.5 text-xs text-neutral-500">{t("onboarding.activityLevelHint")}</p>
            <select
              className="input-field"
              value={activityLevel}
              onChange={(e) => setActivityLevel(e.target.value as ActivityLevel)}
            >
              {ACTIVITY_LEVELS.map((l) => (
                <option key={l} value={l}>
                  {t(`onboarding.activityOptions.${l}`)}
                </option>
              ))}
            </select>
          </div>

          {formError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
              {formError}
            </div>
          )}

          {saved && (
            <div className="flex items-center gap-2 rounded-md border border-success/30 bg-success/10 px-4 py-3 text-sm text-success">
              <Check size={16} /> {t("bodyParams.saved")}
              <button type="button" onClick={() => navigate("/nutrition")} className="ml-auto font-semibold underline">
                {t("bodyParams.toNutrition")}
              </button>
            </div>
          )}

          <button type="submit" disabled={save.isPending} className="btn-primary w-full">
            {save.isPending ? t("onboarding.savingButton") : t("common.save")}
          </button>
        </form>
      )}
    </div>
  );
}
