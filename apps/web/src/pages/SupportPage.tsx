import { useState, useRef } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, Paperclip, X, Send, CheckCircle2 } from "lucide-react";
import { useAuth } from "@/context/AuthContext";
import { supabase } from "@/lib/supabase";

/**
 * "Помощь" — клиент пишет о проблеме, может прикрепить скриншот, это
 * письмом уходит тренеру. Адрес тренера нигде здесь не фигурирует — сама
 * функция (send-support-request, Edge Function) знает, куда слать, эта
 * страница просто вызывает её без параметра "кому".
 */
export default function SupportPage() {
  const { t } = useTranslation();
  const { session } = useAuth();
  const navigate = useNavigate();
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [message, setMessage] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [sending, setSending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [sent, setSent] = useState(false);

  function handleFileSelect(e: React.ChangeEvent<HTMLInputElement>) {
    const picked = e.target.files?.[0];
    if (!picked) return;
    // 5 МБ — с запасом для обычного скриншота с телефона, не даём
    // случайно прикрепить видео или что-то огромное.
    if (picked.size > 5 * 1024 * 1024) {
      setError(t("support.fileTooLarge"));
      return;
    }
    setError(null);
    setFile(picked);
  }

  async function handleSubmit() {
    if (!message.trim() || !session?.user) return;
    setSending(true);
    setError(null);

    try {
      let screenshotPath: string | undefined;
      if (file) {
        const path = `${session.user.id}/${Date.now()}-${file.name}`;
        const { error: uploadError } = await supabase.storage.from("support-attachments").upload(path, file);
        if (uploadError) throw uploadError;
        screenshotPath = path;
      }

      const response = await fetch("/api/send-support-request", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({ message: message.trim(), screenshotPath }),
      });
      const data = await response.json();
      if (!response.ok || data?.error) throw new Error(data?.error ?? "send_failed");

      setSent(true);
    } catch {
      setError(t("support.sendError"));
    } finally {
      setSending(false);
    }
  }

  if (sent) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-5 text-center">
        <div className="flex h-14 w-14 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
          <CheckCircle2 size={28} />
        </div>
        <h1 className="mt-4 font-display text-xl font-bold">{t("support.sentTitle")}</h1>
        <p className="mt-1.5 max-w-xs text-neutral-400">{t("support.sentBody")}</p>
        <button onClick={() => navigate("/profile")} className="btn-primary mt-6">
          {t("common.back")}
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8 pb-8">
      <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ArrowLeft size={16} /> {t("common.back")}
      </Link>

      <h1 className="mb-1 font-display text-2xl font-bold">{t("support.title")}</h1>
      <p className="mb-6 text-neutral-400">{t("support.subtitle")}</p>

      <textarea
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        placeholder={t("support.placeholder") ?? undefined}
        rows={6}
        className="input-field resize-none"
      />

      <input ref={fileInputRef} type="file" accept="image/*" onChange={handleFileSelect} className="hidden" />

      {file ? (
        <div className="mt-3 flex items-center justify-between rounded-md border border-ink-700 bg-ink-800 px-3.5 py-2.5">
          <span className="truncate text-sm text-neutral-300">{file.name}</span>
          <button onClick={() => setFile(null)} className="shrink-0 text-neutral-500 hover:text-neutral-300">
            <X size={16} />
          </button>
        </div>
      ) : (
        <button
          onClick={() => fileInputRef.current?.click()}
          className="mt-3 flex items-center gap-1.5 text-sm text-neutral-400 hover:text-neutral-200"
        >
          <Paperclip size={15} /> {t("support.attachScreenshot")}
        </button>
      )}

      {error && <p className="field-error mt-3">{error}</p>}

      <button
        onClick={handleSubmit}
        disabled={!message.trim() || sending}
        className="btn-primary mt-6 w-full disabled:opacity-50"
      >
        <Send size={16} /> {sending ? t("support.sending") : t("support.send")}
      </button>
    </div>
  );
}
