import { ArrowRight, PlayCircle, ChevronDown, Check, X } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useEffect, useState } from "react";
import { useRegion } from "@/context/RegionContext";
import { getRegionAmounts, formatAmount } from "@/lib/regionPricing";
import { supabase } from "@/lib/supabase";
import { getYouTubeEmbedUrl } from "@/lib/video";

const APP_URL = (import.meta.env.VITE_WEB_APP_URL || "/").replace(/\/$/, "");

const AVATAR_COLORS = ["bg-volt-400", "bg-ember-400", "bg-info", "bg-warning", "bg-success"];

export function Hero() {
  const { t, i18n } = useTranslation();
  const { region } = useRegion();
  const [showreelOpen, setShowreelOpen] = useState(false);
  // Ссылка на ролик берётся из БД (настраивается в админке, "Настройки
  // сайта"), а не из переменной окружения — иначе смену видео пришлось
  // бы каждый раз делать через редеплой. Пока не загрузилась (или не
  // задана) — кнопка просто скроллит к следующему блоку, см. ниже.
  const [showreelUrl, setShowreelUrl] = useState<string | null>(null);
  // Фоновое видео на весь экран — тоже настраивается из админки, тем же
  // способом, что и ролик на кнопке (см. ниже). Пока не загрузилось (или
  // не задано) — используется файл по умолчанию из самого проекта, не
  // пустой экран.
  // ?v=2 — принудительно "новый" URL для браузера/CDN после замены файла
  // с тем же именем (см. PROJECT_PLAN.md) — иначе старая кешированная
  // копия могла бы показываться ещё долго, несмотря на новый деплой.
  // При следующей замене видео под тем же именем — увеличить версию.
  const [backgroundVideoUrl, setBackgroundVideoUrl] = useState<string>("/video/hero-video.mp4?v=5");

  useEffect(() => {
    async function loadHeroSettings() {
      try {
        // Одним запросом тянем сразу все языковые варианты ролика на кнопке
        // + фоновое видео — дальше уже на клиенте выбираем нужное. Так же,
        // как и с переводом контента программ (localizedField), запасной
        // вариант для ролика на кнопке — русский: если для языка
        // посетителя своего ещё не загрузили, показываем его, а не пустоту.
        const { data } = await supabase
          .from("site_settings")
          .select("key, value")
          .in("key", [
            "hero_showreel_url_ru",
            "hero_showreel_url_en",
            "hero_showreel_url_es",
            "hero_showreel_url_hy",
            "hero_background_video_url",
          ]);
        if (!data) return;

        const byKey = Object.fromEntries(data.map((row) => [row.key, row.value]));
        const lang = i18n.language.split("-")[0]; // "en-US" -> "en"
        setShowreelUrl(byKey[`hero_showreel_url_${lang}`] || byKey.hero_showreel_url_ru || null);
        if (byKey.hero_background_video_url) setBackgroundVideoUrl(byKey.hero_background_video_url);
      } catch {
        // Настройки необязательны — если запрос не удался (например, сайт
        // ещё не подключён к свежей базе), кнопка ролика просто ведёт на
        // блок ниже, а фон остаётся стандартным — ничего не ломается.
      }
    }
    loadHeroSettings();
  }, [i18n.language]);

  const cheapest = getRegionAmounts(region).annual;
  // Целое число дней в месяце — достаточно точно для маркетингового "меньше X в день",
  // не претендует на бухгалтерскую точность.
  const perDay = (Number(cheapest.perMonthAmount.replace(/\s/g, "").replace(",", ".")) / 30).toFixed(2);

  const checklist = [
    { text: t("hero.checklist.personalized") },
    { text: t("hero.checklist.results") },
    {
      text: t("hero.checklist.price", { price: formatAmount(region, cheapest.perMonthAmount), perDay: formatAmount(region, perDay) }),
      href: "#pricing",
    },
    { text: t("hero.checklist.flexible") },
    { text: t("hero.checklist.freeWeek") },
  ];

  return (
    <section id="top" className="relative flex min-h-dvh flex-col justify-between overflow-hidden pt-16 lg:items-center lg:justify-center">
      <video
        className="absolute inset-0 h-full w-full object-cover"
        src={backgroundVideoUrl}
        autoPlay
        muted
        loop
        playsInline
        preload="auto"
        aria-hidden="true"
      />
      <div className="absolute inset-0 bg-gradient-to-b from-ink-950/85 via-ink-950/75 to-ink-950" />
      <div className="absolute inset-0 bg-grid-fade opacity-40" />

      {/* На мобильном — заголовок прижат к верху, кнопка к низу (justify-between
          на самой секции), чтобы между ними было видно фон-видео, а не сплошной
          текстовый блок посередине (отклик пользователя на предыдущую версию).
          "contents" — оба блока (header/actions) становятся прямыми flex-детьми
          <section>, это и даёт им разъехаться к разным краям без лишнего DOM.
          На десктопе (lg+) "contents" снимается (lg:flex lg:flex-col) — тогда
          это снова один общий центрированный блок, как было изначально; секция
          на lg получает justify-center вместо between. */}
      <div className="contents lg:flex lg:flex-col lg:items-start">
        {/* Верхний блок: эйброу + заголовок */}
        <div className="section-container relative mt-10 flex flex-col items-center text-center sm:mt-14 lg:mx-0 lg:mt-0 lg:max-w-xl lg:items-start lg:pl-16 lg:text-left xl:max-w-2xl xl:pl-24">
          <span className="eyebrow mb-2 animate-fade-in sm:mb-3">{t("hero.eyebrow")}</span>

          <h1 className="max-w-4xl animate-fade-in font-display text-2xl uppercase leading-[1.05] tracking-tight sm:text-5xl lg:text-6xl">
            {t("hero.titleBefore")} <span className="text-volt-400">{t("hero.titleHighlight")}</span>
          </h1>

          {/* Чек-лист в духе референса — коротко, по делу, каждый пункт правда.
              Шрифт крупнее и жирнее обычного текста — не мельчить рядом с
              громким заголовком.
              На мобильном скрыт здесь — первый экран нарочно оставлен только
              под яркий фон + заголовок, без мелких подробностей (запрос
              пользователя: "перегружено"). Те же пункты показываются чуть
              ниже, вне зоны min-h-dvh — см. HeroMobileDetails внизу файла,
              подключается в App.tsx сразу после <Hero />. Десктоп — как был,
              без изменений. */}
          <ul className="mt-3 hidden animate-fade-in flex-col gap-1.5 text-left sm:mt-5 sm:gap-2 lg:flex lg:items-start">
            {checklist.map((item) => (
              <li key={item.text} className="flex items-center gap-2.5 text-base font-medium text-neutral-100 sm:text-lg">
                <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-volt-400 text-ink-950">
                  <Check size={13} strokeWidth={3.5} />
                </span>
                {item.href ? (
                  <a href={item.href} className="underline decoration-volt-400/50 decoration-2 underline-offset-4 transition hover:text-volt-400">
                    {item.text}
                  </a>
                ) : (
                  item.text
                )}
              </li>
            ))}
          </ul>
        </div>

        {/* Нижний блок: кнопки + соц.доказательство (десктоп) — на мобильном
            прижат к низу секции, прямо над стрелкой. */}
        <div className="section-container relative mb-24 flex flex-col items-center text-center sm:mb-28 lg:mx-0 lg:mb-0 lg:mt-6 lg:max-w-xl lg:items-start lg:pl-16 lg:text-left xl:max-w-2xl xl:pl-24">
          <div className="flex animate-fade-in flex-col gap-3 sm:flex-row">
            <a
              href={`${APP_URL}/register`}
              className="btn-primary transition-transform duration-200 hover:scale-105 hover:shadow-[0_0_36px_rgba(168,224,0,0.45)]"
            >
              {t("hero.ctaPrimary")} <ArrowRight size={18} />
            </a>
            {/* Вторая кнопка (видео) — тоже только на десктопе, та же логика
                упрощения первого экрана на мобильном. */}
            <div className="hidden lg:block">
              {showreelUrl ? (
                <button onClick={() => setShowreelOpen(true)} className="btn-secondary">
                  <PlayCircle size={18} /> {t("hero.ctaSecondary")}
                </button>
              ) : (
                <a href="#pricing" className="btn-secondary">
                  <PlayCircle size={18} /> {t("hero.ctaSecondary")}
                </a>
              )}
            </div>
          </div>

          {/* Социальное доказательство — только на десктопе здесь, на мобильном
              переехало в HeroMobileDetails (см. комментарий у чек-листа выше). */}
          <div className="mt-5 hidden animate-fade-in items-center gap-3 lg:flex">
            <div className="flex -space-x-2">
              {AVATAR_COLORS.map((color, i) => (
                <div
                  key={i}
                  className={`flex h-7 w-7 items-center justify-center rounded-full border-2 border-ink-950 text-xs font-bold text-ink-950 ${color}`}
                >
                  {String.fromCharCode(65 + i)}
                </div>
              ))}
            </div>
            <span className="text-sm text-neutral-400">{t("hero.socialProof")}</span>
          </div>
        </div>
      </div>

      {showreelUrl && showreelOpen && (
        <div
          className="fixed inset-0 z-50 flex animate-fade-in items-center justify-center bg-black/85 p-4"
          onClick={() => setShowreelOpen(false)}
        >
          <div className="w-full max-w-2xl" onClick={(e) => e.stopPropagation()}>
            <button
              onClick={() => setShowreelOpen(false)}
              aria-label={t("common.close")}
              className="mb-2 ml-auto flex h-9 w-9 items-center justify-center rounded-full bg-ink-800 text-neutral-300 hover:bg-ink-700"
            >
              <X size={18} />
            </button>
            {getYouTubeEmbedUrl(showreelUrl) ? (
              <div className="aspect-video w-full overflow-hidden rounded-lg">
                <iframe
                  src={getYouTubeEmbedUrl(showreelUrl)!}
                  className="h-full w-full"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                  allowFullScreen
                />
              </div>
            ) : (
              <video src={showreelUrl} controls autoPlay className="w-full rounded-lg" />
            )}
          </div>
        </div>
      )}

      {/* Стрелка — крупнее и центрирована через inset-x-0 + flex (надёжнее,
          чем left-1/2 + translate: не зависит от точной ширины элемента). */}
      <a
        href="#hero-details"
        className="absolute bottom-5 inset-x-0 flex flex-col items-center gap-2 text-neutral-300 transition hover:text-volt-400 animate-[bounce_2.2s_ease-in-out_infinite] sm:bottom-6"
        aria-label={t("hero.scrollHint")}
      >
        <span className="text-xs font-semibold uppercase tracking-widest sm:text-sm">{t("hero.scrollHint")}</span>
        <ChevronDown size={30} strokeWidth={2.5} />
      </a>
    </section>
  );
}

