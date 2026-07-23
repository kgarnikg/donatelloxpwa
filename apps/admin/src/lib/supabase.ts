import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    "Не заданы VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY. Скопируйте .env.example в .env и заполните значения.",
  );
}

/**
 * Клиент Supabase для CMS. Доступ к чувствительным таблицам (users, payments)
 * защищён политиками RLS на стороне базы данных — этот клиент лишь проходит
 * авторизацию, реальные ограничения по ролям применяются в Postgres.
 */
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
    storageKey: "donatellox-admin-auth",
  },
});
