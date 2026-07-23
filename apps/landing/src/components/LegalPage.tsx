import { Link } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

export function LegalPage({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="min-h-dvh bg-ink-950 px-6 py-20">
      <div className="mx-auto max-w-2xl">
        <Link to="/" className="mb-8 inline-flex items-center gap-1 text-sm text-neutral-400">
          <ArrowLeft size={16} /> На главную
        </Link>
        <h1 className="font-display text-3xl font-bold">{title}</h1>
        <div className="prose prose-invert mt-6 max-w-none text-neutral-400">{children}</div>
      </div>
    </div>
  );
}
