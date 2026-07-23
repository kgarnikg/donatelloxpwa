/**
 * @donatellox/validation
 * Единые схемы валидации (Zod) для форм и API-запросов.
 * Импортируются и на фронтенде (react-hook-form / формы), и в Supabase Edge Functions.
 */
import { z } from "zod";

// ---------------------------------------------------------------------------
// Общие примитивы
// ---------------------------------------------------------------------------

export const uuidSchema = z.string().uuid({ message: "Некорректный идентификатор" });

export const localeSchema = z.enum(["ru", "en", "es"]);

export const emailSchema = z
  .string()
  .trim()
  .min(1, "Введите email")
  .email("Введите корректный email");

/**
 * Пароль: минимум 8 символов, хотя бы одна буква и одна цифра.
 * Осознанно не требуем спецсимволы — это снижает трение при регистрации,
 * но сохраняет базовый уровень надежности.
 */
export const passwordSchema = z
  .string()
  .min(8, "Минимум 8 символов")
  .max(128, "Слишком длинный пароль")
  .regex(/[A-Za-z]/, "Пароль должен содержать хотя бы одну букву")
  .regex(/[0-9]/, "Пароль должен содержать хотя бы одну цифру");

export const phoneSchema = z
  .string()
  .regex(/^\+?[1-9]\d{7,14}$/, "Введите корректный номер телефона в международном формате");

// ---------------------------------------------------------------------------
// Авторизация
// ---------------------------------------------------------------------------

export const registerSchema = z
  .object({
    fullName: z.string().trim().min(2, "Введите имя").max(120),
    email: emailSchema,
    password: passwordSchema,
    passwordConfirm: z.string(),
    locale: localeSchema.default("ru"),
    acceptedTerms: z.literal(true, {
      errorMap: () => ({ message: "Необходимо принять условия использования" }),
    }),
  })
  .refine((data) => data.password === data.passwordConfirm, {
    message: "Пароли не совпадают",
    path: ["passwordConfirm"],
  });

export type RegisterInput = z.infer<typeof registerSchema>;

export const loginSchema = z.object({
  email: emailSchema,
  password: z.string().min(1, "Введите пароль"),
});

export type LoginInput = z.infer<typeof loginSchema>;

export const oauthCallbackSchema = z.object({
  provider: z.enum(["google", "apple", "telegram"]),
  code: z.string().min(1),
  state: z.string().optional(),
});

export type OAuthCallbackInput = z.infer<typeof oauthCallbackSchema>;

export const forgotPasswordSchema = z.object({
  email: emailSchema,
});

export const resetPasswordSchema = z
  .object({
    token: z.string().min(1),
    password: passwordSchema,
    passwordConfirm: z.string(),
  })
  .refine((data) => data.password === data.passwordConfirm, {
    message: "Пароли не совпадают",
    path: ["passwordConfirm"],
  });

// ---------------------------------------------------------------------------
// Анкета (онбординг)
// ---------------------------------------------------------------------------

export const genderSchema = z.enum(["male", "female", "unspecified"]);

export const fitnessGoalSchema = z.enum([
  "lose_weight",
  "build_muscle",
  "improve_endurance",
  "general_fitness",
  "rehabilitation",
]);

export const activityLevelSchema = z.enum([
  "sedentary",
  "light",
  "moderate",
  "active",
  "very_active",
]);

export const onboardingSchema = z.object({
  gender: genderSchema,
  birthDate: z
    .string()
    .refine((v) => !Number.isNaN(Date.parse(v)), "Введите корректную дату")
    .optional(),
  heightCm: z.coerce.number().min(100, "Минимум 100 см").max(250, "Максимум 250 см").optional(),
  weightKg: z.coerce.number().min(30, "Минимум 30 кг").max(300, "Максимум 300 кг").optional(),
  activityLevel: activityLevelSchema,
  goals: z.array(fitnessGoalSchema).min(1, "Выберите хотя бы одну цель"),
  healthNotes: z.string().max(1000).optional(),
  preferredLanguage: localeSchema,
});

export type OnboardingInput = z.infer<typeof onboardingSchema>;

