import { useState } from "react";
import { ChevronDown } from "lucide-react";
import { useTranslation } from "react-i18next";
import clsx from "clsx";

interface FaqItem {
  question: string;
  answer: string;
}

function FaqRow({ item }: { item: FaqItem }) {
  const [open, setOpen] = useState(false);

  return (
    <div className="border-b border-ink-800 py-5">
      <button onClick={() => setOpen((v) => !v)} className="flex w-full items-center justify-between text-left">
        <span className="font-medium">{item.question}</span>
        <ChevronDown size={18} className={clsx("shrink-0 text-neutral-400 transition-transform", open && "rotate-180")} />
      </button>
      {open && <p className="mt-3 text-sm text-neutral-400">{item.answer}</p>}
    </div>
  );
}

export function Faq() {
  const { t } = useTranslation();
  const items = t("faq.items", { returnObjects: true }) as FaqItem[];

  return (
    <section id="faq" className="py-20 sm:py-28">
      <div className="section-container">
        <div className="mx-auto max-w-2xl text-center">
          <span className="eyebrow">{t("faq.eyebrow")}</span>
          <h2 className="mt-3 font-display text-3xl font-bold sm:text-4xl">{t("faq.title")}</h2>
        </div>

        <div className="mx-auto mt-10 max-w-2xl">
          {items.map((item) => (
            <FaqRow key={item.question} item={item} />
          ))}
        </div>
      </div>
    </section>
  );
}
