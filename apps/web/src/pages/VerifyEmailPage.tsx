import { useEffect, useRef, useState } from "react";
import { MailCheck } from "lucide-react";
import { Link, useLocation } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { supabase } from "@/lib/supabase";

const RESEND_COOLDOWN_SECONDS = 120;

export default function VerifyEmailPage() {
  const { t } = useTranslation();
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
      <h1 className="font-display text-2xl font-bold">{t("auth.verify.title")}</h1>
      <p className="mt-2 max-w-xs text-neutral-400">
        {t("auth.verify.text")}
      </p>

      {!email && (
        <input
          type="email"
          value={manualEmail}
          onChange={(e) => setManualEmail(e.target.value)}
          placeholder={t("auth.verify.emailPlaceholder")}
          className="input-field mt-6 max-w-xs"
        />
      )}

      <button
        onClick={handleResend}
        disabled={!manualEmail || cooldown > 0 || status === "sending"}
        className="btn-secondary mt-4 w-full max-w-xs"
      >
        {cooldown > 0
          ? t("auth.verify.resendIn", { time: `${Math.floor(cooldown / 60)}:${String(cooldown % 60).padStart(2, "0")}` })
          : status === "sending"
            ? t("auth.verify.sending")
            : t("auth.verify.resend")}
      </button>

      {status === "sent" && (
        <p className="mt-2 text-sm text-success">{t("auth.verify.resent")}</p>
      )}
      {status === "error" && (
        <p className="mt-2 text-sm text-danger">{t("auth.verify.failed")}</p>
      )}

      <Link to="/login" className="btn-secondary mt-6 w-full max-w-xs">
        {t("auth.backToLogin")}
      </Link>
    </div>
  );
}
