/**
 * @donatellox/theme — общий Tailwind-конфиг.
 * Каждое приложение (web/admin/landing) импортирует это как базу:
 *
 *   import baseConfig from "@donatellox/theme/tailwind.config";
 *   export default { ...baseConfig, content: [...] };
 */
import { colors, fontFamily, radius, shadow, breakpoints } from "./src/tokens.ts";
import tailwindcssAnimate from "tailwindcss-animate";

/** @type {import('tailwindcss').Config} */
const config = {
  darkMode: "class",
  content: [],
  theme: {
    screens: breakpoints,
    extend: {
      colors: {
        ink: colors.ink,
        volt: colors.volt,
        ember: colors.ember,
        neutral: colors.neutral,
        success: colors.semantic.success,
        warning: colors.semantic.warning,
        danger: colors.semantic.danger,
        info: colors.semantic.info,
      },
      fontFamily: {
        display: fontFamily.display,
        body: fontFamily.body,
        mono: fontFamily.mono,
      },
      borderRadius: {
        sm: radius.sm,
        md: radius.md,
        lg: radius.lg,
        xl: radius.xl,
        full: radius.full,
      },
      boxShadow: {
        card: shadow.card,
        glow: shadow.glow,
      },
      backgroundImage: {
        "grid-fade":
          "radial-gradient(ellipse 80% 50% at 50% -20%, rgba(168,224,0,0.15), transparent)",
      },
      keyframes: {
        "fade-in": {
          "0%": { opacity: "0", transform: "translateY(8px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        "pulse-glow": {
          "0%, 100%": { boxShadow: "0 0 0 0 rgba(168,224,0,0.35)" },
          "50%": { boxShadow: "0 0 0 8px rgba(168,224,0,0)" },
        },
        // Последние секунды таймера отдыха: каждая цифра "толкается" заново
        "rest-tick": {
          "0%": { transform: "scale(1.12)", opacity: "0.6" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
      },
      animation: {
        "fade-in": "fade-in 0.4s ease-out both",
        "pulse-glow": "pulse-glow 2.4s ease-in-out infinite",
        "rest-tick": "rest-tick 0.45s cubic-bezier(0.2, 0.8, 0.2, 1) both",
      },
    },
  },
  plugins: [tailwindcssAnimate],
};

export default config;
