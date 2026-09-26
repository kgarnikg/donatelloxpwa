import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { ChevronRight, Play, Check, Flame, Sparkles, Info, X, Trophy, Lock } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { localizedOf } from "@/lib/localizedField";
import { useAuth } from "@/context/AuthContext";
import {
  useActiveSubscription,
  usePrograms,
  useAchievements,
  useProgramAccess,
  useWorkoutCalorieStats,
} from "@/lib/queries";
import { useDashboard } from "@/lib/dashboard";
import { XP_RULES, startOfWeek, rankForLevel, type LevelInfo } from "@/lib/gamification";
import { getDailyQuote } from "@/lib/quotes";
import { InstallPrompt } from "@/components/InstallPrompt";
import { markInstallPromptShown, shouldAutoShowInstall } from "@/lib/install";

/**
 * Главная — геймифицированная (Фаза 23). Сверху вниз:
 * уровень/XP → "Сегодня" (следующая тренировка) → неделя и серия →
 * путь по программе → ближайшая награда → цифры → мысль дня.
 * Список программ — только для тех, у кого ещё нет ни одной тренировки.
 */
export default function DashboardPage() {
  const { t, i18n } = useTranslation();
  const { profile, authUser } = useAuth();
  const { data: subscription } = useActiveSubscription();
  const access = useProgramAccess();
  const { data: allPrograms } = usePrograms();
  const { data: dash, isLoading } = useDashboard();
  const { data: achievements } = useAchievements();
  const { data: calories } = useWorkoutCalorieStats();

  const firstName =
    profile?.fullName?.trim().split(" ")[0] || authUser?.email?.split("@")[0] || "";

  const levelUp = useLevelUpCelebration(authUser?.id, dash?.game.level.level);

  // Подсказка "установи на главный экран": первый заход на главную после
  // анкеты и сразу после первой тренировки (правила — lib/install.ts).
  // Небольшая пауза — сначала человек видит свою главную.
  const [showInstall, setShowInstall] = useState(false);
  const dashReady = !!dash;
  useEffect(() => {
    if (!dashReady || !shouldAutoShowInstall()) return;
    const timer = setTimeout(() => {
      markInstallPromptShown();
      setShowInstall(true);
    }, 1800);
    return () => clearTimeout(timer);
  }, [dashReady]);

  if (isLoading || !dash) {
    return (
      <div className="space-y-4 px-5 pt-8">
        <div className="h-24 animate-pulse rounded-lg bg-ink-900" />
        <div className="h-48 animate-pulse rounded-lg bg-ink-900" />
        <div className="h-28 animate-pulse rounded-lg bg-ink-900" />
      </div>
    );
  }

  const { game, program } = dash;
  const canTrain = !!program && (!access.isReady || access.canAccess(program));
  const trialProgram = access.trial.active
    ? allPrograms?.find((p) => p.id === access.trial.programId) ?? null
    : null;

  return (
    <div className="px-5 pt-8 pb-6">
      <LevelHeader name={firstName} initial={(firstName[0] ?? "?").toUpperCase()} level={game.level} />

      {subscription && isEndingSoon(subscription) && (
        <Link
          to="/subscription"
          className="card mb-4 flex items-center justify-between border-ember-400/30 bg-gradient-to-br from-ember-400/10 to-transparent py-4"
        >
          <div>
            <p className="font-semibold text-ember-300">
              {t("dashboard.expiringTitle", {
                date: new Date(subscription.currentPeriodEnd).toLocaleDateString(i18n.language, {
                  day: "numeric",
                  month: "long",
                }),
              })}
            </p>
            <p className="mt-0.5 text-sm text-neutral-400">{t("dashboard.expiringDesc")}</p>
          </div>
          <ChevronRight className="text-ember-400" />
        </Link>
      )}

      {!subscription && (
        <Link
          to="/subscription"
          className="card mb-4 flex items-center justify-between border-ember-400/30 bg-gradient-to-br from-ember-400/10 to-transparent py-4"
        >
          <div>
            {trialProgram && access.trial.endsAt ? (
              <>
                <p className="font-semibold text-volt-400">
                  {t("dashboard.trialTitle", {
                    date: access.trial.endsAt.toLocaleDateString(i18n.language, { day: "numeric", month: "long" }),
                  })}
                </p>
                <p className="mt-0.5 text-sm text-neutral-400">
                  {t("dashboard.trialDesc", { program: localizedOf(trialProgram, "title", i18n.language) })}
                </p>
              </>
            ) : (
              <>
                <p className="font-semibold text-ember-300">{t("dashboard.activateSubscription")}</p>
                <p className="mt-0.5 text-sm text-neutral-400">{t("dashboard.subscriptionDesc")}</p>
              </>
            )}
          </div>
          <ChevronRight className="text-ember-400" />
        </Link>
      )}

      {dash.hasAnyWorkouts && program ? (
        <>
          <TodayCard dash={dash} canTrain={canTrain} />
          <WeekCard
            days={game.thisWeekDays}
            count={game.thisWeekCount}
            target={dash.weeklyTarget}
            streak={game.weekStreak}
            programPerWeek={program.workoutsPerWeek || 0}
          />
          <ProgramPathCard dash={dash} />
        </>
      ) : (
        <ChooseProgram recommendedId={program?.id} />
      )}

      <NextAchievementCard
        achievements={achievements ?? []}
        totalWorkouts={dash.totalWorkouts}
        totalVolumeKg={dash.totalVolumeKg}
      />

      <div className="mb-4 grid grid-cols-3 gap-2.5">
        <StatTile
          value={(dash.totalVolumeKg / 1000).toLocaleString(i18n.language, { maximumFractionDigits: 1 })}
          label={t("dashboard.statTons")}
        />
        <StatTile value={(calories?.total ?? 0).toLocaleString(i18n.language)} label={t("dashboard.statKcal")} />
        <StatTile value={String(dash.totalWorkouts)} label={t("dashboard.statWorkouts")} />
      </div>

      <div className="card flex items-start gap-3 border-ink-700 bg-ink-900 py-4">
        <Sparkles size={18} className="mt-0.5 shrink-0 text-volt-400" />
        <div>
          <p className="text-xs uppercase tracking-wide text-neutral-500">{t("dashboard.quoteOfDay")}</p>
          <p className="mt-1 text-sm italic text-neutral-300">{getDailyQuote()}</p>
        </div>
      </div>

      {levelUp && <LevelUpOverlay level={levelUp.level} onClose={levelUp.dismiss} />}
      {showInstall && !levelUp && <InstallPrompt onClose={() => setShowInstall(false)} />}
    </div>
  );
}

