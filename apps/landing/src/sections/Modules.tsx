import { Dumbbell, LineChart, Video, ClipboardList, UserCircle, Sparkles } from "lucide-react";

const MODULES = [
  {
    icon: ClipboardList,
    title: "Анкета и подбор программы",
    description:
      "Расскажи о своей цели, уровне подготовки и ограничениях — мы подберём подходящую программу.",
  },
  {
    icon: Dumbbell,
    title: "Программы тренировок",
    description:
      "Структурированные программы на недели вперёд: от похудения до набора массы и реабилитации.",
  },
  {
    icon: Video,
    title: "Видео-инструкции",
    description: "Каждое упражнение — с понятным видео и техникой выполнения, без угадывания.",
  },
  {
    icon: LineChart,
    title: "Дневник и прогресс",
    description: "Фиксируй вес, замеры и результаты тренировок — наблюдай динамику наглядно.",
  },
  {
    icon: UserCircle,
    title: "Личный кабинет",
    description: "Подписка, настройки языка и уведомлений — всё под контролем в одном месте.",
  },
  {
    icon: Sparkles,
    title: "Развивается вместе с тобой",
    description:
      "Питание, магазин, курсы и AI-тренер — в разработке, чтобы платформа росла вместе с тобой.",
  },
];

export function Modules() {
  return (
    <section id="modules" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Возможности</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">
            Всё, что нужно для результата
          </h2>
          <p className="mt-4 text-neutral-400">
            От первой анкеты до дневника прогресса — DonatelloX сопровождает тебя на каждом шаге.
          </p>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {MODULES.map(({ icon: Icon, title, description }) => (
            <div
              key={title}
              className="card transition hover:border-volt-400/30 hover:shadow-glow"
            >
              <div className="mb-4 flex h-11 w-11 items-center justify-center rounded-lg bg-volt-400/10 text-volt-400">
                <Icon size={22} />
              </div>
              <h3 className="font-semibold">{title}</h3>
              <p className="mt-2 text-sm text-neutral-400">{description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
