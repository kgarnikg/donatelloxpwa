import { Link } from "react-router-dom";
import { Flame, Trophy, ChevronRight, Sparkles, Star, Award } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/context/AuthContext";
import {
  useActiveSubscription,
  usePrograms,
  useWorkoutStats,
  useRecommendedProgram,
  useAchievements,
} from "@/lib/queries";
import { getDailyQuote } from "@/lib/quotes";

export default function DashboardPage() {
  const { t } = useTranslation();
  const { profile, authUser } = useAuth();
  const { data: subscription } = useActiveSubscription();
  const { data: programs, isLoading } = usePrograms();
  const { data: stats } = useWorkoutStats();
  const { data: recommended } = useRecommendedProgram();
  const { data: achievements } = useAchievements();

  const unlockedAchievements = achievements?.filter((a) => a.unlockedAt !== null) ?? [];
  const latestAchievement = [...unlockedAchievements].sort(
    (a, b) => new Date(b.unlockedAt!).getTime() - new Date(a.unlockedAt!).getTime(),
  )[0];

  const firstName =
    profile?.fullName?.trim().split(" ")[0] || authUser?.email?.split("@")[0] || "there";
  const otherPrograms = programs?.filter((p) => p.id !== recommended?.id) ?? [];

  return (
    <div className="px-5 pt-8">
      <header className="mb-6">
        <p className="text-neutral-400">{t("dashboard.greeting", { name: firstName })} 👋</p>
        <h1 className="font-display text-2xl font-bold">{t("dashboard.readyQuestion")}</h1>
      </header>

      <div className="card mb-6 flex items-start gap-3 border-ink-700 bg-ink-900">
        <Sparkles size={18} className="mt-0.5 shrink-0 text-volt-400" />
        <p className="text-sm italic text-neutral-300">{getDailyQuote()}</p>
      </div>

      {!subscription && (
        <Link
          to="/subscription"
          className="card mb-6 flex items-center justify-between border-volt-400/30 bg-gradient-to-br from-volt-400/10 to-transparent"
        >
          <div>
            <p className="font-semibold text-volt-300">{t("dashboard.activateSubscription")}</p>
            <p className="mt-1 text-sm text-neutral-400">{t("dashboard.subscriptionDesc")}</p>
          </div>
          <ChevronRight className="text-volt-400" />
        </Link>
      )}

      <div className="mb-6 grid grid-cols-2 gap-3">
        <div className="card flex items-center gap-3">
          <div className="rounded-md bg-ember-400/15 p-2.5 text-ember-400">
            <Flame size={20} />
          </div>
          <div>
            <p className="text-xl font-bold">{stats?.currentStreakDays ?? 0}</p>
            <p className="text-xs text-neutral-400">{t("dashboard.streakDays")}</p>
          </div>
        </div>
        <div className="card flex items-center gap-3">
          <div className="rounded-md bg-volt-400/15 p-2.5 text-volt-400">
            <Trophy size={20} />
          </div>
          <div>
            <p className="text-xl font-bold">{stats?.totalWorkouts ?? 0}</p>
            <p className="text-xs text-neutral-400">{t("dashboard.totalWorkouts")}</p>
          </div>
        </div>
      </div>

      <Link
        to="/achievements"
        className="card mb-6 flex items-center justify-between border-ink-700 hover:border-ink-500"
      >
        <div className="flex items-center gap-3">
          <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-volt-400/10 text-lg">
            {latestAchievement ? latestAchievement.icon : <Award size={20} className="text-volt-400" />}
          </div>
          <div>
            <p className="font-semibold">{t("dashboard.achievements")}</p>
            <p className="text-sm text-neutral-400">
              {unlockedAchievements.length > 0
                ? t("dashboard.achievementsUnlocked", { n: unlockedAchievements.length })
                : t("dashboard.achievementsEmpty")}
            </p>
          </div>
        </div>
        <ChevronRight className="shrink-0 text-neutral-500" />
      </Link>

      {recommended && (
        <div className="mb-6">
          <div className="mb-3 flex items-center gap-1.5">
            <Star size={16} className="text-volt-400" fill="currentColor" />
            <h2 className="font-display text-lg font-semibold">{t("dashboard.recommendedForYou")}</h2>
          </div>
          <Link
            to={`/programs/${recommended.slug}`}
            className="card flex items-center justify-between border-volt-400/40 hover:border-volt-400"
          >
            <div>
              <p className="font-semibold">{recommended.title}</p>
              <p className="mt-1 text-sm text-neutral-400">
                {recommended.durationWeeks} нед · {recommended.workoutsPerWeek}×/нед · {recommended.difficulty}
              </p>
            </div>
            <ChevronRight className="shrink-0 text-neutral-500" />
          </Link>
        </div>
      )}

      <div className="mb-4 flex items-center justify-between">
        <h2 className="font-display text-lg font-semibold">{t("dashboard.programsForYou")}</h2>
        <Link to="/programs" className="text-sm font-medium text-volt-400">
          {t("dashboard.allPrograms")}
        </Link>
      </div>

      <div className="space-y-3">
        {isLoading &&
          Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="card h-24 animate-pulse bg-ink-800" />
          ))}

        {!isLoading && !programs?.length && (
          <p className="card text-center text-neutral-400">
            {t("dashboard.noPrograms")}
          </p>
        )}

        {otherPrograms.slice(0, 3).map((program) => (
          <Link
            key={program.id}
            to={`/programs/${program.slug}`}
            className="card flex items-center justify-between hover:border-ink-500"
          >
            <div>
              <p className="font-semibold">{program.title}</p>
              <p className="mt-1 text-sm text-neutral-400">
                {program.durationWeeks} нед · {program.workoutsPerWeek}×/нед · {program.difficulty}
              </p>
            </div>
            <ChevronRight className="shrink-0 text-neutral-500" />
          </Link>
        ))}
      </div>
    </div>
  );
}
