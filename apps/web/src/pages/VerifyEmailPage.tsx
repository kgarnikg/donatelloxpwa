import { MailCheck } from "lucide-react";
import { Link } from "react-router-dom";

export default function VerifyEmailPage() {
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center bg-ink-950 px-6 text-center">
      <div className="mb-5 flex h-16 w-16 items-center justify-center rounded-full bg-volt-400/15 text-volt-400">
        <MailCheck size={30} />
      </div>
      <h1 className="font-display text-2xl font-bold">Подтвердите email</h1>
      <p className="mt-2 max-w-xs text-neutral-400">
        Мы отправили письмо со ссылкой для подтверждения. Перейдите по ней, чтобы продолжить.
      </p>
      <Link to="/login" className="btn-secondary mt-8">
        Вернуться ко входу
      </Link>
    </div>
  );
}
