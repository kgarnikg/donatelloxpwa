import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";
import path from "node:path";

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      // "prompt": новая версия НЕ применяется молча в любой момент — решает
      // lib/pwaUpdate.ts (сразу, но не посреди тренировки, чтобы не
      // потерять отмеченные подходы).
      registerType: "prompt",
      includeAssets: ["favicon.svg", "apple-touch-icon.png", "robots.txt"],
      manifest: {
        name: "DonatelleX — тренировки и прогресс",
        short_name: "DonatelleX",
        description:
          "Персональные программы тренировок, дневник прогресса и подписка на видео-контент.",
        theme_color: "#0A0B0D",
        background_color: "#0A0B0D",
        display: "standalone",
        orientation: "portrait",
        start_url: "/",
        scope: "/",
        icons: [
          { src: "/icons/icon-192.png", sizes: "192x192", type: "image/png" },
          { src: "/icons/icon-512.png", sizes: "512x512", type: "image/png" },
          {
            src: "/icons/icon-maskable-512.png",
            sizes: "512x512",
            type: "image/png",
            purpose: "maskable",
          },
        ],
      },
      workbox: {
        // Без этого браузер мог продолжать работать со старой закэшированной
        // версией приложения даже после деплоя новой — из-за чего
        // исправленные баги "возвращались" у пользователей со старой вкладкой.
        // skipWaiting вызывается вручную из lib/pwaUpdate.ts (updateSW(true))
        clientsClaim: true,
        cleanupOutdatedCaches: true,
        globPatterns: ["**/*.{js,css,html,svg,png,woff2}"],
        runtimeCaching: [
          {
            urlPattern: ({ url }) => url.pathname.startsWith("/storage/"),
            handler: "CacheFirst",
            options: {
              cacheName: "donatellox-video-cache",
              expiration: { maxEntries: 40, maxAgeSeconds: 60 * 60 * 24 * 14 },
            },
          },
          {
            urlPattern: ({ url }) => url.pathname.startsWith("/rest/v1/"),
            method: "GET",
            handler: "NetworkFirst",
            options: { cacheName: "donatellox-api-cache" },
          },
        ],
      },
      devOptions: { enabled: false },
    }),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  server: {
    port: 5173,
    strictPort: true,
  },
  build: {
    target: "es2022",
    sourcemap: true,
  },
});
