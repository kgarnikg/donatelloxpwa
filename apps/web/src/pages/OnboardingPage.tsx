import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslation } from "react-i18next";
import { onboardingSchema, type OnboardingInput } from "@donatellox/validation";
import type { FitnessGoal } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { CountrySelect } from "@/components/CountrySelect";
import clsx from "clsx";

const GOALS: FitnessGoal[] = [
  "lose_weight",
  "build_muscle",
  "improve_endurance",
  "general_fitness",
  "rehabilitation",
];

const ACTIVITY_LEVELS = ["sedentary", "light", "moderate", "active", "very_active"] as const;
const TRAINING_FORMATS = ["gym", "home"] as const;
const DAYS_OPTIONS = [2, 3, 4, 5, 6] as const;

export default function OnboardingPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { authUser, profile, refreshProfile } = useAuth();
  const [step, setStep] = useState(0);
  // Страна обязательна (0081). При регистрации по email её уже выбрали;
  // при входе через Google её нет — спрашиваем здесь, на первом шаге.
  const needsCountry = !!profile && !profile.country;
  const [country, setCountry] = useState<string | undefined>(undefined);
  const [serverError, setServerError] = useState<string | null>(null);
  const [daysError, setDaysError] = useState(false);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    trigger,
    formState: { errors, isSubmitting },
  } = useForm<OnboardingInput>({
    resolver: zodResolver(onboardingSchema),
    defaultValues: {
      gender: "unspecified",
      activityLevel: "moderate",
      goals: [],
      trainingFormat: "gym",
      // без готового ответа: раньше тут стояло 3, и многие просто не трогали —
      // потом на главной было "4 из 3". Теперь выбрать нужно самому.
      preferredLanguage: "ru",
    },
  });

  const selectedGoals = watch("goals");
  const trainingFormat = watch("trainingFormat");
  const daysPerWeek = watch("daysPerWeek");
  const gender = watch("gender");

  function toggleGoal(goal: FitnessGoal) {
    const next = selectedGoals?.includes(goal)
      ? selectedGoals.filter((g) => g !== goal)
      : [...(selectedGoals ?? []), goal];
    setValue("goals", next, { shouldValidate: true });
  }

  async function onSubmit(values: OnboardingInput) {
    if (!authUser) return;
    setServerError(null);

    const { error } = await supabase.from("user_profiles").upsert({
      user_id: authUser.id,
      gender: values.gender,
      birth_date: values.birthDate ?? null,
      height_cm: values.heightCm ?? null,
      weight_kg: values.weightKg ?? null,
      activity_level: values.activityLevel,
      goals: values.goals,
      training_format: values.trainingFormat,
      days_per_week: values.daysPerWeek ?? null,
      health_notes: values.healthNotes ?? null,
      preferred_language: values.preferredLanguage,
      updated_at: new Date().toISOString(),
    });

    if (error) {
      setServerError(error.message);
      return;
    }

    await supabase
      .from("users")
      .update({ onboarding_completed: true, ...(needsCountry && country ? { country } : {}) })
      .eq("id", authUser.id);
    await refreshProfile();
    navigate("/dashboard", { replace: true });
  }

  const steps = t("onboarding.steps", { returnObjects: true }) as string[];

  return (
    <div className="min-h-dvh bg-ink-950 px-6 py-10">
      <div className="mx-auto w-full max-w-md animate-fade-in">
        <div className="mb-8 flex items-center gap-2">
          {steps.map((label, idx) => (
            <div key={label} className="flex flex-1 items-center gap-2">
              <div
                className={clsx(
                  "h-1.5 flex-1 rounded-full transition-colors",
                  idx <= step ? "bg-volt-400" : "bg-ink-700",
                )}
              />
            </div>
          ))}
        </div>

        <form onSubmit={handleSubmit(onSubmit)} noValidate>
          {step === 0 && (
            <fieldset>
              {needsCountry && (
                <div className="mb-8">
                  <label htmlFor="onboarding-country" className="mb-1.5 block text-sm font-medium text-neutral-300">
                    {t("auth.register.country")}
                  </label>
                  <CountrySelect id="onboarding-country" value={country} onChange={setCountry} />
                </div>
              )}
              <h1 className="font-display text-2xl font-bold">{t("onboarding.goalsTitle")}</h1>
              <p className="mt-1 text-neutral-400">{t("onboarding.goalsSubtitle")}</p>
              <div className="mt-6 grid grid-cols-1 gap-3">
                {GOALS.map((goal) => (
                  <button
                    type="button"
                    key={goal}
                    onClick={() => toggleGoal(goal)}
                    className={clsx(
                      "rounded-md border px-4 py-3.5 text-left font-medium transition",
                      selectedGoals?.includes(goal)
                        ? "border-volt-400 bg-volt-400/10 text-volt-300"
                        : "border-ink-600 bg-ink-800 text-neutral-200 hover:border-ink-500",
                    )}
                  >
                    {t(`onboarding.goals.${goal}`)}
                  </button>
                ))}
              </div>
              {errors.goals && <p className="field-error">{t(errors.goals.message === "Выберите хотя бы одну цель" ? "validation.goalsRequired" : (errors.goals.message ?? ""), { defaultValue: errors.goals.message })}</p>}
              <button
                type="button"
                onClick={() => setStep(1)}
                disabled={!selectedGoals?.length || (needsCountry && !country)}
                className="btn-primary mt-8 w-full"
              >
                {t("common.next")}
              </button>
            </fieldset>
          )}

          {step === 1 && (
            <fieldset className="space-y-4">
              <h1 className="font-display text-2xl font-bold">{t("onboarding.aboutTitle")}</h1>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.gender")}
                </label>
                <div className="grid grid-cols-3 gap-2">
                  {(["male", "female", "unspecified"] as const).map((g) => (
                    <button
                      type="button"
                      key={g}
                      onClick={() => setValue("gender", g)}
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
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.birthDate")} <span className="text-danger">*</span>
                </label>
                <input type="date" className="input-field" {...register("birthDate")} />
                {errors.birthDate && <p className="field-error">{t(errors.birthDate.message ?? "", { defaultValue: errors.birthDate.message })}</p>}
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                    {t("onboarding.height")} <span className="text-danger">*</span>
                  </label>
                  <input type="number" inputMode="decimal" className="input-field" {...register("heightCm")} />
                  {errors.heightCm && <p className="field-error">{t(errors.heightCm.message ?? "", { defaultValue: errors.heightCm.message })}</p>}
                </div>
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                    {t("onboarding.weight")} <span className="text-danger">*</span>
                  </label>
                  <input type="number" inputMode="decimal" step="0.1" className="input-field" {...register("weightKg")} />
                  {errors.weightKg && <p className="field-error">{t(errors.weightKg.message ?? "", { defaultValue: errors.weightKg.message })}</p>}
                </div>
              </div>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.activityLevel")}
                </label>
                <p className="mb-1.5 text-xs text-neutral-500">{t("onboarding.activityLevelHint")}</p>
                <select className="input-field" {...register("activityLevel")}>
                  {ACTIVITY_LEVELS.map((l) => (
                    <option key={l} value={l}>
                      {t(`onboarding.activityOptions.${l}`)}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.healthNotes")}
                </label>
                <textarea rows={3} className="input-field resize-none" {...register("healthNotes")} />
              </div>

              <div className="flex gap-3 pt-2">
                <button type="button" onClick={() => setStep(0)} className="btn-secondary flex-1">
                  {t("common.back")}
                </button>
                <button
                  type="button"
                  onClick={async () => {
                    // Не пускаем дальше без роста/веса/даты рождения —
                    // иначе ошибки всплыли бы только на последнем шаге,
                    // где этих полей уже не видно.
                    const ok = await trigger(["birthDate", "heightCm", "weightKg"]);
                    if (ok) setStep(2);
                  }}
                  className="btn-primary flex-1"
                >
                  {t("common.next")}
                </button>
              </div>
            </fieldset>
          )}

          {step === 2 && (
            <fieldset className="space-y-5">
              <h1 className="font-display text-2xl font-bold">{t("onboarding.formatTitle")}</h1>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.trainingFormat")}
                </label>
                <div className="grid grid-cols-2 gap-3">
                  {TRAINING_FORMATS.map((f) => (
                    <button
                      type="button"
                      key={f}
                      onClick={() => setValue("trainingFormat", f)}
                      className={clsx(
                        "rounded-md border px-4 py-3.5 text-center font-medium transition",
                        trainingFormat === f
                          ? "border-volt-400 bg-volt-400/10 text-volt-300"
                          : "border-ink-600 bg-ink-800 text-neutral-200 hover:border-ink-500",
                      )}
                    >
                      {t(`onboarding.formatOptions.${f}`)}
                    </button>
                  ))}
                </div>
              </div>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  {t("onboarding.daysPerWeek")} <span className="text-danger">*</span>
                </label>
                <div className="grid grid-cols-5 gap-2">
                  {DAYS_OPTIONS.map((d) => (
                    <button
                      type="button"
                      key={d}
                      onClick={() => {
                        setValue("daysPerWeek", d);
                        setDaysError(false);
                      }}
                      className={clsx(
                        "rounded-md border py-2.5 text-sm font-semibold transition",
                        daysPerWeek === d
                          ? "border-volt-400 bg-volt-400/10 text-volt-300"
                          : "border-ink-600 bg-ink-800 text-neutral-300",
                      )}
                    >
                      {d}
                    </button>
                  ))}
                </div>
                {daysError && <p className="field-error">{t("onboarding.daysPerWeekRequired")}</p>}
              </div>

              <div className="flex gap-3 pt-2">
                <button type="button" onClick={() => setStep(1)} className="btn-secondary flex-1">
                  {t("common.back")}
                </button>
                <button
                  type="button"
                  onClick={() => {
                    if (!daysPerWeek) {
                      setDaysError(true);
                      return;
                    }
                    setStep(3);
                  }}
                  className="btn-primary flex-1"
                >
                  {t("common.next")}
                </button>
              </div>
            </fieldset>
          )}

          {step === 3 && (
            <fieldset>
              <h1 className="font-display text-2xl font-bold">{t("onboarding.doneTitle")}</h1>
              <p className="mt-1 text-neutral-400">{t("onboarding.doneSubtitle")}</p>
              {serverError && (
                <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
                  {serverError}
                </div>
              )}
              <div className="mt-8 flex gap-3">
                <button type="button" onClick={() => setStep(2)} className="btn-secondary flex-1">
                  {t("common.back")}
                </button>
                <button type="submit" disabled={isSubmitting} className="btn-primary flex-1">
                  {isSubmitting ? t("onboarding.savingButton") : t("onboarding.startButton")}
                </button>
              </div>
            </fieldset>
          )}
        </form>
      </div>
    </div>
  );
}
