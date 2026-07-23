import { useQuery } from "@tanstack/react-query";
import { AreaChart, Area, ResponsiveContainer, Tooltip, XAxis, YAxis, CartesianGrid } from "recharts";
import { Users, CreditCard, Dumbbell, TrendingUp } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface OverviewStats {
  totalUsers: number;
  activeSubscriptions: number;
  totalPrograms: number;
  revenueLast30Days: number;
  signupsByDay: { date: string; count: number }[];
}

async function fetchOverviewStats(): Promise<OverviewStats> {
  const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString();

  const [usersRes, subsRes, programsRes, paymentsRes] = await Promise.all([
    supabase.from("users").select("id, created_at", { count: "exact" }),
    supabase.from("subscriptions").select("id", { count: "exact" }).eq("status", "active"),
    supabase.from("workout_programs").select("id", { count: "exact" }),
    supabase
      .from("payments")
      .select("amount, created_at")
      .eq("status", "confirmed")
      .gte("created_at", thirtyDaysAgo),
  ]);

  const revenueLast30Days = (paymentsRes.data ?? []).reduce(
    (sum, p) => sum + (Number((p as { amount: number }).amount) || 0),
    0,
  );

  const signupsByDayMap = new Map<string, number>();
  for (const u of usersRes.data ?? []) {
    const day = ((u as { created_at: string }).created_at ?? "").slice(0, 10);
    if (!day) continue;
    signupsByDayMap.set(day, (signupsByDayMap.get(day) ?? 0) + 1);
  }
  const signupsByDay = Array.from(signupsByDayMap.entries())
    .sort(([a], [b]) => a.localeCompare(b))
    .slice(-30)
    .map(([date, count]) => ({ date: date.slice(5), count }));

  return {
    totalUsers: usersRes.count ?? 0,
    activeSubscriptions: subsRes.count ?? 0,
    totalPrograms: programsRes.count ?? 0,
    revenueLast30Days,
    signupsByDay,
  };
}

function StatCard({
  icon: Icon,
  label,
  value,
}: {
  icon: typeof Users;
  label: string;
  value: string;
}) {
  return (
    <div className="card flex items-center gap-4">
      <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-volt-400/10 text-volt-400">
        <Icon size={20} />
      </div>
      <div className="min-w-0">
        <p className="text-sm text-neutral-400">{label}</p>
        <p className="truncate font-display text-xl font-bold">{value}</p>
      </div>
    </div>
  );
}

export default function OverviewPage() {
  const { data, isLoading, error } = useQuery({
    queryKey: ["admin-overview"],
    queryFn: fetchOverviewStats,
  });

  return (
    <div>
      <h1 className="font-display text-2xl font-bold">Обзор</h1>
      <p className="mt-1 text-neutral-400">Ключевые показатели платформы DonatelloX</p>

      {error && (
        <div className="mt-6 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
          Не удалось загрузить данные. Проверьте подключение к Supabase.
        </div>
      )}

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard icon={Users} label="Пользователей" value={isLoading ? "…" : String(data?.totalUsers ?? 0)} />
        <StatCard
          icon={CreditCard}
          label="Активных подписок"
          value={isLoading ? "…" : String(data?.activeSubscriptions ?? 0)}
        />
        <StatCard icon={Dumbbell} label="Программ" value={isLoading ? "…" : String(data?.totalPrograms ?? 0)} />
        <StatCard
          icon={TrendingUp}
          label="Доход за 30 дней"
          value={isLoading ? "…" : `${(data?.revenueLast30Days ?? 0).toFixed(2)} €`}
        />
      </div>

      <div className="card mt-6">
        <h2 className="mb-4 font-semibold">Регистрации по дням</h2>
        <div className="h-64">
          <ResponsiveContainer width="100%" height="100%">
            <AreaChart data={data?.signupsByDay ?? []}>
              <defs>
                <linearGradient id="signupsGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="#A8E000" stopOpacity={0.35} />
                  <stop offset="100%" stopColor="#A8E000" stopOpacity={0} />
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" stroke="#23272F" vertical={false} />
              <XAxis dataKey="date" stroke="#8A909C" fontSize={12} tickLine={false} />
              <YAxis stroke="#8A909C" fontSize={12} tickLine={false} allowDecimals={false} />
              <Tooltip
                contentStyle={{
                  background: "#191C22",
                  border: "1px solid #2E333D",
                  borderRadius: 8,
                  fontSize: 13,
                }}
              />
              <Area type="monotone" dataKey="count" stroke="#A8E000" fill="url(#signupsGradient)" strokeWidth={2} />
            </AreaChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
}
