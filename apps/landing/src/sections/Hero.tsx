import { ArrowRight, PlayCircle } from "lucide-react";

const APP_URL = import.meta.env.VITE_WEB_APP_URL || "/";

export function Hero() {
  return (
    <section id="top" className="relative overflow-hidden bg-grid-fade pt-32 pb-20 sm:pt-40 sm:pb-28">
      <div className="section-container relative flex flex-col items-center text-center">
        <span className="eyebrow mb-4 animate-fade-in">Тренировки нового поколения</span>
        <h1 className="max-w-3xl animate-fade-in font-display text-4xl font-bold leading-tight sm:text-6xl">
          Твой персональный тренер,
          <br />
          <span className="text-volt-400">всегда под рукой</span>
        </h1>
        <p className="mt-6 max-w-xl animate-fade-in text-lg text-neutral-400">
          Программы тренировок под твою цель, видео-инструкции, дневник прогресса и поддержка —
          в одном приложении. Занимайся дома, в зале или в дороге.
        </p>

        <div className="mt-8 flex animate-fade-in flex-col gap-3 sm:flex-row">
          <a href={`${APP_URL}#/register`} className="btn-primary">
            Начать бесплатно <ArrowRight size={18} />
          </a>
          <a href="#modules" className="btn-secondary">
            <PlayCircle size={18} /> Как это работает
          </a>
        </div>

        <p className="mt-6 text-sm text-neutral-500">
          Без банковской карты для старта · Отмена подписки в любой момент
        </p>
      </div>
    </section>
  );
}
