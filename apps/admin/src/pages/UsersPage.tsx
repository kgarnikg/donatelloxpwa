import { useMemo, useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Search, Gift, ArrowUp, ArrowDown, ArrowUpDown } from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type { User, UserRole, Subscription, SubscriptionPlan } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

const ROLE_BADGE: Record<UserRole, string> = {
  athlete: "bg-info/10 text-info",
  coach: "bg-success/10 text-success",
  admin: "bg-volt-400/10 text-volt-400",
  superadmin: "bg-ember-400/10 text-ember-400",
};

const ROLE_LABEL: Record<UserRole, string> = {
  athlete: "Пользователь",
  coach: "Тренер",
  admin: "Админ",
  superadmin: "Суперадмин",
};

const PLAN_LABEL: Record<SubscriptionPlan, string> = {
  monthly: "Месяц",
  quarterly: "3 месяца",
  semiannual: "6 месяцев",
  annual: "Год",
  lifetime: "Безлимит",
};

/** Порядок планов для сортировки колонки "Подписка" — от отсутствия к самому долгому. */
const PLAN_RANK: Record<SubscriptionPlan, number> = {
  monthly: 1,
  quarterly: 2,
  semiannual: 3,
  annual: 4,
  lifetime: 5,
};

type SortKey = "createdAt" | "subscription";
type SortDir = "asc" | "desc";

