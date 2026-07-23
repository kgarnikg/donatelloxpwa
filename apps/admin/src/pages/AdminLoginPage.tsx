import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { loginSchema, type LoginInput } from "@donatellox/validation";
import { supabase } from "@/lib/supabase";

export default function AdminLoginPage() {
  const navigate = useNavigate();
  const location = useLocation();
  const from = (location.state as { from?: Location })?.from?.pathname ?? "/";
  const [serverError, setServerError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<LoginInput>({ resolver: zodResolver(loginSchema) });

  async function onSubmit(values: LoginInput) {
    setServerError(null);
    const { error } = await supabase.auth.signInWithPassword(values);
    if (error) {
      setServerError("Неверный email или пароль");
      return;
    }
    navigate(from, { replace: true });
  }

  return (
    <div className="flex min-h-dvh items-center justify-center bg-ink-950 px-6">
      <div className="w-full max-w-sm">
        <div className="mb-8 flex flex-col items-center">
          <div className="mb-3 flex h-11 w-11 items-center justify-center rounded-lg bg-volt-400 font-display text-xl font-bold text-ink-950">
            D
          </div>
          <h1 className="font-display text-xl font-bold">DonatelloX CMS</h1>
          <p className="mt-1 text-sm text-neutral-400">Вход для администраторов</p>
        </div>

        <form onSubmit={handleSubmit(onSubmit)} className="card space-y-4">
          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Email</label>
            <input
              type="email"
              className="input-field"
              placeholder="admin@donatellox.com"
              {...register("email")}
            />
            {errors.email && <p className="field-error">{errors.email.message}</p>}
          </div>

          <div>
            <label className="mb-1.5 block text-sm font-medium text-neutral-300">Пароль</label>
            <input type="password" className="input-field" {...register("password")} />
            {errors.password && <p className="field-error">{errors.password.message}</p>}
          </div>

          {serverError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              {serverError}
            </div>
          )}

          <button type="submit" disabled={isSubmitting} className="btn-primary w-full">
            {isSubmitting ? "Входим…" : "Войти"}
          </button>
        </form>
      </div>
    </div>
  );
}
