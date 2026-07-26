import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { KeyRound } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { PasswordInput } from "@/components/PasswordInput";

const resetPasswordFormSchema = z
  .object({
    password: z.string().min(8, "Минимум 8 символов"),
    passwordConfirm: z.string(),
  })
  .refine((data) => data.password === data.passwordConfirm, {
    message: "Пароли не совпадают",
    path: ["passwordConfirm"],
  });

type FormValues = z.infer<typeof resetPasswordFormSchema>;

export default function ResetPasswordPage() {
  const navigate = useNavigate();
  const [ready, setReady] = useState(false);
  const [invalidLink, setInvalidLink] = useState(false);
  const [serverError, setServerError] = useState<string | null>(null);
  const [done, setDone] = useState(false);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<FormValues>({ resolver: zodResolver(resetPasswordFormSchema) });

  useEffect(() => {
    // Ссылка восстановления пароля от Supabase кладёт токен восстановления
    // во фрагмент URL (#access_token=...&type=recovery) и supabase-js сам
    // обменивает его на сессию через onAuthStateChange → PASSWORD_RECOVERY.
    const { data: subscription } = supabase.auth.onAuthStateChange((event) => {
      if (event === "PASSWORD_RECOVERY") setReady(true);
    });

    // Если сессия уже была восстановлена до монтирования слушателя.
    supabase.auth.getSession().then(({ data }) => {
      if (data.session) setReady(true);
    });

    const timeout = setTimeout(() => {
      setReady((current) => {
        if (!current) setInvalidLink(true);
        return current;
      });
    }, 3000);

    return () => {
      subscription.subscription.unsubscribe();
      clearTimeout(timeout);
    };
  }, []);

  async function onSubmit(values: FormValues) {
    setServerError(null);
    const { error } = await supabase.auth.updateUser({ password: values.password });
    if (error) {
      setServerError(error.message);
      return;
    }
    setDone(true);
    setTimeout(() => navigate("/dashboard", { replace: true }), 1500);
  }

  if (invalidLink) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
        <h1 className="font-display text-2xl font-bold">Ссылка недействительна</h1>
        <p className="mt-2 max-w-xs text-neutral-400">
          Ссылка для сброса пароля устарела или уже была использована. Запросите новую.
        </p>
        <button onClick={() => navigate("/forgot-password")} className="btn-primary mt-6">
          Запросить новую ссылку
        </button>
      </div>
    );
  }

  if (!ready) {
    return (
      <div className="flex min-h-dvh items-center justify-center bg-ink-950">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
      </div>
    );
  }

  if (done) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
        <h1 className="font-display text-2xl font-bold">Пароль обновлён</h1>
        <p className="mt-2 text-neutral-400">Переходим в приложение…</p>
      </div>
    );
  }

  return (
    <div className="flex min-h-dvh flex-col justify-center bg-ink-950 px-6 py-12">
      <div className="mx-auto w-full max-w-sm animate-fade-in">
        <div className="mb-5 flex h-14 w-14 items-center justify-center rounded-full bg-volt-400/15 text-volt-400">
          <KeyRound size={26} />
        </div>
        <h1 className="font-display text-2xl font-bold">Новый пароль</h1>
        <p className="mt-2 text-neutral-400">Придумайте новый пароль для входа.</p>

        <form onSubmit={handleSubmit(onSubmit)} className="mt-6 space-y-4" noValidate>
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Новый пароль</label>
            <PasswordInput placeholder="Минимум 8 символов" {...register("password")} />
            {errors.password && <p className="field-error">{errors.password.message}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Повторите пароль</label>
            <PasswordInput {...register("passwordConfirm")} />
            {errors.passwordConfirm && <p className="field-error">{errors.passwordConfirm.message}</p>}
          </div>

          {serverError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
              {serverError}
            </div>
          )}

          <button type="submit" disabled={isSubmitting} className="btn-primary w-full">
            {isSubmitting ? "Сохраняем…" : "Сохранить пароль"}
          </button>
        </form>
      </div>
    </div>
  );
}
