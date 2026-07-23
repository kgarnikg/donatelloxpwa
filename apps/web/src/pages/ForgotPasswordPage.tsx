import { useState } from "react";
import { Link } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { forgotPasswordSchema } from "@donatellox/validation";
import { z } from "zod";
import { supabase } from "@/lib/supabase";

type FormValues = z.infer<typeof forgotPasswordSchema>;

export default function ForgotPasswordPage() {
  const [sent, setSent] = useState(false);
  const [serverError, setServerError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<FormValues>({ resolver: zodResolver(forgotPasswordSchema) });

  async function onSubmit(values: FormValues) {
    setServerError(null);
    const { error } = await supabase.auth.resetPasswordForEmail(values.email, {
      redirectTo: `${window.location.origin}/reset-password`,
    });
    if (error) {
      setServerError(error.message);
      return;
    }
    setSent(true);
  }

  return (
    <div className="flex min-h-dvh flex-col justify-center bg-ink-950 px-6 py-12">
      <div className="mx-auto w-full max-w-sm animate-fade-in">
        <h1 className="font-display text-3xl font-bold">Восстановление пароля</h1>

        {sent ? (
          <div className="card mt-8 border-success/30 bg-success/5">
            <p className="text-success">Письмо со ссылкой для сброса пароля отправлено на почту.</p>
          </div>
        ) : (
          <form onSubmit={handleSubmit(onSubmit)} className="mt-8 space-y-4" noValidate>
            <div>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">Email</label>
              <input type="email" className="input-field" {...register("email")} />
              {errors.email && <p className="field-error">{errors.email.message}</p>}
            </div>
            {serverError && (
              <div className="rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
                {serverError}
              </div>
            )}
            <button type="submit" disabled={isSubmitting} className="btn-primary w-full">
              {isSubmitting ? "Отправляем…" : "Отправить ссылку"}
            </button>
          </form>
        )}

        <p className="mt-8 text-center text-sm text-neutral-400">
          <Link to="/login" className="font-medium text-volt-400 hover:text-volt-300">
            Вернуться ко входу
          </Link>
        </p>
      </div>
    </div>
  );
}
