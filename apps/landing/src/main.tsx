import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { registerSW } from "virtual:pwa-register";
import { Analytics } from "@vercel/analytics/react";
import App from "./App";
import "./index.css";
import "./i18n";

// Автообновление после деплоя (autoUpdate): браузер сам проверяет новый
// service worker только при загрузке страницы, поэтому дополнительно
// проверяем при возврате на вкладку и раз в 5 минут — новая версия
// применяется перезагрузкой. На лендинге нечего терять, в отличие от
// плеера тренировки в apps/web (см. apps/web/src/lib/pwaUpdate.ts).
registerSW({
  immediate: true,
  onRegisteredSW(swUrl, registration) {
    if (!registration) return;
    const check = () => {
      if (!navigator.onLine) return;
      fetch(swUrl, { cache: "no-store" })
        .then((res) => (res.status === 200 ? registration.update() : undefined))
        .catch(() => {});
    };
    setInterval(check, 5 * 60 * 1000);
    document.addEventListener("visibilitychange", () => {
      if (document.visibilityState === "visible") check();
    });
  },
});

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <BrowserRouter>
      <App />
      {/* Vercel Web Analytics — бесплатно до 50 000 событий/мес на Hobby-
          тарифе, без cookies. Компонент сам подхватывает домен на Vercel и
          ничего не делает при локальной разработке (не шлёт события). */}
      <Analytics />
    </BrowserRouter>
  </StrictMode>,
);
