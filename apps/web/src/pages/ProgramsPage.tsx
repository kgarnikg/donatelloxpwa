import { useMemo, useState, type ReactNode } from "react";
import { Link } from "react-router-dom";
import { Lock, ChevronRight, Play, Sparkles, Dumbbell } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import type { WorkoutProgram } from "@donatellox/types";
import {
  usePrograms,
  useFreeProgramAccess,
  useActiveSubscription,
  useRecommendedProgram,
  useUserProfile,
} from "@/lib/queries";
import { useDashboard } from "@/lib/dashboard";
import { goalTone, splitDescription, useProgramsProgress, type ProgramProgress } from "@/lib/programMeta";
import { localizedField } from "@/lib/localizedField";

/**
 * Каталог программ (Фаза 26).
 * Модель доступа: одна оплата открывает ВСЕ программы; активна одна —
 * та, по которой человек тренировался последним. Прогресс по каждой
 * программе хранится отдельно.
 *
 * Сверху — "Моя программа" с прогрессом и "Продолжить", ниже — каталог
 * с фильтрами цель / где / для кого (пол по умолчанию — из анкеты).
 */

type GoalFilter = "all" | "build_muscle" | "lose_weight";
type PlaceFilter = "all" | "gym" | "home";
type GenderFilter = "all" | "male" | "female";

export default function ProgramsPage() {
  const { t } = useTranslation();
  const { data: programs, isLoading } = usePrograms();
  const { data: userProfile } = useUserProfile();
  const { data: recommended } = useRecommendedProgram();
  const { data: dash } = useDashboard();
  const { data: progress } = useProgramsProgress();
  const { hasFreeAccess } = useFreeProgramAccess();
  const { data: activeSubscription } = useActiveSubscription();

  const [goal, setGoal] = useState<GoalFilter>("all");
  const [place, setPlace] = useState<PlaceFilter>("all");
  const [genderChoice, setGenderChoice] = useState<GenderFilter | null>(null);
  const profileGender: GenderFilter =
    userProfile?.gender === "male" || userProfile?.gender === "female" ? userProfile.gender : "all";
  const gender = genderChoice ?? profileGender;

  const activeProgram = dash?.isActiveProgram ? dash.program : null;

  const filtered = useMemo(
    () =>
      (programs ?? [])
        .filter((p) => p.id !== activeProgram?.id)
        .filter((p) => goal === "all" || p.goal === goal)
        .filter((p) => place === "all" || p.trainingFormat === place || p.trainingFormat === "any")
        .filter((p) => gender === "all" || p.gender === gender || p.gender === "unspecified")
        // Подходящая — первой
        .sort((a, b) => (a.id === recommended?.id ? -1 : b.id === recommended?.id ? 1 : 0)),
    [programs, activeProgram?.id, goal, place, gender, recommended?.id],
  );

  const isLockedFor = (p: WorkoutProgram) => p.isPremium && !hasFreeAccess && !activeSubscription;

  return (
    <div className="px-5 pt-8 pb-6">
      <h1 className="font-display text-2xl font-bold">{t("programs.pageTitle")}</h1>

      {activeProgram && dash && (
        <MyProgramCard
          program={activeProgram}
          done={dash.programDone}
          total={dash.programTotal}
          nextWorkoutId={dash.nextWorkout?.id ?? null}
          locked={isLockedFor(activeProgram)}
        />
      )}

      <h2 className="mt-7 font-display text-lg font-semibold">
        {activeProgram ? t("programs.otherPrograms") : t("programs.pageSubtitle")}
      </h2>
      <p className="mt-0.5 text-sm text-neutral-500">{t("programs.accessNote")}</p>

      <div className="mt-4 space-y-2">
        <FilterRow
          value={goal}
          onChange={setGoal}
          options={[
            ["all", t("programs.filters.all")],
            ["build_muscle", t("programs.goalShort.build_muscle")],
            ["lose_weight", t("programs.goalShort.lose_weight")],
          ]}
        />
        <FilterRow
          value={place}
          onChange={setPlace}
          options={[
            ["all", t("programs.filters.anywhere")],
            ["gym", t("programs.placeShort.gym")],
            ["home", t("programs.placeShort.home")],
          ]}
        />
        <FilterRow
          value={gender}
          onChange={(v) => setGenderChoice(v)}
          options={[
            ["male", t("programs.genderShort.male")],
            ["female", t("programs.genderShort.female")],
            ["all", t("programs.filters.everyone")],
          ]}
        />
      </div>

      <div className="mt-4 space-y-3">
        {isLoading &&
          Array.from({ length: 4 }).map((_, i) => <div key={i} className="card h-36 animate-pulse bg-ink-800" />)}

        {!isLoading && filtered.length === 0 && (
          <p className="card py-8 text-center text-sm text-neutral-400">{t("programs.noMatch")}</p>
        )}

        {filtered.map((program) => (
          <ProgramCard
            key={program.id}
            program={program}
            progress={progress?.[program.id]}
            fitsYou={program.id === recommended?.id}
            locked={isLockedFor(program)}
          />
        ))}
      </div>
    </div>
  );
}

