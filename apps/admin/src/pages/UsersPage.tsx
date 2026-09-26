import { useMemo, useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Search, Gift, ArrowUp, ArrowDown, ArrowUpDown, Ban, Trash2, Unlock, X } from "lucide-react";
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

const TRIAL_DAYS = 7;

/** "ES" → "🇪🇸" */
function flagOf(code: string): string {
  return code.replace(/./g, (c) => String.fromCodePoint(127397 + c.charCodeAt(0)));
}

const countryNames = (() => {
  try {
    return new Intl.DisplayNames(["ru"], { type: "region" });
  } catch {
    return null;
  }
})();

type ConfirmAction =
  | { kind: "block"; user: User }
  | { kind: "delete"; user: User };
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

  /** Анкеты: программа бесплатной недели (0080). */
  const { data: trialProgramByUser } = useQuery({
    queryKey: ["admin-trial-programs"],
    queryFn: async (): Promise<Map<string, string>> => {
      const { data, error } = await supabase
        .from("user_profiles")
        .select("user_id, trial_program_id, program:workout_programs(title)")
        .not("trial_program_id", "is", null);
      if (error) throw error;
      const map = new Map<string, string>();
      for (const row of (data ?? []) as unknown as Array<{ user_id: string; program: { title: string } | null }>) {
        if (row.program?.title) map.set(row.user_id, row.program.title);
      }
      return map;
    },
  });

  /** Приглашённые друзья и начисленные награды (+1 месяц, 0082). */
  const { data: referralStats } = useQuery({
    queryKey: ["admin-referrals"],
    queryFn: async (): Promise<Map<string, { invited: number; rewarded: number }>> => {
      const { data, error } = await supabase.from("referrals").select("referrer_id, reward_applied");
      if (error) throw error;
      const map = new Map<string, { invited: number; rewarded: number }>();
      for (const row of (data ?? []) as Array<{ referrer_id: string; reward_applied: boolean }>) {
        const cur = map.get(row.referrer_id) ?? { invited: 0, rewarded: 0 };
        cur.invited += 1;
        if (row.reward_applied) cur.rewarded += 1;
        map.set(row.referrer_id, cur);
      }
      return map;
    },
  });

  const [confirm, setConfirm] = useState<ConfirmAction | null>(null);
  const [confirmText, setConfirmText] = useState("");
  const [actionError, setActionError] = useState<string | null>(null);

  function openConfirm(action: ConfirmAction) {
    setConfirm(action);
    setConfirmText("");
    setActionError(null);
  }

  /** Блокировка / разблокировка (0083): вход закрыт, сессии сброшены, доступа к тренировкам нет. */
  const setBlocked = useMutation({
    mutationFn: async ({ userId, blocked, reason }: { userId: string; blocked: boolean; reason?: string }) => {
      const { error } = await supabase.rpc("admin_set_user_blocked", {
        p_user_id: userId,
        p_blocked: blocked,
        p_reason: reason ?? null,
      });
      if (error) throw error;
    },
    onSuccess: () => {
      setConfirm(null);
      queryClient.invalidateQueries({ queryKey: ["admin-users"] });
    },
    onError: (e: Error) => setActionError(e.message),
  });

  /** Полное удаление (0083): аккаунт и все данные человека; платежи остаются без привязки. */
  const deleteUser = useMutation({
    mutationFn: async (userId: string) => {
      const { error } = await supabase.rpc("admin_delete_user", { p_user_id: userId });
      if (error) throw error;
    },
    onSuccess: () => {
      setConfirm(null);
      queryClient.invalidateQueries({ queryKey: ["admin-users"] });
      queryClient.invalidateQueries({ queryKey: ["admin-subscriptions"] });
      queryClient.invalidateQueries({ queryKey: ["admin-referrals"] });
    },
    onError: (e: Error) => setActionError(e.message),
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
      const digits = q.replace(/\D/g, "");
      return (
        u.fullName?.toLowerCase().includes(q) ||
        u.email?.toLowerCase().includes(q) ||
        (digits.length >= 3 && !!u.phone?.replace(/\D/g, "").includes(digits))
      );
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
            placeholder="Поиск по имени, email или телефону…"
            className="input-field pl-9"
          />
        </div>
      </div>

      <div className="card mt-6 overflow-x-auto p-0">
        <table className="w-full min-w-[1280px] border-collapse">
          <thead>
            <tr className="border-b border-ink-700">
              <th className="table-th">Пользователь</th>
              <th className="table-th">Email</th>
              <th className="table-th">Страна</th>
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
              <th className="table-th">Пробная неделя</th>
              <th className="table-th">Друзья</th>
              <th className="table-th">Онбординг</th>
              <th className="table-th">Действия</th>
            </tr>
          </thead>
          <tbody>
            {isLoading &&
              Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} className="border-b border-ink-800">
                  <td className="table-td" colSpan={10}>
                    <div className="h-4 w-full animate-pulse rounded bg-ink-800" />
                  </td>
                </tr>
              ))}

            {!isLoading && rows.length === 0 && (
              <tr>
                <td className="table-td py-8 text-center text-neutral-500" colSpan={10}>
                  Пользователи не найдены
                </td>
              </tr>
            )}

            {rows.map((u) => {
              const sub = subscriptionByUser?.get(u.id);
              const hasGift = sub?.provider === "gift";
              const isPending =
                toggleGiftAccess.isPending && toggleGiftAccess.variables?.userId === u.id;
              const createdMs = new Date(u.createdAt).getTime();
              const trialEnds = new Date(createdMs + TRIAL_DAYS * 24 * 60 * 60 * 1000);
              const trialActive = !sub && Date.now() < trialEnds.getTime();
              const trialProgram = trialProgramByUser?.get(u.id);
              const refs = referralStats?.get(u.id);
              return (
                <tr
                  key={u.id}
                  className={clsx("border-b border-ink-800 last:border-0", u.isBlocked && "bg-danger/5")}
                >
                  <td className="table-td font-medium">
                    <div className="flex items-center gap-2">
                      {u.fullName || "—"}
                      {u.isBlocked && (
                        <span className="badge bg-danger/10 text-danger" title={u.blockedReason ?? undefined}>
                          Заблокирован
                        </span>
                      )}
                    </div>
                  </td>
                  <td className="table-td text-neutral-400">
                    {u.email}
                    {u.phone && (
                      <a href={`tel:${u.phone}`} className="block text-xs text-neutral-500 hover:text-volt-400">
                        {u.phone}
                      </a>
                    )}
                  </td>
                  <td className="table-td whitespace-nowrap text-neutral-300">
                    {u.country ? (
                      <span title={countryNames?.of(u.country) ?? u.country}>
                        {flagOf(u.country)} {countryNames?.of(u.country) ?? u.country}
                      </span>
                    ) : (
                      <span className="text-neutral-600">—</span>
                    )}
                  </td>
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
                    {sub ? (
                      <span className="text-neutral-600">—</span>
                    ) : trialActive ? (
                      <div>
                        <span className="badge bg-volt-400/10 text-volt-400">
                          до {trialEnds.toLocaleDateString("ru-RU")}
                        </span>
                        <p className="mt-1 max-w-[180px] truncate text-xs text-neutral-500" title={trialProgram}>
                          {trialProgram ?? "программа ещё не выбрана"}
                        </p>
                      </div>
                    ) : (
                      <span className="badge bg-neutral-600/20 text-neutral-400">Закончилась</span>
                    )}
                  </td>
                  <td className="table-td whitespace-nowrap text-neutral-300">
                    {refs ? (
                      <span title="Пригласил / из них получено наград (+1 месяц)">
                        {refs.invited} · <span className="text-volt-400">+{refs.rewarded} мес.</span>
                      </span>
                    ) : (
                      <span className="text-neutral-600">—</span>
                    )}
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
                  <td className="table-td">
                    <div className="flex items-center gap-1.5">
                      {u.isBlocked ? (
                        <button
                          onClick={() => setBlocked.mutate({ userId: u.id, blocked: false })}
                          disabled={setBlocked.isPending}
                          className="badge inline-flex items-center gap-1 border-0 bg-success/10 text-success hover:bg-success/20"
                          title="Вернуть доступ"
                        >
                          <Unlock size={12} /> Разблокировать
                        </button>
                      ) : (
                        <button
                          onClick={() => openConfirm({ kind: "block", user: u })}
                          className="badge inline-flex items-center gap-1 border-0 bg-ember-400/10 text-ember-400 hover:bg-ember-400/20"
                          title="Закрыть вход и доступ к тренировкам"
                        >
                          <Ban size={12} /> Блок
                        </button>
                      )}
                      <button
                        onClick={() => openConfirm({ kind: "delete", user: u })}
                        className="badge inline-flex items-center gap-1 border-0 bg-danger/10 text-danger hover:bg-danger/20"
                        title="Удалить пользователя и все его данные"
                      >
                        <Trash2 size={12} /> Удалить
                      </button>
                    </div>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>

      {confirm && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 p-4"
          onClick={() => setConfirm(null)}
        >
          <div
            className="w-full max-w-md rounded-xl border border-ink-700 bg-ink-900 p-6"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-start justify-between gap-3">
              <h2 className="font-display text-lg font-bold">
                {confirm.kind === "delete" ? "Удалить пользователя?" : "Заблокировать пользователя?"}
              </h2>
              <button onClick={() => setConfirm(null)} className="text-neutral-500 hover:text-neutral-200">
                <X size={18} />
              </button>
            </div>
            <p className="mt-1 text-sm text-neutral-300">
              {confirm.user.fullName || "—"} · {confirm.user.email}
            </p>

            {confirm.kind === "delete" ? (
              <>
                <p className="mt-4 text-sm text-neutral-400">
                  Будут удалены навсегда: аккаунт, анкета, все тренировки, прогресс, замеры, достижения,
                  подписки и приглашения. Платежи останутся в отчётах, но без привязки к человеку.
                  Отменить нельзя.
                </p>
                <label className="mt-4 block text-sm text-neutral-300">
                  Для подтверждения введи email пользователя:
                </label>
                <input
                  className="input-field mt-1.5"
                  value={confirmText}
                  onChange={(e) => setConfirmText(e.target.value)}
                  placeholder={confirm.user.email}
                  autoFocus
                />
              </>
            ) : (
              <>
                <p className="mt-4 text-sm text-neutral-400">
                  Человек сразу выйдет из приложения, не сможет войти снова и не увидит тренировки. Данные
                  сохраняются — разблокировать можно в любой момент.
                </p>
                <label className="mt-4 block text-sm text-neutral-300">Причина (видна только в админке):</label>
                <input
                  className="input-field mt-1.5"
                  value={confirmText}
                  onChange={(e) => setConfirmText(e.target.value)}
                  placeholder="Например: возврат платежа, спам…"
                  autoFocus
                />
              </>
            )}

            {actionError && (
              <div className="mt-3 rounded-md border border-danger/30 bg-danger/10 px-3 py-2 text-sm text-danger">
                {actionError}
              </div>
            )}

            <div className="mt-5 flex gap-3">
              <button onClick={() => setConfirm(null)} className="btn-secondary flex-1">
                Отмена
              </button>
              {confirm.kind === "delete" ? (
                <button
                  onClick={() => deleteUser.mutate(confirm.user.id)}
                  disabled={
                    deleteUser.isPending ||
                    confirmText.trim().toLowerCase() !== (confirm.user.email ?? "").toLowerCase()
                  }
                  className="flex-1 rounded-md bg-danger px-4 py-2.5 font-semibold text-neutral-0 transition hover:bg-danger/90 disabled:opacity-40"
                >
                  {deleteUser.isPending ? "Удаляем…" : "Удалить навсегда"}
                </button>
              ) : (
                <button
                  onClick={() =>
                    setBlocked.mutate({ userId: confirm.user.id, blocked: true, reason: confirmText })
                  }
                  disabled={setBlocked.isPending}
                  className="flex-1 rounded-md bg-ember-400 px-4 py-2.5 font-semibold text-ink-950 transition hover:brightness-110 disabled:opacity-40"
                >
                  {setBlocked.isPending ? "Блокируем…" : "Заблокировать"}
                </button>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
