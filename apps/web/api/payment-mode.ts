// GET /api/payment-mode — в каком режиме сейчас оплата (для экрана оплаты).
//   test — тестовая среда банка (10 ֏, только админы);
//   open — оплата открыта всем (VITE_PAYMENTS_ENABLED=true), иначе в боевом
//          режиме платить могут только админы (проверка перед запуском).
// Секретов не отдаёт.
import { env, json, vposConfigured, vposTestMode } from "./_lib/vpos";

export const config = { runtime: "edge" };

export default function handler(): Response {
  return json({
    configured: vposConfigured(),
    test: vposTestMode(),
    open: env("VITE_PAYMENTS_ENABLED") === "true",
  });
}
