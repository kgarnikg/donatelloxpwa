import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import {
  MutationCache,
  QueryCache,
  QueryClient,
  QueryClientProvider,
} from "@tanstack/react-query";
import { AuthProvider } from "@/context/AuthContext";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { installErrorLog, reportError } from "@/lib/errorLog";
import App from "./App";
import "./index.css";

// Журнал ошибок (0093): всё необработанное → раздел «Ошибки»
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
      staleTime: 30_000,
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
