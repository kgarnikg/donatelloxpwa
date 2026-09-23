import { registerSW } from "virtual:pwa-register";

/**
 * Автообновление PWA — чтобы после деплоя пользователь получал новую
 * версию сам, без "закрой и открой приложение дважды".
 *
 * Почему раньше не работало: браузер проверяет, не вышел ли новый
 * service worker, только при переходах/загрузке страницы и не чаще раза в
 * сутки. PWA на iPhone почти никогда не перезагружается — её сворачивают
 * и разворачивают — поэтому проверка просто не происходила и Safari
 * часами показывал старую сборку.
 *
 * Что делаем:
 * 1. Сами проверяем обновление — при каждом возврате в приложение
 *    (visibilitychange/focus), при появлении сети и раз в 5 минут.
 * 2. Новая версия нашлась → применяем её (перезагрузка) сразу, НО не
 *    посреди тренировки: на /workout/... отмеченные подходы живут только в
 *    памяти страницы и пропали бы. Там ждём, пока человек выйдет из плеера.
 * 3. vercel.json: sw.js и index.html отдаются с no-cache, чтобы проверка
 *    всегда видела свежий файл, а не копию из HTTP-кэша.
 */

const CHECK_INTERVAL_MS = 5 * 60 * 1000;
/** Не чаще раза в N мс — visibilitychange и focus часто приходят парой. */
const MIN_CHECK_GAP_MS = 30 * 1000;

function isSafeToReload(): boolean {
  // Посреди тренировки перезагружать нельзя — потеряются отметки подходов
  return !window.location.pathname.startsWith("/workout/");
}

export function setupPwaAutoUpdate(): void {
  let updatePending = false;
  let lastCheck = 0;

  const updateSW = registerSW({
    immediate: true,
    onNeedRefresh() {
      updatePending = true;
      applyIfSafe();
    },
    onRegisteredSW(swUrl, registration) {
      if (!registration) return;

      const check = async () => {
        if (!navigator.onLine) return;
        if (Date.now() - lastCheck < MIN_CHECK_GAP_MS) return;
        lastCheck = Date.now();
        try {
          // Сначала убеждаемся, что сервер доступен (иначе update() в
          // офлайне кидает ошибку), и в обход HTTP-кэша
          const res = await fetch(swUrl, { cache: "no-store", headers: { "cache-control": "no-cache" } });
          if (res.status === 200) await registration.update();
        } catch {
          // Нет сети/сервер недоступен — попробуем при следующем случае
        }
      };

      setInterval(check, CHECK_INTERVAL_MS);
      document.addEventListener("visibilitychange", () => {
        if (document.visibilityState === "visible") {
          void check();
          applyIfSafe();
        }
      });
      window.addEventListener("focus", () => void check());
      window.addEventListener("online", () => void check());
    },
  });

  function applyIfSafe() {
    if (updatePending && isSafeToReload()) {
      updatePending = false;
      // skipWaiting для нового service worker + перезагрузка страницы
      void updateSW(true);
    }
  }

  // Человек вышел из плеера тренировки — применяем отложенное обновление.
  // React Router меняет адрес через history.pushState/replaceState, у
  // которых нет своих событий, — поэтому проверяем раз в несколько секунд
  // (дёшево, и только пока обновление реально ждёт).
  setInterval(() => {
    if (updatePending) applyIfSafe();
  }, 3000);
  window.addEventListener("popstate", applyIfSafe);
}
