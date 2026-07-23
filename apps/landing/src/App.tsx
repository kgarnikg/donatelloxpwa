import { Routes, Route } from "react-router-dom";
import { Header } from "@/components/Header";
import { Footer } from "@/components/Footer";
import { LegalPage } from "@/components/LegalPage";
import { Hero } from "@/sections/Hero";
import { Modules } from "@/sections/Modules";
import { Pricing } from "@/sections/Pricing";
import { Faq } from "@/sections/Faq";
import { CallToAction } from "@/sections/CallToAction";

function HomePage() {
  return (
    <>
      <Hero />
      <Modules />
      <Pricing />
      <Faq />
      <CallToAction />
    </>
  );
}

function TermsPage() {
  return (
    <LegalPage title="Условия использования">
      <p>
        Используя приложение и сайт DonatelloX, вы соглашаетесь с настоящими условиями. Полный
        текст условий использования будет опубликован здесь до запуска платформы в продакшн.
      </p>
    </LegalPage>
  );
}

function PrivacyPage() {
  return (
    <LegalPage title="Политика конфиденциальности">
      <p>
        DonatelloX обрабатывает персональные данные пользователей в соответствии с применимым
        законодательством о защите данных. Полный текст политики конфиденциальности будет
        опубликован здесь до запуска платформы в продакшн.
      </p>
    </LegalPage>
  );
}

export default function App() {
  return (
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
  );
}
