/**
 * @donatellox/types
 * Единый источник истины для доменных типов платформы DonatelleX.
 * Используется во всех apps (web, admin, landing) и в Supabase Edge Functions.
 */

// ---------------------------------------------------------------------------
// Общие утилитарные типы
// ---------------------------------------------------------------------------

export type UUID = string;
export type ISODateString = string;
export type LocaleCode = "ru" | "en" | "es";

export interface Paginated<T> {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
  hasMore: boolean;
}

export type ApiResult<T> =
  | { success: true; data: T }
  | { success: false; error: ApiError };

export interface ApiError {
  code: string;
  message: string;
  details?: Record<string, unknown>;
}

// ---------------------------------------------------------------------------
// Пользователи и авторизация
// ---------------------------------------------------------------------------

export type AuthProvider = "email" | "google" | "apple" | "telegram";

export type UserRole = "athlete" | "coach" | "admin" | "superadmin";

export type Gender = "male" | "female" | "unspecified";

export type FitnessGoal =
  | "lose_weight"
  | "build_muscle"
  | "improve_endurance"
  | "general_fitness"
  | "rehabilitation";

export type ActivityLevel = "sedentary" | "light" | "moderate" | "active" | "very_active";

export type TrainingFormat = "gym" | "home";

export interface User {
  id: UUID;
  email: string;
  phone?: string;
  fullName: string;
  /** Имя / фамилия / страна (ISO-код) — с регистрации, 0081. */
  firstName?: string | null;
  lastName?: string | null;
  country?: string | null;
  /** Заблокирован в админке (0083). */
  isBlocked?: boolean;
  blockedAt?: string | null;
  blockedReason?: string | null;
  avatarUrl?: string;
  locale: LocaleCode;
  role: UserRole;
  authProvider: AuthProvider;
  emailVerified: boolean;
  onboardingCompleted: boolean;
  referralCode?: string;
  pendingDiscountPercent?: number;
  pendingDiscountReason?: string;
  createdAt: ISODateString;
  updatedAt: ISODateString;
  lastSeenAt?: ISODateString;
}

/** Данные "анкеты" — заполняются пользователем при онбординге. */
export interface UserProfile {
  userId: UUID;
  gender: Gender;
  birthDate?: ISODateString;
  heightCm?: number;
  weightKg?: number;
  activityLevel: ActivityLevel;
  goals: FitnessGoal[];
  trainingFormat: TrainingFormat;
  daysPerWeek?: number;
  healthNotes?: string;
  preferredLanguage: LocaleCode;
  /** Программа бесплатной недели (0080): ставится один раз — подобранная по анкете. */
  trialProgramId?: UUID | null;
  updatedAt: ISODateString;
}

// ---------------------------------------------------------------------------
// Подписки и платежи
// ---------------------------------------------------------------------------

export type SubscriptionPlan = "monthly" | "quarterly" | "semiannual" | "annual" | "lifetime";

export type SubscriptionStatus =
  | "trialing"
  | "active"
  | "past_due"
  | "canceled"
  | "expired"
  | "incomplete";

export interface Subscription {
  id: UUID;
  userId: UUID;
  plan: SubscriptionPlan;
  status: SubscriptionStatus;
  currentPeriodStart: ISODateString;
  currentPeriodEnd: ISODateString;
  cancelAtPeriodEnd: boolean;
  provider: SubscriptionProvider;
  providerSubscriptionId?: string;
  createdAt: ISODateString;
  updatedAt: ISODateString;
}

/**
 * "ararat" — vPOS Араратбанка (Ереван), основной провайдер с Фазы 3.
 * Остальные оставлены ради совместимости с уже существующими строками в БД.
 */
export type PaymentProvider = "stripe" | "paypal" | "yookassa" | "usdt" | "ararat";
/** provider подписки — то же самое + 'gift' (безлимитный доступ, выдаётся вручную в CMS, никогда не создаёт запись в payments). */
export type SubscriptionProvider = PaymentProvider | "gift";

export type PaymentStatus =
  | "pending"
  | "confirmed"
  | "failed"
  | "refunded"
  | "expired";

export type Currency = "EUR" | "USD" | "RUB" | "USDT" | "AMD";

