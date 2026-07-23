import { Link } from "react-router-dom";
import { Flame, Trophy, ChevronRight } from "lucide-react";
import { useAuth } from "@/context/AuthContext";
import { useActiveSubscription, usePrograms } from "@/lib/queries";

export default function DashboardPage() {
  const { profile } = useAuth();
  const { data: subscription } = useActiveSubscription();
  const { data: programs, isLoading } = usePrograms();

  const firstName = profile?.fullName?.split(" ")[0] ?? "спортсмен";

  return (
    <div className="px-5 pt-8">
      <header className="mb-6">
        <p className="text-neutral-400">Привет, {firstName} 👋</p>
        <h1 className="font-display text-2xl font-bold">Готовы к тренировке?</h1>
      </header>

      {!subscription && (
        <Link
          to="/subscription"
          className="card mb-6 flex items-center justify-between border-volt-400/30 bg-gradient-to-br from-volt-400/10 to-transparent"
        >
          <div>
            <p className="font-semibold text-volt-300">Активируйте подписку</p>
            <p className="mt-1 text-sm text-neutral-400">Доступ ко всем программам и видео</p>
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
            <p className="text-xl font-bold">0</p>
            <p className="text-xs text-neutral-400">дней подряд</p>
          </div>
        </div>
        <div className="card flex items-center gap-3">
          <div className="rounded-md bg-volt-400/15 p-2.5 text-volt-400">
            <Trophy size={20} />
          </div>
          <div>
            <p className="text-xl font-bold">0</p>
            <p className="text-xs text-neutral-400">тренировок</p>
          </div>
        </div>
      </div>

      <div className="mb-4 flex items-center justify-between">
        <h2 className="font-display text-lg font-semibold">Программы для вас</h2>
        <Link to="/programs" className="text-sm font-medium text-volt-400">
          Все программы
        </Link>
      </div>

      <div className="space-y-3">
        {isLoading &&
          Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="card h-24 animate-pulse bg-ink-800" />
          ))}

        {!isLoading && !programs?.length && (
          <p className="card text-center text-neutral-400">
            Программы скоро появятся — загляните позже.
          </p>
        )}

        {programs?.slice(0, 4).map((program) => (
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
