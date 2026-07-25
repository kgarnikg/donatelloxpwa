import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";

import ru from "./locales/ru.json";
import en from "./locales/en.json";
import es from "./locales/es.json";
import de from "./locales/de.json";
import it from "./locales/it.json";

export const SUPPORTED_LANGUAGES = ["ru", "en", "es", "de", "it"] as const;
export type SupportedLanguage = (typeof SUPPORTED_LANGUAGES)[number];

export const LANGUAGE_LABELS: Record<SupportedLanguage, string> = {
  ru: "Русский",
  en: "English",
  es: "Español",
  de: "Deutsch",
  it: "Italiano",
};

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources: {
      ru: { translation: ru },
      en: { translation: en },
      es: { translation: es },
      de: { translation: de },
      it: { translation: it },
    },
    fallbackLng: "en",
    supportedLngs: SUPPORTED_LANGUAGES as unknown as string[],
    // Приводим варианты вида "en-US" / "es-MX" к базовому языку "en" / "es",
    // так как переводы у нас не разделены по региону.
    load: "languageOnly",
    detection: {
      // Сначала — явный выбор пользователя (сохранённый в приложении),
      // затем — язык устройства/браузера.
      order: ["localStorage", "navigator"],
      lookupLocalStorage: "donatellox-language",
      caches: ["localStorage"],
    },
    interpolation: { escapeValue: false },
  });

export default i18n;
