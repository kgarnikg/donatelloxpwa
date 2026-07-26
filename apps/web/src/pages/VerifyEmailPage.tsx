import { useEffect, useRef, useState } from "react";
import { MailCheck } from "lucide-react";
import { Link, useLocation } from "react-router-dom";
import { supabase } from "@/lib/supabase";

const RESEND_COOLDOWN_SECONDS = 120;

export default function VerifyEmailPage() {
  const location = useLocation();
  const email = (location.state as { email?: string } | null)?.email ?? "";

  const [manualEmail, setManualEmail] = useState(email);
  const [cooldown, setCooldown] = useState(0);
  const [status, setStatus] = useState<"idle" | "sending" | "sent" | "error">("idle");
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    return () => {
      if (intervalRef.current) clearInterval(intervalRef.current);
    };
  }, []);

  function startCooldown() {
    setCooldown(RESEND_COOLDOWN_SECONDS);
    intervalRef.current = setInterval(() => {
      setCooldown((prev) => {
        if (prev <= 1) {
          if (intervalRef.current) clearInterval(intervalRef.current);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
  }

  async function handleResend() {
    if (!manualEmail || cooldown > 0) return;
    setStatus("sending");
    const { error } = await supabase.auth.resend({
      type: "signup",
      email: manualEmail,
      options: { emailRedirectTo: `${window.location.origin}/onboarding` },
    });
    if (error) {
      setStatus("error");
      return;
    }
    setStatus("sent");
    startCooldown();
  }

  return (
    <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
      <div className="mb-5 flex h-16 w-16 items-center justify-center rounded-full bg-volt-400/15 text-volt-400">
        <MailCheck size={30} />
      </div>
      <h1 className="font-display text-2xl font-bold">Подтвердите email</h1>
      <p className="mt-2 max-w-xs text-neutral-400">
        Мы отправили письмо со ссылкой для подтверждения. Перейдите по ней, чтобы продолжить.
      </p>

      {!email && (
        <input
          type="email"
          value={manualEmail}
          onChange={(e) => setManualEmail(e.target.value)}
          placeholder="ваш email"
          className="input-field mt-6 max-w-xs"
        />
      )}

      <button
        onClick={handleResend}
        disabled={!manualEmail || cooldown > 0 || status === "sending"}
        className="btn-secondary mt-4 w-full max-w-xs"
      >
        {cooldown > 0
          ? `Повторить через ${Math.floor(cooldown / 60)}:${String(cooldown % 60).padStart(2, "0")}`
          : status === "sending"
            ? "Отправляем…"
            : "Отправить письмо ещё раз"}
      </button>

      {status === "sent" && (
        <p className="mt-2 text-sm text-success">Письмо отправлено повторно.</p>
      )}
      {status === "error" && (
        <p className="mt-2 text-sm text-danger">Не удалось отправить. Попробуйте позже.</p>
      )}

      <Link to="/login" className="btn-secondary mt-6 w-full max-w-xs">
        Вернуться ко входу
      </Link>
    </div>
  );
}
