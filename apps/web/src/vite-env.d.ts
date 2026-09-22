/// <reference types="vite/client" />
/// <reference types="vite-plugin-pwa/client" />

interface ImportMetaEnv {
  readonly VITE_SUPABASE_URL: string;
  readonly VITE_SUPABASE_ANON_KEY: string;
  readonly VITE_STRIPE_PUBLISHABLE_KEY?: string;
  /** "true" — включает кнопку оплаты (Фаза 3, после подключения vPOS Араратбанка). */
  readonly VITE_PAYMENTS_ENABLED?: string;
  readonly VITE_APP_ENV?: "development" | "staging" | "production";
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
