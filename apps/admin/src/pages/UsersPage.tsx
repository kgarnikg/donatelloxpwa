import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Search } from "lucide-react";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import type { User, UserRole } from "@donatellox/types";
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

export default function UsersPage() {
  const [search, setSearch] = useState("");
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

  const updateRole = useMutation({
    mutationFn: async ({ userId, role }: { userId: string; role: UserRole }) => {
      const { error } = await supabase.from("users").update({ role }).eq("id", userId);
      if (error) throw error;
    },
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-users"] }),
  });

  const filtered = (users ?? []).filter((u) => {
    const q = search.trim().toLowerCase();
    if (!q) return true;
    return u.fullName?.toLowerCase().includes(q) || u.email?.toLowerCase().includes(q);
  });

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
        <table className="w-full min-w-[640px] border-collapse">
          <thead>
            <tr className="border-b border-ink-700">
              <th className="table-th">Пользователь</th>
              <th className="table-th">Email</th>
              <th className="table-th">Роль</th>
              <th className="table-th">Регистрация</th>
              <th className="table-th">Онбординг</th>
            </tr>
          </thead>
          <tbody>
            {isLoading &&
              Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} className="border-b border-ink-800">
                  <td className="table-td" colSpan={5}>
                    <div className="h-4 w-full animate-pulse rounded bg-ink-800" />
                  </td>
                </tr>
              ))}

            {!isLoading && filtered.length === 0 && (
              <tr>
                <td className="table-td py-8 text-center text-neutral-500" colSpan={5}>
                  Пользователи не найдены
                </td>
              </tr>
            )}

            {filtered.map((u) => (
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
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
