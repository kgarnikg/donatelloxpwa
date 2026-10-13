import { Component, type ErrorInfo, type ReactNode } from "react";
import i18n from "@/i18n";
import { reportError } from "@/lib/errorLog";

/**
 * Если страница упала при отрисовке — вместо белого экрана показываем
 * «Что-то пошло не так» с кнопкой «Обновить», а ошибку пишем в журнал.
 */
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
        <h1 className="font-display text-2xl font-bold">{i18n.t("errorBoundary.title")}</h1>
        <p className="mt-2 max-w-sm text-neutral-400">{i18n.t("errorBoundary.text")}</p>
        <button type="button" onClick={() => window.location.reload()} className="btn-primary mt-6">
          {i18n.t("errorBoundary.reload")}
        </button>
      </div>
    );
  }
}
