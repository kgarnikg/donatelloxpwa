import { useState, useMemo } from "react";
import { Routes, Route, Navigate, Outlet, Link, useParams } from "react-router-dom";
import { ChevronLeft, Play, Lock } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import clsx from "clsx";
import { AppShell } from "@/components/AppShell";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import { useAuth } from "@/context/AuthContext";
import { supabase } from "@/lib/supabase";
import { useFreeProgramAccess } from "@/lib/queries";
import type { Workout, WorkoutProgram } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

import LoginPage from "@/pages/LoginPage";
import RegisterPage from "@/pages/RegisterPage";
import ForgotPasswordPage from "@/pages/ForgotPasswordPage";
import ResetPasswordPage from "@/pages/ResetPasswordPage";
import VerifyEmailPage from "@/pages/VerifyEmailPage";
import OnboardingPage from "@/pages/OnboardingPage";
import DashboardPage from "@/pages/DashboardPage";
import ProgramsPage from "@/pages/ProgramsPage";
import NutritionPage from "@/pages/NutritionPage";
import ProgressPage from "@/pages/ProgressPage";
import ProfilePage from "@/pages/ProfilePage";
import LanguageSettingsPage from "@/pages/LanguageSettingsPage";
import NotificationsSettingsPage from "@/pages/NotificationsSettingsPage";
import SubscriptionPage from "@/pages/SubscriptionPage";
import WorkoutPlayerPage from "@/pages/WorkoutPlayerPage";
import NotFoundPage from "@/pages/NotFoundPage";

/**
 * Полноэкранный загрузчик, пока восстанавливается сессия Supabase.
 * Используется до того, как AuthProvider определится с наличием сессии.
 */
function SplashScreen() {
  return (
    <div className="flex min-h-dvh items-center justify-center bg-ink-950">
      <div className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
    </div>
  );
}

/** Корневой "/" — маршрутизирует в зависимости от того, вошёл ли пользователь и заполнил ли анкету. */
function RootRedirect() {
  const { session, profile, loading } = useAuth();

  if (loading) return <SplashScreen />;
  if (!session) return <Navigate to="/login" replace />;
  if (profile && !profile.onboardingCompleted) return <Navigate to="/onboarding" replace />;
  return <Navigate to="/dashboard" replace />;
}

/** Layout для основных вкладок (нижняя навигация видна на этих страницах). */
function TabsLayout() {
  return (
    <AppShell>
      <Outlet />
    </AppShell>
  );
}

/**
 * Детальная страница программы тренировок: тренировки, сгруппированные по
 * блокам недель (week_label/week_order), с переключателем блока.
 * Премиум-программы без активной подписки показывают пейволл вместо списка.
 */
