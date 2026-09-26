/**
 * "Установить на главный экран" (PWA).
 *
 * iPhone: установить сайт как приложение можно ТОЛЬКО руками — "Поделиться"
 * → "На экран «Домой»" (системной кнопки у Safari нет), поэтому показываем
 * короткую инструкцию. Android/Chrome присылает событие beforeinstallprompt —
 * тогда достаточно нашей кнопки "Установить".
 *
 * Когда показываем сами (useAutoInstallPrompt):
 *   1) первый заход на главную после анкеты — человек уже вложился и
 *      увидел свой план (а не на экране входа, где просьба раздражает);
 *   2) сразу после первой завершённой тренировки — момент "мне понравилось";
 *   3) если закрыл — не чаще раза в 3 дня, максимум 3 раза, потом только
 *      из профиля ("Установить приложение").
 * Никогда — если приложение уже открыто с главного экрана.
 */

export type InstallPlatform =
  | "ios-safari" // iPhone/iPad, Safari
  | "ios-other" // iPhone, Chrome/Firefox/Edge — тоже умеют через "Поделиться"
  | "ios-inapp" // Instagram/Facebook/TikTok и т.п. — нужно открыть в Safari
  | "android" // Android (кнопка установки или меню ⋮)
  | "desktop";

interface BeforeInstallPromptEvent extends Event {
  prompt: () => Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
}

let deferredPrompt: BeforeInstallPromptEvent | null = null;
const listeners = new Set<() => void>();

/** Вызывается один раз при старте (main.tsx) — событие приходит рано. */
export function initInstallCapture() {
  if (typeof window === "undefined") return;
  window.addEventListener("beforeinstallprompt", (e) => {
    e.preventDefault();
    deferredPrompt = e as BeforeInstallPromptEvent;
    listeners.forEach((l) => l());
  });
  window.addEventListener("appinstalled", () => {
    deferredPrompt = null;
    savePrefs({ ...loadPrefs(), installed: true });
    listeners.forEach((l) => l());
  });
}

export function onInstallAvailabilityChange(cb: () => void): () => void {
  listeners.add(cb);
  return () => listeners.delete(cb);
}

export function canPromptNatively(): boolean {
  return deferredPrompt !== null;
}

/** Системное окно установки (Android/Chrome). true — установил. */
export async function promptNativeInstall(): Promise<boolean> {
  if (!deferredPrompt) return false;
  const event = deferredPrompt;
  deferredPrompt = null;
  await event.prompt();
  const choice = await event.userChoice.catch(() => ({ outcome: "dismissed" as const }));
  listeners.forEach((l) => l());
  return choice.outcome === "accepted";
}

export function isStandalone(): boolean {
  if (typeof window === "undefined") return false;
  return (
    window.matchMedia?.("(display-mode: standalone)").matches ||
    (navigator as Navigator & { standalone?: boolean }).standalone === true
  );
}

export function detectPlatform(): InstallPlatform {
  const ua = navigator.userAgent;
  const isIOS =
    /iPhone|iPad|iPod/i.test(ua) || (navigator.platform === "MacIntel" && navigator.maxTouchPoints > 1);
  if (isIOS) {
    if (/Instagram|FBAN|FBAV|FB_IAB|musical_ly|BytedanceWebview|Line\/|Snapchat|Pinterest|LinkedInApp|GSA\//i.test(ua)) {
      return "ios-inapp";
    }
    if (/CriOS|FxiOS|EdgiOS|OPiOS|YaBrowser/i.test(ua)) return "ios-other";
    return "ios-safari";
  }
  if (/Android/i.test(ua)) return "android";
  return "desktop";
}

// ---- Когда показывали / закрывали -----------------------------------------

const PREFS_KEY = "donatellex-install-prompt";
const JUST_FINISHED_KEY = "donatellex-just-finished-workout";

interface InstallPrefs {
  shownCount: number;
  lastShownAt: number;
  installed?: boolean;
}

function loadPrefs(): InstallPrefs {
  try {
    const raw = localStorage.getItem(PREFS_KEY);
    if (raw) return { shownCount: 0, lastShownAt: 0, ...(JSON.parse(raw) as Partial<InstallPrefs>) };
  } catch {
    // приватный режим — просто считаем, что не показывали
  }
  return { shownCount: 0, lastShownAt: 0 };
}

function savePrefs(p: InstallPrefs) {
  try {
    localStorage.setItem(PREFS_KEY, JSON.stringify(p));
  } catch {
    // не критично
  }
}

export function markInstallPromptShown() {
  const p = loadPrefs();
  savePrefs({ ...p, shownCount: p.shownCount + 1, lastShownAt: Date.now() });
}

/** Ставит плеер тренировки после сохранения — главная покажет подсказку. */
export function markWorkoutJustFinished() {
  try {
    sessionStorage.setItem(JUST_FINISHED_KEY, "1");
  } catch {
    // не критично
  }
}

function consumeJustFinished(): boolean {
  try {
    const v = sessionStorage.getItem(JUST_FINISHED_KEY) === "1";
    sessionStorage.removeItem(JUST_FINISHED_KEY);
    return v;
  } catch {
    return false;
  }
}

const MAX_AUTO_SHOWS = 3;
const MIN_GAP_MS = 3 * 24 * 60 * 60 * 1000;

/** Показывать ли подсказку автоматически прямо сейчас (на главной). */
export function shouldAutoShowInstall(): boolean {
  if (isStandalone()) return false;
  const platform = detectPlatform();
  if (platform === "desktop") return false;
  const p = loadPrefs();
  const justFinished = consumeJustFinished();
  if (p.installed || p.shownCount >= MAX_AUTO_SHOWS) return false;
  if (p.shownCount === 0) return true; // первый заход на главную
  if (justFinished && p.shownCount === 1) return true; // после первой тренировки
  return Date.now() - p.lastShownAt >= MIN_GAP_MS;
}
