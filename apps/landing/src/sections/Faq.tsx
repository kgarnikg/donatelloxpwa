import { useState } from "react";
import { ChevronDown } from "lucide-react";
import clsx from "clsx";

const FAQ_ITEMS = [
  {
    question: "Нужно ли специальное оборудование?",
    answer:
      "Нет. Многие программы рассчитаны на тренировки с собственным весом. Для программ с отягощениями мы отмечаем, какое оборудование понадобится, до начала тренировки.",
  },
  {
    question: "Можно ли отменить подписку?",
    answer:
      "Да, в любой момент — прямо в личном кабинете приложения, без обращения в поддержку и без штрафов.",
  },
  {
    question: "Какие способы оплаты поддерживаются?",
    answer:
      "Банковские карты и локальные способы оплаты через Stripe и PayPal, ЮKassa для карт РФ и СБП, а также оплата в USDT через собственный крипто-кошелёк с автоматической проверкой транзакции.",
  },
  {
    question: "Работает ли приложение офлайн?",
    answer:
      "DonatelloX — это PWA (Progressive Web App): интерфейс и ранее просмотренные тренировки доступны офлайн, а прогресс синхронизируется при появлении сети.",
  },
  {
    question: "Есть ли поддержка на русском языке?",
    answer: "Да, интерфейс и контент доступны на русском, английском и испанском языках.",
  },
];

function FaqItem({ question, answer }: { question: string; answer: string }) {
  const [open, setOpen] = useState(false);

  return (
    <div className="border-b border-ink-800 py-5">
      <button
        onClick={() => setOpen((v) => !v)}
        className="flex w-full items-center justify-between text-left"
      >
        <span className="font-medium">{question}</span>
        <ChevronDown
          size={18}
          className={clsx("shrink-0 text-neutral-400 transition-transform", open && "rotate-180")}
        />
      </button>
      {open && <p className="mt-3 text-sm text-neutral-400">{answer}</p>}
    </div>
  );
}

export function Faq() {
  return (
    <section id="faq" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">Вопросы</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">Частые вопросы</h2>
        </div>

        <div className="mx-auto mt-10 max-w-2xl">
          {FAQ_ITEMS.map((item) => (
            <FaqItem key={item.question} {...item} />
          ))}
        </div>
      </div>
    </section>
  );
}
