// Отправка ошибок из браузера в журнал (таблица app_errors, миграция 0093).
// Общий код для приложения, лендинга и админки: каждое приложение передаёт
// свою функцию отправки (supabase.rpc("log_client_error", …)).
//
// Что НЕ уходит в журнал: адрес страницы — без параметров (?…, #…), из
// текстов вырезаются токены, email и длинные числа (номера карт и т.п.).
// Ограничения: одна и та же ошибка — не чаще раза в минуту, не больше 25
// записей за загрузку страницы. Шум браузеров и расширений отбрасывается.

export type ErrorApp = "web" | "landing" | "admin";
export type ErrorLevel = "warning" | "error" | "critical";

export interface ClientErrorRow {
  p_app: ErrorApp;
  p_level: ErrorLevel;
  p_message: string;
  p_stack: string | null;
  p_url: string | null;
  p_user_agent: string | null;
  p_app_version: string | null;
  p_context: Record<string, unknown> | null;
}

export interface ErrorReporterOptions {
  app: ErrorApp;
  version: string;
  send: (row: ClientErrorRow) => PromiseLike<unknown>;
}

export interface ReportOptions {
  level?: ErrorLevel;
  context?: Record<string, unknown>;
}

const IGNORE = [
  /ResizeObserver loop/i,
  /^Script error\.?$/i,
  /chrome-extension:|moz-extension:|safari-(web-)?extension:/i,
  /Non-Error promise rejection captured/i,
  /AbortError|The operation was aborted|signal is aborted/i,
  /webkit\.messageHandlers/i,
  /instagram|fbq is not defined|__gCrWeb/i,
];

/** Ошибки сети: у человека пропал интернет — это не баг сайта, но знать полезно */
const NETWORK = /Failed to fetch|Load failed|NetworkError|Network request failed|ERR_INTERNET_DISCONNECTED/i;
/** После деплоя старая вкладка просит удалённые файлы — важно видеть */
const CHUNK = /dynamically imported module|Importing a module script failed|ChunkLoadError|Loading chunk/i;

export function scrubText(text: string): string {
  return text
    .replace(/(access_token|refresh_token|token|apikey|password|code)=([^&\s"']+)/gi, "$1=[скрыто]")
    .replace(/Bearer\s+[A-Za-z0-9._-]+/g, "Bearer [скрыто]")
    .replace(/eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g, "[jwt]")
    .replace(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/g, "[email]")
    .replace(/\b\d{12,19}\b/g, "[число]");
}

function describe(err: unknown): { message: string; stack: string | null } {
  if (err instanceof Error) {
    return { message: `${err.name && err.name !== "Error" ? `${err.name}: ` : ""}${err.message}`, stack: err.stack ?? null };
  }
  if (typeof err === "string") return { message: err, stack: null };
  if (err && typeof err === "object") {
    const o = err as { message?: unknown; code?: unknown; details?: unknown; hint?: unknown };
    if (typeof o.message === "string") {
      // Ошибки Supabase/PostgREST: { message, code, details, hint }
      const extra = [o.code, o.details, o.hint].filter((x) => typeof x === "string" && x).join(" · ");
      return { message: extra ? `${o.message} (${extra})` : o.message, stack: null };
    }
    try {
      return { message: JSON.stringify(err).slice(0, 500), stack: null };
    } catch {
      /* ниже */
    }
  }
  return { message: String(err), stack: null };
}

export function createErrorReporter(opts: ErrorReporterOptions) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const g = globalThis as any;
  const lastSent = new Map<string, number>();
  let sentCount = 0;

  function report(err: unknown, options: ReportOptions = {}) {
    try {
      const { message: rawMessage, stack } = describe(err);
      if (!rawMessage || IGNORE.some((re) => re.test(rawMessage) || (stack ? re.test(stack) : false))) return;

      let level: ErrorLevel = options.level ?? "error";
      const context: Record<string, unknown> = { ...(options.context ?? {}) };
      if (NETWORK.test(rawMessage)) {
        level = "warning";
        context.online = g.navigator?.onLine;
      }
      if (CHUNK.test(rawMessage)) context.kind = "old-version-after-deploy";

      const message = scrubText(rawMessage).slice(0, 1000);
      const key = `${level}:${message}`;
      const now = Date.now();
      if ((lastSent.get(key) ?? 0) > now - 60_000) return;
      if (sentCount >= 25) return;
      lastSent.set(key, now);
      sentCount += 1;

      const loc = g.location as { origin?: string; pathname?: string } | undefined;
      const row: ClientErrorRow = {
        p_app: opts.app,
        p_level: level,
        p_message: message,
        p_stack: stack ? scrubText(stack).slice(0, 4000) : null,
        p_url: loc ? `${loc.origin ?? ""}${loc.pathname ?? ""}` : null,
        p_user_agent: typeof g.navigator?.userAgent === "string" ? g.navigator.userAgent : null,
        p_app_version: opts.version,
        p_context: Object.keys(context).length ? JSON.parse(scrubText(JSON.stringify(context))) : null,
      };
      Promise.resolve(opts.send(row)).then(undefined, () => {});
    } catch {
      // журнал ошибок никогда не должен ломать сайт
    }
  }

  /** Ловит всё, что не поймал код: window.onerror и необработанные промисы */
  function install() {
    if (!g.addEventListener) return;
    g.addEventListener("error", (event: { message?: string; error?: unknown; filename?: string; lineno?: number }) => {
      // Ошибки загрузки картинок/скриптов тоже приходят сюда — без message
      if (!event.error && !event.message) return;
      report(event.error ?? event.message, {
        context: event.filename ? { file: event.filename.split("?")[0], line: event.lineno } : undefined,
      });
    });
    g.addEventListener("unhandledrejection", (event: { reason?: unknown }) => {
      report(event.reason, { context: { kind: "unhandled-promise" } });
    });
  }

  return { report, install };
}
