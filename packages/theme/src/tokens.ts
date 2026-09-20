/**
 * @donatellox/theme/tokens
 * Единственный источник истины для цветов, отступов и типографики бренда.
 * tailwind.config.js читает эти значения, а приложения могут импортировать
 * их напрямую (например, для canvas/SVG, где Tailwind-классы не применимы).
 */

export const colors = {
  // Тёмный "спортивный" фон — не чёрный в ноль, чтобы не убивать контраст видео/фото.
  ink: {
    950: "#0A0B0D",
    900: "#111318",
    800: "#191C22",
    700: "#23272F",
    600: "#2E333D",
  },
  // Основной акцент бренда — сигнальный вольт-лайм, ассоциируется с энергией и прогрессом.
  volt: {
    50: "#F3FFDD",
    100: "#E4FFB0",
    200: "#D2FF7A",
    300: "#BEF23F",
    400: "#A8E000", // primary
    500: "#8FC000",
    600: "#719900",
    700: "#547000",
  },
  // Тёплый вторичный акцент для CTA "оплата/подписка" — контрастирует с вольтом.
  ember: {
    300: "#FF9466",
    400: "#FF6B35", // primary
    500: "#F04E1B",
    600: "#C43A10",
  },
  // Нейтральная шкала для текста и поверхностей.
  neutral: {
    0: "#FFFFFF",
    50: "#F7F8F9",
    100: "#EDEFF2",
    200: "#D8DBE0",
    300: "#B4B9C2",
    400: "#8A909C",
    500: "#666C78",
    600: "#4B505A",
  },
  semantic: {
    success: "#3DD68C",
    warning: "#FFC24B",
    danger: "#FF5A5F",
    info: "#4EA6FF",
  },
} as const;

export const fontFamily = {
  // Заголовки — плотный жирный гротеск для энергичных заголовков.
  // Было "Clash Display" — платный шрифт (не доступен бесплатно через
  // Google Fonts) и физически никогда не подключался ни на одной
  // странице (не было ни <link>, ни @font-face) — заголовки всё это
  // время рендерились системным шрифтом браузера по умолчанию.
  display: ["Archivo Black", "Manrope", "system-ui", "sans-serif"],
  // Основной текст интерфейса — нейтральный, отлично читается в мелком
  // размере. Сам шрифт бесплатный (это открытый Google Font), просто
  // тоже никогда не подключался явно — тот же баг, что и с display.
  body: ["Manrope", "system-ui", "-apple-system", "sans-serif"],
  mono: ["JetBrains Mono", "ui-monospace", "monospace"],
} as const;

export const radius = {
  sm: "6px",
  md: "10px",
  lg: "16px",
  xl: "24px",
  full: "9999px",
} as const;

export const shadow = {
  card: "0 1px 2px rgba(10, 11, 13, 0.4), 0 8px 24px -8px rgba(10, 11, 13, 0.5)",
  glow: "0 0 0 1px rgba(168, 224, 0, 0.15), 0 0 32px rgba(168, 224, 0, 0.12)",
} as const;

export const breakpoints = {
  xs: "420px",
  sm: "640px",
  md: "768px",
  lg: "1024px",
  xl: "1280px",
  "2xl": "1536px",
} as const;

export const theme = { colors, fontFamily, radius, shadow, breakpoints } as const;

export type ThemeTokens = typeof theme;
