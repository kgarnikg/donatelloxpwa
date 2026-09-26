import { Link } from "react-router-dom";
import { ChevronLeft, Dumbbell, Flame, Sparkles, TrendingUp } from "lucide-react";
import { useTranslation } from "react-i18next";
import i18n from "@/i18n";
import clsx from "clsx";
import { useAchievements, usePersonalRecords, useVolumeStats, type VolumePeriod } from "@/lib/queries";
import type { AchievementCategory, AchievementWithStatus } from "@donatellox/types";

const CATEGORY_ORDER: AchievementCategory[] = ["workouts", "streak", "volume", "special"];
const VOLUME_PERIODS: VolumePeriod[] = ["workout", "week", "month", "year", "all"];

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString(i18n.language, { day: "numeric", month: "short", year: "numeric" });
}

function formatKg(kg: number) {
  return kg >= 1000
    ? `${(kg / 1000).toLocaleString(i18n.language, { maximumFractionDigits: 1 })} ${i18n.t("common.ton")}`
    : `${Math.round(kg)} ${i18n.t("common.kg")}`;
}

function BadgeCard({ achievement }: { achievement: AchievementWithStatus }) {
  const { t } = useTranslation();
  const unlocked = achievement.unlockedAt !== null;
  return (
    <div
      className={clsx(
        "card flex flex-col items-center gap-1.5 py-5 text-center transition",
        unlocked ? "border-volt-400/40 bg-volt-400/5" : "opacity-50",
      )}
    >
      <span className={clsx("text-3xl", !unlocked && "grayscale")}>{achievement.icon}</span>
      <p className="text-sm font-semibold leading-tight">{t(`achievements.badges.${achievement.slug}.title`, { defaultValue: achievement.title })}</p>
      <p className="text-xs leading-tight text-neutral-500">{t(`achievements.badges.${achievement.slug}.description`, { defaultValue: achievement.description })}</p>
      {unlocked && (
        <p className="mt-1 text-[11px] font-medium text-volt-400">{formatDate(achievement.unlockedAt!)}</p>
      )}
    </div>
  );
}

export default function AchievementsPage() {
  const { t } = useTranslation();
  const { data: achievements, isLoading } = useAchievements();
  const { data: personalRecords, isLoading: recordsLoading } = usePersonalRecords();
  const { data: volumeStats, isLoading: volumeLoading } = useVolumeStats();

  const CATEGORY_LABEL: Record<AchievementCategory, string> = {
    workouts: t("achievements.categoryWorkouts"),
    streak: t("achievements.categoryStreak"),
    volume: t("achievements.categoryVolume"),
    special: t("achievements.categorySpecial"),
  };

  const VOLUME_PERIOD_LABEL: Record<VolumePeriod, string> = {
    workout: t("achievements.volumeStats.workout"),
    week: t("achievements.volumeStats.week"),
    month: t("achievements.volumeStats.month"),
    year: t("achievements.volumeStats.year"),
    all: t("achievements.volumeStats.all"),
  };

  const unlockedCount = achievements?.filter((a) => a.unlockedAt !== null).length ?? 0;
  const totalCount = achievements?.length ?? 0;

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pb-10 pt-6">
      <Link to="/dashboard" className="mb-4 flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200">
        <ChevronLeft size={18} /> {t("common.back")}
      </Link>

      <div className="mb-6 flex items-center gap-3">
        <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
          <Sparkles size={22} />
        </div>
        <div>
          <h1 className="font-display text-2xl font-bold">{t("achievements.title")}</h1>
          <p className="text-sm text-neutral-400">
            {isLoading ? "…" : t("achievements.unlockedCount", { n: unlockedCount, total: totalCount })}
          </p>
        </div>
      </div>

      {/* Сколько поднято — по периодам */}
      <div className="mb-6">
        <h2 className="mb-3 flex items-center gap-1.5 text-sm font-semibold text-neutral-300">
          <TrendingUp size={14} className="text-volt-400" />
          {t("achievements.volumeStats.title")}
        </h2>
        {volumeLoading ? (
          <div className="card h-24 animate-pulse bg-ink-800" />
        ) : (
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
            {VOLUME_PERIODS.map((period) => (
              <div key={period} className="card py-4 text-center">
                <p className="font-display text-xl font-bold text-volt-400">
                  {formatKg(volumeStats?.[period] ?? 0)}
                </p>
                <p className="mt-0.5 text-xs text-neutral-500">{VOLUME_PERIOD_LABEL[period]}</p>
              </div>
            ))}
          </div>
        )}
      </div>

      {isLoading &&
        Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="card mb-3 h-24 animate-pulse bg-ink-800" />
        ))}

      {!isLoading &&
        CATEGORY_ORDER.map((category) => {
          const items = achievements?.filter((a) => a.category === category) ?? [];
          if (!items.length) return null;
          return (
            <div key={category} className="mb-6">
              <h2 className="mb-3 flex items-center gap-1.5 text-sm font-semibold text-neutral-300">
                {category === "streak" ? <Flame size={14} className="text-ember-400" /> : null}
                {CATEGORY_LABEL[category]}
              </h2>
              <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
                {items.map((a) => (
                  <BadgeCard key={a.id} achievement={a} />
                ))}
              </div>
            </div>
          );
        })}

      <div className="mt-2">
        <h2 className="mb-3 flex items-center gap-1.5 text-sm font-semibold text-neutral-300">
          <Dumbbell size={14} className="text-volt-400" />
          {t("achievements.personalRecords")}
        </h2>

        {recordsLoading && (
          <div className="space-y-2">
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="h-14 animate-pulse rounded-md bg-ink-800" />
            ))}
          </div>
        )}

        {!recordsLoading && !personalRecords?.length && (
          <div className="card py-8 text-center text-sm text-neutral-500">
            {t("achievements.noRecordsYet")}
          </div>
        )}

        {!recordsLoading && !!personalRecords?.length && (
          <ul className="space-y-2">
            {personalRecords.map((pr) => (
              <li key={pr.exerciseId} className="card flex items-center justify-between py-3">
                <div className="min-w-0">
                  <p className="truncate text-sm font-medium">{pr.exerciseTitle}</p>
                  <p className="text-xs text-neutral-500">{formatDate(pr.achievedAt)}</p>
                </div>
                <span className="shrink-0 rounded-full bg-volt-400/10 px-2.5 py-1 text-sm font-bold text-volt-400">
                  {pr.bestWeightKg} {t("common.kg")}
                </span>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}
