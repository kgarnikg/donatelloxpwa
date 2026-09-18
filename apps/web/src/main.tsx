import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { registerSW } from "virtual:pwa-register";
import { AuthProvider } from "@/context/AuthContext";
import App from "./App";
import "./index.css";
import "./i18n";

// Без этого вызова конфигурация skipWaiting/clientsClaim в vite.config.ts
// (workbox) обновляет service worker "в фоне", но уже открытая вкладка не
// узнаёт об этом сама и продолжает работать со старым кэшем, пока
// пользователь не закроет и не откроет приложение заново вручную —
// именно так и проявлялось "ничего не поменялось после деплоя".
// registerSW с registerType: "autoUpdate" сам следит за новой версией и
// перезагружает страницу, как только она готова — без участия пользователя.
registerSW({ immediate: true });

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 60_000,
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
});

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        <AuthProvider>
          <App />
        </AuthProvider>
      </BrowserRouter>
    </QueryClientProvider>
  </StrictMode>,
);
