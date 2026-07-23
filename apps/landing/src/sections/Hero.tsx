import { ArrowRight, PlayCircle } from "lucide-react";

const APP_URL = import.meta.env.VITE_WEB_APP_URL || "/";

export function Hero() {
  return (
    <section id="top" className="relative flex min-h-dvh items-center overflow-hidden pt-20">
      {/* Фоновое видео */}
      <video
        className="absolute inset-0 h-full w-full object-cover"
        src="/video/hero-video.mp4"
        autoPlay
        muted
        loop
        playsInline
        preload="auto"
        aria-hidden="true"
      />
      {/* Затемнение поверх видео для читаемости текста */}
      <div className="absolute inset-0 bg-gradient-to-b from-ink-950/80 via-ink-950/70 to-ink-950" />
      <div className="absolute inset-0 bg-grid-fade opacity-40" />

      <div className="section-container relative flex flex-col items-center py-20 text-center sm:py-28">
        <span className="eyebrow mb-4 animate-fade-in">DonatelloX Fitness Training</span>
        <h1 className="max-w-3xl animate-fade-in font-display text-4xl font-bold leading-tight sm:text-6xl">
          Всё для построения
          <br />
          <span className="text-volt-400">тела мечты</span>
        </h1>
        <p className="mt-6 max-w-xl animate-fade-in text-lg text-neutral-300">
          Структурированные тренировки, видео-инструкции и дневник прогресса — в одном приложении.
          Занимайся дома, в зале или в дороге.
        </p>

        <div className="mt-8 flex animate-fade-in flex-col gap-3 sm:flex-row">
          <a href={`${APP_URL}#/register`} className="btn-primary">
            Начать сейчас <ArrowRight size={18} />
          </a>
          <a href="#modules" className="btn-secondary">
            <PlayCircle size={18} /> Узнать больше
          </a>
        </div>

        <p className="mt-6 text-sm text-neutral-400">
          Без банковской карты для старта · Отмена подписки в любой момент
        </p>
      </div>
    </section>
  );
}
