import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    "Не заданы VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY. Скопируйте .env.example в .env и заполните значения.",
  );
}

/**
 * Единственный клиент Supabase для всего PWA.
 * Сессия хранится в localStorage и переживает офлайн/PWA-режим.
 */
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
    storageKey: "donatellox-auth",
  },
});
