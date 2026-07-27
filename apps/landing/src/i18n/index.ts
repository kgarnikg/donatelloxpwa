import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";

import ru from "./locales/ru.json";
import en from "./locales/en.json";
import es from "./locales/es.json";
import de from "./locales/de.json";
import it from "./locales/it.json";
import hy from "./locales/hy.json";
import ar from "./locales/ar.json";
import hi from "./locales/hi.json";
import pa from "./locales/pa.json";
import uk from "./locales/uk.json";

export const SUPPORTED_LANGUAGES = ["ru", "en", "es", "de", "it", "hy", "ar", "hi", "pa", "uk"] as const;
export type SupportedLanguage = (typeof SUPPORTED_LANGUAGES)[number];

export const LANGUAGE_LABELS: Record<SupportedLanguage, string> = {
  ru: "Русский",
  en: "English",
  es: "Español",
  de: "Deutsch",
  it: "Italiano",
  hy: "Հայերեն",
  ar: "العربية",
  hi: "हिन्दी",
  pa: "ਪੰਜਾਬੀ",
  uk: "Українська",
};

const RTL_LANGUAGES: readonly SupportedLanguage[] = ["ar"];

// Тот же ключ localStorage, что и в apps/web — выбор языка на лендинге
// подхватывается веб-приложением при переходе (Header/CallToAction ссылки).
const LANGUAGE_STORAGE_KEY = "donatellox-language";

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
      hy: { translation: hy },
      ar: { translation: ar },
      hi: { translation: hi },
      pa: { translation: pa },
      uk: { translation: uk },
    },
    fallbackLng: "en",
    supportedLngs: SUPPORTED_LANGUAGES as unknown as string[],
    load: "languageOnly",
    detection: {
      order: ["localStorage", "navigator"],
      lookupLocalStorage: LANGUAGE_STORAGE_KEY,
      caches: ["localStorage"],
    },
    interpolation: { escapeValue: false },
  });

function applyDocumentDirection(lang: string) {
  const isRtl = (RTL_LANGUAGES as readonly string[]).includes(lang);
  document.documentElement.dir = isRtl ? "rtl" : "ltr";
  document.documentElement.lang = lang;
}

applyDocumentDirection(i18n.language);
i18n.on("languageChanged", applyDocumentDirection);

export default i18n;