/** Оплаченный доступ заканчивается в ближайшие 5 дней (безлимит — не в счёт). */
function isEndingSoon(sub: { plan: string; currentPeriodEnd: string }): boolean {
  if (sub.plan === "lifetime") return false;
  const left = new Date(sub.currentPeriodEnd).getTime() - Date.now();
  return left > 0 && left <= 5 * 24 * 60 * 60 * 1000;
}

// ---------------------------------------------------------------------------
// Уровень / XP
// ---------------------------------------------------------------------------

function LevelHeader({ name, initial, level }: { name: string; initial: string; level: LevelInfo }) {
  const { t, i18n } = useTranslation();
  const [showRules, setShowRules] = useState(false);
  const R = 30;
  const C = 2 * Math.PI * R;

  return (
    <div className="card mb-4 overflow-hidden border-volt-400/20 bg-gradient-to-br from-volt-400/10 via-ink-900 to-ink-900">
      <div className="flex items-center gap-4">
        <div className="relative h-[76px] w-[76px] shrink-0">
          <svg viewBox="0 0 76 76" className="h-full w-full -rotate-90">
            <circle cx="38" cy="38" r={R} fill="none" stroke="currentColor" strokeWidth="6" className="text-ink-700" />
            <circle
              cx="38"
              cy="38"
              r={R}
              fill="none"
              stroke="currentColor"
              strokeWidth="6"
              strokeLinecap="round"
              strokeDasharray={C}
              strokeDashoffset={C * (1 - level.progress)}
              className="text-volt-400 transition-[stroke-dashoffset] duration-1000 ease-out"
            />
          </svg>
          <div className="absolute inset-0 flex items-center justify-center font-display text-2xl font-bold text-volt-300">
            {initial}
          </div>
          <div className="absolute -bottom-1 left-1/2 -translate-x-1/2 rounded-full border-2 border-ink-900 bg-volt-400 px-2 text-xs font-bold text-ink-950">
            {level.level}
          </div>
        </div>

        <div className="min-w-0 flex-1">
          <p className="truncate text-sm text-neutral-400">{t("dashboard.greeting", { name })} 👋</p>
          <p className="font-display text-xl font-bold">
            {t(`dashboard.ranks.${level.rank}`)}{" "}
            <span className="text-sm font-medium text-neutral-500">· {t("dashboard.level", { level: level.level })}</span>
          </p>
          <div className="mt-2 h-2 overflow-hidden rounded-full bg-ink-700">
            <div
              className="h-full rounded-full bg-gradient-to-r from-volt-500 to-volt-300 transition-all duration-1000 ease-out"
              style={{ width: `${Math.max(3, level.progress * 100)}%` }}
            />
          </div>
          <div className="mt-1.5 flex items-center justify-between text-xs text-neutral-400">
            <span>{t("dashboard.xpToNext", { xp: level.xpToNext.toLocaleString(i18n.language), next: level.level + 1 })}</span>
            <button onClick={() => setShowRules((v) => !v)} className="flex items-center gap-1 text-neutral-500 hover:text-neutral-300">
              <Info size={12} /> XP
            </button>
          </div>
        </div>
      </div>

      {showRules && (
        <div className="mt-4 grid grid-cols-2 gap-2 border-t border-ink-700 pt-3 text-xs text-neutral-400 animate-fade-in">
          <span>{t("dashboard.xpRules.workout")}</span>
          <span className="text-right font-semibold text-volt-400">+{XP_RULES.workout}</span>
          <span>{t("dashboard.xpRules.week")}</span>
          <span className="text-right font-semibold text-volt-400">+{XP_RULES.fullWeek}</span>
          <span>{t("dashboard.xpRules.record")}</span>
          <span className="text-right font-semibold text-volt-400">+{XP_RULES.personalRecord}</span>
          <span>{t("dashboard.xpRules.catchUp")}</span>
          <span className="text-right font-semibold text-volt-400">+{XP_RULES.catchUpWorkout}</span>
        </div>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Сегодня
// ---------------------------------------------------------------------------

function TodayCard({ dash, canTrain }: { dash: NonNullable<ReturnType<typeof useDashboard>["data"]>; canTrain: boolean }) {
  const { t, i18n } = useTranslation();
  const w = dash.nextWorkout;
  const lang = i18n.language;

  if (!w) {
    return (
      <div className="card mb-4 border-volt-400/40 bg-gradient-to-br from-volt-400/15 to-ink-900 text-center">
        <Trophy size={40} className="mx-auto text-volt-400" />
        <p className="mt-3 font-display text-xl font-bold">{t("dashboard.programDone")}</p>
        <p className="mt-1 text-sm text-neutral-400">{t("dashboard.programDoneHint")}</p>
        <Link to="/programs" className="btn-primary mt-4 w-full">
          {t("dashboard.allPrograms")}
        </Link>
      </div>
    );
  }

  const title = localizedOf(w, "title", lang);
  const week = w.weekLabel
    ? localizedOf(w, "weekLabel", lang).split(/\s[—–-]\s|·/)[0].trim()
    : null;
  const done = dash.game.trainedToday;

  return (
    <div
      className={clsx(
        "card mb-4 relative overflow-hidden",
        done ? "border-success/30 bg-success/5" : "border-volt-400/50 bg-gradient-to-br from-volt-400/15 via-ink-900 to-ink-900",
      )}
    >
      <p className={clsx("text-xs font-semibold uppercase tracking-wider", done ? "text-success" : "text-volt-400")}>
        {done ? t("dashboard.todayDone") : t("dashboard.today")}
      </p>

      {done && <p className="mt-1 text-sm text-neutral-400">{t("dashboard.todayDoneHint")}</p>}

      <p className={clsx("font-display font-bold leading-tight", done ? "mt-3 text-lg text-neutral-200" : "mt-2 text-2xl")}>
        {title}
      </p>
      <p className="mt-1.5 text-sm text-neutral-400">
        {[
          week,
          dash.nextPositionInBlock && t("dashboard.workoutOf", dash.nextPositionInBlock),
          `${w.estimatedDurationMinutes} ${t("common.min")}`,
        ]
          .filter(Boolean)
          .join(" · ")}
      </p>

      {canTrain ? (
        <Link
          to={`/workout/${w.id}`}
          className={clsx("mt-4 w-full", done ? "btn-secondary" : "btn-primary animate-pulse-glow py-3.5 text-base")}
        >
          <Play size={18} fill="currentColor" /> {t("dashboard.start")}
        </Link>
      ) : (
        <Link to="/subscription" className="btn-primary mt-4 w-full">
          <Lock size={16} /> {t("dashboard.activateSubscription")}
        </Link>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Неделя и серия
// ---------------------------------------------------------------------------

function WeekCard({
  days,
  count,
  target,
  streak,
  programPerWeek,
}: {
  days: boolean[];
  count: number;
  target: number;
  streak: number;
  /** Сколько тренировок в неделю заложено в программе (обычно 4). */
  programPerWeek: number;
}) {
  const { t, i18n } = useTranslation();
  const monday = startOfWeek(new Date());
  const todayIndex = (new Date().getDay() + 6) % 7;
  const labels = days.map((_, i) => {
    const d = new Date(monday);
    d.setDate(d.getDate() + i);
    return d.toLocaleDateString(i18n.language, { weekday: "short" }).replace(".", "").slice(0, 2);
  });
  const planDone = count >= target;

  return (
    <div className="card mb-4">
      <div className="mb-3 flex items-center justify-between">
        <p className="font-semibold">{t("dashboard.thisWeek")}</p>
        <p className={clsx("text-sm font-semibold", planDone ? "text-success" : "text-neutral-400")}>
          {t("dashboard.weekProgress", { done: Math.min(count, 99), target })} {planDone && "✓"}
        </p>
      </div>

      <div className="grid grid-cols-7 gap-1.5">
        {days.map((trained, i) => (
          <div key={i} className="flex flex-col items-center gap-1">
            <div
              className={clsx(
                "flex h-9 w-9 items-center justify-center rounded-full border-2 transition",
                trained
                  ? "border-volt-400 bg-volt-400 text-ink-950"
                  : i === todayIndex
                    ? "border-volt-400/60 border-dashed"
                    : "border-ink-700",
              )}
            >
              {trained && <Check size={16} strokeWidth={3} />}
            </div>
            <span className={clsx("text-[11px] capitalize", i === todayIndex ? "font-semibold text-neutral-200" : "text-neutral-500")}>
              {labels[i]}
            </span>
          </div>
        ))}
      </div>

      <div className="mt-3 flex items-center gap-2 rounded-md bg-ink-800 px-3 py-2 text-sm">
        <Flame size={16} className={streak > 0 ? "text-ember-400" : "text-neutral-600"} />
        {streak > 0 ? (
          <span>
            {t("dashboard.weekStreak")}: <span className="font-bold text-ember-300">{streak}</span>
          </span>
        ) : (
          <span className="text-neutral-400">{t("dashboard.weekStreakStart")}</span>
        )}
      </div>

      {/* Программа рассчитана на N тренировок в неделю, а человек выбрал другое
          число дней — честно говорим, сколько по календарю займёт одна
          "неделя" программы. Тренировки идут по порядку, ничего не теряется. */}
      {programPerWeek > 0 && target !== programPerWeek && (
        <p className="mt-3 flex items-start gap-1.5 text-xs leading-relaxed text-neutral-400">
          <Info size={13} className="mt-0.5 shrink-0" />
          {t(target < programPerWeek ? "dashboard.programWeekSlower" : "dashboard.programWeekFaster", {
            count: Math.round((7 * programPerWeek) / target),
            program: programPerWeek,
            days: target,
          })}
        </p>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Путь по программе
// ---------------------------------------------------------------------------

function ProgramPathCard({ dash }: { dash: NonNullable<ReturnType<typeof useDashboard>["data"]> }) {
  const { t, i18n } = useTranslation();
  const p = dash.program!;
  const pct = dash.programTotal ? Math.round((dash.programDone / dash.programTotal) * 100) : 0;
  const title = localizedOf(p, "title", i18n.language);
  // Отметки на полосе — границы месяцев (каждые ~4 недели)
  const months = Math.max(1, Math.round(p.durationWeeks / 4));

  return (
    <Link to={`/programs/${p.slug}`} className="card mb-4 block hover:border-ink-500">
      <div className="flex items-center justify-between">
        <p className="text-xs uppercase tracking-wide text-neutral-500">{t("dashboard.programPath")}</p>
        <ChevronRight size={18} className="text-neutral-500" />
      </div>
      <p className="mt-1 font-semibold">{title}</p>

      <div className="relative mt-3 h-3 overflow-hidden rounded-full bg-ink-700">
        <div
          className="h-full rounded-full bg-gradient-to-r from-volt-600 to-volt-400 transition-all duration-1000"
          style={{ width: `${Math.max(2, pct)}%` }}
        />
        {Array.from({ length: months - 1 }, (_, i) => (
          <span
            key={i}
            className="absolute top-0 h-full w-px bg-ink-950/60"
            style={{ left: `${((i + 1) / months) * 100}%` }}
          />
        ))}
      </div>
      <div className="mt-2 flex justify-between text-xs text-neutral-400">
        <span>{t("dashboard.programProgress", { done: dash.programDone, total: dash.programTotal })}</span>
        <span className="font-semibold text-volt-400">{pct}%</span>
      </div>
    </Link>
  );
}

// ---------------------------------------------------------------------------
// Ближайшая награда
// ---------------------------------------------------------------------------

function NextAchievementCard({
  achievements,
  totalWorkouts,
  totalVolumeKg,
}: {
  achievements: ReturnType<typeof useAchievements>["data"] & object;
  totalWorkouts: number;
  totalVolumeKg: number;
}) {
  const { t, i18n } = useTranslation();
  const unlocked = achievements.filter((a) => a.unlockedAt).length;

  // Ближайшая = самая близкая к получению (по доле), среди тех, что можно
  // посчитать по истории: число тренировок и суммарный объём.
  const next = useMemo(() => {
    let best: { a: (typeof achievements)[number]; current: number; ratio: number } | null = null;
    for (const a of achievements) {
      if (a.unlockedAt) continue;
      const current = a.category === "workouts" ? totalWorkouts : a.category === "volume" ? totalVolumeKg : null;
      if (current === null || a.threshold <= 0) continue;
      const ratio = Math.min(1, current / a.threshold);
      if (!best || ratio > best.ratio) best = { a, current, ratio };
    }
    return best;
  }, [achievements, totalWorkouts, totalVolumeKg]);

  if (!achievements.length) return null;

  const left = next ? Math.max(0, Math.ceil(next.a.threshold - next.current)) : 0;
  const leftLabel =
    next?.a.category === "volume"
      ? `${left.toLocaleString(i18n.language)} ${t("dashboard.kg")}`
      : left.toLocaleString(i18n.language);

  return (
    <Link to="/achievements" className="card mb-4 block hover:border-ink-500">
      <div className="flex items-center justify-between">
        <p className="text-xs uppercase tracking-wide text-neutral-500">{t("dashboard.nextAchievement")}</p>
        <span className="text-xs text-neutral-500">
          {t("dashboard.achievementsUnlocked", { n: unlocked })} <ChevronRight size={14} className="inline" />
        </span>
      </div>
      {next ? (
        <div className="mt-2 flex items-center gap-3">
          <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-ink-800 text-2xl grayscale-[40%]">
            {next.a.icon}
          </div>
          <div className="min-w-0 flex-1">
            <p className="truncate font-semibold">{t(`achievements.badges.${next.a.slug}.title`, { defaultValue: next.a.title })}</p>
            <div className="mt-1.5 h-2 overflow-hidden rounded-full bg-ink-700">
              <div className="h-full rounded-full bg-ember-400" style={{ width: `${Math.max(3, next.ratio * 100)}%` }} />
            </div>
            <p className="mt-1 text-xs text-neutral-400">{t("dashboard.achievementLeft", { left: leftLabel })}</p>
          </div>
        </div>
      ) : (
        <p className="mt-2 text-sm text-neutral-400">{t("dashboard.allAchievementsDone")}</p>
      )}
    </Link>
  );
}

function StatTile({ value, label }: { value: string; label: string }) {
  return (
    <div className="rounded-lg border border-ink-700 bg-ink-900 px-2 py-3 text-center">
      <p className="font-display text-xl font-bold">{value}</p>
      <p className="mt-0.5 text-[11px] leading-tight text-neutral-500">{label}</p>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Нет ни одной тренировки — выбор программы
// ---------------------------------------------------------------------------

function ChooseProgram({ recommendedId }: { recommendedId?: string }) {
  const { t, i18n } = useTranslation();
  const { data: programs } = usePrograms();
  const sorted = [...(programs ?? [])].sort((a, b) => (a.id === recommendedId ? -1 : b.id === recommendedId ? 1 : 0));

  return (
    <div className="mb-4">
      <h2 className="mb-3 font-display text-lg font-semibold">{t("dashboard.chooseProgram")}</h2>
      <div className="space-y-3">
        {sorted.slice(0, 4).map((program) => (
          <Link
            key={program.id}
            to={`/programs/${program.slug}`}
            className={clsx(
              "card flex items-center justify-between",
              program.id === recommendedId ? "border-volt-400/50 hover:border-volt-400" : "hover:border-ink-500",
            )}
          >
            <div>
              {program.id === recommendedId && (
                <p className="mb-1 text-xs font-semibold uppercase tracking-wide text-volt-400">
                  {t("dashboard.recommendedForYou")}
                </p>
              )}
              <p className="font-semibold">
                {localizedOf(program, "title", i18n.language)}
              </p>
              <p className="mt-1 text-sm text-neutral-400">
                {t("programs.weeks", { count: program.durationWeeks })} ·{" "}
                {t("programs.perWeek", { count: program.workoutsPerWeek })} ·{" "}
                {t(`programs.difficulty.${program.difficulty}`)}
              </p>
            </div>
            <ChevronRight className="shrink-0 text-neutral-500" />
          </Link>
        ))}
      </div>
      <Link to="/programs" className="mt-3 block text-center text-sm font-medium text-volt-400">
        {t("dashboard.allPrograms")}
      </Link>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Новый уровень — празднование
// ---------------------------------------------------------------------------

/**
 * Запоминаем последний показанный уровень в localStorage (на пользователя).
 * При первом заходе — просто запоминаем, без праздника (иначе каждый
 * пользователь получил бы конфетти за уровень, набранный "задним числом").
 */
function useLevelUpCelebration(userId: string | undefined, level: number | undefined) {
  const [celebrate, setCelebrate] = useState<number | null>(null);

  useEffect(() => {
    if (!userId || !level) return;
    const key = `donatellex-level-${userId}`;
    try {
      const stored = Number(localStorage.getItem(key));
      if (stored && level > stored) setCelebrate(level);
      if (!stored || level > stored) localStorage.setItem(key, String(level));
    } catch {
      // localStorage недоступен — просто без праздника
    }
  }, [userId, level]);

  if (celebrate === null) return null;
  return { level: celebrate, dismiss: () => setCelebrate(null) };
}

function LevelUpOverlay({ level, onClose }: { level: number; onClose: () => void }) {
  const { t } = useTranslation();
  const rank = rankForLevel(level);
  const pieces = useMemo(
    () =>
      Array.from({ length: 48 }, (_, i) => ({
        left: Math.random() * 100,
        delay: Math.random() * 0.8,
        duration: 2.2 + Math.random() * 1.6,
        color: ["#A8E000", "#FF6B35", "#D2FF7A", "#FFFFFF", "#FFC24B"][i % 5],
        size: 6 + Math.random() * 6,
        rotate: Math.random() * 360,
      })),
    [],
  );

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-ink-950/85 px-6 backdrop-blur-sm animate-fade-in" onClick={onClose}>
      <style>{`
        @keyframes dx-confetti { 0% { transform: translateY(-10vh) rotate(0deg); opacity: 1 } 100% { transform: translateY(105vh) rotate(720deg); opacity: .9 } }
        @media (prefers-reduced-motion: reduce) { .dx-confetti { display: none } }
      `}</style>
      {pieces.map((p, i) => (
        <span
          key={i}
          className="dx-confetti pointer-events-none absolute top-0 rounded-sm"
          style={{
            left: `${p.left}%`,
            width: p.size,
            height: p.size * 0.5,
            background: p.color,
            transform: `rotate(${p.rotate}deg)`,
            animation: `dx-confetti ${p.duration}s ${p.delay}s ease-in forwards`,
          }}
        />
      ))}
      <div className="relative w-full max-w-sm rounded-xl border border-volt-400/40 bg-ink-900 p-7 text-center shadow-glow" onClick={(e) => e.stopPropagation()}>
        <button onClick={onClose} className="absolute right-3 top-3 rounded-full p-1.5 text-neutral-500 hover:text-neutral-200" aria-label={t("common.close")}>
          <X size={18} />
        </button>
        <div className="mx-auto flex h-20 w-20 items-center justify-center rounded-full bg-volt-400 font-display text-4xl font-bold text-ink-950 animate-pulse-glow">
          {level}
        </div>
        <p className="mt-5 font-display text-2xl font-bold">{t("dashboard.levelUpTitle")}</p>
        <p className="mt-1 text-neutral-300">
          {t("dashboard.level", { level })} — {t(`dashboard.ranks.${rank}`)}
        </p>
        <button onClick={onClose} className="btn-primary mt-6 w-full">
          {t("dashboard.levelUpButton")}
        </button>
      </div>
    </div>
  );
}
