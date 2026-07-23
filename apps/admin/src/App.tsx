import { Routes, Route, Outlet } from "react-router-dom";
import { AdminShell } from "@/components/AdminShell";
import { RequireAdmin } from "@/components/RequireAdmin";
import AdminLoginPage from "@/pages/AdminLoginPage";
import OverviewPage from "@/pages/OverviewPage";
import UsersPage from "@/pages/UsersPage";
import ProgramsPage from "@/pages/ProgramsPage";
import VideosPage from "@/pages/VideosPage";
import PaymentsPage from "@/pages/PaymentsPage";

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
        <Route path="/videos" element={<VideosPage />} />
        <Route path="/payments" element={<PaymentsPage />} />
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
