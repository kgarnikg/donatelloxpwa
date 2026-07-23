import { Link } from "react-router-dom";
import { Lock, ChevronRight } from "lucide-react";
import { usePrograms } from "@/lib/queries";

export default function ProgramsPage() {
  const { data: programs, isLoading } = usePrograms();

  return (
    <div className="px-5 pt-8">
      <h1 className="font-display text-2xl font-bold">Программы тренировок</h1>
      <p className="mt-1 text-neutral-400">Выберите программу под свою цель</p>

      <div className="mt-6 space-y-3">
        {isLoading &&
          Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="card h-28 animate-pulse bg-ink-800" />
          ))}

        {programs?.map((program) => (
          <Link
            key={program.id}
            to={`/programs/${program.slug}`}
            className="card flex items-center justify-between hover:border-ink-500"
          >
            <div className="min-w-0">
              <div className="flex items-center gap-2">
                <p className="truncate font-semibold">{program.title}</p>
                {program.isPremium && <Lock size={14} className="shrink-0 text-neutral-500" />}
              </div>
              <p className="mt-1 line-clamp-2 text-sm text-neutral-400">{program.description}</p>
              <p className="mt-2 text-xs font-medium uppercase tracking-wide text-volt-400">
                {program.goal.replace("_", " ")}
              </p>
            </div>
            <ChevronRight className="ml-3 shrink-0 text-neutral-500" />
          </Link>
        ))}
      </div>
    </div>
  );
}
