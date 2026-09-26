import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, Bell } from "lucide-react";

export default function NotificationsSettingsPage() {
  const { t } = useTranslation();

  return (
    <div className="min-h-dvh bg-ink-950 px-5 pt-8">
      <Link to="/profile" className="mb-6 inline-flex items-center gap-1 text-sm text-neutral-400">
        <ArrowLeft size={16} /> {t("common.back")}
      </Link>

      <h1 className="mb-6 font-display text-2xl font-bold">{t("profile.notifications")}</h1>

      <div className="card flex flex-col items-center py-10 text-center">
        <div className="mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-volt-400/10 text-volt-400">
          <Bell size={24} />
        </div>
        <p className="font-semibold">{t("common.comingSoon")}</p>
        <p className="mt-1.5 max-w-xs text-sm text-neutral-400">
          {t("profile.notificationsSoon")}
        </p>
      </div>
    </div>
  );
}
