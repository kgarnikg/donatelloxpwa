import { useState } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, Mail } from "lucide-react";
import { useAuth } from "@/context/AuthContext";

const SUPPORT_EMAIL = "donatellex@gmail.com";

/**
 * "Помощь" — максимально просто: пишешь сообщение, жмёшь кнопку, открывается
 * обычное письмо в родной почте телефона/компьютера, уже с адресом,
 * темой и текстом внутри. Ни бэкенда, ни базы, ни хранилища — раньше
 * здесь была Vercel-функция + Supabase Storage под скриншоты, убрано по
 * запросу пользователя (почту скрывать не критично, автоскриншот тоже) —
 * см. PROJECT_PLAN.md. Прикрепить скриншот, если нужно, — можно вручную
 * в уже открывшемся письме.
 */
export default function SupportPage() {
  const { t } = useTranslation();
  const { profile } = useAuth();
  const [message, setMessage] = useState("");

  function openEmail() {
    const subject = t("support.emailSubject", { name: profile?.fullName ?? "" });
    const body = message.trim();
    window.location.href = `mailto:${SUPPORT_EMAIL}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
  }

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-8">
      <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ArrowLeft size={16} /> {t("common.back")}
      </Link>

      <div className="mb-6 flex h-12 w-12 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
        <Mail size={22} />
      </div>

      <h1 className="mb-1 font-display text-2xl font-bold">{t("support.title")}</h1>
      <p className="mb-6 text-neutral-400">{t("support.subtitle")}</p>

      <textarea
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        placeholder={t("support.placeholder") ?? undefined}
        rows={6}
        className="input-field resize-none"
      />
      <p className="mt-2 text-xs text-neutral-500">{t("support.screenshotHint")}</p>

      <button onClick={openEmail} className="btn-primary mt-6 w-full">
        <Mail size={16} /> {t("support.send")}
      </button>
    </div>
  );
}
