import { useState, useMemo, useRef, useEffect } from "react";
import { Routes, Route, Navigate, Outlet, Link, useParams } from "react-router-dom";
import { ChevronLeft, Play, Lock, Check, Dumbbell, Info } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { AppShell } from "@/components/AppShell";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import { useAuth } from "@/context/AuthContext";
import { supabase } from "@/lib/supabase";
import { useProgramAccess, usePrograms } from "@/lib/queries";
import { localizedOf } from "@/lib/localizedField";
import { splitDescription } from "@/lib/programMeta";
import { useDashboard } from "@/lib/dashboard";
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
import SupportPage from "@/pages/SupportPage";
import LanguageSettingsPage from "@/pages/LanguageSettingsPage";
import BodyParamsPage from "@/pages/BodyParamsPage";
import NotificationsSettingsPage from "@/pages/NotificationsSettingsPage";
import SubscriptionPage from "@/pages/SubscriptionPage";
import WithdrawalPage from "@/pages/WithdrawalPage";
import { PaymentSuccessPage, PaymentFailedPage } from "@/pages/PaymentResultPage";
import WorkoutPlayerPage from "@/pages/WorkoutPlayerPage";
import AchievementsPage from "@/pages/AchievementsPage";
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
  const { t, i18n } = useTranslation();
  const { session } = useAuth();
  const access = useProgramAccess();
  const { data: allPrograms } = usePrograms();
  const [activeWeekOrder, setActiveWeekOrder] = useState<number | null>(null);
  const { data: dashboard } = useDashboard();

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

  // Последовательное открытие тренировок: у каждой программы свой
  // прогресс (запрос отдельно на program.id), никакого отдельного
  // "указателя" в базе не заводили — вычисляем на лету из того, какие
  // workout_id уже есть в workout_logs этого пользователя. Тренировка N
  // открыта для прохождения, только если все тренировки ДО неё (в
  // каноническом порядке — том же week_order → order, каким их и
  // запрашиваем выше) уже отмечены выполненными. Порядок ГЛОБАЛЬНЫЙ по
  // всей программе, не сбрасывается по неделям — если человек месяц не
  // ходил в зал, следующая тренировка не "откроется по календарю" сама,
  // только по факту выполнения предыдущей.
  const { data: completedWorkoutIds } = useQuery({
    queryKey: ["completed-workout-ids", program?.id, session?.user?.id, workouts?.length],
    queryFn: async (): Promise<Set<string>> => {
      const workoutIds = (workouts ?? []).map((w) => w.id);
      if (workoutIds.length === 0) return new Set();
      const { data, error } = await supabase
        .from("workout_logs")
        .select("workout_id")
        .eq("user_id", session!.user.id)
        .in("workout_id", workoutIds);
      if (error) throw error;
      return new Set((data ?? []).map((row) => row.workout_id as string));
    },
    // Ждём workouts, чтобы точно знать, по каким ID фильтровать — иначе
    // пришлось бы полагаться на менее очевидный синтаксис фильтра через
    // связанную таблицу (workouts!inner(program_id)).
    enabled: !!program?.id && !!session?.user && !!workouts,
  });

  // Первая в каноническом порядке тренировка, которой ещё нет в
  // completedWorkoutIds — это она открыта для прохождения сейчас. Всё до
  // неё — уже пройдено, всё после — заблокировано. Ничего не считали, пока
  // completedWorkoutIds ещё не загрузился (undefined) — тогда просто не
  // определяем состояние вообще, чтобы не мигнуть "всё заблокировано" на
  // долю секунды до прихода реальных данных.
  const nextUnlockedWorkoutId = useMemo(() => {
    if (!workouts || !completedWorkoutIds) return undefined;
    return workouts.find((w) => !completedWorkoutIds.has(w.id))?.id ?? null;
  }, [workouts, completedWorkoutIds]);

  // "Уже занимался(-ась) раньше" — раньше было самостоятельной кнопкой
  // прямо здесь, у каждой заблокированной тренировки. Убрано по запросу
  // пользователя — самообслуживание клиентом подрывает саму идею
  // последовательного открытия (можно было бы "перепрыгнуть" не
  // тренируясь). Теперь это админская функция для форс-мажоров
  // (см. apps/admin — SettingsPage либо отдельная карточка в UsersPage),
  // отмечает то же самое (батч в workout_logs), просто инициируется
  // тренером, не самим клиентом.

  // Уникальные блоки недель в порядке появления (week_order уже отсортирован запросом).
  const weekBlocks = useMemo(() => {
    if (!workouts) return [];
    const seen = new Map<number, string>();
    for (const w of workouts) {
      if (!seen.has(w.weekOrder)) {
        const label = localizedOf(w, "weekLabel", i18n.language) || t("common.block", { n: w.weekOrder });
        seen.set(w.weekOrder, label);
      }
    }
    return Array.from(seen, ([order, label]) => ({ order, label }));
  }, [workouts, i18n.language, t]);

  // По умолчанию (пока пользователь сам не переключил вкладку) показываем
  // не первую неделю, а ту, где реально находится следующая доступная
  // тренировка — иначе человеку на 13-й неделе пришлось бы каждый раз
  // заново пролистывать все прошлые недели, чтобы дойти до своей текущей.
  const defaultWeekOrder = useMemo(() => {
    if (!workouts || nextUnlockedWorkoutId === undefined) return undefined;
    if (nextUnlockedWorkoutId === null) return workouts.at(-1)?.weekOrder; // всё пройдено — последняя неделя
    return workouts.find((w) => w.id === nextUnlockedWorkoutId)?.weekOrder;
  }, [workouts, nextUnlockedWorkoutId]);

  const effectiveWeekOrder = activeWeekOrder ?? defaultWeekOrder ?? weekBlocks[0]?.order ?? 1;
  const visibleWorkouts = useMemo(
    () => (workouts ?? []).filter((w) => w.weekOrder === effectiveWeekOrder),
    [workouts, effectiveWeekOrder],
  );
  const hasMultipleBlocks = weekBlocks.length > 1;

  // Лента недель прокручивается горизонтально: при открытии программы
  // (например, на 13-й неделе) активная неделя оказывалась далеко за
  // правым краем экрана — её приходилось искать, пролистывая ленту.
  // Прокручиваем саму ленту (не страницу — scrollIntoView дёрнул бы и
  // вертикальный скролл), чтобы активная неделя стояла по центру.
  const weekStripRef = useRef<HTMLDivElement>(null);
  const weekStripScrolledOnce = useRef(false);
  useEffect(() => {
    const strip = weekStripRef.current;
    if (!strip) return;
    const active = strip.querySelector<HTMLElement>('[data-active="true"]');
    if (!active) return;
    const left = active.offsetLeft - (strip.clientWidth - active.offsetWidth) / 2;
    strip.scrollTo({
      left: Math.max(0, left),
      behavior: weekStripScrolledOnce.current ? "smooth" : "auto",
    });
    weekStripScrolledOnce.current = true;
  }, [effectiveWeekOrder, weekBlocks.length]);

  if (isLoading) {
    return (
      <div className="px-5 pt-8">
        <div className="card h-24 animate-pulse bg-ink-800" />
      </div>
    );
  }

  if (!program) {
    return (
      <div className="px-5 pt-8 text-center text-neutral-400">{t("programs.notFound")}</div>
    );
  }

  // Правила доступа — в useProgramAccess (0080): подписка открывает всё,
  // бесплатная неделя — только программу, подобранную по анкете.
  const isLocked = access.isReady && !access.canAccess(program);
  const trialProgram =
    access.trial.active && access.trial.programId && access.trial.programId !== program.id
      ? allPrograms?.find((p) => p.id === access.trial.programId) ?? null
      : null;

  // Превью программы (Фаза 26): описание без хвоста "Оборудование: …",
  // оборудование — отдельными метками, число тренировок, большая кнопка.
  const { summary, equipment } = splitDescription(
    localizedOf(program, "description", i18n.language),
  );
  const doneCount = completedWorkoutIds?.size ?? 0;
  const totalCount = workouts?.length ?? 0;
  // Другая программа уже активна (по ней была последняя тренировка) —
  // предупреждаем, что прогресс там сохранится.
  const otherActiveProgram =
    dashboard?.isActiveProgram && dashboard.program && dashboard.program.id !== program.id
      ? dashboard.program
      : null;

  return (
    <div className="px-5 pt-8">
      <Link to="/programs" className="mb-4 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ChevronLeft size={16} /> {t("programs.allPrograms")}
      </Link>

      {/* Заголовок как в каталоге: крупно цель, мельче — для кого и где */}
      <h1 className="font-display text-3xl font-bold">
        {t(`programs.goalShort.${program.goal}`, {
          defaultValue: localizedOf(program, "title", i18n.language),
        })}
      </h1>
      <p className="text-neutral-400">
        {[
          program.gender !== "unspecified" ? t(`programs.genderShort.${program.gender}`) : null,
          program.trainingFormat !== "any" ? t(`programs.placeShort.${program.trainingFormat}`) : null,
        ]
          .filter(Boolean)
          .join(" · ")}
      </p>
      <p className="mt-3 text-sm text-neutral-400">{summary}</p>
      <div className="mt-3 flex flex-wrap gap-2 text-xs font-medium uppercase tracking-wide text-volt-400">
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {t("programs.weeks", { count: program.durationWeeks })}
        </span>
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {t("programs.perWeek", { count: program.workoutsPerWeek })}
        </span>
        <span className="rounded-full border border-volt-400/30 px-2.5 py-1">
          {t(`programs.difficulty.${program.difficulty}`)}
        </span>
      </div>

      {equipment.length > 0 && (
        <div className="mt-4">
          <p className="mb-1.5 flex items-center gap-1.5 text-xs uppercase tracking-wide text-neutral-500">
            <Dumbbell size={13} /> {t("programs.equipment")}
          </p>
          <div className="flex flex-wrap gap-1.5">
            {equipment.map((item) => (
              <span key={item} className="rounded-full bg-ink-800 px-2.5 py-1 text-xs text-neutral-300">
                {item}
              </span>
            ))}
          </div>
        </div>
      )}

      {!isLocked && totalCount > 0 && (
        <div className="card mt-5">
          <div className="flex items-center justify-between text-sm">
            <span className="text-neutral-400">{t("dashboard.programProgress", { done: doneCount, total: totalCount })}</span>
            <span className="font-semibold text-volt-400">{Math.round((doneCount / totalCount) * 100)}%</span>
          </div>
          <div className="mt-2 h-2 overflow-hidden rounded-full bg-ink-700">
            <div
              className="h-full rounded-full bg-volt-400"
              style={{ width: `${Math.max(2, (doneCount / totalCount) * 100)}%` }}
            />
          </div>
          {otherActiveProgram && (
            <p className="mt-3 flex items-start gap-1.5 text-xs text-neutral-400">
              <Info size={13} className="mt-0.5 shrink-0" />
              {t("programs.switchNote", {
                program: localizedOf(otherActiveProgram, "title", i18n.language),
              })}
            </p>
          )}
          {nextUnlockedWorkoutId && (
            <Link to={`/workout/${nextUnlockedWorkoutId}`} className="btn-primary mt-4 w-full py-3.5">
              <Play size={16} fill="currentColor" />
              {doneCount > 0 ? t("programs.continue") : t("programs.startProgram")}
            </Link>
          )}
        </div>
      )}

      {isLocked && (
        <div className="card mt-4 border-volt-400/30 bg-volt-400/5">
          <p className="text-sm text-neutral-300">
            {trialProgram
              ? t("programs.lockedTrialText", {
                  program: localizedOf(trialProgram, "title", i18n.language),
                })
              : t("programs.lockedText")}
          </p>
          <Link to="/subscription" className="btn-primary mt-3 w-full">
            {t("dashboard.activateSubscription")}
          </Link>
          {trialProgram && (
            <Link to={`/programs/${trialProgram.slug}`} className="btn-secondary mt-2 w-full">
              {t("programs.openTrialProgram")}
            </Link>
          )}
        </div>
      )}

      {hasMultipleBlocks && (
        <div ref={weekStripRef} className="relative mt-6 -mx-5 flex gap-2 overflow-x-auto px-5 pb-1">
          {weekBlocks.map((block) => (
            <button
              key={block.order}
              data-active={block.order === effectiveWeekOrder}
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

        {visibleWorkouts.map((workout, index) => {
          const workoutTitle = localizedOf(workout, "title", i18n.language);

          if (isLocked) {
            return (
              <Link
                key={workout.id}
                to="/subscription"
                className="card flex items-center justify-between opacity-70 hover:opacity-100"
              >
                <div>
                  <p className="text-xs text-neutral-500">{t("programs.workoutLabel", { number: index + 1 })}</p>
                  <p className="font-semibold">{workoutTitle}</p>
                </div>
                <Lock size={18} className="text-neutral-500" />
              </Link>
            );
          }

          const isDone = completedWorkoutIds?.has(workout.id) ?? false;
          // Пока nextUnlockedWorkoutId ещё не вычислен (undefined) — не
          // блокируем на всякий случай, считаем доступной (безопаснее
          // показать лишний Play на долю секунды, чем ложно показать замок
          // на тренировке, которую на самом деле можно проходить).
          const isNext = nextUnlockedWorkoutId === undefined || workout.id === nextUnlockedWorkoutId;
          const isSequenceLocked = !isDone && !isNext;

          if (isSequenceLocked) {
            return (
              <div
                key={workout.id}
                className="card flex items-center justify-between opacity-50"
                title={t("programs.sequenceLockedHint")}
              >
                <div>
                  <p className="text-xs text-neutral-500">{t("programs.workoutLabel", { number: index + 1 })}</p>
                  <p className="font-semibold">{workoutTitle}</p>
                </div>
                <Lock size={18} className="text-neutral-500" />
              </div>
            );
          }

          return (
            <Link
              key={workout.id}
              to={`/workout/${workout.id}`}
              className={clsx(
                "card flex items-center justify-between hover:border-ink-500",
                isDone && "border-volt-400/30 bg-volt-400/5",
              )}
            >
              <div>
                <p className="text-xs text-neutral-500">{t("programs.workoutLabel", { number: index + 1 })}</p>
                <p className="font-semibold">{workoutTitle}</p>
                <p className="mt-0.5 text-sm text-neutral-400">
                  {workout.estimatedDurationMinutes} {t("common.min")} · {t("programs.exercises", { count: workout.sets.length })}
                </p>
              </div>
              <span
                className={clsx(
                  "flex h-9 w-9 shrink-0 items-center justify-center rounded-full",
                  isDone ? "bg-volt-400/15 text-volt-400" : "bg-volt-400 text-ink-950",
                )}
              >
                {isDone ? <Check size={18} /> : <Play size={16} fill="currentColor" />}
              </span>
            </Link>
          );
        })}

        {!workoutsLoading && visibleWorkouts.length === 0 && (
          <p className="py-8 text-center text-neutral-500">
            {t("programs.noWorkoutsYet")}
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
        path="/achievements"
        element={
          <ProtectedRoute>
            <AchievementsPage />
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
      <Route
        path="/subscription/withdraw"
        element={
          <ProtectedRoute>
            <WithdrawalPage />
          </ProtectedRoute>
        }
      />
      <Route
        path="/payment/success"
        element={
          <ProtectedRoute>
            <PaymentSuccessPage />
          </ProtectedRoute>
        }
      />
      <Route
        path="/payment/failed"
        element={
          <ProtectedRoute>
            <PaymentFailedPage />
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
        <Route path="/support" element={<SupportPage />} />
      </Route>

      <Route
        path="/profile/body"
        element={
          <ProtectedRoute>
            <BodyParamsPage />
          </ProtectedRoute>
        }
      />
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
