import baseConfig from "@donatellox/theme/tailwind.config";

/** @type {import('tailwindcss').Config} */
export default {
  ...baseConfig,
  content: [
    "./index.html",
    "./src/**/*.{ts,tsx}",
    "../../packages/theme/src/**/*.{ts,tsx}",
  ],
};
