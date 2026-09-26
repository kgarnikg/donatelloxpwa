import { useTranslation } from "react-i18next";

/**
 * Сообщения валидации в @donatellox/validation написаны по-русски (их же
 * видит админка). В приложении показываем их на языке интерфейса: русская
 * строка → ключ i18n. Если сообщение уже ключ ("onboarding.errors.…") или
 * неизвестно — t() вернёт его как есть.
 */
const RU_TO_KEY: Record<string, string> = {
  "Введите email": "validation.emailRequired",
  "Введите корректный email": "validation.emailInvalid",
  "Минимум 8 символов": "validation.passwordMin",
  "Слишком длинный пароль": "validation.passwordMax",
  "Пароль должен содержать хотя бы одну букву": "validation.passwordLetter",
  "Пароль должен содержать хотя бы одну цифру": "validation.passwordDigit",
  "Введите корректный номер телефона в международном формате": "validation.phoneInvalid",
  "Введите имя": "validation.nameRequired",
  "Введите фамилию": "validation.lastNameRequired",
  "Выберите страну": "validation.countryRequired",
  "Необходимо принять условия использования": "validation.acceptTerms",
  "Пароли не совпадают": "validation.passwordsMismatch",
  "Введите пароль": "validation.passwordRequired",
  "Выберите хотя бы одну цель": "validation.goalsRequired",
};

export function useValidationMessage() {
  const { t } = useTranslation();
  return (message: string | undefined): string => {
    if (!message) return "";
    const key = RU_TO_KEY[message] ?? message;
    return t(key, { defaultValue: message });
  };
}
