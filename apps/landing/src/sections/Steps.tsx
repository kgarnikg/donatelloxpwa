import { ClipboardList, Sparkles, TrendingUp } from "lucide-react";

const STEPS = [
  {
    number: "01",
    icon: ClipboardList,
    title: "Определи начальную точку",
    description:
      "Укажи свой уровень, цель и доступное оборудование — и программа подстроится под тебя с первого дня.",
  },
  {
    number: "02",
    icon: Sparkles,
    title: "Получи персональный план",
    description: "Структурированная программа, построенная под твой уровень и график тренировок.",
  },
  {
    number: "03",
    icon: TrendingUp,
    title: "Тренируйся и прогрессируй",
    description:
      "Следуй ежедневным тренировкам, фиксируй веса и повторения — программа растёт вместе с тобой.",
  },
];

export function Steps() {
  return (
    <section id="how-it-works" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Как начать</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">Три простых шага</h2>
        </div>

        <div className="mt-14 grid grid-cols-1 gap-8 md:grid-cols-3">
          {STEPS.map(({ number, icon: Icon, title, description }, index) => (
            <div key={number} className="relative text-center">
              <div className="mx-auto mb-5 flex h-16 w-16 items-center justify-center rounded-2xl bg-volt-400/10 text-volt-400">
                <Icon size={26} />
              </div>
              <span className="font-display text-sm font-bold text-neutral-600">{number}</span>
              <h3 className="mt-2 font-semibold">{title}</h3>
              <p className="mt-2 text-sm text-neutral-400">{description}</p>

              {index < STEPS.length - 1 && (
                <div className="absolute right-[-1rem] top-8 hidden h-px w-8 bg-ink-700 md:block" />
              )}
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
