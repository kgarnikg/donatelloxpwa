import { ArrowRight } from "lucide-react";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

export function CallToAction() {
  return (
    <section className="py-20 sm:py-28">
      <div className="section-container">
        <div className="card relative overflow-hidden bg-gradient-to-br from-volt-400/10 via-ink-900 to-ink-900 px-8 py-14 text-center sm:px-16">
          <h2 className="font-display text-3xl font-bold sm:text-4xl">
            Готов начать тренироваться?
          </h2>
          <p className="mx-auto mt-4 max-w-md text-neutral-400">
            Заполни короткую анкету, получи персональную программу и сделай первый шаг уже сегодня.
          </p>
          <a href={`${APP_URL}/register`} className="btn-primary mx-auto mt-8 w-fit">
            Начать бесплатно <ArrowRight size={18} />
          </a>
        </div>
      </div>
    </section>
  );
}
