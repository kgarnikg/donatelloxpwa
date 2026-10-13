import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import clsx from "clsx";
import { Check, ChevronDown, ChevronUp, RotateCcw } from "lucide-react";
import { supabase } from "@/lib/supabase";

/**
 * Журнал ошибок (0093). Сюда пишут приложение, сайт, админка и серверные
 * функции (оплата, письма, cron). Одинаковые ошибки собраны в группы.
 * «Решено» скрывает группу, пока ошибка не повторится снова.
 * Записи хранятся 90 дней.
 */

type Level = "warning" | "error" | "critical";
type App = "web" | "landing" | "admin" | "api";

interface ErrorGroup {
  fingerprint: string;
  app: App;
  source: string | null;
  level: Level;
  message: string;
  occurrences: number;
  users: number;
  first_seen: string;
  last_seen: string;
  last_url: string | null;
  last_version: string | null;
  resolved_at: string | null;
}

interface ErrorRow {
  id: number;
  created_at: string;
  app: App;
  level: Level;
  source: string | null;
  message: string;
  stack: string | null;
  url: string | null;
  user_agent: string | null;
  app_version: string | null;
  context: Record<string, unknown> | null;
  user: { email: string | null; first_name: string | null; last_name: string | null; full_name: string | null } | null;
}

const PERIODS = [
  { key: 1, label: "24 часа" },
  { key: 7, label: "7 дней" },
  { key: 30, label: "30 дней" },
  { key: 90, label: "90 дней" },
] as const;

const APPS: { key: App | "all"; label: string }[] = [
  { key: "all", label: "Всё" },
  { key: "web", label: "Приложение" },
  { key: "landing", label: "Сайт" },
  { key: "admin", label: "Админка" },
  { key: "api", label: "Сервер" },
];

const APP_LABEL: Record<App, string> = {
  web: "Приложение",
  landing: "Сайт",
  admin: "Админка",
  api: "Сервер",
};

const LEVEL_LABEL: Record<Level, string> = {
  critical: "Критично",
  error: "Ошибка",
  warning: "Предупреждение",
};

const LEVEL_BADGE: Record<Level, string> = {
  critical: "bg-danger/15 text-danger",
  error: "bg-warning/15 text-warning",
  warning: "bg-neutral-600/20 text-neutral-400",
};

function ago(iso: string): string {
  const min = Math.round((Date.now() - new Date(iso).getTime()) / 60000);
  if (min < 1) return "только что";
  if (min < 60) return `${min} мин назад`;
  const h = Math.round(min / 60);
  if (h < 24) return `${h} ч назад`;
  return `${Math.round(h / 24)} дн назад`;
}

function dateTime(iso: string): string {
  return new Date(iso).toLocaleString("ru-RU", {
    day: "numeric",
    month: "short",
    hour: "2-digit",
    minute: "2-digit",
  });
}

function path(url: string | null): string {
  if (!url) return "—";
  try {
    const u = new URL(url);
    return `${u.hostname.replace(/^www\./, "")}${u.pathname}`;
  } catch {
    return url;
  }
}

/** Коротко об устройстве: «iPhone · Safari 18», «Windows · Chrome 129» */
function deviceOf(ua: string | null): string {
  if (!ua) return "—";
  const os = /iPhone/.test(ua)
    ? "iPhone"
    : /iPad/.test(ua)
      ? "iPad"
      : /Android/.test(ua)
        ? "Android"
        : /Mac OS X/.test(ua)
          ? "Mac"
          : /Windows/.test(ua)
            ? "Windows"
            : /Linux/.test(ua)
              ? "Linux"
              : "?";
  const map: Record<string, string> = {
    Edg: "Edge",
    OPR: "Opera",
    SamsungBrowser: "Samsung",
    CriOS: "Chrome",
    FxiOS: "Firefox",
  };
  const m = ua.match(/(Edg|OPR|SamsungBrowser|CriOS|FxiOS|Firefox|Chrome)\/(\d+)/);
  const safari = ua.match(/Version\/(\d+)[^ ]* (Mobile\/\S+ )?Safari/);
  const name = m ? `${map[m[1]] ?? m[1]} ${m[2]}` : safari ? `Safari ${safari[1]}` : "";
  const inApp = /Instagram|FBAN|FBAV|Telegram/.test(ua) ? " (в приложении соцсети)" : "";
  return [os, name].filter(Boolean).join(" · ") + inApp;
}

function userName(u: ErrorRow["user"]): string {
  if (!u) return "гость";
  const name = [u.first_name, u.last_name].filter(Boolean).join(" ") || u.full_name;
  return [name, u.email].filter(Boolean).join(" · ") || "пользователь";
}

