import { Link } from "react-router-dom";
import { Lock, ChevronRight, Gift } from "lucide-react";
import { usePrograms, useFreeProgramAccess } from "@/lib/queries";

export default function ProgramsPage() {
  const { data: programs, isLoading } = usePrograms();
  const { hasFreeAccess } = useFreeProgramAccess();

  return (
    <div className="px-5 pt-8">
      <h1 className="font-display text-2xl font-bold">Программы тренировок</h1>
      <p className="mt-1 text-neutral-400">Выберите программу под свою цель</p>

      <div className="mt-6 space-y-3">
        {isLoading &&
          Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="card h-28 animate-pulse bg-ink-800" />
          ))}

        {programs?.map((program) => {
          const isLocked = program.isPremium || !hasFreeAccess;
          return (
            <Link
              key={program.id}
              to={isLocked && !program.isPremium ? "/subscription" : `/programs/${program.slug}`}
              className="card flex items-center justify-between hover:border-ink-500"
            >
              <div className="min-w-0">
                <div className="flex items-center gap-2">
                  <p className="truncate font-semibold">{program.title}</p>
                  {isLocked ? (
                    <Lock size={14} className="shrink-0 text-neutral-500" />
                  ) : (
                    !program.isPremium && <Gift size={14} className="shrink-0 text-volt-400" />
                  )}
                </div>
                <p className="mt-1 line-clamp-2 text-sm text-neutral-400">{program.description}</p>
                <p className="mt-2 text-xs font-medium uppercase tracking-wide text-volt-400">
                  {program.durationWeeks} нед · {program.workoutsPerWeek}×/нед · {program.difficulty}
                </p>
              </div>
              <ChevronRight className="ml-3 shrink-0 text-neutral-500" />
            </Link>
          );
        })}
      </div>
    </div>
  );
}
