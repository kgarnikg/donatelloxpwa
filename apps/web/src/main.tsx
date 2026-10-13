import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import {
  MutationCache,
  QueryCache,
  QueryClient,
  QueryClientProvider,
} from "@tanstack/react-query";
import { setupPwaAutoUpdate } from "@/lib/pwaUpdate";
import { initInstallCapture } from "@/lib/install";
import { AuthProvider } from "@/context/AuthContext";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { installErrorLog, reportError } from "@/lib/errorLog";
import App from "./App";
import "./index.css";
import "./i18n";

// Автообновление после деплоя: проверка при каждом возврате в приложение
// и раз в 5 минут, применение — сразу, но не посреди тренировки.
// Подробности — в lib/pwaUpdate.ts.
setupPwaAutoUpdate();
// "Установить на главный экран": событие Android/Chrome приходит рано
initInstallCapture();
// Журнал ошибок (0093): всё необработанное уходит в админку → «Ошибки»
installErrorLog();

const queryClient = new QueryClient({
  // Ошибки загрузки/сохранения данных — тоже в журнал (с ключом запроса)
  queryCache: new QueryCache({
    onError: (error, query) =>
      reportError(error, {
        context: { query: JSON.stringify(query.queryKey).slice(0, 200) },
      }),
  }),
  mutationCache: new MutationCache({
    onError: (error, _vars, _ctx, mutation) =>
      reportError(error, {
        context: {
          mutation: JSON.stringify(
            mutation.options.mutationKey ?? "mutation",
          ).slice(0, 200),
        },
      }),
  }),
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
    <ErrorBoundary>
      <QueryClientProvider client={queryClient}>
        <BrowserRouter>
          <AuthProvider>
            <App />
          </AuthProvider>
        </BrowserRouter>
      </QueryClientProvider>
    </ErrorBoundary>
  </StrictMode>,
);