function ProgramDetailPage() {
  const { slug } = useParams<{ slug: string }>();
  const { hasFreeAccess } = useFreeProgramAccess();
  const [activeWeekOrder, setActiveWeekOrder] = useState<number | null>(null);

  const { data: program, isLoading } = useQuery({
    queryKey: ["program", slug],
    queryFn: async (): Promise<WorkoutProgram> => {
      const { data, error } = await supabase
        .from("workout_programs")
        .select("*")
        .eq("slug", slug)
        .single();
      if (error) throw error;
      return toCamelCase<WorkoutProgram>(data);
    },
    enabled: !!slug,
  });

  const { data: workouts, isLoading: workoutsLoading } = useQuery({
    queryKey: ["program-workouts", program?.id],
    queryFn: async (): Promise<Workout[]> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*)")
        .eq("program_id", program!.id)
        .order("week_order", { ascending: true })
        .order("order", { ascending: true });
      if (error) throw error;
      return toCamelCase<Workout[]>(data ?? []);
    },
    enabled: !!program?.id,
  });

  // Уникальные блоки недель в порядке появления (week_order уже отсортирован запросом).
  const weekBlocks = useMemo(() => {
    if (!workouts) return [];
    const seen = new Map<number, string>();
    for (const w of workouts) {
      if (!seen.has(w.weekOrder)) seen.set(w.weekOrder, w.weekLabel || `Блок ${w.weekOrder}`);
    }
    return Array.from(seen, ([order, label]) => ({ order, label }));
  }, [workouts]);

  const effectiveWeekOrder = activeWeekOrder ?? weekBlocks[0]?.order ?? 1;
  const visibleWorkouts = useMemo(
    () => (workouts ?? []).filter((w) => w.weekOrder === effectiveWeekOrder),
    [workouts, effectiveWeekOrder],
  );
  const hasMultipleBlocks = weekBlocks.length > 1;

  if (isLoading) {
    return (
      <div className="px-5 pt-8">
        <div className="card h-24 animate-pulse bg-ink-800" />
      </div>
    );
  }

  if (!program) {
    return (
      <div className="px-5 pt-8 text-center text-neutral-400">Программа не найдена.</div>
    );
  }

  return (
    <div className="px-5 pt-8">
      <Link to="/programs" className="mb-4 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ChevronLeft size={16} /> Все программы
      </Link>

      <h1 className="font-display text-2xl font-bold">{program.title}</h1>
      <p className="mt-1 text-neutral-400">{program.description}</p>
      <div className="mt-3 flex flex-wrap gap-2 text-xs font-medium uppercase tracking-wide text-volt-400">
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {program.durationWeeks} недель
        </span>
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {program.workoutsPerWeek}x в неделю
        </span>
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {program.difficulty}
        </span>
      </div>

      {!program.isPremium && !hasFreeAccess && (
        <div className="card mt-4 border-volt-400/30 bg-volt-400/5">
          <p className="text-sm text-neutral-300">
            Бесплатный доступ к этой программе был доступен в первую неделю после регистрации.
            Оформите подписку, чтобы продолжить тренировки по ней.
          </p>
          <Link to="/subscription" className="btn-primary mt-3 w-full">
            Оформить подписку
          </Link>
        </div>
      )}

      {hasMultipleBlocks && (
        <div className="mt-6 -mx-5 flex gap-2 overflow-x-auto px-5 pb-1">
          {weekBlocks.map((block) => (
            <button
              key={block.order}
              onClick={() => setActiveWeekOrder(block.order)}
              className={clsx(
                "shrink-0 whitespace-nowrap rounded-full border px-3.5 py-1.5 text-xs font-semibold transition",
                block.order === effectiveWeekOrder
                  ? "border-volt-400 bg-volt-400 text-ink-950"
                  : "border-ink-700 text-neutral-400 hover:border-ink-500",
              )}
            >
              {block.label}
            </button>
          ))}
        </div>
      )}

      <div className="mt-4 space-y-3">
        {workoutsLoading &&
          Array.from({ length: 4 }).map((_, i) => (
            <div key={i} className="card h-20 animate-pulse bg-ink-800" />
          ))}

        {visibleWorkouts.map((workout, index) =>
          program.isPremium || !hasFreeAccess ? (
            <Link
              key={workout.id}
              to="/subscription"
              className="card flex items-center justify-between opacity-70 hover:opacity-100"
            >
              <div>
                <p className="text-xs text-neutral-500">Тренировка {index + 1}</p>
                <p className="font-semibold">{workout.title}</p>
              </div>
              <Lock size={18} className="text-neutral-500" />
            </Link>
          ) : (
            <Link
              key={workout.id}
              to={`/workout/${workout.id}`}
              className="card flex items-center justify-between hover:border-ink-500"
            >
              <div>
                <p className="text-xs text-neutral-500">Тренировка {index + 1}</p>
                <p className="font-semibold">{workout.title}</p>
                <p className="mt-0.5 text-sm text-neutral-400">
                  {workout.estimatedDurationMinutes} мин · {workout.sets.length} упражнений
                </p>
              </div>
              <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-volt-400 text-ink-950">
                <Play size={16} fill="currentColor" />
              </span>
            </Link>
          ),
        )}

        {!workoutsLoading && visibleWorkouts.length === 0 && (
          <p className="py-8 text-center text-neutral-500">
            Тренировки для этой программы скоро появятся.
          </p>
        )}
      </div>
    </div>
  );
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<RootRedirect />} />

      {/* Публичные маршруты авторизации */}
      <Route path="/login" element={<LoginPage />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route path="/forgot-password" element={<ForgotPasswordPage />} />
      <Route path="/reset-password" element={<ResetPasswordPage />} />
      <Route path="/verify-email" element={<VerifyEmailPage />} />

      {/* Анкета — отдельно от табов, доступна сразу после регистрации */}
      <Route
        path="/onboarding"
        element={
          <ProtectedRoute>
            <OnboardingPage />
          </ProtectedRoute>
        }
      />

      {/* Полноэкранные защищённые страницы без нижней навигации */}
      <Route
        path="/workout/:workoutId"
        element={
          <ProtectedRoute>
            <WorkoutPlayerPage />
          </ProtectedRoute>
        }
      />
      <Route
        path="/subscription"
        element={
          <ProtectedRoute>
            <SubscriptionPage />
          </ProtectedRoute>
        }
      />

      {/* Основные вкладки приложения (с нижней навигацией) */}
      <Route
        element={
          <ProtectedRoute>
            <TabsLayout />
          </ProtectedRoute>
        }
      >
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/programs" element={<ProgramsPage />} />
        <Route path="/programs/:slug" element={<ProgramDetailPage />} />
        <Route path="/nutrition" element={<NutritionPage />} />
        <Route path="/progress" element={<ProgressPage />} />
        <Route path="/profile" element={<ProfilePage />} />
      </Route>

      <Route
        path="/profile/language"
        element={
          <ProtectedRoute>
            <LanguageSettingsPage />
          </ProtectedRoute>
        }
      />
      <Route
        path="/profile/notifications"
        element={
          <ProtectedRoute>
            <NotificationsSettingsPage />
          </ProtectedRoute>
        }
      />

      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}
