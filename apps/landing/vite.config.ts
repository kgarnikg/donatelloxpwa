import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";
import path from "node:path";

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      includeAssets: ["favicon.svg", "apple-touch-icon.png", "robots.txt", "video/hero-video.mp4"],
      manifest: {
        name: "DonatelloX — тренировки, которые работают",
        short_name: "DonatelloX",
        description:
          "Персональные программы тренировок, видео-инструкции и дневник прогресса.",
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
            purpose: "maskable"
          }
        ]
      },
      workbox: {
        globPatterns: ["**/*.{js,css,html,svg,png,woff2}"],
        globIgnores: ["**/hero-video.mp4"],
        runtimeCaching: [
          {
            urlPattern: ({ url }) => url.pathname.startsWith("/video/"),
            handler: "CacheFirst",
            options: {
              cacheName: "donatellox-landing-video-cache",
              expiration: { maxEntries: 5, maxAgeSeconds: 60 * 60 * 24 * 30 }
            }
          }
        ]
      },
      devOptions: { enabled: false }
    })
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src")
    }
  },
  server: {
    port: 5175,
    strictPort: true
  },
  build: {
    target: "es2022",
    sourcemap: true
  }
});
