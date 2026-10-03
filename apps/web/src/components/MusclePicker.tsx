import { lazy, Suspense, useEffect, useRef, useState } from "react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { Check, RotateCw } from "lucide-react";
import {
  FOCUS_MUSCLES,
  type FocusMuscle,
  type Gender,
} from "@donatellox/types";

// three.js и модель подгружаются только на этом шаге анкеты —
// в основной загрузке приложения их нет.
const MuscleBody3D = lazy(() => import("./MuscleBody3D"));

/** Какие мышцы видно только со спины: при выборе из списка фигура сама поворачивается. */
const BACK_SIDE: ReadonlySet<FocusMuscle> = new Set([
  "triceps",
  "traps",
  "back",
  "lower_back",
  "glutes",
  "hamstrings",
]);
const FRONT_SIDE: ReadonlySet<FocusMuscle> = new Set([
  "chest",
  "biceps",
  "abs",
  "quads",
]);

interface MusclePickerProps {
  gender: Gender;
  value: FocusMuscle[];
  onChange: (next: FocusMuscle[]) => void;
}

/**
 * Выбор мышц для акцента: 3D-фигура (нажать на мышцу) + тот же выбор списком.
 * Список — не запасной вариант, а равноправный: им удобнее на маленьком
 * экране, он работает без WebGL и с экранным диктором.
 * Женской модели пока нет — для женщин показываем только список.
 */
export function MusclePicker({ gender, value, onChange }: MusclePickerProps) {
  const { t } = useTranslation();
  const [view, setView] = useState<"front" | "back">("front");
  const [ready, setReady] = useState(false);
  const [failed, setFailed] = useState(false);
  const [touched, setTouched] = useState(false);
  const [flash, setFlash] = useState<{
    muscle: FocusMuscle;
    on: boolean;
    key: number;
  } | null>(null);
  const flashTimer = useRef<number | undefined>(undefined);
  const show3d = gender !== "female" && !failed;

  useEffect(() => () => window.clearTimeout(flashTimer.current), []);

  function toggle(muscle: FocusMuscle, fromList: boolean) {
    const on = !value.includes(muscle);
    // порядок как в списке — чтобы в базе и в админке он был одинаковым
    const next = FOCUS_MUSCLES.filter((m) =>
      m === muscle ? on : value.includes(m),
    );
    onChange(next);
    setTouched(true);
    if (fromList && on) {
      if (BACK_SIDE.has(muscle)) setView("back");
      else if (FRONT_SIDE.has(muscle)) setView("front");
    }
    if (!fromList) {
      setFlash({ muscle, on, key: Date.now() });
      window.clearTimeout(flashTimer.current);
      flashTimer.current = window.setTimeout(() => setFlash(null), 1400);
    }
  }

  return (
    <div>
      {show3d && (
        <div className="mt-4 flex justify-center">
          <div
            role="group"
            className="flex rounded-full border border-ink-600 bg-ink-800 p-0.5 text-xs font-semibold"
          >
            {(["front", "back"] as const).map((side) => (
              <button
                key={side}
                type="button"
                aria-pressed={view === side}
                disabled={!ready}
                onClick={() => {
                  setView(side);
                  setTouched(true);
                }}
                className={clsx(
                  "rounded-full px-5 py-1.5 transition",
                  view === side
                    ? "bg-volt-400 text-ink-950"
                    : "text-neutral-300",
                )}
              >
                {t(`onboarding.muscles.${side}`)}
              </button>
            ))}
          </div>
        </div>
      )}
      {show3d && (
        <div className="relative -mx-6 mt-1 h-[clamp(340px,54dvh,520px)] overflow-hidden">
          <div
            aria-hidden
            className="pointer-events-none absolute inset-0"
            style={{
              background:
                "radial-gradient(58% 46% at 50% 40%, rgba(168,224,0,0.09), rgba(168,224,0,0.02) 55%, transparent 75%)",
            }}
          />
          <div
            aria-hidden
            className="pointer-events-none absolute bottom-10 left-1/2 h-5 w-36 -translate-x-1/2 rounded-[50%] bg-black/70 blur-md"
          />
          <Suspense fallback={null}>
            <MuscleBody3D
              className={clsx(
                "absolute inset-x-0 bottom-9 top-0 transition-opacity duration-500",
                ready ? "opacity-100" : "opacity-0",
              )}
              ariaLabel={t("onboarding.muscles.figureLabel")}
              selected={value}
              onToggle={(m) => toggle(m, false)}
              view={view}
              onViewChange={setView}
              onReady={() => setReady(true)}
              onError={() => setFailed(true)}
            />
          </Suspense>

          {!ready && (
            <div className="absolute inset-0 flex flex-col items-center justify-center gap-3 text-sm text-neutral-500">
              <span className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
              {t("onboarding.muscles.loading")}
            </div>
          )}

          {ready && (
            <div
              className="pointer-events-none absolute inset-x-0 bottom-0 flex justify-center px-6"
              aria-live="polite"
            >
              {flash ? (
                <span
                  key={flash.key}
                  className={clsx(
                    "inline-flex animate-fade-in items-center gap-1.5 rounded-full px-3.5 py-1.5 text-sm font-semibold shadow-card",
                    flash.on
                      ? "bg-volt-400 text-ink-950"
                      : "border border-ink-600 bg-ink-900/90 text-neutral-300",
                  )}
                >
                  {flash.on && (
                    <Check className="h-4 w-4" strokeWidth={3} aria-hidden />
                  )}
                  {t(`onboarding.muscles.names.${flash.muscle}`)}
                </span>
              ) : (
                !touched && (
                  <span className="inline-flex animate-fade-in items-center gap-1.5 rounded-full border border-ink-600 bg-ink-900/80 px-3.5 py-1.5 text-xs text-neutral-300 backdrop-blur">
                    <RotateCw
                      className="h-3.5 w-3.5 text-volt-400"
                      aria-hidden
                    />
                    {t("onboarding.muscles.hint")}
                  </span>
                )
              )}
            </div>
          )}
        </div>
      )}

      <div className={clsx("flex flex-wrap gap-2", show3d ? "mt-4" : "mt-6")}>
        {FOCUS_MUSCLES.map((muscle) => {
          const on = value.includes(muscle);
          return (
            <button
              key={muscle}
              type="button"
              aria-pressed={on}
              onClick={() => toggle(muscle, true)}
              className={clsx(
                "rounded-full border px-3.5 py-2 text-sm font-medium transition",
                on
                  ? "border-volt-400 bg-volt-400/10 text-volt-300"
                  : "border-ink-600 bg-ink-800 text-neutral-300 hover:border-ink-500",
              )}
            >
              {t(`onboarding.muscles.names.${muscle}`)}
            </button>
          );
        })}
      </div>
    </div>
  );
}
