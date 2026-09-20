import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    "Не заданы VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY. Скопируйте .env.example в .env и заполните значения.",
  );
}

/**
 * Клиент Supabase для лендинга — только на чтение публичных настроек
 * (site_settings), у лендинга нет ни авторизации, ни личного кабинета.
 * Ключ anon безопасно публиковать — доступ и так регулируется RLS-
 * политиками на стороне базы, не секретностью ключа.
 */
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: { persistSession: false },
});
