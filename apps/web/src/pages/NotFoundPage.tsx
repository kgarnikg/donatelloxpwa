import { Link } from "react-router-dom";

export default function NotFoundPage() {
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
      <p className="font-display text-6xl font-bold text-volt-400">404</p>
      <h1 className="mt-2 text-xl font-semibold">Страница не найдена</h1>
      <Link to="/dashboard" className="btn-primary mt-8">
        На главную
      </Link>
    </div>
  );
}
