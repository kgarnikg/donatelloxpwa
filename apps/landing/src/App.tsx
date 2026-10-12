import { Routes, Route } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { Header } from "@/components/Header";
import { Footer } from "@/components/Footer";
import { LegalPage } from "@/components/LegalPage";
import { LanguageSwitcher } from "@/components/LanguageSwitcher";
import { RegionSwitcher } from "@/components/RegionSwitcher";
import { RegionProvider, useRegion } from "@/context/RegionContext";
import { Hero, HeroMobileDetails } from "@/sections/Hero";
import { ForWomenMen } from "@/sections/ForWomenMen";
import { Modules } from "@/sections/Modules";
import { WeeklyPlan } from "@/sections/WeeklyPlan";
import { Pricing } from "@/sections/Pricing";
import { Steps } from "@/sections/Steps";
import { Faq } from "@/sections/Faq";
import { CallToAction } from "@/sections/CallToAction";
import { ExitIntentModal } from "@/components/ExitIntentModal";

function HomePage() {
  return (
    <>
      <Hero />
      <HeroMobileDetails />
      <Pricing />
      <ForWomenMen />
      <Modules />
      <WeeklyPlan />
      <Steps />
      <Faq />
      <CallToAction />
    </>
  );
}

/** Условия использования / публичная оферта (в т.ч. отказ от ответственности за здоровье). */
function TermsPage() {
  return <SectionsPage base="legal.terms" />;
}

/** Юридическая страница из i18n: title, intro, sections[{h, p}]. */
function SectionsPage({ base, footer }: { base: "legal.terms" | "legal.refund" | "legal.privacy"; footer?: string }) {
  const { t } = useTranslation();
  const sections = t(`${base}.sections`, { returnObjects: true }) as { h: string; p: string }[];
  return (
    <LegalPage title={t(`${base}.title`) as string}>
      <p>{t(`${base}.intro`)}</p>
      {Array.isArray(sections) &&
        sections.map((s) => (
          <section key={s.h} className="mt-6">
            <h2 className="font-display text-lg font-semibold text-neutral-100">{s.h}</h2>
            <p className="mt-2">{s.p}</p>
          </section>
        ))}
      {footer && <p className="mt-6">{footer}</p>}
    </LegalPage>
  );
}

/** Политика конфиденциальности (0092): что собираем, зачем, кому, права. */
function PrivacyPage() {
  const { t } = useTranslation();
  const { region } = useRegion();
  return <SectionsPage base="legal.privacy" footer={t(`legal.regionNotes.${region}`) as string} />;
}

/** Политика возврата (0086): 14 дней на отказ, пропорциональный возврат. */
function RefundPage() {
  return <SectionsPage base="legal.refund" />;
}

export default function App() {
  return (
    <RegionProvider>
      <Routes>
        <Route
          path="/"
          element={
            <div className="min-h-dvh bg-ink-950">
              <Header />
              <main>
                <HomePage />
              </main>
              <Footer />
            </div>
          }
        />
        <Route path="/terms" element={<TermsPage />} />
        <Route path="/privacy" element={<PrivacyPage />} />
        <Route path="/refund" element={<RefundPage />} />
      </Routes>
      {/* На мобильном эти же переключатели — в Header.tsx, рядом с кнопкой
          меню (variant="inline"), а не здесь внизу справа, где раньше
          перекрывали кнопки/соц.доказательство/стрелку в Hero. */}
      <div className="hidden md:block">
        <RegionSwitcher />
        <LanguageSwitcher />
      </div>
      <ExitIntentModal />
    </RegionProvider>
  );
}
