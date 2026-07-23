/**
 * @donatellox/types
 * Единый источник истины для доменных типов платформы DonatelloX.
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

export interface User {
  id: UUID;
  email: string;
  phone?: string;
  fullName: string;
  avatarUrl?: string;
  locale: LocaleCode;
  role: UserRole;
  authProvider: AuthProvider;
  emailVerified: boolean;
  onboardingCompleted: boolean;
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
  healthNotes?: string;
  preferredLanguage: LocaleCode;
  updatedAt: ISODateString;
}

// ---------------------------------------------------------------------------
// Подписки и платежи
// ---------------------------------------------------------------------------

export type SubscriptionPlan = "monthly" | "quarterly" | "semiannual" | "annual";

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
  provider: PaymentProvider;
  providerSubscriptionId?: string;
  createdAt: ISODateString;
  updatedAt: ISODateString;
}

export type PaymentProvider = "stripe" | "paypal" | "yookassa" | "usdt";

export type PaymentStatus =
  | "pending"
  | "confirmed"
  | "failed"
  | "refunded"
  | "expired";

export type Currency = "EUR" | "USD" | "RUB" | "USDT";

export interface Payment {
  id: UUID;
  userId: UUID;
  subscriptionId?: UUID;
  provider: PaymentProvider;
  providerPaymentId: string;
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
  description?: string;
  muscleGroups: MuscleGroup[];
  difficulty: ExerciseDifficulty;
  videoUrl?: string;
  thumbnailUrl?: string;
  durationSeconds?: number;
  equipment?: string[];
}

export interface WorkoutSet {
  exerciseId: UUID;
  order: number;
  reps?: number;
  durationSeconds?: number;
  restSeconds: number;
  weightKg?: number;
  notes?: string;
}

export interface Workout {
  id: UUID;
  programId: UUID;
  title: string;
  order: number;
  estimatedDurationMinutes: number;
  sets: WorkoutSet[];
}

export interface WorkoutProgram {
  id: UUID;
  slug: string;
  title: string;
  description: string;
  coverUrl?: string;
  goal: FitnessGoal;
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
