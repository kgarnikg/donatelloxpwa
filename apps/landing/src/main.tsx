import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { registerSW } from "virtual:pwa-register";
import { Analytics } from "@vercel/analytics/react";
import App from "./App";
import "./index.css";
import "./i18n";

// См. подробный комментарий в apps/web/src/main.tsx — без этого вызова
// service worker обновляется "молча" и уже открытая вкладка не подхватывает
// новую версию сама.
registerSW({ immediate: true });

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