export default function ErrorsPage() {
  const [days, setDays] = useState<number>(7);
  const [app, setApp] = useState<App | "all">("all");
  const [showResolved, setShowResolved] = useState(false);
  const [onlySerious, setOnlySerious] = useState(false);

  const { data: groups, isLoading, error } = useQuery({
    queryKey: ["admin-errors", days, app, showResolved],
    refetchInterval: 60_000,
    queryFn: async (): Promise<ErrorGroup[]> => {
      const { data, error } = await supabase.rpc("admin_error_groups", {
        p_since: new Date(Date.now() - days * 24 * 60 * 60 * 1000).toISOString(),
        p_app: app === "all" ? null : app,
        p_include_resolved: showResolved,
      });
      if (error) throw error;
      return (data ?? []) as ErrorGroup[];
    },
  });

  const list = (groups ?? []).filter((g) => !onlySerious || g.level !== "warning");
  const critical = list.filter((g) => g.level === "critical").length;
  const total = list.reduce((sum, g) => sum + Number(g.occurrences), 0);

  return (
    <div>
      <h1 className="font-display text-2xl font-bold">Ошибки</h1>
      <p className="mt-1 max-w-3xl text-neutral-400">
        Сбои в приложении, на сайте, в админке и на сервере (оплата, письма). Одинаковые ошибки собраны вместе.
        О критичных ошибках сервера сразу приходит письмо. «Решено» прячет ошибку, пока она не повторится. Записи
        хранятся 90 дней.
      </p>

      <div className="mt-4 flex flex-wrap gap-2">
        {PERIODS.map((p) => (
          <Chip key={p.key} active={days === p.key} onClick={() => setDays(p.key)}>
            {p.label}
          </Chip>
        ))}
        <span className="mx-1 hidden w-px bg-ink-700 sm:block" />
        {APPS.map((a) => (
          <Chip key={a.key} active={app === a.key} onClick={() => setApp(a.key)}>
            {a.label}
          </Chip>
        ))}
      </div>
      <div className="mt-3 flex flex-wrap gap-4 text-sm text-neutral-400">
        <label className="flex items-center gap-2">
          <input type="checkbox" checked={onlySerious} onChange={(e) => setOnlySerious(e.target.checked)} />
          Без предупреждений (сеть и т.п.)
        </label>
        <label className="flex items-center gap-2">
          <input type="checkbox" checked={showResolved} onChange={(e) => setShowResolved(e.target.checked)} />
          Показать решённые
        </label>
      </div>

      {error && (
        <div className="mt-6 rounded-md border border-danger/30 bg-danger/10 px-4 py-3 text-sm text-danger">
          Не удалось загрузить журнал. Проверьте, что миграция 0093 выполнена в Supabase.
        </div>
      )}

      {!isLoading && !error && (
        <p className="mt-6 text-sm text-neutral-400">
          Групп: <b className="text-neutral-100">{list.length}</b> · случаев: <b className="text-neutral-100">{total}</b>
          {critical > 0 && (
            <>
              {" "}
              · критичных: <b className="text-danger">{critical}</b>
            </>
          )}
        </p>
      )}

      <div className="mt-4 space-y-3">
        {isLoading && <div className="h-32 animate-pulse rounded-lg bg-ink-900" />}
        {!isLoading && !error && list.length === 0 && (
          <p className="py-10 text-center text-neutral-500">Ошибок нет</p>
        )}
        {list.map((g) => (
          <GroupCard key={g.fingerprint} group={g} />
        ))}
      </div>
    </div>
  );
}

function Chip({ active, onClick, children }: { active: boolean; onClick: () => void; children: React.ReactNode }) {
  return (
    <button
      onClick={onClick}
      className={clsx(
        "rounded-full border px-3.5 py-1.5 text-sm font-medium transition",
        active ? "border-volt-400 bg-volt-400/10 text-volt-400" : "border-ink-600 text-neutral-400 hover:border-ink-500",
      )}
    >
      {children}
    </button>
  );
}