/**
 * Те же подробности (чек-лист/вторая кнопка/соц.доказательство), что на
 * десктопе живут прямо внутри Hero — на мобильном подключается отдельным
 * блоком сразу после <Hero /> в App.tsx. Не видео-фон, обычный тёмный фон,
 * как у остальных секций сайта — первый экран уже полностью "потратил"
 * яркий эффект инфлюенсера, здесь просто продолжение по смыслу.
 * На lg+ (десктоп) не рендерится вообще — там всё уже внутри Hero.
 */
export function HeroMobileDetails() {
  const { t } = useTranslation();
  const { region } = useRegion();

  const cheapest = getRegionAmounts(region).annual;
  const perDay = (Number(cheapest.perMonthAmount.replace(/\s/g, "").replace(",", ".")) / 30).toFixed(2);

  const checklist = [
    { text: t("hero.checklist.personalized") },
    { text: t("hero.checklist.results") },
    {
      text: t("hero.checklist.price", { price: formatAmount(region, cheapest.perMonthAmount), perDay: formatAmount(region, perDay) }),
      href: "#pricing",
    },
    { text: t("hero.checklist.flexible") },
    { text: t("hero.checklist.freeWeek") },
  ];

  return (
    <div id="hero-details" className="section-container py-8 lg:hidden">
      <ul className="flex flex-col gap-2 text-left">
        {checklist.map((item) => (
          <li key={item.text} className="flex items-center gap-2.5 text-base font-medium text-neutral-100">
            <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-volt-400 text-ink-950">
              <Check size={13} strokeWidth={3.5} />
            </span>
            {item.href ? (
              <a href={item.href} className="underline decoration-volt-400/50 decoration-2 underline-offset-4 transition hover:text-volt-400">
                {item.text}
              </a>
            ) : (
              item.text
            )}
          </li>
        ))}
      </ul>

      <div className="mt-5 flex items-center gap-3">
        <div className="flex -space-x-2">
          {AVATAR_COLORS.map((color, i) => (
            <div
              key={i}
              className={`flex h-7 w-7 items-center justify-center rounded-full border-2 border-ink-950 text-xs font-bold text-ink-950 ${color}`}
            >
              {String.fromCharCode(65 + i)}
            </div>
          ))}
        </div>
        <span className="text-sm text-neutral-400">{t("hero.socialProof")}</span>
      </div>
    </div>
  );
}
