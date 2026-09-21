/**
 * navigator.vibrate() никогда не работал в Safari/iPhone — это не баг
 * нашего кода, подтверждённое ограничение WebKit (Apple принципиально не
 * реализовала Vibration API). На Android/Chrome обычный navigator.vibrate()
 * работает нормально и его трогать не нужно.
 *
 * С Safari 17.4 есть рабочий обходной путь именно под iOS: скрытый
 * <input type="checkbox" switch> — переключение его состояния запускает
 * настоящий тактильный отклик (Taptic Engine) как побочный эффект того,
 * как Safari обрабатывает этот тип элемента. Не наш код это "чинит" —
 * используем существующее (не документированное официально, но проверенное
 * сообществом) поведение самого браузера.
 *
 * Честно: по свежим данным Apple, похоже, залатала это в iOS 26.5 — то
 * есть трюк может уже не работать на самых новых iPhone. Оставляем как
 * best-effort слой поверх обычного vibrate(), а не замену ему — ничего не
 * теряем, если он однажды перестанет работать у части пользователей.
 */
let hiddenToggle: HTMLInputElement | null = null;

function getHiddenToggle(): HTMLInputElement | null {
  if (typeof document === "undefined") return null;
  if (hiddenToggle) return hiddenToggle;

  const input = document.createElement("input");
  input.type = "checkbox";
  // "switch" — нестандартный HTML-атрибут, добавленный Safari 17.4 именно
  // под этот сценарий (стилизованный iOS-переключатель). Не влияет на
  // остальные браузеры — они его просто игнорируют.
  input.setAttribute("switch", "");
  input.setAttribute("aria-hidden", "true");
  input.tabIndex = -1;
  // Не display:none — в некоторых версиях WebKit скрытые через display:none
  // элементы не проигрывают связанные с ними системные эффекты. Прячем
  // визуально, оставляя технически "живым" в DOM.
  input.style.position = "fixed";
  input.style.opacity = "0";
  input.style.pointerEvents = "none";
  input.style.width = "1px";
  input.style.height = "1px";
  document.body.appendChild(input);
  hiddenToggle = input;
  return input;
}

/**
 * Пытается вызвать тактильный отклик обоими известными способами разом —
 * какой из них реально сработает, зависит от платформы, но вызов обоих
 * ничего не стоит и не мешает друг другу.
 */
export function triggerHapticPulse() {
  try {
    navigator.vibrate?.(200);
  } catch {
    // no-op — Vibration API недоступен на этой платформе
  }
  try {
    const toggle = getHiddenToggle();
    toggle?.click();
  } catch {
    // no-op — трюк не сработал (например, Apple патчит его в новых iOS)
  }
}
