import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { setupPwaAutoUpdate } from "@/lib/pwaUpdate";
import { initInstallCapture } from "@/lib/install";
import { AuthProvider } from "@/context/AuthContext";
import App from "./App";
import "./index.css";
import "./i18n";

// Автообновление после деплоя: проверка при каждом возврате в приложение
// и раз в 5 минут, применение — сразу, но не посреди тренировки.
// Подробности — в lib/pwaUpdate.ts.
setupPwaAutoUpdate();
// "Установить на главный экран": событие Android/Chrome приходит рано
initInstallCapture();

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
