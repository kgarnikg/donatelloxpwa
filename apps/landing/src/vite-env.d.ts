/// <reference types="vite/client" />
/// <reference types="vite-plugin-pwa/client" />

interface ImportMetaEnv {
  readonly VITE_WEB_APP_URL: string;
  readonly VITE_APP_ENV?: "development" | "staging" | "production";
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

/** Версия сборки (коммит), задаётся в vite.config.ts */
declare const __APP_VERSION__: string;
