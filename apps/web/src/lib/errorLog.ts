import { createErrorReporter } from "@donatellox/types";
import { supabase } from "@/lib/supabase";

/**
 * Журнал ошибок (миграция 0093, раздел «Ошибки» в админке).
 * reportError(err, { context }) — записать вручную; installErrorLog() в
 * main.tsx ловит всё необработанное.
 */
const reporter = createErrorReporter({
  app: "web",
  version: __APP_VERSION__,
  send: (row) => supabase.rpc("log_client_error", row),
});

export const reportError = reporter.report;
export const installErrorLog = reporter.install;
