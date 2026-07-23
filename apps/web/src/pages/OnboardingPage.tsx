import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { onboardingSchema, type OnboardingInput } from "@donatellox/validation";
import type { FitnessGoal } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import clsx from "clsx";

const GOALS: { value: FitnessGoal; label: string }[] = [
  { value: "lose_weight", label: "Похудеть" },
  { value: "build_muscle", label: "Набрать мышечную массу" },
  { value: "improve_endurance", label: "Улучшить выносливость" },
  { value: "general_fitness", label: "Общая физическая форма" },
  { value: "rehabilitation", label: "Реабилитация" },
];

const ACTIVITY_LEVELS = [
  { value: "sedentary", label: "Малоподвижный" },
  { value: "light", label: "Лёгкая активность" },
  { value: "moderate", label: "Умеренная активность" },
  { value: "active", label: "Активный" },
  { value: "very_active", label: "Очень активный" },
] as const;

export default function OnboardingPage() {
  const navigate = useNavigate();
  const { authUser, refreshProfile } = useAuth();
  const [step, setStep] = useState(0);
  const [serverError, setServerError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    formState: { errors, isSubmitting },
  } = useForm<OnboardingInput>({
    resolver: zodResolver(onboardingSchema),
    defaultValues: { gender: "unspecified", activityLevel: "moderate", goals: [], preferredLanguage: "ru" },
  });

  const selectedGoals = watch("goals");

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
      health_notes: values.healthNotes ?? null,
      preferred_language: values.preferredLanguage,
      updated_at: new Date().toISOString(),
    });

    if (error) {
      setServerError(error.message);
      return;
    }

    await supabase.from("users").update({ onboarding_completed: true }).eq("id", authUser.id);
    await refreshProfile();
    navigate("/dashboard", { replace: true });
  }

  const steps = ["Цели", "О себе", "Готово"];

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
              <h1 className="font-display text-2xl font-bold">Какая у вас цель?</h1>
              <p className="mt-1 text-neutral-400">Можно выбрать несколько</p>
              <div className="mt-6 grid grid-cols-1 gap-3">
                {GOALS.map((goal) => (
                  <button
                    type="button"
                    key={goal.value}
                    onClick={() => toggleGoal(goal.value)}
                    className={clsx(
                      "rounded-md border px-4 py-3.5 text-left font-medium transition",
                      selectedGoals?.includes(goal.value)
                        ? "border-volt-400 bg-volt-400/10 text-volt-300"
                        : "border-ink-600 bg-ink-800 text-neutral-200 hover:border-ink-500",
                    )}
                  >
                    {goal.label}
                  </button>
                ))}
              </div>
              {errors.goals && <p className="field-error">{errors.goals.message}</p>}
              <button
                type="button"
                onClick={() => setStep(1)}
                disabled={!selectedGoals?.length}
                className="btn-primary mt-8 w-full"
              >
                Далее
              </button>
            </fieldset>
          )}

          {step === 1 && (
            <fieldset className="space-y-4">
              <h1 className="font-display text-2xl font-bold">Расскажите о себе</h1>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">Рост, см</label>
                  <input type="number" className="input-field" {...register("heightCm")} />
                </div>
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-neutral-300">Вес, кг</label>
                  <input type="number" className="input-field" {...register("weightKg")} />
                </div>
              </div>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">Уровень активности</label>
                <select className="input-field" {...register("activityLevel")}>
                  {ACTIVITY_LEVELS.map((l) => (
                    <option key={l.value} value={l.value}>
                      {l.label}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                  Особенности здоровья (необязательно)
                </label>
                <textarea rows={3} className="input-field resize-none" {...register("healthNotes")} />
              </div>

              <div className="flex gap-3 pt-2">
                <button type="button" onClick={() => setStep(0)} className="btn-secondary flex-1">
                  Назад
                </button>
                <button type="button" onClick={() => setStep(2)} className="btn-primary flex-1">
                  Далее
                </button>
              </div>
            </fieldset>
          )}

          {step === 2 && (
            <fieldset>
              <h1 className="font-display text-2xl font-bold">Всё готово!</h1>
              <p className="mt-1 text-neutral-400">
                Мы подберём программу тренировок под ваши цели и уровень подготовки.
              </p>
              {serverError && (
                <div className="mt-4 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
                  {serverError}
                </div>
              )}
              <div className="mt-8 flex gap-3">
                <button type="button" onClick={() => setStep(1)} className="btn-secondary flex-1">
                  Назад
                </button>
                <button type="submit" disabled={isSubmitting} className="btn-primary flex-1">
                  {isSubmitting ? "Сохраняем…" : "Начать тренировки"}
                </button>
              </div>
            </fieldset>
          )}
        </form>
      </div>
    </div>
  );
}
