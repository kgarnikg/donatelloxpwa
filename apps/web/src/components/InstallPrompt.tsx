import { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { Share, SquarePlus, X, Copy, Check, ArrowDown, MoreVertical, Download } from "lucide-react";
import {
  canPromptNatively,
  detectPlatform,
  onInstallAvailabilityChange,
  promptNativeInstall,
  type InstallPlatform,
} from "@/lib/install";

/**
 * Нижняя панель "Установи DonatelleX на главный экран": на iPhone —
 * три коротких шага с теми же значками, что в Safari; на Android — одна
 * кнопка "Установить" (системное окно) или подсказка про меню ⋮; во
 * встроенных браузерах (Instagram и т.п.) — "открой в Safari".
 */
export function InstallPrompt({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const [platform] = useState<InstallPlatform>(() => detectPlatform());
  const [nativeAvailable, setNativeAvailable] = useState(canPromptNatively());
  const [copied, setCopied] = useState(false);

  useEffect(() => onInstallAvailabilityChange(() => setNativeAvailable(canPromptNatively())), []);

  // Фон не скроллится, Esc закрывает
  useEffect(() => {
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && onClose();
    window.addEventListener("keydown", onKey);
    return () => {
      document.body.style.overflow = prev;
      window.removeEventListener("keydown", onKey);
    };
  }, [onClose]);

  async function copyLink() {
    try {
      await navigator.clipboard.writeText(window.location.origin);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // буфер обмена недоступен — ссылка и так видна в тексте
    }
  }

  const isIOS = platform === "ios-safari" || platform === "ios-other";

  return (
    <div className="fixed inset-0 z-[60] flex items-end justify-center bg-black/70 animate-fade-in" onClick={onClose}>
      <div
        className="relative w-full max-w-md rounded-t-3xl border border-b-0 border-ink-700 bg-ink-900 px-6 pb-[max(1.5rem,env(safe-area-inset-bottom))] pt-6"
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
        aria-label={t("install.title")}
      >
        <button
          onClick={onClose}
          aria-label={t("common.close")}
          className="absolute end-4 top-4 flex h-8 w-8 items-center justify-center rounded-full bg-ink-800 text-neutral-400 hover:text-neutral-200"
        >
          <X size={16} />
        </button>

        <div className="flex items-center gap-4 pe-8">
          <img src="/icons/icon-192.png" alt="" className="h-14 w-14 shrink-0 rounded-2xl shadow-lg" />
          <div>
            <h2 className="font-display text-lg font-bold leading-tight">{t("install.title")}</h2>
            <p className="mt-1 text-sm text-neutral-400">{t("install.subtitle")}</p>
          </div>
        </div>

        {isIOS && (
          <ol className="mt-6 space-y-4">
            <Step n={1}>
              <span>
                {platform === "ios-safari" ? t("install.iosStep1") : t("install.iosOtherStep1")}{" "}
                <Share size={17} className="mx-0.5 inline -translate-y-0.5 text-info" />
              </span>
              {platform === "ios-safari" && (
                <span className="mt-0.5 block text-xs text-neutral-500">{t("install.iosStep1Hint")}</span>
              )}
            </Step>
            <Step n={2}>
              <span>
                {t("install.iosStep2")}{" "}
                <span className="inline-flex items-center gap-1 rounded-md bg-ink-800 px-2 py-0.5 font-semibold text-neutral-100">
                  {t("install.iosAddLabel")} <SquarePlus size={15} />
                </span>
              </span>
              <span className="mt-0.5 block text-xs text-neutral-500">{t("install.iosStep2Hint")}</span>
            </Step>
            <Step n={3}>
              <span>
                {t("install.iosStep3")}{" "}
                <span className="font-semibold text-info">{t("install.iosAdd")}</span>
              </span>
            </Step>
          </ol>
        )}

        {platform === "ios-inapp" && (
          <div className="mt-6 space-y-3 text-sm text-neutral-300">
            <p>{t("install.inappText")}</p>
            <button onClick={copyLink} className="btn-secondary w-full">
              {copied ? <Check size={16} /> : <Copy size={16} />}
              {copied ? t("install.copied") : t("install.copyLink")}
            </button>
          </div>
        )}

        {(platform === "android" || platform === "desktop") &&
          (nativeAvailable ? (
            <button
              onClick={async () => {
                const ok = await promptNativeInstall();
                if (ok) onClose();
              }}
              className="btn-primary mt-6 w-full py-4 text-base"
            >
              <Download size={18} /> {t("install.androidInstall")}
            </button>
          ) : (
            <p className="mt-6 flex items-start gap-2 text-sm text-neutral-300">
              <MoreVertical size={18} className="mt-0.5 shrink-0 text-volt-400" />
              {t("install.androidManual")}
            </p>
          ))}

        <button onClick={onClose} className="mt-6 w-full py-2 text-sm font-medium text-neutral-400 hover:text-neutral-200">
          {isIOS ? t("install.done") : t("install.later")}
        </button>

        {/* В Safari на iPhone кнопка "Поделиться" — в нижней панели браузера, прямо под этой карточкой */}
        {platform === "ios-safari" && (
          <div className="flex justify-center" aria-hidden>
            <ArrowDown size={22} className="animate-bounce text-volt-400" />
          </div>
        )}
      </div>
    </div>
  );
}

function Step({ n, children }: { n: number; children: React.ReactNode }) {
  return (
    <li className="flex items-start gap-3 text-[15px] leading-snug text-neutral-200">
      <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-volt-400 text-sm font-extrabold text-ink-950">
        {n}
      </span>
      <div className="pt-0.5">{children}</div>
    </li>
  );
}
