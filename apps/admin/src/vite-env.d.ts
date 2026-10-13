/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_SUPABASE_URL: string;
  readonly VITE_SUPABASE_ANON_KEY: string;
  readonly VITE_APP_ENV?: "development" | "staging" | "production";
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

/** Версия сборки (коммит), задаётся в vite.config.ts */
declare const __APP_VERSION__: string;