function Chip({ children }: { children: ReactNode }) {
  return <span className="rounded-full bg-ink-800 px-2.5 py-1 font-medium text-neutral-300">{children}</span>;
}

function FilterRow<T extends string>({
  value,
  onChange,
  options,
}: {
  value: T;
  onChange: (v: T) => void;
  options: [T, string][];
}) {
  return (
    <div className="flex gap-1 rounded-full bg-ink-900 p-1">
      {options.map(([v, label]) => (
        <button
          key={v}
          onClick={() => onChange(v)}
          className={clsx(
            "flex-1 rounded-full px-2 py-1.5 text-sm font-medium transition",
            value === v ? "bg-ink-700 text-neutral-0" : "text-neutral-500 hover:text-neutral-300",
          )}
        >
          {label}
        </button>
      ))}
    </div>
  );
}

function useTitleParts() {
  const { t, i18n } = useTranslation();
  return (p: WorkoutProgram) => ({
    main: t(`programs.goalShort.${p.goal}`, {
      defaultValue: localizedField(p.title, { en: p.titleEn, es: p.titleEs, hy: p.titleHy }, i18n.language),
    }),
    sub: [
      p.gender !== "unspecified" ? t(`programs.genderShort.${p.gender}`) : null,
      p.trainingFormat !== "any" ? t(`programs.placeShort.${p.trainingFormat}`) : null,
    ]
      .filter(Boolean)
      .join(" · "),
  });
}

function MyProgramCard({
  program,
  done,
  total,
  nextWorkoutId,
  locked,
}: {
  program: WorkoutProgram;
  done: number;
  total: number;
  nextWorkoutId: string | null;
  locked: boolean;
}) {
  const { t } = useTranslation();
  const titleParts = useTitleParts();
  const tone = goalTone(program.goal);
  const pct = total ? Math.round((done / total) * 100) : 0;
  const { main, sub } = titleParts(program);
  return (
    <div
      className={clsx(
        "card mt-5 bg-gradient-to-br to-ink-900",
        tone === "ember" ? "border-ember-400/40 from-ember-400/15" : "border-volt-400/40 from-volt-400/15",
      )}
    >
      <p className={clsx("text-xs font-semibold uppercase tracking-wider", tone === "ember" ? "text-ember-300" : "text-volt-400")}>
        {t("programs.myProgram")}
      </p>
      <Link to={`/programs/${program.slug}`} className="mt-1 flex items-center justify-between">
        <div>
          <p className="font-display text-2xl font-bold">{main}</p>
          <p className="text-sm text-neutral-400">{sub}</p>
        </div>
        <ChevronRight className="shrink-0 text-neutral-500" />
      </Link>
      <div className="mt-4 h-2.5 overflow-hidden rounded-full bg-ink-700">
        <div
          className={clsx("h-full rounded-full", tone === "ember" ? "bg-ember-400" : "bg-volt-400")}
          style={{ width: `${Math.max(2, pct)}%` }}
        />
      </div>
      <div className="mt-1.5 flex justify-between text-xs text-neutral-400">
        <span>{t("dashboard.programProgress", { done, total })}</span>
        <span className="font-semibold">{pct}%</span>
      </div>
      {locked ? (
        <Link to="/subscription" className="btn-primary mt-4 w-full">
          <Lock size={16} /> {t("dashboard.activateSubscription")}
        </Link>
      ) : nextWorkoutId ? (
        <Link to={`/workout/${nextWorkoutId}`} className="btn-primary mt-4 w-full">
          <Play size={16} fill="currentColor" /> {t("programs.continue")}
        </Link>
      ) : null}
    </div>
  );
}

