import { useEffect } from "react";
import { useTranslation } from "react-i18next";
import { ChevronDown, Plus, SkipForward, Undo2 } from "lucide-react";
import clsx from "clsx";

interface RestTimerOverlayProps {
  kind: "set" | "exercise";
  /** Осталось секунд (целое, считается от абсолютного endAt — см. WorkoutPlayerPage). */
  remaining: number;
  /** Полная длительность текущего отдыха (с учётом "+15 с"). */
  total: number;
  /** Что дальше: "Подход 2 · Жим лёжа" — видно издалека, куда возвращаться. */
  nextLabel?: string;
  onSkip: () => void;
  onAddTime: (seconds: number) => void;
  onMinimize: () => void;
  /** Есть, пока открыто 5-секундное окно "Отменить" после отметки подхода. */
  onUndo?: () => void;
}

const RING_RADIUS = 46;
const RING_LENGTH = 2 * Math.PI * RING_RADIUS;
/** Последние секунды — кольцо и цифры становятся оранжевыми и пульсируют. */
const FINAL_SECONDS = 5;

/**
 * Полноэкранный таймер отдыха.
 *
 * Сценарий: атлет отметил подход, положил телефон и отошёл от тренажёра —
 * цифры должны читаться с 2–3 метров. Поэтому: крупные цифры на весь
 * экран, толстое кольцо прогресса в фирменном вольте, экран не гаснет
 * (Wake Lock), открывается сам при отметке подхода и сам закрывается,
 * когда время вышло. "Свернуть" возвращает компактную полоску внизу —
 * например, чтобы вписать рабочий вес, пока идёт отдых.
 */
