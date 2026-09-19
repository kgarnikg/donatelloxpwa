/**
 * Выбирает переведённое (title_en/notes_en/...) поле, если интерфейс на
 * английском и перевод есть, иначе — русский оригинал. Используется везде,
 * где показывается контент программ (названия программ/тренировок/
 * упражнений, заметки тренера) — см. Фазу 6 в PROJECT_PLAN.md.
 */
export function localizedField(
  ru: string,
  en: string | null | undefined,
  currentLanguage: string,
): string {
  if (currentLanguage.startsWith("en") && en) return en;
  return ru;
}
