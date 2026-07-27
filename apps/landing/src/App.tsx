import { Routes, Route } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { Header } from "@/components/Header";
import { Footer } from "@/components/Footer";
import { LegalPage } from "@/components/LegalPage";
import { LanguageSwitcher } from "@/components/LanguageSwitcher";
import { Hero } from "@/sections/Hero";
import { Modules } from "@/sections/Modules";
import { WeeklyPlan } from "@/sections/WeeklyPlan";
import { Pricing } from "@/sections/Pricing";
import { Steps } from "@/sections/Steps";
import { Faq } from "@/sections/Faq";
import { CallToAction } from "@/sections/CallToAction";

function HomePage() {
  return (
    <>
      <Hero />
      <Modules />
      <WeeklyPlan />
      <Pricing />
      <Steps />
      <Faq />
      <CallToAction />
    </>
  );
}

function TermsPage() {
  const { t } = useTranslation();
  return (
    <LegalPage title={t("legal.terms.title") as string}>
      <p>{t("legal.terms.body")}</p>
    </LegalPage>
  );
}

function PrivacyPage() {
  const { t } = useTranslation();
  return (
    <LegalPage title={t("legal.privacy.title") as string}>
      <p>{t("legal.privacy.body")}</p>
    </LegalPage>
  );
}

export default function App() {
  return (
    <>
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
      <LanguageSwitcher />
    </>
  );
}