export function RestTimerOverlay({
  kind,
  remaining,
  total,
  nextLabel,
  onSkip,
  onAddTime,
  onMinimize,
  onUndo,
}: RestTimerOverlayProps) {
  const { t } = useTranslation();
  const progress = total > 0 ? Math.min(1, Math.max(0, remaining / total)) : 0;
  const isFinal = remaining <= FINAL_SECONDS;
  const minutes = Math.floor(remaining / 60);
  const seconds = String(remaining % 60).padStart(2, "0");

  // Фон не скроллится, пока таймер на весь экран.
  useEffect(() => {
    const previous = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = previous;
    };
  }, []);

  // Экран не гаснет, пока идёт отдых (иначе телефон уснёт через 30 с и
  // таймер издалека не увидеть). Wake Lock есть в Chrome/Android и в
  // Safari 16.4+; где его нет — просто без него. Браузер сам снимает
  // блокировку при сворачивании вкладки — поэтому берём заново при возврате.
  useEffect(() => {
    type WakeLockSentinelLike = { release: () => Promise<void> };
    const wakeLock = (navigator as Navigator & {
      wakeLock?: { request: (type: "screen") => Promise<WakeLockSentinelLike> };
    }).wakeLock;
    if (!wakeLock) return;

    let sentinel: WakeLockSentinelLike | null = null;
    let disposed = false;
    const acquire = () => {
      if (document.visibilityState !== "visible") return;
      wakeLock
        .request("screen")
        .then((s) => {
          if (disposed) s.release().catch(() => {});
          else sentinel = s;
        })
        .catch(() => {});
    };
    acquire();
    document.addEventListener("visibilitychange", acquire);
    return () => {
      disposed = true;
      document.removeEventListener("visibilitychange", acquire);
      sentinel?.release().catch(() => {});
    };
  }, []);

  return (
    <div
      className="fixed inset-0 z-[45] flex flex-col bg-ink-950/[0.97] backdrop-blur-md animate-fade-in"
      role="dialog"
      aria-modal="true"
      aria-label={kind === "exercise" ? t("workout.restingNextExercise") : t("workout.resting")}
    >
      {/* Мягкое вольт-свечение за кольцом — "наш" стиль, как на карточках и кнопках */}
      <div
        className={clsx(
          "pointer-events-none absolute left-1/2 top-[42%] h-[70vmin] w-[70vmin] -translate-x-1/2 -translate-y-1/2 rounded-full blur-3xl transition-colors duration-700",
          isFinal ? "bg-ember-400/15" : "bg-volt-400/10",
        )}
        aria-hidden
      />

      <div className="relative flex items-center justify-between px-5 pt-[max(1rem,env(safe-area-inset-top))]">
        <button
          onClick={onMinimize}
          className="flex items-center gap-1.5 rounded-full px-3 py-2 text-sm font-medium text-neutral-400 transition hover:bg-ink-800 hover:text-neutral-200"
        >
          <ChevronDown size={18} /> {t("workout.restMinimize")}
        </button>
        {onUndo && (
          <button
            onClick={onUndo}
            className="flex items-center gap-1.5 rounded-full px-3 py-2 text-sm font-semibold text-volt-400 transition hover:bg-ink-800 animate-fade-in"
          >
            <Undo2 size={16} /> {t("workout.undo")}
          </button>
        )}
      </div>

      <div className="relative flex flex-1 flex-col items-center justify-center px-6">
        <p
          className={clsx(
            "text-center text-sm font-extrabold uppercase tracking-[0.25em] transition-colors",
            isFinal ? "text-ember-400" : "text-volt-400",
          )}
        >
          {kind === "exercise" ? t("workout.restingNextExercise") : t("workout.resting")}
        </p>

        <div
          className="relative mt-6 aspect-square w-[min(84vw,52vh,380px)]"
          role="timer"
          aria-live="off"
        >
          <svg viewBox="0 0 100 100" className="h-full w-full -rotate-90 overflow-visible" aria-hidden>
            <circle cx="50" cy="50" r={RING_RADIUS} fill="none" strokeWidth="5" className="stroke-ink-800" />
            <circle
              cx="50"
              cy="50"
              r={RING_RADIUS}
              fill="none"
              strokeWidth="5"
              strokeLinecap="round"
              strokeDasharray={RING_LENGTH}
              strokeDashoffset={RING_LENGTH * (1 - progress)}
              className={clsx(
                "transition-[stroke-dashoffset,stroke] duration-1000 ease-linear",
                isFinal ? "stroke-ember-400" : "stroke-volt-400",
              )}
              style={{
                filter: isFinal
                  ? "drop-shadow(0 0 3px rgba(255,107,53,0.7))"
                  : "drop-shadow(0 0 3px rgba(168,224,0,0.6))",
              }}
            />
          </svg>

          <div className="absolute inset-0 flex items-center justify-center">
            <span
              key={isFinal ? remaining : "steady"}
              className={clsx(
                "font-display font-extrabold leading-none tracking-tight tabular-nums",
                "text-[clamp(64px,min(24vw,15vh),148px)]",
                isFinal ? "animate-rest-tick text-ember-400" : "text-neutral-0",
              )}
            >
              {minutes}:{seconds}
            </span>
          </div>
        </div>

        {nextLabel && (
          <div className="mt-7 max-w-sm text-center">
            <p className="text-xs font-semibold uppercase tracking-[0.2em] text-neutral-500">{t("workout.nextUp")}</p>
            <p className="mt-1.5 line-clamp-2 text-lg font-bold text-neutral-100">{nextLabel}</p>
          </div>
        )}
      </div>

      <div className="relative mx-auto grid w-full max-w-md grid-cols-2 gap-3 px-5 pb-[max(1.25rem,env(safe-area-inset-bottom))]">
        <button
          onClick={() => onAddTime(15)}
          className="flex items-center justify-center gap-1.5 rounded-xl border border-ink-600 bg-ink-900 py-4 text-base font-bold text-neutral-100 transition hover:bg-ink-800 active:scale-[0.97]"
        >
          <Plus size={18} /> {t("workout.restAdd", { count: 15 })}
        </button>
        <button
          onClick={onSkip}
          className="flex items-center justify-center gap-1.5 rounded-xl bg-volt-400 py-4 text-base font-extrabold uppercase tracking-wide text-ink-950 transition hover:bg-volt-300 active:scale-[0.97]"
        >
          {t("workout.restSkipShort")} <SkipForward size={18} />
        </button>
      </div>
    </div>
  );
}
