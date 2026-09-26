# Письма Supabase Auth в стиле DonatelleX

Шаблоны на 10 языках: язык берётся из данных пользователя (`locale`, его
пишет регистрация и приложение при смене языка). Нет языка — английский.

Куда вставлять: Supabase → Authentication → Emails → Templates.

| Шаблон в Supabase | Subject (вставить содержимое файла) | Body (вставить содержимое файла) |
|---|---|---|
| Confirm signup | `confirm_signup.subject.txt` | `confirm_signup.html` |
| Reset password | `reset_password.subject.txt` | `reset_password.html` |
| Change email address | `change_email.subject.txt` | `change_email.html` |

Файлы вставлять целиком, включая первую строку `{{ $l := or .Data.locale "en" }}`
(она выбирает язык). После сохранения — проверить: регистрация / "Забыли пароль".

Письма напоминаний и награды за друга отправляет не Supabase, а ежедневная
задача `apps/web/api/cron/daily.ts` (тексты — `apps/web/api/_lib/email.ts`).
