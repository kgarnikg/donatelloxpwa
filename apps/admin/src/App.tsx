import { Routes, Route, Outlet } from "react-router-dom";
import { AdminShell } from "@/components/AdminShell";
import { RequireAdmin } from "@/components/RequireAdmin";
import AdminLoginPage from "@/pages/AdminLoginPage";
import OverviewPage from "@/pages/OverviewPage";
import UsersPage from "@/pages/UsersPage";
import ProgramsPage from "@/pages/ProgramsPage";
import ProgramDetailPage from "@/pages/ProgramDetailPage";
import VideosPage from "@/pages/VideosPage";
import PaymentsPage from "@/pages/PaymentsPage";
import SettingsPage from "@/pages/SettingsPage";
import CatchUpProgressPage from "@/pages/CatchUpProgressPage";

function AuthorizedLayout() {
  return (
    <RequireAdmin>
      <AdminShell>
        <Outlet />
      </AdminShell>
    </RequireAdmin>
  );
}

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<AdminLoginPage />} />

      <Route element={<AuthorizedLayout />}>
        <Route path="/" element={<OverviewPage />} />
        <Route path="/users" element={<UsersPage />} />
        <Route path="/programs" element={<ProgramsPage />} />
        <Route path="/programs/:programId" element={<ProgramDetailPage />} />
        <Route path="/videos" element={<VideosPage />} />
        <Route path="/payments" element={<PaymentsPage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="/catch-up" element={<CatchUpProgressPage />} />
      </Route>

      <Route
        path="*"
        element={
          <div className="flex min-h-dvh items-center justify-center bg-ink-950 text-neutral-400">
            Страница не найдена
          </div>
        }
      />
    </Routes>
  );
}
