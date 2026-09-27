import { useEffect, type RefObject } from "react";

/**
 * Держит fixed-элемент на месте, когда страницу увеличили пальцами.
 *
 * На iPhone position: fixed привязан к "раскладке" страницы, а не к тому,
 * что видно на экране: стоит увеличить страницу — нижняя панель (свёрнутый
 * таймер отдыха, кнопка "Завершить") уезжает. Через visualViewport узнаём,
 * какую часть страницы сейчас видно, и сдвигаем/масштабируем элемент так,
 * чтобы он оставался прижатым к низу экрана (или закрывал весь экран) в
 * своём обычном размере. То же после ввода веса: iOS сдвигает видимую
 * область под клавиатуру и не всегда возвращает её — панель "висела"
 * посреди экрана. Без увеличения/клавиатуры ничего не трогаем.
 */
export function useViewportPin(ref: RefObject<HTMLElement | null>, anchor: "bottom" | "full" = "bottom") {
  useEffect(() => {
    const vv = window.visualViewport;
    const el = ref.current;
    if (!vv || !el) return;

    let frame = 0;
    function apply() {
      frame = 0;
      if (!vv || !el) return;
      const scale = vv.scale || 1;
      // Обычное состояние: без увеличения, без клавиатуры и без "уехавшей"
      // видимой области — ничего не трогаем.
      if (
        Math.abs(scale - 1) < 0.01 &&
        Math.abs(vv.offsetTop) < 1 &&
        Math.abs(vv.offsetLeft) < 1 &&
        Math.abs(vv.height - window.innerHeight) < 1
      ) {
        el.style.transform = "";
        el.style.transformOrigin = "";
        return;
      }
      if (anchor === "bottom") {
        const dy = vv.offsetTop + vv.height - window.innerHeight;
        el.style.transformOrigin = "left bottom";
        el.style.transform = `translate(${vv.offsetLeft}px, ${dy}px) scale(${1 / scale})`;
      } else {
        el.style.transformOrigin = "left top";
        el.style.transform = `translate(${vv.offsetLeft}px, ${vv.offsetTop}px) scale(${1 / scale})`;
      }
    }
    const schedule = () => {
      if (!frame) frame = requestAnimationFrame(apply);
    };

    apply();
    vv.addEventListener("resize", schedule);
    vv.addEventListener("scroll", schedule);
    return () => {
      vv.removeEventListener("resize", schedule);
      vv.removeEventListener("scroll", schedule);
      if (frame) cancelAnimationFrame(frame);
      el.style.transform = "";
      el.style.transformOrigin = "";
    };
  }, [ref, anchor]);
}
