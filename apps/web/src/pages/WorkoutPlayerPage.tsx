import { useEffect, useMemo, useRef, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Check, ChevronLeft, PlayCircle, Video, TrendingUp, X, Timer, ArrowDown, Shuffle, Lock } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";
import { localizedOf } from "@/lib/localizedField";
import { getYouTubeEmbedUrl } from "@/lib/video";
import { triggerHapticPulse } from "@/lib/haptics";
import { estimateWorkoutCalories, calculateAge } from "@/lib/calories";
import { useUserProfile, useProgramAccess } from "@/lib/queries";
import { RestTimerOverlay } from "@/components/RestTimerOverlay";
import { markWorkoutJustFinished } from "@/lib/install";
import { clearWorkoutSession, loadWorkoutSession, saveWorkoutSession } from "@/lib/workoutSession";
import { WorkoutSummary, type WorkoutSummaryData } from "@/components/WorkoutSummary";
import type { Exercise, WorkoutSet } from "@donatellox/types";
import { toCamelCase } from "@donatellox/types";

interface SetRow extends WorkoutSet {
  id: string;
  exercise: Exercise;
}

interface WorkoutWithSets {
  id: string;
  title: string;
  titleEn?: string;
  titleEs?: string;
  titleHy?: string;
  estimatedDurationMinutes: number;
  sets: SetRow[];
  /** Формат тренировок программы, к которой относится эта тренировка ("зал"/"дома") — см. комментарий у REST_BETWEEN_EXERCISES_SECONDS ниже. */
  trainingFormat: "home" | "gym";
  /** Цель программы (workout_programs.goal) — задаёт интенсивность для расчёта калорий. */
  programGoal: string | null;
  /** Программа тренировки — для проверки доступа (подписка / бесплатная неделя, 0080). */
  programRef: { id: string; slug: string; isPremium: boolean } | null;
}

interface CompletedSetEntry {
  exerciseId: string;
  weightKg?: number;
}

/**
 * Отдых между УПРАЖНЕНИЯМИ (не между подходами одного упражнения) — только
 * для программ в зале, по просьбе: смена станции/тренажёра в зале требует
 * больше времени, чем просто отдых между подходами. Для домашних программ
 * между упражнениями по-прежнему действует обычный set.restSeconds —
 * специально не трогаем, дома обычно нет очереди к оборудованию.
 */
const REST_BETWEEN_EXERCISES_SECONDS = 180;

/** Группирует подходы по упражнению, сохраняя порядок первого появления. */
function groupByExercise(sets: SetRow[]) {
  const groups: { exercise: Exercise; sets: SetRow[] }[] = [];
  for (const set of sets) {
    const last = groups[groups.length - 1];
    if (last && last.exercise.id === set.exercise.id) {
      last.sets.push(set);
    } else {
      groups.push({ exercise: set.exercise, sets: [set] });
    }
  }
  return groups;
}

