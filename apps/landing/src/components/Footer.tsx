const FOOTER_LINKS = [
  {
    title: "Продукт",
    links: [
      { label: "Возможности", href: "#modules" },
      { label: "Тарифы", href: "#pricing" },
      { label: "Вопросы", href: "#faq" },
    ],
  },
  {
    title: "Компания",
    links: [
      { label: "О нас", href: "#top" },
      { label: "Контакты", href: "mailto:hello@donatellox.com" },
    ],
  },
  {
    title: "Правовая информация",
    links: [
      { label: "Условия использования", href: "/terms" },
      { label: "Политика конфиденциальности", href: "/privacy" },
    ],
  },
];

export function Footer() {
  return (
    <footer className="border-t border-ink-800 bg-ink-950 py-12">
      <div className="section-container">
        <div className="grid grid-cols-2 gap-8 md:grid-cols-4">
          <div className="col-span-2 md:col-span-1">
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-md bg-volt-400 font-display font-bold text-ink-950">
                D
              </div>
              <span className="font-display text-lg font-bold">DonatelloX</span>
            </div>
            <p className="mt-3 max-w-xs text-sm text-neutral-500">
              Персональные программы тренировок, видео и дневник прогресса в одном приложении.
            </p>
          </div>

          {FOOTER_LINKS.map((group) => (
            <div key={group.title}>
              <h3 className="mb-3 text-sm font-semibold text-neutral-200">{group.title}</h3>
              <ul className="space-y-2">
                {group.links.map((link) => (
                  <li key={link.label}>
                    <a href={link.href} className="text-sm text-neutral-500 hover:text-neutral-300">
                      {link.label}
                    </a>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        <div className="mt-10 flex flex-col items-center justify-between gap-4 border-t border-ink-800 pt-6 text-sm text-neutral-600 sm:flex-row">
          <p>© {new Date().getFullYear()} DonatelloX. Все права защищены.</p>
          <p>Оплата: Stripe · PayPal · ЮKassa · USDT</p>
        </div>
      </div>
    </footer>
  );
}
