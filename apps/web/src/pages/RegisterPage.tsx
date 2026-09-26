import { useState } from "react";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslation } from "react-i18next";
import { registerSchema, type RegisterInput } from "@donatellox/validation";
import { supabase } from "@/lib/supabase";
import { useValidationMessage } from "@/lib/validationMessage";
import { PasswordInput } from "@/components/PasswordInput";
import { CountrySelect } from "@/components/CountrySelect";

const REFERRAL_STORAGE_KEY = "donatellox-referral-code";

export default function RegisterPage() {
  const { t, i18n } = useTranslation();
  const vm = useValidationMessage();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [serverError, setServerError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    formState: { errors, isSubmitting },
  } = useForm<RegisterInput>({
    resolver: zodResolver(registerSchema),
    defaultValues: { locale: "ru" },
  });

  async function onSubmit(values: RegisterInput) {
    setServerError(null);

    // Реферальный код из ссылки (?ref=ABC123) сохраняем в localStorage —
    // применится в AuthContext при первом входе (сразу или после
    // подтверждения email, в зависимости от настроек проекта).
    const referralCode = searchParams.get("ref");
    if (referralCode) {
      localStorage.setItem(REFERRAL_STORAGE_KEY, referralCode);
    }

    const { data, error } = await supabase.auth.signUp({
      email: values.email,
      password: values.password,
      options: {
        data: {
          // full_name остаётся "Имя Фамилия" — его читают главная, админка, письма
          full_name: `${values.firstName} ${values.lastName}`,
          first_name: values.firstName,
          last_name: values.lastName,
          country: values.country,
          locale: i18n.language,
        },
        emailRedirectTo: `${window.location.origin}/onboarding`,
      },
    });

    if (error) {
      setServerError(error.message);
      return;
    }

    if (data.session) {
      navigate("/onboarding", { replace: true });
    } else {
      navigate("/verify-email", { replace: true, state: { email: values.email } });
    }
  }

  return (
    <div className="flex min-h-dvh flex-col justify-center bg-ink-950 bg-grid-fade px-6 py-12">
      <div className="mx-auto w-full max-w-sm animate-fade-in">
        <h1 className="font-display text-3xl font-bold text-neutral-0">{t("auth.register.title")}</h1>
        <p className="mt-2 text-neutral-400">{t("auth.register.subtitle")}</p>

        <form onSubmit={handleSubmit(onSubmit)} className="mt-8 space-y-4" noValidate>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                {t("auth.register.firstName")}
              </label>
              <input
                className="input-field"
                autoComplete="given-name"
                placeholder={t("auth.register.firstNamePlaceholder") ?? ""}
                {...register("firstName")}
              />
              {errors.firstName && <p className="field-error">{vm(errors.firstName.message)}</p>}
            </div>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">
                {t("auth.register.lastName")}
              </label>
              <input
                className="input-field"
                autoComplete="family-name"
                placeholder={t("auth.register.lastNamePlaceholder") ?? ""}
                {...register("lastName")}
              />
              {errors.lastName && <p className="field-error">{vm(errors.lastName.message)}</p>}
            </div>
          </div>

          <div>
            <label htmlFor="register-country" className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("auth.register.country")}
            </label>
            <CountrySelect
              id="register-country"
              value={watch("country")}
              onChange={(code) => setValue("country", code, { shouldValidate: !!errors.country })}
              invalid={!!errors.country}
            />
            {errors.country && <p className="field-error">{vm(errors.country.message)}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("auth.register.email")}
            </label>
            <input type="email" className="input-field" placeholder="you@example.com" {...register("email")} />
            {errors.email && <p className="field-error">{vm(errors.email.message)}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("auth.register.password")}
            </label>
            <PasswordInput
              placeholder={t("auth.register.passwordPlaceholder") ?? ""}
              {...register("password")}
            />
            {errors.password && <p className="field-error">{vm(errors.password.message)}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("auth.register.passwordConfirm")}
            </label>
            <PasswordInput {...register("passwordConfirm")} />
            {errors.passwordConfirm && <p className="field-error">{vm(errors.passwordConfirm.message)}</p>}
          </div>

          <label className="flex items-start gap-2.5 text-sm text-neutral-400">
            <input
              type="checkbox"
              className="mt-0.5 h-4 w-4 rounded border-ink-600 bg-ink-800 text-volt-400 focus:ring-volt-400"
              {...register("acceptedTerms")}
            />
            {t("auth.register.acceptTerms")}
          </label>
          {errors.acceptedTerms && <p className="field-error">{vm(errors.acceptedTerms.message)}</p>}

          {serverError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
              {serverError}
            </div>
          )}

          <button type="submit" disabled={isSubmitting} className="btn-primary w-full">
            {isSubmitting ? t("auth.register.submitting") : t("auth.register.submit")}
          </button>
        </form>

        <p className="mt-8 text-center text-sm text-neutral-400">
          {t("auth.register.haveAccount")}{" "}
          <Link to="/login" className="font-medium text-volt-400 hover:text-volt-300">
            {t("auth.register.signIn")}
          </Link>
        </p>
      </div>
    </div>
  );
}