export interface Payment {
  id: UUID;
  userId: UUID;
  subscriptionId?: UUID;
  provider: PaymentProvider;
  providerPaymentId: string;
  /** Наш номер заказа (уходит в банк как orderNumber), см. миграцию 0065. */
  orderNumber?: string;
  /** Какой период оплачен — сервер выдаёт доступ по этому полю, не по данным из браузера. */
  plan?: Exclude<SubscriptionPlan, "lifetime">;
  /** Применённая скидка в процентах (реферальная), 0 — без скидки. */
  discountPercent?: number;
  amount: number;
  currency: Currency;
  status: PaymentStatus;
  /** Для USDT: адрес кошелька и хеш транзакции в сети (TRC20 / ERC20). */
  cryptoTxHash?: string;
  cryptoNetwork?: "TRC20" | "ERC20" | "BEP20";
  rawPayload?: Record<string, unknown>;
  createdAt: ISODateString;
  confirmedAt?: ISODateString;
}

// ---------------------------------------------------------------------------
// Тренировки
// ---------------------------------------------------------------------------

export type MuscleGroup =
  | "chest"
  | "back"
  | "legs"
  | "shoulders"
  | "arms"
  | "core"
  | "full_body"
  | "cardio";

export type ExerciseDifficulty = "beginner" | "intermediate" | "advanced";

export interface Exercise {
  id: UUID;
  slug: string;
  title: string;
  /** Английский перевод названия. Добавлено в 0029/0030 (Фаза 6 — локализация контента). */
  titleEn?: string;
  /** Испанский перевод названия. Добавлено в 0039/0040 (Фаза 6). */
  titleEs?: string;
  /** Армянский перевод названия. Добавлено в 0049/0050 (Фаза 6). */
  titleHy?: string;
  description?: string;
  muscleGroups: MuscleGroup[];
  difficulty: ExerciseDifficulty;
  videoUrl?: string;
  thumbnailUrl?: string;
  durationSeconds?: number;
  equipment?: string[];
  /**
   * На что можно заменить кнопкой "Заменить" (0079): chest, back, triceps,
   * quads, block_core... "other" — заменять нечего (заголовок-плейсхолдер).
   */
  swapGroup?: string | null;
}

export interface WorkoutSet {
  exerciseId: UUID;
  order: number;
  reps?: number;
  durationSeconds?: number;
  restSeconds: number;
  weightKg?: number;
  notes?: string;
  /** Английский перевод notes. Добавлено в 0029 (Фаза 6). */
  notesEn?: string;
  /** Испанский перевод notes. Добавлено в 0039 (Фаза 6). */
  notesEs?: string;
  /** Армянский перевод notes. Добавлено в 0049 (Фаза 6). */
  notesHy?: string;
}

export interface Workout {
  id: UUID;
  programId: UUID;
  title: string;
  /** Английский перевод title. Добавлено в 0029 (Фаза 6). */
  titleEn?: string;
  /** Испанский перевод title. Добавлено в 0039 (Фаза 6). */
  titleEs?: string;
  /** Армянский перевод title. Добавлено в 0049 (Фаза 6). */
  titleHy?: string;
  order: number;
  estimatedDurationMinutes: number;
  /** Заголовок блока недель, напр. "Недели 1–2 · LEVEL 1A". Добавлено в 0013. */
  weekLabel?: string;
  /** Английский перевод weekLabel. Добавлено в 0029 (Фаза 6). */
  weekLabelEn?: string;
  /** Испанский перевод weekLabel. Добавлено в 0039 (Фаза 6). */
  weekLabelEs?: string;
  /** Армянский перевод weekLabel. Добавлено в 0049 (Фаза 6). */
  weekLabelHy?: string;
  /** Порядок блока недель в программе (1, 2, 3...), отдельно от `order` — дня внутри блока. Добавлено в 0013. */
  weekOrder: number;
  sets: WorkoutSet[];
}

export interface WorkoutProgram {
  id: UUID;
  slug: string;
  title: string;
  /** Английский перевод title. Добавлено в 0029 (Фаза 6). */
  titleEn?: string;
  /** Испанский перевод title. Добавлено в 0039 (Фаза 6). */
  titleEs?: string;
  /** Армянский перевод title. Добавлено в 0049 (Фаза 6). */
  titleHy?: string;
  description: string;
  /** Английский перевод description. Добавлено в 0029 (Фаза 6). */
  descriptionEn?: string;
  /** Испанский перевод description. Добавлено в 0039 (Фаза 6). */
  descriptionEs?: string;
  /** Армянский перевод description. Добавлено в 0049 (Фаза 6). */
  descriptionHy?: string;
  coverUrl?: string;
  goal: FitnessGoal;
  /** Целевой пол программы. `"unspecified"` — универсальная, подходит любому. Добавлено в 0012. */
  gender: Gender;
  /** Целевой формат тренировок. `"any"` — универсальная, подходит и залу, и дому. Добавлено в 0012. */
  trainingFormat: TrainingFormat | "any";
  difficulty: ExerciseDifficulty;
  durationWeeks: number;
  workoutsPerWeek: number;
  isPremium: boolean;
  locale: LocaleCode;
  createdAt: ISODateString;
  updatedAt: ISODateString;
}