function ProgramCard({
  program,
  progress,
  fitsYou,
  locked,
}: {
  program: WorkoutProgram;
  progress?: ProgramProgress;
  fitsYou: boolean;
  locked: boolean;
}) {
  const { t, i18n } = useTranslation();
  const titleParts = useTitleParts();
  const tone = goalTone(program.goal);
  const { main, sub } = titleParts(program);
  const { equipment } = splitDescription(
    localizedField(program.description, { en: program.descriptionEn, es: program.descriptionEs, hy: program.descriptionHy }, i18n.language),
  );
  const started = !!progress && progress.done > 0;
  const pct = progress?.total ? Math.round((progress.done / progress.total) * 100) : 0;

  return (
    <Link
      to={`/programs/${program.slug}`}
      className={clsx(
        "card relative block overflow-hidden border-l-4 hover:border-ink-500",
        tone === "ember" ? "border-l-ember-400" : "border-l-volt-400",
        fitsYou && (tone === "ember" ? "border-ember-400/40" : "border-volt-400/40"),
      )}
    >
      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          {fitsYou && (
            <p className={clsx("mb-1 flex items-center gap-1 text-xs font-semibold uppercase tracking-wide", tone === "ember" ? "text-ember-300" : "text-volt-400")}>
              <Sparkles size={12} /> {t("programs.fitsYou")}
            </p>
          )}
          <p className="font-display text-xl font-bold leading-tight">{main}</p>
          <p className="text-sm text-neutral-400">{sub}</p>
        </div>
        {locked ? (
          <span className="flex shrink-0 items-center gap-1 rounded-full bg-ink-800 px-2.5 py-1 text-xs text-neutral-400">
            <Lock size={12} /> {t("programs.needsAccess")}
          </span>
        ) : (
          <ChevronRight className="mt-1 shrink-0 text-neutral-500" />
        )}
      </div>

      <div className="mt-3 flex flex-wrap gap-1.5 text-xs">
        <Chip>{t("programs.weeks", { count: program.durationWeeks })}</Chip>
        <Chip>{t("programs.perWeek", { count: program.workoutsPerWeek })}</Chip>
        <Chip>{t(`programs.difficulty.${program.difficulty}`)}</Chip>
      </div>

      {equipment.length > 0 && (
        <p className="mt-2.5 flex items-start gap-1.5 text-xs text-neutral-500">
          <Dumbbell size={13} className="mt-0.5 shrink-0" />
          <span className="line-clamp-1">
            {equipment.slice(0, 3).join(" · ")}
            {equipment.length > 3 ? ` +${equipment.length - 3}` : ""}
          </span>
        </p>
      )}

      {started && (
        <div className="mt-3">
          <div className="h-1.5 overflow-hidden rounded-full bg-ink-700">
            <div
              className={clsx("h-full rounded-full", tone === "ember" ? "bg-ember-400" : "bg-volt-400")}
              style={{ width: `${Math.max(2, pct)}%` }}
            />
          </div>
          <p className="mt-1 text-xs text-neutral-500">
            {t("dashboard.programProgress", { done: progress!.done, total: progress!.total })} · {pct}%
          </p>
        </div>
      )}
    </Link>
  );
}