export default function UsersPage() {
  const [search, setSearch] = useState("");
  const [sortKey, setSortKey] = useState<SortKey>("createdAt");
  const [sortDir, setSortDir] = useState<SortDir>("desc");
  const queryClient = useQueryClient();

  const { data: users, isLoading } = useQuery({
    queryKey: ["admin-users"],
    queryFn: async (): Promise<User[]> => {
      const { data, error } = await supabase
        .from("users")
        .select("*")
        .order("created_at", { ascending: false })
        .limit(200);
      if (error) throw error;
      return toCamelCase<User[]>(data ?? []);
    },
  });

  /**
   * Активные/пробные/просроченные подписки всех пользователей — одним
   * запросом, вместо N+1. На пользователя обычно одна такая запись; если
   * их несколько, берём самую свежую (created_at desc из запроса).
   */
  const { data: subscriptionByUser } = useQuery({
    queryKey: ["admin-subscriptions"],
    queryFn: async (): Promise<Map<string, Subscription>> => {
      const { data, error } = await supabase
        .from("subscriptions")
        .select("*")
        .in("status", ["active", "trialing", "past_due"])
        .order("created_at", { ascending: false });
      if (error) throw error;
      const rows = toCamelCase<Subscription[]>(data ?? []);
      const map = new Map<string, Subscription>();
      for (const row of rows) {
        if (!map.has(row.userId)) map.set(row.userId, row);
      }
      return map;
    },
  });

  const updateRole = useMutation({
    mutationFn: async ({ userId, role }: { userId: string; role: UserRole }) => {
      const { error } = await supabase.from("users").update({ role }).eq("id", userId);
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-users"] }),
  });

  /**
   * Выдаёт/отзывает безлимитный доступ (подарок близким, награда) через
   * RPC — обычная подписка со статусом active и provider='gift', без
   * ограничения по времени. Работает через тот же механизм проверки
   * доступа, что и настоящие оплаченные подписки, поэтому изменений в
   * пользовательском приложении не требуется. См. 0022.
   */
  const toggleGiftAccess = useMutation({
    mutationFn: async ({ userId, grant }: { userId: string; grant: boolean }) => {
      const { error } = await supabase.rpc(
        grant ? "grant_lifetime_access" : "revoke_lifetime_access",
        { p_user_id: userId },
      );
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-subscriptions"] }),
  });

  function toggleSort(key: SortKey) {
    if (sortKey === key) {
      setSortDir((d) => (d === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortDir("desc");
    }
  }

  const rows = useMemo(() => {
    const q = search.trim().toLowerCase();
    let list = (users ?? []).filter((u) => {
      if (!q) return true;
      // Email и есть логин в этой системе (входа по отдельному username нет) —
      // поиск по нему покрывает то, что имеется в виду под "ввести логин".
      return u.fullName?.toLowerCase().includes(q) || u.email?.toLowerCase().includes(q);
    });

    list = [...list].sort((a, b) => {
      let cmp = 0;
      if (sortKey === "createdAt") {
        cmp = new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
      } else {
        const subA = subscriptionByUser?.get(a.id);
        const subB = subscriptionByUser?.get(b.id);
        const rankA = subA ? PLAN_RANK[subA.plan] : 0;
        const rankB = subB ? PLAN_RANK[subB.plan] : 0;
        cmp = rankA - rankB;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });

    return list;
  }, [users, search, sortKey, sortDir, subscriptionByUser]);

  function SortIcon({ active }: { active: boolean }) {
    if (!active) return <ArrowUpDown size={13} className="text-neutral-600" />;
    return sortDir === "asc" ? <ArrowUp size={13} /> : <ArrowDown size={13} />;
  }

  return (
    <div>
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold">Пользователи</h1>
          <p className="mt-1 text-neutral-400">Управление аккаунтами и ролями</p>
        </div>
        <div className="relative w-full sm:w-72">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-neutral-500" />
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Поиск по имени или email…"
            className="input-field pl-9"
          />
        </div>
      </div>

      <div className="card mt-6 overflow-x-auto p-0">
        <table className="w-full min-w-[820px] border-collapse">
          <thead>
            <tr className="border-b border-ink-700">
              <th className="table-th">Пользователь</th>
              <th className="table-th">Email</th>
              <th className="table-th">Роль</th>
              <th className="table-th">
                <button
                  onClick={() => toggleSort("subscription")}
                  className="inline-flex items-center gap-1 hover:text-neutral-200"
                >
                  Подписка <SortIcon active={sortKey === "subscription"} />
                </button>
              </th>
              <th className="table-th">
                <button
                  onClick={() => toggleSort("createdAt")}
                  className="inline-flex items-center gap-1 hover:text-neutral-200"
                >
                  Регистрация <SortIcon active={sortKey === "createdAt"} />
                </button>
              </th>
              <th className="table-th">Онбординг</th>
            </tr>
          </thead>
          <tbody>
            {isLoading &&
              Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} className="border-b border-ink-800">
                  <td className="table-td" colSpan={6}>
                    <div className="h-4 w-full animate-pulse rounded bg-ink-800" />
                  </td>
                </tr>
              ))}

            {!isLoading && rows.length === 0 && (
              <tr>
                <td className="table-td py-8 text-center text-neutral-500" colSpan={6}>
                  Пользователи не найдены
                </td>
              </tr>
            )}

            {rows.map((u) => {
              const sub = subscriptionByUser?.get(u.id);
              const hasGift = sub?.provider === "gift";
              const isPending =
                toggleGiftAccess.isPending && toggleGiftAccess.variables?.userId === u.id;
              return (
                <tr key={u.id} className="border-b border-ink-800 last:border-0">
                  <td className="table-td font-medium">{u.fullName || "—"}</td>
                  <td className="table-td text-neutral-400">{u.email}</td>
                  <td className="table-td">
                    <select
                      value={u.role}
                      onChange={(e) =>
                        updateRole.mutate({ userId: u.id, role: e.target.value as UserRole })
                      }
                      className={clsx(
                        "badge cursor-pointer border-0",
                        ROLE_BADGE[u.role],
                      )}
                    >
                      {(Object.keys(ROLE_LABEL) as UserRole[]).map((role) => (
                        <option key={role} value={role}>
                          {ROLE_LABEL[role]}
                        </option>
                      ))}
                    </select>
                  </td>
                  <td className="table-td">
                    <div className="flex items-center gap-2">
                      <span
                        className={clsx(
                          "badge",
                          sub ? "bg-success/10 text-success" : "bg-neutral-600/20 text-neutral-400",
                        )}
                      >
                        {sub ? PLAN_LABEL[sub.plan] : "Нет подписки"}
                      </span>
                      <button
                        onClick={() =>
                          toggleGiftAccess.mutate({ userId: u.id, grant: !hasGift })
                        }
                        disabled={isPending}
                        title={
                          hasGift
                            ? "Отозвать безлимитный доступ"
                            : "Выдать безлимитный доступ (подарок / награда)"
                        }
                        className={clsx(
                          "badge inline-flex items-center gap-1.5 border-0 transition disabled:opacity-50",
                          hasGift
                            ? "bg-volt-400/10 text-volt-400 hover:bg-volt-400/20"
                            : "bg-neutral-600/20 text-neutral-400 hover:bg-neutral-600/30",
                        )}
                      >
                        <Gift size={12} />
                        {isPending ? "…" : hasGift ? "Безлимит" : "Подарить"}
                      </button>
                    </div>
                  </td>
                  <td className="table-td text-neutral-400">
                    {new Date(u.createdAt).toLocaleDateString("ru-RU")}
                  </td>
                  <td className="table-td">
                    <span
                      className={clsx(
                        "badge",
                        u.onboardingCompleted ? "bg-success/10 text-success" : "bg-neutral-600/20 text-neutral-400",
                      )}
                    >
                      {u.onboardingCompleted ? "Завершён" : "Не завершён"}
                    </span>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}