/** Запись в дневнике тренировок пользователя. */
export interface WorkoutLogEntry {
  id: UUID;
  userId: UUID;
  workoutId: UUID;
  completedAt: ISODateString;
  durationMinutes: number;
  perceivedEffort?: 1 | 2 | 3 | 4 | 5;
  notes?: string;
  /** Вес × повторения, просуммированные по всем подходам тренировки. Добавлено в 0026. */
  totalVolumeKg: number;
  completedSets: Array<{
    exerciseId: UUID;
    reps?: number;
    weightKg?: number;
    durationSeconds?: number;
  }>;
}

/** Точка прогресса пользователя (вес, замеры, фото). */
export interface ProgressEntry {
  id: UUID;
  userId: UUID;
  recordedAt: ISODateString;
  weightKg?: number;
  bodyFatPercent?: number;
  measurements?: Record<string, number>;
  photoUrls?: string[];
}

// ---------------------------------------------------------------------------
// Награды и достижения (0023). Разблокировка считается на сервере
// триггером после каждой записи в workout_logs — см. миграцию. Личные
// рекорды по весам отдельной таблицей не хранятся — выводятся на клиенте
// из WorkoutLogEntry.completedSets (там уже есть exerciseId + weightKg).
// ---------------------------------------------------------------------------

export type AchievementCategory = "workouts" | "streak" | "special" | "volume";

export interface Achievement {
  id: UUID;
  slug: string;
  title: string;
  description: string;
  icon: string;
  category: AchievementCategory;
  threshold: number;
  sortOrder: number;
  createdAt: ISODateString;
}

export interface UserAchievement {
  id: UUID;
  userId: UUID;
  achievementId: UUID;
  unlockedAt: ISODateString;
}

/** Достижение из каталога, дополненное статусом разблокировки для текущего пользователя. */
export interface AchievementWithStatus extends Achievement {
  unlockedAt: ISODateString | null;
}

/** Личный рекорд по упражнению — вычисляется на клиенте, не хранится в БД. */
export interface PersonalRecord {
  exerciseId: UUID;
  exerciseTitle: string;
  bestWeightKg: number;
  achievedAt: ISODateString;
}

// ---------------------------------------------------------------------------
// Калории — автоматическая оценка расхода (0025). Основная формула — в
// apps/web/src/lib/calories.ts, здесь только форма данных для ручного
// переопределения (когда у пользователя есть более точные данные, например
// с умных часов).
// ---------------------------------------------------------------------------

export interface CalorieOverride {
  id: UUID;
  userId: UUID;
  loggedAt: string; // YYYY-MM-DD
  calories: number;
  createdAt: ISODateString;
  updatedAt: ISODateString;
}

// ---------------------------------------------------------------------------
// Уведомления (после MVP, но типы удобно завести заранее)
// ---------------------------------------------------------------------------

export type NotificationType =
  | "workout_reminder"
  | "subscription_expiring"
  | "payment_failed"
  | "new_program"
  | "system";

export interface Notification {
  id: UUID;
  userId: UUID;
  type: NotificationType;
  title: string;
  body: string;
  read: boolean;
  createdAt: ISODateString;
}

export * from "./pricing";

// ---------------------------------------------------------------------------
// Утилита: конвертация snake_case → camelCase
// ---------------------------------------------------------------------------
//
// Supabase возвращает строки БД с колонками в snake_case (duration_weeks,
// is_premium и т.д.), а все типы в этом пакете описаны в camelCase.
// Использовать `as unknown as T` без реальной конвертации ключей — баг:
// TypeScript "поверит" каста, но в рантайме поля вроде `durationWeeks`
// будут `undefined`, потому что реальный ключ — `duration_weeks`.
//
// Всегда прогоняйте результат `.select()` через `toCamelCase<T>(data)`
// перед тем, как использовать его как значение типа из этого пакета.
function snakeToCamelKey(key: string): string {
  return key.replace(/_([a-z0-9])/g, (_, char: string) => char.toUpperCase());
}

export function toCamelCase<T>(input: unknown): T {
  if (Array.isArray(input)) {
    return input.map((item) => toCamelCase(item)) as unknown as T;
  }
  if (input !== null && typeof input === "object" && !(input instanceof Date)) {
    const out: Record<string, unknown> = {};
    for (const [key, value] of Object.entries(input as Record<string, unknown>)) {
      out[snakeToCamelKey(key)] = toCamelCase(value);
    }
    return out as T;
  }
  return input as T;
}