function GroupCard({ group: g }: { group: ErrorGroup }) {
  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const resolved = !!g.resolved_at && new Date(g.last_seen) <= new Date(g.resolved_at);

  const resolve = useMutation({
    mutationFn: async (value: boolean) => {
      const { error } = await supabase.rpc("admin_resolve_error", { p_fingerprint: g.fingerprint, p_resolved: value });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-errors"] });
      queryClient.invalidateQueries({ queryKey: ["admin-errors-badge"] });
    },
  });

  const { data: rows, isLoading } = useQuery({
    queryKey: ["admin-error-rows", g.fingerprint],
    enabled: open,
    queryFn: async (): Promise<ErrorRow[]> => {
      const { data, error } = await supabase
        .from("app_errors")
        .select(
          "id, created_at, app, level, source, message, stack, url, user_agent, app_version, context, user:users(email, first_name, last_name, full_name)",
        )
        .eq("fingerprint", g.fingerprint)
        .order("created_at", { ascending: false })
        .limit(20);
      if (error) throw error;
      return (data ?? []) as unknown as ErrorRow[];
    },
  });

  return (
    <div className={clsx("rounded-lg border bg-ink-900 p-4", resolved ? "border-ink-700 opacity-60" : "border-ink-700")}>
      <div className="flex flex-wrap items-center gap-2 text-xs">
        <span className={clsx("rounded-full px-2 py-0.5 font-semibold", LEVEL_BADGE[g.level])}>{LEVEL_LABEL[g.level]}</span>
        <span className="rounded-full bg-ink-800 px-2 py-0.5 text-neutral-300">
          {APP_LABEL[g.app]}
          {g.source ? ` · ${g.source}` : ""}
        </span>
        {resolved && <span className="rounded-full bg-success/10 px-2 py-0.5 text-success">Решено</span>}
        <span className="ml-auto text-neutral-500">{ago(g.last_seen)}</span>
      </div>

      <p className="mt-2 break-words font-mono text-sm text-neutral-100">{g.message}</p>

      <div className="mt-2 flex flex-wrap gap-x-4 gap-y-1 text-xs text-neutral-400">
        <span>
          <b className="text-neutral-200">{g.occurrences}</b> раз · <b className="text-neutral-200">{g.users}</b> чел.
        </span>
        <span>впервые: {dateTime(g.first_seen)}</span>
        <span className="truncate">стр.: {path(g.last_url)}</span>
        {g.last_version && <span>версия: {g.last_version}</span>}
      </div>

      <div className="mt-3 flex flex-wrap gap-2">
        <button
          onClick={() => setOpen((v) => !v)}
          className="flex items-center gap-1 rounded-md border border-ink-600 px-3 py-1.5 text-sm text-neutral-300 hover:border-ink-500"
        >
          {open ? <ChevronUp size={14} /> : <ChevronDown size={14} />} Подробнее
        </button>
        {resolved ? (
          <button
            onClick={() => resolve.mutate(false)}
            disabled={resolve.isPending}
            className="flex items-center gap-1 rounded-md border border-ink-600 px-3 py-1.5 text-sm text-neutral-300 hover:border-ink-500"
          >
            <RotateCcw size={14} /> Вернуть
          </button>
        ) : (
          <button
            onClick={() => resolve.mutate(true)}
            disabled={resolve.isPending}
            className="flex items-center gap-1 rounded-md border border-success/40 px-3 py-1.5 text-sm text-success hover:bg-success/10"
          >
            <Check size={14} /> Решено
          </button>
        )}
      </div>

      {open && (
        <div className="mt-4 space-y-3 border-t border-ink-700 pt-4">
          {isLoading && <div className="h-16 animate-pulse rounded bg-ink-800" />}
          {(rows ?? []).map((r) => (
            <div key={r.id} className="rounded-md bg-ink-950 p-3 text-xs">
              <div className="flex flex-wrap gap-x-4 gap-y-1 text-neutral-400">
                <span className="text-neutral-200">{dateTime(r.created_at)}</span>
                <span>{userName(r.user)}</span>
                <span>{deviceOf(r.user_agent)}</span>
                <span>{path(r.url)}</span>
                {r.app_version && <span>версия {r.app_version}</span>}
              </div>
              {r.message !== g.message && <p className="mt-1 break-words font-mono text-neutral-300">{r.message}</p>}
              {r.context && (
                <pre className="mt-2 overflow-x-auto whitespace-pre-wrap break-words text-neutral-400">
                  {JSON.stringify(r.context, null, 2)}
                </pre>
              )}
              {r.stack && (
                <details className="mt-2">
                  <summary className="cursor-pointer text-neutral-500">Стек вызовов</summary>
                  <pre className="mt-1 overflow-x-auto whitespace-pre-wrap break-words text-neutral-500">{r.stack}</pre>
                </details>
              )}
            </div>
          ))}
          {rows && rows.length === 20 && (
            <p className="text-center text-xs text-neutral-500">Показаны последние 20 случаев</p>
          )}
        </div>
      )}
    </div>
  );
}
