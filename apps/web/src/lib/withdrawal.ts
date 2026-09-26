import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { CURRENCY_SYMBOL, formatMinorAmount, type DisplayCurrency } from "@donatellox/types";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/context/AuthContext";

/**
 * Отказ от подписки и возврат (0086): 14 дней с оплаты, возврат — не позже
 * 14 дней после заявления. Всё считает сервер (get_withdrawal_info /
 * request_withdrawal) — здесь только показ.
 */

export const REFUND_POLICY_URL = "https://www.donatellex.com/refund";
export const TERMS_URL = "https://www.donatellex.com/terms";

export type WithdrawalReason = "no_paid" | "already_requested" | "refunded" | "window_passed" | null;
export type RefundStatus = "pending" | "approved" | "refunded" | "rejected";

export interface WithdrawalInfo {
  eligible: boolean;
  reason: WithdrawalReason;
  payment_id?: string;
  plan?: string | null;
  paid_at?: string;
  deadline?: string;
  paid_amount?: number;
  currency?: string;
  consent_given?: boolean;
  days_used?: number;
  period_days?: number;
  refund_amount?: number;
  request?: {
    id: string;
    status: RefundStatus;
    requested_at: string;
    refund_amount: number | null;
    currency: string | null;
    admin_comment: string | null;
    refunded_at: string | null;
    pay_by: string;
  } | null;
}

export function useWithdrawalInfo() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["withdrawal-info", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<WithdrawalInfo | null> => {
      const { data, error } = await supabase.rpc("get_withdrawal_info");
      if (error) throw error;
      return (data as WithdrawalInfo | null) ?? null;
    },
  });
}

export function useRequestWithdrawal() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (reason: string) => {
      const { error } = await supabase.rpc("request_withdrawal", { p_reason: reason || null });
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["withdrawal-info"] });
      queryClient.invalidateQueries({ queryKey: ["subscription"] });
    },
  });
}

/** Сумма в минорных единицах → "11,90 €" / "17 790 ֏". */
export function formatMoney(minor: number | null | undefined, currency: string | null | undefined): string {
  if (minor == null) return "—";
  const symbol = CURRENCY_SYMBOL[currency as DisplayCurrency] ?? currency ?? "";
  return `${formatMinorAmount(Number(minor))} ${symbol}`.trim();
}
