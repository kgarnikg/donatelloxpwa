/**
 * Выбирает переведённое поле (title_en/title_es/notes_en/...) для текущего
 * языка интерфейса, с фолбэком на русский оригинал, если перевода нет для
 * этого языка (или для этого языка перевод вообще не делали — см. Фазу 6
 * в PROJECT_PLAN.md, сейчас переведено: en, es).
 *
 * Обобщённая форма — принимает объект переводов { en, es, ... }, а не
 * позиционные аргументы под каждый язык, чтобы добавление следующего
 * языка не требовало менять сигнатуру и все места вызова.
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