export default function WorkoutPlayerPage() {
  const { t, i18n } = useTranslation();
  const { workoutId } = useParams<{ workoutId: string }>();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const { authUser } = useAuth();
  const { data: userProfile } = useUserProfile();
  const access = useProgramAccess();
  // Незаконченная тренировка восстанавливается после перезагрузки
  // страницы (iPhone делает это при переключении приложений) — lib/workoutSession.ts
  const [restored] = useState(() => loadWorkoutSession(workoutId, authUser?.id));
  const [completedIds, setCompletedIds] = useState<Set<string>>(() => new Set(restored?.completedIds ?? []));
  const [confirmExit, setConfirmExit] = useState(false);
  const [weights, setWeights] = useState<Record<string, string>>(() => restored?.weights ?? {});
  const [startedAt] = useState(() => restored?.startedAt ?? Date.now());
  const [summary, setSummary] = useState<WorkoutSummaryData | null>(null);
  const [activeVideo, setActiveVideo] = useState<Exercise | null>(null);
  const [videoClosing, setVideoClosing] = useState(false);

  // Плавное закрытие: сначала проигрываем анимацию ухода, и только потом
  // реально убираем модалку из DOM — иначе видео просто исчезает рывком,
  // что не ощущается премиально.
  function closeVideo() {
    setVideoClosing(true);
    setTimeout(() => {
      setActiveVideo(null);
      setVideoClosing(false);
    }, 220);
  }

  function openVideo(exercise: Exercise) {
    setVideoClosing(false);
    setActiveVideo(exercise);
  }

  // Блокируем скролл фона, пока открыт просмотр видео, и даём закрыть по Esc
  // (мелочь, но так плеер ощущается частью приложения, а не случайной вставкой).
  useEffect(() => {
    if (!activeVideo) return;
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") closeVideo();
    };
    window.addEventListener("keydown", onKeyDown);
    return () => {
      document.body.style.overflow = previousOverflow;
      window.removeEventListener("keydown", onKeyDown);
    };
  }, [activeVideo]);


  // ---- Таймер отдыха между подходами ------------------------------------
  // Запускается после отметки подхода выполненным, на set.restSeconds.
  //
  // ВАЖНО: считаем не тиками setInterval (remaining--), а от абсолютной
  // метки времени окончания (endAt = Date.now() + секунды). Мобильные
  // браузеры замедляют/полностью останавливают JS-таймеры, когда вкладка
  // свёрнута (экономия батареи) — если бы отсчёт шёл декрементом на
  // каждый тик, после возврата из фона (например, ответил в мессенджере,
  // пока шёл отдых) таймер показывал бы неверное, "отставшее" время.
  // Здесь же на каждый рендер remaining пересчитывается заново из разницы
  // endAt - Date.now() — сколько бы тиков ни было пропущено, как только
  // компонент перерендерится (в т.ч. принудительно при возврате видимости
  // вкладки, см. ниже), значение будет верным.
  const [restState, setRestState] = useState<{ total: number; endAt: number; kind: "set" | "exercise" } | null>(
    () => (restored?.rest && restored.rest.endAt > Date.now() ? restored.rest : null),
  );
  // Полноэкранный режим таймера: открывается сам при каждом старте отдыха,
  // "Свернуть" — компактная полоска внизу (тап по ней разворачивает обратно).
  const [restExpanded, setRestExpanded] = useState(true);
  const [, forceTick] = useState(0);
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  function clearRestInterval() {
    if (intervalRef.current !== null) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
  }

  function startRestTimer(seconds: number, kind: "set" | "exercise") {
    clearRestInterval();
    if (seconds <= 0) return;
    setRestState({ total: seconds, endAt: Date.now() + seconds * 1000, kind });
    setRestExpanded(true);
    intervalRef.current = setInterval(() => forceTick((t) => t + 1), 1000);

    // Спрашиваем разрешение на уведомления один раз, лениво — именно в
    // момент, когда это реально нужно (первый запуск отдыха), а не сразу
    // при открытии страницы. Так контекст запроса понятен пользователю,
    // и вероятность согласия выше, чем при "холодном" запросе на входе.
    if (typeof Notification !== "undefined" && Notification.permission === "default") {
      Notification.requestPermission().catch(() => {});
    }
  }

  function skipRestTimer() {
    clearRestInterval();
    setRestState(null);
  }

  function addRestTime(seconds: number) {
    setRestState((prev) =>
      prev ? { ...prev, total: prev.total + seconds, endAt: prev.endAt + seconds * 1000 } : prev,
    );
  }

  // ---- Отметка подхода: один раз, без снятия --------------------------
  // Галочку нельзя снять повторным нажатием (иначе её можно "щёлкать"
  // сколько угодно, а таймер отдыха продолжал бы идти). Для случайного
  // нажатия — короткое окно "Отменить" (как при удалении письма в почте):
  // снимает ИМЕННО последнюю отметку и останавливает запущенный ею отдых.
  const UNDO_WINDOW_MS = 5000;
  const [undoSetId, setUndoSetId] = useState<string | null>(null);
  const undoTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  function clearUndo() {
    if (undoTimeoutRef.current !== null) {
      clearTimeout(undoTimeoutRef.current);
      undoTimeoutRef.current = null;
    }
    setUndoSetId(null);
  }

  function offerUndo(setId: string) {
    if (undoTimeoutRef.current !== null) clearTimeout(undoTimeoutRef.current);
    setUndoSetId(setId);
    undoTimeoutRef.current = setTimeout(() => {
      undoTimeoutRef.current = null;
      setUndoSetId(null);
    }, UNDO_WINDOW_MS);
  }

  function undoLastSet() {
    if (!undoSetId) return;
    const id = undoSetId;
    setCompletedIds((prev) => {
      const next = new Set(prev);
      next.delete(id);
      return next;
    });
    skipRestTimer();
    clearUndo();
  }

  useEffect(
    () => () => {
      if (undoTimeoutRef.current !== null) clearTimeout(undoTimeoutRef.current);
    },
    [],
  );

  const restRemaining = restState ? Math.max(0, Math.ceil((restState.endAt - Date.now()) / 1000)) : 0;

  // Как только реальное время истекло — закрываем таймер (проверяется на
  // каждом рендере, включая принудительный при возврате на вкладку, а не
  // только по тику setInterval, который в фоне мог не сработать вовремя).
  useEffect(() => {
    if (restState && restRemaining <= 0) {
      clearRestInterval();

      if (document.visibilityState === "visible") {
        // Страница на экране — пробуем оба известных способа разом (обычный
        // navigator.vibrate для Android/Chrome + резервный трюк под iOS
        // Safari, где Vibration API в принципе не реализован — см. lib/haptics.ts).
        triggerHapticPulse();
      } else if (typeof Notification !== "undefined" && Notification.permission === "granted") {
        // Страница свёрнута — прямой navigator.vibrate() браузер молча
        // игнорирует (намеренное ограничение платформы, не обойти). Вместо
        // этого показываем системное уведомление с СОБСТВЕННЫМ паттерном
        // вибрации — это идёт через систему уведомлений ОС, а не через
        // голый JS страницы, поэтому шанс реальной вибрации в фоне выше
        // (не 100% гарантия на iOS, но лучшее, что доступно без сервера
        // push-уведомлений — см. комментарий в PROJECT_PLAN.md). Плюс тот
        // же best-effort iOS-трюк — на случай, если колбэк таймера всё же
        // выполняется в фоне у части браузеров.
        triggerHapticPulse();
        const title =
          restState.kind === "exercise" ? t("workout.restingNextExercise") : t("workout.resting");
        navigator.serviceWorker?.ready
          .then((reg) =>
            reg.showNotification(title, {
              body: t("workout.restDoneBody"),
              icon: "/icons/icon-192.png",
              badge: "/icons/icon-192.png",
              // `vibrate` — часть спецификации Notification, но встроенные
              // типы TypeScript (lib.dom.d.ts) пока его не знают — отсюда
              // приведение типа, не ошибка в логике.
              vibrate: [200, 100, 200],
              tag: "donatellex-rest-timer",
            } as NotificationOptions & { vibrate: number[] }),
          )
          .catch(() => {});
      }

      setRestState(null);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [restState, restRemaining]);

  // Принудительный пересчёт сразу при возврате на вкладку — не ждём
  // следующего тика setInterval, который сразу после возврата из фона
  // тоже может быть отложен на секунду-другую.
  useEffect(() => {
    function onVisibilityChange() {
      if (document.visibilityState === "visible") forceTick((t) => t + 1);
    }
    document.addEventListener("visibilitychange", onVisibilityChange);
    return () => document.removeEventListener("visibilitychange", onVisibilityChange);
  }, []);

  // Отдых, восстановленный после перезагрузки, — продолжаем отсчёт
  useEffect(() => {
    if (restState && intervalRef.current === null) {
      intervalRef.current = setInterval(() => forceTick((t) => t + 1), 1000);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Чистим интервал при уходе со страницы — иначе он продолжит тикать
  // в фоне и попытается обновлять состояние размонтированного компонента.
  useEffect(() => clearRestInterval, []);

  const { data: workout, isLoading } = useQuery({
    queryKey: ["workout", workoutId],
    queryFn: async (): Promise<WorkoutWithSets> => {
      const { data, error } = await supabase
        .from("workouts")
        .select("*, sets:workout_sets(*, exercise:exercises(*)), program:workout_programs(id, slug, is_premium, training_format, goal)")
        .eq("id", workoutId)
        .order("order", { referencedTable: "workout_sets", ascending: true })
        .single();
      if (error) throw error;
      const camel = toCamelCase<
        WorkoutWithSets & {
          program?: { id: string; slug: string; isPremium: boolean; trainingFormat: "home" | "gym"; goal?: string | null };
        }
      >(data);
      return {
        ...camel,
        trainingFormat: camel.program?.trainingFormat ?? "home",
        programGoal: camel.program?.goal ?? null,
        programRef: camel.program ? { id: camel.program.id, slug: camel.program.slug, isPremium: camel.program.isPremium } : null,
      };
    },
    enabled: !!workoutId,
  });

  const groups = useMemo(() => (workout ? groupByExercise(workout.sets) : []), [workout]);

  // ---- Переставить/заменить упражнение — только на текущий сеанс -------
  // Ни то, ни другое не пишет в саму программу (workout_sets в базе) —
  // иначе поменялось бы для всех, кто проходит эту же тренировку. Заказ
  // пользователя: "занят тренажёр — подвинуть дальше" и "заменить на
  // похожее, если это конкретное выполнить нельзя". При сохранении
  // тренировки (finishMutation ниже) в историю пишется РЕАЛЬНО
  // выполненное упражнение (после замены, если она была) — иначе личные
  // рекорды и объём по упражнениям задваивались бы неправильному движению.
  const [orderOverride, setOrderOverride] = useState<string[] | null>(() => restored?.orderOverride ?? null);
  const [substitutions, setSubstitutions] = useState<Record<string, Exercise>>(() => restored?.substitutions ?? {});

  // Сохраняем прогресс на телефоне, как только человек реально начал
  // (отметил подход или вписал вес) — просто открыть и посмотреть не считается.
  useEffect(() => {
    if (!workoutId || !authUser || summary) return;
    const started = completedIds.size > 0 || Object.values(weights).some((v) => v !== "");
    if (!started) return;
    saveWorkoutSession(workoutId, {
      userId: authUser.id,
      startedAt,
      completedIds: [...completedIds],
      weights,
      orderOverride,
      substitutions,
      rest: restState,
    });
  }, [workoutId, authUser, summary, startedAt, completedIds, weights, orderOverride, substitutions, restState]);
  const [replacingId, setReplacingId] = useState<string | null>(null);

  const orderedGroups = useMemo(() => {
    if (!orderOverride) return groups;
    const byId = new Map(groups.map((g) => [g.exercise.id, g]));
    const ordered = orderOverride.map((id) => byId.get(id)).filter((g): g is (typeof groups)[number] => !!g);
    // На случай рассинхронизации (состав groups поменялся под ногами) —
    // не теряем упражнения, которых нет в сохранённом порядке.
    const missing = groups.filter((g) => !orderOverride.includes(g.exercise.id));
    return [...ordered, ...missing];
  }, [groups, orderOverride]);

  function moveGroupLater(exerciseId: string) {
    const currentOrder = (orderOverride ?? groups.map((g) => g.exercise.id)).slice();
    const idx = currentOrder.indexOf(exerciseId);
    if (idx === -1 || idx === currentOrder.length - 1) return;
    [currentOrder[idx], currentOrder[idx + 1]] = [currentOrder[idx + 1], currentOrder[idx]];
    setOrderOverride(currentOrder);
  }

  // Замена упражнения — только на упражнение той же группы замены
  // (exercises.swap_group, миграция 0079): грудь → грудь, трицепс →
  // трицепс, круг на пресс → круг на пресс. Кандидатов подбирает сервер
  // (suggest_exercise_swaps): тот же формат программы (зал/дом), без
  // упражнений, которые уже есть в этой тренировке. Раньше искали по
  // первому слову названия — "Жим гантелей" находил "Жим ногами".
  const [swapError, setSwapError] = useState<string | null>(null);

  async function replaceExercise(original: Exercise) {
    if (!workoutId) return;
    setReplacingId(original.id);
    setSwapError(null);
    try {
      const { data, error } = await supabase.rpc("suggest_exercise_swaps", {
        p_exercise_id: original.id,
        p_workout_id: workoutId,
      });
      if (error) throw error;
      const current = substitutions[original.id];
      const candidates = toCamelCase<Exercise[]>(data ?? []).filter((c) => c.id !== current?.id);
      if (candidates.length === 0) {
        setSwapError(original.id);
        return;
      }
      const pick = candidates[Math.floor(Math.random() * candidates.length)];
      setSubstitutions((prev) => ({ ...prev, [original.id]: pick }));
    } catch {
      setSwapError(original.id);
    } finally {
      setReplacingId(null);
    }
  }

  /** Последние зафиксированные рабочие веса по этой тренировке — для подсказки "в прошлый раз". */
  const { data: lastWeights } = useQuery({
    queryKey: ["last-weights", workoutId, authUser?.id],
    enabled: !!workoutId && !!authUser,
    queryFn: async (): Promise<Record<string, number>> => {
      const { data, error } = await supabase
        .from("workout_logs")
        .select("completed_sets, completed_at")
        .eq("user_id", authUser!.id)
        .eq("workout_id", workoutId)
        .order("completed_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (error || !data) return {};

      const entries = (data.completed_sets ?? []) as CompletedSetEntry[];
      const map: Record<string, number> = {};
      for (const e of entries) {
        if (e.exerciseId && typeof e.weightKg === "number") map[e.exerciseId] = e.weightKg;
      }
      return map;
    },
  });

  const finishMutation = useMutation({
    mutationFn: async () => {
      if (!authUser) throw new Error(t("errors.sessionExpiredSave"));
      if (!workout) throw new Error(t("errors.workoutUnknown"));

      const durationMinutes = Math.max(1, Math.round((Date.now() - startedAt) / 60_000));
      const completedSets: CompletedSetEntry[] = groups.map((g) => {
        const actual = substitutions[g.exercise.id] ?? g.exercise;
        return {
          exerciseId: actual.id,
          weightKg: weights[g.exercise.id] ? Number(weights[g.exercise.id]) : undefined,
        };
      });

      // Суммарный поднятый вес (вес × повторения по всем подходам) — для
      // достижений и статистики "сколько поднято" (0026). Считаем только
      // по упражнениям, где реально указан рабочий вес — иначе это не вес,
      // который "подняли", а просто выполненные повторения.
      const totalVolumeKg = groups.reduce((sum, g) => {
        const weight = weights[g.exercise.id] ? Number(weights[g.exercise.id]) : 0;
        if (!weight) return sum;
        const totalReps = g.sets.reduce((s, set) => s + (set.reps ?? 0), 0);
        return sum + weight * totalReps;
      }, 0);

      // Калории за ЭТУ тренировку (lib/calories.ts, estimateWorkoutCalories):
      // вес/рост/возраст/пол из профиля + интенсивность программы +
      // фактическая длительность (с потолком) + доля выполненных подходов.
      // Сохраняем в саму запись — общий счётчик на странице "Питание"
      // складывает эти числа и не "плывёт", если потом поменяется вес.
      const caloriesBurned = userProfile?.weightKg
        ? estimateWorkoutCalories({
            weightKg: userProfile.weightKg,
            heightCm: userProfile.heightCm,
            age: userProfile.birthDate ? calculateAge(userProfile.birthDate) : null,
            gender: userProfile.gender,
            actualMinutes: (Date.now() - startedAt) / 60_000,
            estimatedMinutes: workout.estimatedDurationMinutes,
            programGoal: workout.programGoal,
            completionRatio: workout.sets.length ? completedIds.size / workout.sets.length : 1,
          })
        : null;

      const { data, error } = await supabase
        .from("workout_logs")
        .insert({
          user_id: authUser.id,
          workout_id: workout.id,
          completed_at: new Date().toISOString(),
          duration_minutes: durationMinutes,
          completed_sets: completedSets,
          total_volume_kg: totalVolumeKg,
          calories_burned: caloriesBurned,
        })
        .select()
        .single();

      if (error) {
        console.error("Не удалось сохранить тренировку:", error);
        throw new Error(error.message || t("errors.workoutSaveFailed"));
      }
      const result: WorkoutSummaryData = {
        title: localizedOf(workout, "title", i18n.language),
        minutes: durationMinutes,
        exercises: groups.length,
        sets: workout.sets.length,
        kcal: caloriesBurned,
        volumeKg: totalVolumeKg,
        programGoal: workout.programGoal ?? null,
        weightKg: userProfile?.weightKg ?? null,
      };
      return { log: data, summary: result };
    },
    onSuccess: ({ summary: result }) => {
      clearWorkoutSession(workoutId);
      clearRestInterval();
      setRestState(null);
      clearUndo();
      markWorkoutJustFinished();
      // Без этого страница "Прогресс" могла показывать старый (пустой)
      // снимок истории тренировок ещё до минуты (staleTime=60с в
      // main.tsx) после реального сохранения — данные в базе были, но
      // react-query не знал, что их нужно перезапросить.
      queryClient.invalidateQueries({ queryKey: ["workout-history"] });
      queryClient.invalidateQueries({ queryKey: ["progress"] });
      queryClient.invalidateQueries({ queryKey: ["daily-calories"] });
      queryClient.invalidateQueries({ queryKey: ["workout-calorie-stats"] });
      queryClient.invalidateQueries({ queryKey: ["dashboard"] });
      // Вместо мгновенного перехода — экран итогов тренировки
      setSummary(result);
      window.scrollTo(0, 0);
    },
  });

  if (summary) {
    return <WorkoutSummary data={summary} onDone={() => navigate("/dashboard", { replace: true })} />;
  }

  if (isLoading || !workout) {
    return (
      <div className="flex min-h-dvh items-center justify-center bg-ink-950">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-ink-600 border-t-volt-400" />
      </div>
    );
  }

  // Прямая ссылка на тренировку закрытой программы не должна обходить
  // оплату: та же проверка, что в каталоге и на странице программы.
  if (access.isReady && workout.programRef && !access.canAccess(workout.programRef)) {
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
        <div className="flex h-14 w-14 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
          <Lock size={24} />
        </div>
        <h1 className="mt-4 font-display text-xl font-bold">{localizedOf(workout, "title", i18n.language)}</h1>
        <p className="mt-2 max-w-xs text-sm text-neutral-400">
          {access.trial.active ? t("programs.lockedOtherText") : t("programs.lockedText")}
        </p>
        <button onClick={() => navigate("/subscription")} className="btn-primary mt-6 w-full max-w-xs">
          {t("dashboard.activateSubscription")}
        </button>
        <button onClick={() => navigate(-1)} className="mt-3 text-sm text-neutral-400 hover:text-neutral-200">
          {t("workout.back")}
        </button>
      </div>
    );
  }

  const allDone = workout.sets.every((s) => completedIds.has(s.id));

  // Следующий неотмеченный подход — показываем на таймере отдыха ("Далее"),
  // чтобы издалека было видно, к какому упражнению возвращаться.
  let nextLabel: string | undefined;
  for (const group of orderedGroups) {
    const index = group.sets.findIndex((s) => !completedIds.has(s.id));
    if (index === -1) continue;
    const shown = substitutions[group.exercise.id] ?? group.exercise;
    nextLabel = `${t("workout.set", { number: index + 1 })} · ${localizedOf(shown, "title", i18n.language)}`;
    break;
  }
  const restOverlayOpen = !!restState && restExpanded;

  return (
    <div className={clsx(
        "min-h-dvh bg-ink-950 px-5 pt-6",
        restState && undoSetId ? "pb-60" : restState || undoSetId ? "pb-48" : "pb-32",
      )}>
      <button
        onClick={() => {
          if (completedIds.size > 0) {
            setConfirmExit(true);
          } else {
            clearWorkoutSession(workoutId);
            navigate(-1);
          }
        }}
        className="mb-4 flex items-center gap-1 text-sm text-neutral-400 hover:text-neutral-200"
      >
        <ChevronLeft size={18} /> {t("workout.back")}
      </button>

      <h1 className="font-display text-2xl font-bold">
        {localizedOf(workout, "title", i18n.language)}
      </h1>
      <p className="mt-1 text-neutral-400">~{workout.estimatedDurationMinutes} {t("common.min")}</p>

      <div className="mt-6 space-y-4">
        {orderedGroups.map((group, groupIndex) => {
          const lastWeight = lastWeights?.[group.exercise.id];
          const isWeighted = !group.sets[0].durationSeconds;
          // group.exercise — то, что ПРЕДПИСАНО программой; displayExercise —
          // то, что реально показываем/играем (может быть заменено пользователем
          // на этот сеанс). Подходы/повторения/отдых (group.sets) остаются от
          // исходного предписания — меняется только сама движение.
          const displayExercise = substitutions[group.exercise.id] ?? group.exercise;
          const exerciseTitle = localizedOf(displayExercise, "title", i18n.language);
          const firstSetNotes = localizedOf(group.sets[0], "notes", i18n.language);
          return (
            <div key={group.exercise.id} className="card">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="font-semibold">{exerciseTitle}</p>
                  <p className="mt-0.5 text-xs text-neutral-500">
                    {t("workout.sets", { count: group.sets.length })}
                    {firstSetNotes ? ` · ${firstSetNotes}` : ""}
                  </p>
                </div>

                {displayExercise.videoUrl ? (
                  <button
                    onClick={() => openVideo(displayExercise)}
                    className="flex shrink-0 items-center gap-1.5 rounded-full bg-volt-400/10 px-3 py-1.5 text-xs font-semibold text-volt-400 transition hover:bg-volt-400/20"
                  >
                    <PlayCircle size={14} /> {t("workout.video")}
                  </button>
                ) : (
                  <span className="flex shrink-0 items-center gap-1.5 rounded-full bg-ink-800 px-3 py-1.5 text-xs font-medium text-neutral-500">
                    <Video size={14} /> {t("workout.videoSoon")}
                  </span>
                )}
              </div>

              {/* "Занят тренажёр — подвинуть дальше" и "заменить на похожее" —
                  оба только на этот сеанс, см. комментарий у состояния выше. */}
              <div className="mt-2 flex flex-wrap gap-2">
                {groupIndex < orderedGroups.length - 1 && (
                  <button
                    onClick={() => moveGroupLater(group.exercise.id)}
                    className="flex items-center gap-1 rounded-full border border-ink-700 px-2.5 py-1 text-xs text-neutral-400 transition hover:border-ink-500 hover:text-neutral-200"
                  >
                    <ArrowDown size={12} /> {t("workout.moveLater")}
                  </button>
                )}
                {group.exercise.swapGroup !== "other" && (
                <button
                  onClick={() => replaceExercise(group.exercise)}
                  disabled={replacingId === group.exercise.id}
                  className="flex items-center gap-1 rounded-full border border-ink-700 px-2.5 py-1 text-xs text-neutral-400 transition hover:border-ink-500 hover:text-neutral-200 disabled:opacity-50"
                >
                  <Shuffle size={12} className={replacingId === group.exercise.id ? "animate-spin" : ""} />
                  {substitutions[group.exercise.id] ? t("workout.replaced") : t("workout.replace")}
                </button>
                )}
              </div>
              {swapError === group.exercise.id && (
                <p className="mt-2 text-xs text-neutral-500">{t("workout.noReplacement")}</p>
              )}

              <div className="mt-3 space-y-2">
                {group.sets.map((set, i) => {
                  const done = completedIds.has(set.id);
                  // Последний подход этого упражнения, и после него есть ещё
                  // упражнения — значит, дальше не просто отдых между
                  // подходами, а переход к следующему упражнению.
                  const isLastSetOfGroup = i === group.sets.length - 1;
                  const hasNextGroup = groupIndex < groups.length - 1;
                  // Подходы — строго по порядку: третий нельзя отметить,
                  // пока не отмечены первый и второй (иначе объём, калории
                  // и прогресс считаются по подходам, которых не было).
                  const previousDone = group.sets.slice(0, i).every((s) => completedIds.has(s.id));
                  const outOfOrder = !done && !previousDone;
                  const locked = done || (!!restState && !done) || outOfOrder;
                  return (
                    <button
                      key={set.id}
                      disabled={locked}
                      aria-disabled={locked}
                      aria-pressed={done}
                      onClick={() => {
                        // Уже отмеченный подход — не снимается (только через "Отменить")
                        if (completedIds.has(set.id)) return;
                        if (!group.sets.slice(0, i).every((s) => completedIds.has(s.id))) return;
                        setCompletedIds((prev) => new Set(prev).add(set.id));
                        // Последний подход всей тренировки — отдыхать не нужно,
                        // сразу "Завершить тренировку"
                        const isLastOfWorkout = workout.sets.every((s) => s.id === set.id || completedIds.has(s.id));
                        if (isLastOfWorkout) {
                          skipRestTimer();
                        } else if (isLastSetOfGroup && hasNextGroup && workout.trainingFormat === "gym") {
                          startRestTimer(REST_BETWEEN_EXERCISES_SECONDS, "exercise");
                        } else {
                          startRestTimer(set.restSeconds, "set");
                        }
                        offerUndo(set.id);
                      }}
                      className={clsx(
                        "flex w-full items-center justify-between rounded-md border px-3.5 py-2.5 text-left transition",
                        done
                          ? "border-volt-400/40 bg-volt-400/5"
                          : locked
                            ? "cursor-not-allowed border-ink-800 opacity-40"
                            : "border-ink-700 hover:border-ink-500",
                      )}
                    >
                      <p className="text-sm">
                        <span className="text-neutral-500">{t("workout.set", { number: i + 1 })}:</span>{" "}
                        {set.reps
                          ? t("workout.reps", { count: set.reps })
                          : set.durationSeconds
                            ? `${set.durationSeconds}s`
                            : // Составные "финишеры"/круги без числовых reps/duration —
                              // вся инструкция только в notes (напр. "30 сек высокий темп /
                              // 60 сек спокойно ×7"). Раньше здесь падало в `${null}s` = "nulls".
                              set.notes || t("workout.setLabel")}
                        <span className="text-neutral-500"> · {t("workout.rest", { count: set.restSeconds })}</span>
                      </p>
                      <div
                        className={clsx(
                          "flex h-6 w-6 shrink-0 items-center justify-center rounded-full border",
                          done ? "border-volt-400 bg-volt-400 text-ink-950" : "border-ink-600",
                        )}
                      >
                        {done && <Check size={14} strokeWidth={3} />}
                      </div>
                    </button>
                  );
                })}
              </div>

              {isWeighted && (
                <div className="mt-3 border-t border-ink-700 pt-3">
                  <label className="mb-1.5 block text-xs font-medium text-neutral-400">
                    {t("workout.workingWeight")}
                  </label>
                  <input
                    type="number"
                    inputMode="decimal"
                    placeholder={lastWeight ? String(lastWeight) : (t("workout.weightPlaceholder") as string)}
                    value={weights[group.exercise.id] ?? ""}
                    onChange={(e) =>
                      setWeights((prev) => ({ ...prev, [group.exercise.id]: e.target.value }))
                    }
                    className="input-field w-40 py-1.5 text-sm"
                  />
                  {lastWeight != null && (
                    <p className="mt-1.5 flex items-center gap-1 text-xs text-volt-400">
                      <TrendingUp size={12} />
                      {t("workout.lastTime", {
                        weight: lastWeight,
                        next: (lastWeight + 2.5).toString().replace(".", ","),
                      })}
                    </p>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {activeVideo &&
        (() => {
          const youtubeEmbedUrl = getYouTubeEmbedUrl(activeVideo.videoUrl);
          return (
            <div
              className={clsx(
                "fixed inset-0 z-50 flex items-center justify-center bg-black/80 p-4 transition-opacity duration-200",
                videoClosing ? "opacity-0" : "animate-fade-in opacity-100",
              )}
              onClick={closeVideo}
            >
              <div
                className={clsx(
                  "w-full max-w-md transition-all duration-200 ease-out",
                  videoClosing ? "translate-y-3 scale-[0.97] opacity-0" : "translate-y-0 scale-100 opacity-100",
                )}
                onClick={(e) => e.stopPropagation()}
              >
                <div className="mb-2 flex items-center justify-between gap-3">
                  <p className="truncate font-semibold text-neutral-100">
                    {localizedOf(activeVideo, "title", i18n.language)}
                  </p>
                  <button
                    onClick={closeVideo}
                    aria-label={t("common.close")}
                    className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-ink-800 text-neutral-300 transition hover:bg-ink-700 hover:text-neutral-100 active:scale-90"
                  >
                    <X size={16} strokeWidth={2.5} />
                  </button>
                </div>

                <div className="overflow-hidden rounded-lg border border-ink-700 bg-black shadow-2xl">
                  {youtubeEmbedUrl ? (
                    <div className="aspect-video w-full">
                      <iframe
                        src={youtubeEmbedUrl}
                        className="h-full w-full"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowFullScreen
                      />
                    </div>
                  ) : (
                    <video src={activeVideo.videoUrl} controls autoPlay className="w-full" />
                  )}
                </div>
              </div>
            </div>
          );
        })()}

      <div className="fixed inset-x-0 bottom-0 z-40">
        {undoSetId && !restOverlayOpen && (
          <div className="border-t border-ink-700 bg-ink-800/95 px-5 py-2.5 backdrop-blur animate-fade-in">
            <div className="mx-auto flex max-w-md items-center justify-between gap-3 text-sm">
              <span className="flex items-center gap-2 text-neutral-300">
                <Check size={16} className="text-volt-400" /> {t("workout.setMarked")}
              </span>
              <button
                onClick={undoLastSet}
                className="shrink-0 rounded-full px-3 py-1 font-semibold text-volt-400 hover:bg-ink-700"
              >
                {t("workout.undo")}
              </button>
            </div>
          </div>
        )}
        {restState && !restExpanded && (
          <div className="border-t border-ink-700 bg-ink-900/95 px-5 py-3 backdrop-blur animate-fade-in">
            <div
              className="mx-auto flex max-w-md cursor-pointer items-center gap-3"
              role="button"
              tabIndex={0}
              aria-label={t("workout.restExpand")}
              onClick={() => setRestExpanded(true)}
              onKeyDown={(e) => {
                if (e.key === "Enter" || e.key === " ") setRestExpanded(true);
              }}
            >
              <Timer size={18} className="shrink-0 text-volt-400" />
              <div className="min-w-0 flex-1">
                <div className="flex items-center justify-between text-sm">
                  <span className="font-medium text-neutral-200">
                    {restState.kind === "exercise" ? t("workout.restingNextExercise") : t("workout.resting")}
                  </span>
                  <span className="font-display text-lg font-bold tabular-nums text-volt-400">
                    {Math.floor(restRemaining / 60)}:{String(restRemaining % 60).padStart(2, "0")}
                  </span>
                </div>
                <div className="mt-1.5 h-1.5 overflow-hidden rounded-full bg-ink-700">
                  <div
                    className="h-full rounded-full bg-volt-400 transition-all duration-1000 ease-linear"
                    style={{ width: `${(restRemaining / restState.total) * 100}%` }}
                  />
                </div>
              </div>
              <button
                onClick={(e) => {
                  e.stopPropagation();
                  skipRestTimer();
                }}
                className="shrink-0 rounded-full p-1.5 text-neutral-400 hover:bg-ink-800 hover:text-neutral-200"
                aria-label={t("workout.skipRest")}
              >
                <X size={16} />
              </button>
            </div>
          </div>
        )}

        <div className="border-t border-ink-700 bg-ink-950/95 p-5 backdrop-blur">
          {finishMutation.isError && (
            <div className="mx-auto mb-3 max-w-md rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              {finishMutation.error instanceof Error
                ? finishMutation.error.message
                : t("errors.workoutSaveFailed")}
            </div>
          )}
          <button
            onClick={() => finishMutation.mutate()}
            disabled={!allDone || finishMutation.isPending}
            className="btn-primary mx-auto block w-full max-w-md"
          >
            {finishMutation.isPending
              ? t("workout.saving")
              : allDone
                ? t("workout.finishWorkout")
                : t("workout.remaining", { count: workout.sets.filter((s) => !completedIds.has(s.id)).length })}
          </button>
        </div>
      </div>

      {restState && restExpanded && (
        <RestTimerOverlay
          kind={restState.kind}
          remaining={restRemaining}
          total={restState.total}
          nextLabel={nextLabel}
          onSkip={skipRestTimer}
          onAddTime={addRestTime}
          onMinimize={() => setRestExpanded(false)}
          onUndo={undoSetId ? undoLastSet : undefined}
        />
      )}

      {confirmExit && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4"
          onClick={() => setConfirmExit(false)}
        >
          <div className="w-full max-w-sm rounded-lg border border-ink-700 bg-ink-900 p-6 text-center" onClick={(e) => e.stopPropagation()}>
            <p className="font-semibold">{t("workout.confirmExitTitle")}</p>
            <p className="mt-1.5 text-sm text-neutral-400">{t("workout.confirmExitBody")}</p>
            <div className="mt-5 flex gap-3">
              <button onClick={() => setConfirmExit(false)} className="btn-secondary flex-1">
                {t("workout.confirmExitStay")}
              </button>
              <button
                onClick={() => {
                  clearWorkoutSession(workoutId);
                  navigate(-1);
                }}
                className="flex-1 rounded-md bg-danger px-5 py-3 font-medium text-neutral-0 transition hover:bg-danger/90"
              >
                {t("workout.confirmExitLeave")}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
