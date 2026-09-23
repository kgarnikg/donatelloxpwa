import { useState, useMemo } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Search, Check, CheckCircle2 } from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type { User, Workout, WorkoutProgram } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

/**
 * Форс-мажорное обновление прогресса клиента — раньше было
 * самообслуживанием прямо в клиентском приложении ("уже занимался
 * раньше" у каждой заблокированной тренировки), убрано оттуда: клиент
 * сам мог "перепрыгнуть" тренировки, не занимаясь — подрывает саму идею
 * последовательного открытия. Здесь то же самое действие, но
 * инициируется только тренером/админом, для реальных исключительных
 * случаев (клиент занимался по программе до появления приложения/этой
 * функции, технический сбой и т.п.).
 */
export default function CatchUpProgressPage() {
  const [userSearch, setUserSearch] = useState("");
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [selectedProgramId, setSelectedProgramId] = useState<string>("");
  const [activeWeekOrder, setActiveWeekOrder] = useState<number | null>(null);
  const queryClient = useQueryClient();

  const { data: users } = useQuery({
    queryKey: ["admin-users-search"],
    queryFn: async (): Promise<User[]> => {
      const { data, error } = await supabase.from("users").select("*").order("created_at", { ascending: false }).limit(200);
      if (error) throw error;
      return toCamelCase<User[]>(data ?? []);
    },
  });

  const filteredUsers = useMemo(() => {
    const q = userSearch.trim().toLowerCase();
    if (!q) return [];
    return (users ?? [])
      .filter((u) => u.email.toLowerCase().includes(q) || u.fullName?.toLowerCase().includes(q))
      .slice(0, 8);
  }, [users, userSearch]);

  const { data: programs } = useQuery({
    queryKey: ["admin-programs-list"],
    queryFn: async (): Promise<WorkoutProgram[]> => {
      const { data, error } = await supabase.from("workout_programs").select("*").order("title", { ascending: true });
      if (error) throw error;
      return toCamelCase<WorkoutProgram[]>(data ?? []);
    },
  });

  const { data: workouts } = useQuery({
    queryKey: ["admin-catchup-workouts", selectedProgramId],
    queryFn: async (): Promise<Workout[]> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*)")
        .eq("program_id", selectedProgramId)
        .order("week_order", { ascending: true })
        .order("order", { ascending: true });
      if (error) throw error;
      return toCamelCase<Workout[]>(data ?? []);
    },
    enabled: !!selectedProgramId,
  });

  const { data: completedIds } = useQuery({
    queryKey: ["admin-catchup-completed", selectedProgramId, selectedUser?.id, workouts?.length],
    queryFn: async (): Promise<Set<string>> => {
      const ids = (workouts ?? []).map((w) => w.id);
      if (ids.length === 0) return new Set();
      const { data, error } = await supabase
        .from("workout_logs")
        .select("workout_id")
        .eq("user_id", selectedUser!.id)
        .in("workout_id", ids);
      if (error) throw error;
      return new Set((data ?? []).map((r) => r.workout_id as string));
    },
    enabled: !!selectedProgramId && !!selectedUser && !!workouts,
  });

  const catchUpMutation = useMutation({
    mutationFn: async (upToWorkout: Workout) => {
      if (!workouts || !selectedUser || !completedIds) return;
      const idx = workouts.findIndex((w) => w.id === upToWorkout.id);
      if (idx === -1) return;
      const toMark = workouts.slice(0, idx + 1).filter((w) => !completedIds.has(w.id));
      if (toMark.length === 0) return;
      const { error } = await supabase.from("workout_logs").insert(
        toMark.map((w) => ({
          user_id: selectedUser.id,
          workout_id: w.id,
          completed_at: new Date().toISOString(),
          duration_minutes: w.estimatedDurationMinutes ?? 0,
          completed_sets: [],
          // Отметка "проставлено тренером" — открывает следующие
          // тренировки, но не считается тренировкой сегодня в калориях
          // клиента (иначе 20 тренировок разом = +11 000 ккал, см. 0066).
          is_catch_up: true,
          calories_burned: 0,
        })),
      );
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-catchup-completed"] }),
  });

  const weekBlocks = useMemo(() => {
    if (!workouts) return [];
    const seen = new Map<number, string>();
    for (const w of workouts) if (!seen.has(w.weekOrder)) seen.set(w.weekOrder, w.weekLabel || `Блок ${w.weekOrder}`);
    return Array.from(seen, ([order, label]) => ({ order, label }));
  }, [workouts]);

  const effectiveWeekOrder = activeWeekOrder ?? weekBlocks[0]?.order ?? 1;
  const visibleWorkouts = (workouts ?? []).filter((w) => w.weekOrder === effectiveWeekOrder);

  return (
    <div>
      <h1 className="font-display text-2xl font-bold">Догнать прогресс клиента</h1>
      <p className="mt-1 max-w-2xl text-neutral-400">
        Только для реальных исключений — клиент занимался по программе до появления приложения/этой функции,
        технический сбой и т.п. Отмечает тренировки выполненными без прохождения через плеер, только сам факт.
      </p>

      {/* Шаг 1 — пользователь */}
      <div className="card mt-6 max-w-lg">
        <label className="mb-1.5 block text-sm font-medium text-neutral-300">Клиент</label>
        {selectedUser ? (
          <div className="flex items-center justify-between rounded-md border border-ink-700 bg-ink-800 px-3.5 py-2.5">
            <span>
              {selectedUser.fullName} <span className="text-neutral-500">· {selectedUser.email}</span>
            </span>
            <button
              onClick={() => {
                setSelectedUser(null);
                setSelectedProgramId("");
              }}
              className="text-sm text-neutral-400 hover:text-neutral-200"
            >
              Сменить
            </button>
          </div>
        ) : (
          <div className="relative">
            <Search size={16} className="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-neutral-500" />
            <input
              value={userSearch}
              onChange={(e) => setUserSearch(e.target.value)}
              placeholder="Имя или email…"
              className="input-field pl-10"
            />
            {filteredUsers.length > 0 && (
              <div className="absolute z-10 mt-1.5 w-full overflow-hidden rounded-md border border-ink-700 bg-ink-900 shadow-lg">
                {filteredUsers.map((u) => (
                  <button
                    key={u.id}
                    onClick={() => {
                      setSelectedUser(u);
                      setUserSearch("");
                    }}
                    className="flex w-full items-center justify-between px-3.5 py-2.5 text-left text-sm hover:bg-ink-800"
                  >
                    <span>{u.fullName}</span>
                    <span className="text-neutral-500">{u.email}</span>
                  </button>
                ))}
              </div>
            )}
          </div>
        )}
      </div>

      {/* Шаг 2 — программа */}
      {selectedUser && (
        <div className="card mt-4 max-w-lg">
          <label className="mb-1.5 block text-sm font-medium text-neutral-300">Программа</label>
          <select
            value={selectedProgramId}
            onChange={(e) => {
              setSelectedProgramId(e.target.value);
              setActiveWeekOrder(null);
            }}
            className="input-field"
          >
            <option value="">— выбрать —</option>
            {(programs ?? []).map((p) => (
              <option key={p.id} value={p.id}>
                {p.title}
              </option>
            ))}
          </select>
        </div>
      )}

      {/* Шаг 3 — тренировки */}
      {selectedUser && selectedProgramId && workouts && (
        <div className="mt-6">
          {weekBlocks.length > 1 && (
            <div className="mb-4 flex gap-2 overflow-x-auto pb-1">
              {weekBlocks.map((wk) => (
                <button
                  key={wk.order}
                  onClick={() => setActiveWeekOrder(wk.order)}
                  className={clsx(
                    "shrink-0 rounded-full border px-3.5 py-1.5 text-sm transition",
                    wk.order === effectiveWeekOrder
                      ? "border-volt-400 bg-volt-400/10 text-volt-400"
                      : "border-ink-700 text-neutral-400 hover:border-ink-500",
                  )}
                >
                  {wk.label}
                </button>
              ))}
            </div>
          )}

          <div className="space-y-3">
            {visibleWorkouts.map((w) => {
              const isDone = completedIds?.has(w.id) ?? false;
              return (
                <div key={w.id} className="card flex items-center justify-between">
                  <p className="font-semibold">{w.title}</p>
                  {isDone ? (
                    <span className="flex items-center gap-1.5 text-sm text-volt-400">
                      <CheckCircle2 size={16} /> Выполнено
                    </span>
                  ) : (
                    <button
                      onClick={() => catchUpMutation.mutate(w)}
                      disabled={catchUpMutation.isPending}
                      className="btn-secondary text-sm disabled:opacity-50"
                    >
                      <Check size={14} /> Отметить (и всё до неё)
                    </button>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
