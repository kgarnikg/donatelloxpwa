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

function TermsPage() {
  const { t } = useTranslation();
  const { region } = useRegion();
  return (
    <LegalPage title={t("legal.terms.title") as string}>
      <p>{t("legal.terms.body")}</p>
      <p className="mt-4">{t(`legal.regionNotes.${region}`)}</p>
    </LegalPage>
  );
}

function PrivacyPage() {
  const { t } = useTranslation();
  const { region } = useRegion();
  return (
    <LegalPage title={t("legal.privacy.title") as string}>
      <p>{t("legal.privacy.body")}</p>
      <p className="mt-4">{t(`legal.regionNotes.${region}`)}</p>
    </LegalPage>
  );
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
