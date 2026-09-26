import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";

export default function NotFoundPage() {
  const { t } = useTranslation();
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
      <p className="font-display text-6xl font-bold text-volt-400">404</p>
      <h1 className="mt-2 text-xl font-semibold">{t("notFound.title")}</h1>
      <Link to="/dashboard" className="btn-primary mt-8">
        {t("notFound.home")}
      </Link>
    </div>
  );
}
