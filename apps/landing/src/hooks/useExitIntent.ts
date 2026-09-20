import { useEffect, useState } from "react";

const SESSION_KEY = "donatellex_exit_intent_shown";
const MIN_TIME_ON_PAGE_MS = 8000;

/**
 * Показывает попап "не уходи" один раз за сессию, когда курсор уходит вверх
 * за пределы страницы (типичный жест перед закрытием вкладки/переходом в
 * адресную строку). Осознанно только для десктопа — на мобильных курсора
 * нет, а перехват кнопки "назад" ради имитации exit-intent слишком
 * агрессивно вмешивается в навигацию браузера.
 */
export function useExitIntent(): { show: boolean; dismiss: () => void } {
  const [show, setShow] = useState(false);

  useEffect(() => {
    if (sessionStorage.getItem(SESSION_KEY)) return;

    const mountedAt = Date.now();
    let armed = false;
    const armTimer = setTimeout(() => {
      armed = true;
    }, MIN_TIME_ON_PAGE_MS);

    function onMouseLeave(e: MouseEvent) {
      if (!armed) return;
      if (e.clientY > 0) return; // уходит не вверх — не считается
      if (Date.now() - mountedAt < MIN_TIME_ON_PAGE_MS) return;
      setShow(true);
      sessionStorage.setItem(SESSION_KEY, "1");
      document.removeEventListener("mouseleave", onMouseLeave);
    }

    document.addEventListener("mouseleave", onMouseLeave);
    return () => {
      clearTimeout(armTimer);
      document.removeEventListener("mouseleave", onMouseLeave);
    };
  }, []);

  return { show, dismiss: () => setShow(false) };
}