// ---------------------------------------------------------------------------
// Подписки и платежи
// ---------------------------------------------------------------------------

export const subscriptionPlanSchema = z.enum(["monthly", "quarterly", "annual", "lifetime"]);

export const paymentProviderSchema = z.enum(["stripe", "paypal", "yookassa", "usdt"]);

export const currencySchema = z.enum(["EUR", "USD", "RUB", "USDT"]);

export const createCheckoutSchema = z.object({
  plan: subscriptionPlanSchema,
  provider: paymentProviderSchema,
  currency: currencySchema,
  successUrl: z.string().url().optional(),
  cancelUrl: z.string().url().optional(),
});

export type CreateCheckoutInput = z.infer<typeof createCheckoutSchema>;

/** Валидация для собственного USDT-кошелька — подтверждение платежа по хешу транзакции. */
export const usdtConfirmationSchema = z.object({
  txHash: z
    .string()
    .regex(/^0x[a-fA-F0-9]{64}$/, "Некорректный хеш транзакции ERC20")
    .or(z.string().regex(/^[a-fA-F0-9]{64}$/, "Некорректный хеш транзакции TRC20")),
  network: z.enum(["TRC20", "ERC20", "BEP20"]),
  expectedAmount: z.coerce.number().positive(),
  userId: uuidSchema,
});

export type UsdtConfirmationInput = z.infer<typeof usdtConfirmationSchema>;

/** Общая форма для входящих вебхуков платежных систем (до провайдер-специфичного парсинга). */
export const webhookEnvelopeSchema = z.object({
  provider: paymentProviderSchema,
  eventId: z.string().min(1),
  receivedAt: z.string().default(() => new Date().toISOString()),
});

// ---------------------------------------------------------------------------
// Профиль / личный кабинет
// ---------------------------------------------------------------------------

export const updateProfileSchema = z.object({
  fullName: z.string().trim().min(2).max(120).optional(),
  phone: phoneSchema.optional(),
  avatarUrl: z.string().url().optional(),
  locale: localeSchema.optional(),
});

export type UpdateProfileInput = z.infer<typeof updateProfileSchema>;

// ---------------------------------------------------------------------------
// Дневник тренировок / прогресс
// ---------------------------------------------------------------------------

export const workoutLogSchema = z.object({
  workoutId: uuidSchema,
  durationMinutes: z.coerce.number().min(1).max(600),
  perceivedEffort: z.coerce.number().int().min(1).max(5).optional(),
  notes: z.string().max(2000).optional(),
  completedSets: z
    .array(
      z.object({
        exerciseId: uuidSchema,
        reps: z.coerce.number().int().min(0).optional(),
        weightKg: z.coerce.number().min(0).optional(),
        durationSeconds: z.coerce.number().min(0).optional(),
      }),
    )
    .default([]),
});

export type WorkoutLogInput = z.infer<typeof workoutLogSchema>;

export const progressEntrySchema = z.object({
  weightKg: z.coerce.number().min(20).max(400).optional(),
  bodyFatPercent: z.coerce.number().min(1).max(70).optional(),
  measurements: z.record(z.string(), z.coerce.number()).optional(),
  photoUrls: z.array(z.string().url()).max(10).optional(),
});

export type ProgressEntryInput = z.infer<typeof progressEntrySchema>;

// ---------------------------------------------------------------------------
// Утилита для парсинга форм с человекочитаемыми ошибками
// ---------------------------------------------------------------------------

export function formatZodError(error: z.ZodError): Record<string, string> {
  const fieldErrors: Record<string, string> = {};
  for (const issue of error.issues) {
    const key = issue.path.join(".") || "_root";
    if (!fieldErrors[key]) fieldErrors[key] = issue.message;
  }
  return fieldErrors;
}

export function safeParseForm<T extends z.ZodTypeAny>(
  schema: T,
  data: unknown,
): { success: true; data: z.infer<T> } | { success: false; errors: Record<string, string> } {
  const result = schema.safeParse(data);
  if (result.success) {
    return { success: true, data: result.data };
  }
  return { success: false, errors: formatZodError(result.error) };
}
