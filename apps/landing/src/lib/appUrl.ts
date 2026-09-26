/**
 * Адрес PWA-приложения, куда ведут кнопки лендинга ("Войти", "Начать").
 *
 * Боевой адрес — https://app.donatellex.com. Переменная VITE_WEB_APP_URL
 * нужна для локальной разработки (http://localhost:5173) и превью. Старые
 * технические адреса Vercel (*.vercel.app) игнорируем, чтобы после
 * подключения своего домена ссылки не вели на них, даже если в настройках
 * Vercel осталось старое значение переменной.
 */
const PRODUCTION_APP_URL = "https://app.donatellex.com";

const fromEnv = (import.meta.env.VITE_WEB_APP_URL || "").trim();

export const APP_URL = (fromEnv && !/\.vercel\.app/i.test(fromEnv) ? fromEnv : PRODUCTION_APP_URL).replace(/\/$/, "");
