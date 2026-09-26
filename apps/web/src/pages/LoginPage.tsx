import { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useTranslation } from "react-i18next";
import { loginSchema, type LoginInput } from "@donatellox/validation";
import { supabase } from "@/lib/supabase";
import { useValidationMessage } from "@/lib/validationMessage";
import { PasswordInput } from "@/components/PasswordInput";

export default function LoginPage() {
  const { t } = useTranslation();
  const vm = useValidationMessage();
  const navigate = useNavigate();
  const location = useLocation();
  const from = (location.state as { from?: Location })?.from?.pathname ?? "/dashboard";
  const [serverError, setServerError] = useState<string | null>(null);
  const [oauthLoading, setOauthLoading] = useState<"google" | null>(null);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<LoginInput>({ resolver: zodResolver(loginSchema) });

  async function onSubmit(values: LoginInput) {
    setServerError(null);
    const { error } = await supabase.auth.signInWithPassword(values);
    if (error) {
      setServerError(
        error.message === "Invalid login credentials"
          ? t("auth.login.invalidCredentials")
          : /banned/i.test(error.message)
            ? t("auth.blocked.text")
            : error.message,
      );
      return;
    }
    navigate(from, { replace: true });
  }

  async function signInWithOAuth(provider: "google") {
    setOauthLoading(provider);
    const { error } = await supabase.auth.signInWithOAuth({
      provider,
      options: { redirectTo: `${window.location.origin}/dashboard` },
    });
    if (error) {
      setServerError(error.message);
      setOauthLoading(null);
    }
  }

  return (
    <div className="flex min-h-dvh flex-col justify-center bg-ink-950 bg-grid-fade px-6 py-12">
      <div className="mx-auto w-full max-w-sm animate-fade-in">
        <h1 className="font-display text-3xl font-bold text-neutral-0">{t("auth.login.title")}</h1>
        <p className="mt-2 text-neutral-400">{t("auth.login.subtitle")}</p>

        <form onSubmit={handleSubmit(onSubmit)} className="mt-8 space-y-4" noValidate>
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">
              {t("auth.login.email")}
            </label>
            <input
              type="email"
              autoComplete="email"
              className="input-field"
              placeholder="you@example.com"
              {...register("email")}
            />
            {errors.email && <p className="field-error">{vm(errors.email.message)}</p>}
          </div>

          <div>
            <div className="mb-1.5 flex items-center justify-between">
              <label className="block text-sm font-medium text-neutral-300">
                {t("auth.login.password")}
              </label>
              <Link to="/forgot-password" className="text-sm text-volt-400 hover:text-volt-300">
                {t("auth.login.forgotPassword")}
              </Link>
            </div>
            <PasswordInput
              autoComplete="current-password"
              placeholder="••••••••"
              {...register("password")}
            />
            {errors.password && <p className="field-error">{vm(errors.password.message)}</p>}
          </div>

          {serverError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
              {serverError}
            </div>
          )}

          <button type="submit" disabled={isSubmitting} className="btn-primary w-full">
            {isSubmitting ? t("auth.login.submitting") : t("auth.login.submit")}
          </button>
        </form>

        <div className="my-6 flex items-center gap-3">
          <div className="h-px flex-1 bg-ink-700" />
          <span className="text-xs uppercase tracking-wide text-neutral-500">{t("auth.login.or")}</span>
          <div className="h-px flex-1 bg-ink-700" />
        </div>

        <div className="space-y-3">
          <button
            onClick={() => signInWithOAuth("google")}
            disabled={oauthLoading !== null}
            className="btn-secondary w-full"
          >
            {oauthLoading === "google" ? t("auth.login.openingGoogle") : t("auth.login.continueWithGoogle")}
          </button>
        </div>

        <p className="mt-8 text-center text-sm text-neutral-400">
          {t("auth.login.noAccount")}{" "}
          <Link to="/register" className="font-medium text-volt-400 hover:text-volt-300">
            {t("auth.login.signUp")}
          </Link>
        </p>
      </div>
    </div>
  );
}
