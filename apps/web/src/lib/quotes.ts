import i18n from "@/i18n";

/**
 * Мотивационная фраза дня на главном экране. Сами фразы лежат в файлах
 * переводов (ключ "quotes" — массив, одинаковой длины и в одном порядке во
 * всех языках), поэтому показываются на языке интерфейса.
 * Ротация детерминирована по дню года: все пользователи в один день видят
 * одну и ту же фразу, а на следующий день — следующую по списку.
 */
export function getDailyQuote(): string {
  const quotes = i18n.t("quotes", { returnObjects: true }) as unknown;
  if (!Array.isArray(quotes) || quotes.length === 0) return "";
  const start = new Date(new Date().getFullYear(), 0, 0);
  const diff = Date.now() - start.getTime();
  const dayOfYear = Math.floor(diff / 86_400_000);
  return String(quotes[dayOfYear % quotes.length]);
}
