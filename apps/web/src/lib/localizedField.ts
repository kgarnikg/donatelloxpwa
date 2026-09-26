/**
 * Языки, на которые переведён контент программ (упражнения, заметки к
 * подходам, названия тренировок и недель, программы). Русский — оригинал.
 * Колонки в БД: title_en, title_es, …; в camelCase — titleEn, titleEs, …
 * en/es/hy — Фаза 6 (перевод заново в Фазе 27), uk/de/it/ar/hi/pa — Фаза 28.
 */
export const CONTENT_LANGS = ["en", "es", "hy", "uk", "de", "it", "ar", "hi", "pa"] as const;
export type ContentLang = (typeof CONTENT_LANGS)[number];

/**
 * Выбирает переведённое поле для текущего языка интерфейса, с фолбэком на
 * русский оригинал, если перевода нет.
 */
export function localizedField(
  ru: string,
  translations: Partial<Record<string, string | null | undefined>>,
  currentLanguage: string,
): string {
  const lang = currentLanguage.split("-")[0]; // "en-US" -> "en"
  const translated = translations[lang];
  return translated || ru;
}

/**
 * То же самое, но берёт переводы прямо из объекта строки: для поля "title"
 * смотрит title + язык в camelCase (titleEn) или snake_case (title_en),
 * для "week_label" — week_label_en. Так новые языки не требуют правок во
 * всех местах вызова.
 */
export function localizedOf(
  row: object | null | undefined,
  field: string,
  currentLanguage: string,
): string {
  if (!row) return "";
  const r = row as Record<string, unknown>;
  const ru = (r[field] as string | null | undefined) ?? "";
  const lang = currentLanguage.split("-")[0];
  if (lang === "ru") return ru;
  const camel = field + lang.charAt(0).toUpperCase() + lang.slice(1);
  const snake = `${field}_${lang}`;
  const translated = (r[camel] ?? r[snake]) as string | null | undefined;
  return translated || ru;
}

/** "title" → "title, title_en, title_es, …" — для явных select(). */
export function withTranslations(...fields: string[]): string {
  return fields.flatMap((f) => [f, ...CONTENT_LANGS.map((l) => `${f}_${l}`)]).join(", ");
}
