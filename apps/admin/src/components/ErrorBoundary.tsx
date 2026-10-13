import { Component, type ErrorInfo, type ReactNode } from "react";
import { reportError } from "@/lib/errorLog";

/** Упала отрисовка — показываем «Обновить» и пишем ошибку в журнал */
export class ErrorBoundary extends Component<{ children: ReactNode }, { failed: boolean }> {
  state = { failed: false };

  static getDerivedStateFromError() {
    return { failed: true };
  }

  componentDidCatch(error: Error, info: ErrorInfo) {
    reportError(error, {
      level: "critical",
      context: { kind: "render-crash", component: info.componentStack?.split("\n").slice(0, 6).join("\n") },
    });
  }

  render() {
    if (!this.state.failed) return this.props.children;
    return (
      <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
        <h1 className="font-display text-2xl font-bold">Что-то пошло не так</h1>
        <p className="mt-2 max-w-sm text-neutral-400">Ошибка уже записана в журнал. Обновите страницу.</p>
        <button type="button" onClick={() => window.location.reload()} className="btn-primary mt-6">
          Обновить
        </button>
      </div>
    );
  }
}
