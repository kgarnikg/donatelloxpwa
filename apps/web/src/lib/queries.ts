import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import type { Subscription, WorkoutProgram, ProgressEntry } from "@donatellox/types";
import { useAuth } from "@/context/AuthContext";

export function usePrograms() {
  return useQuery({
    queryKey: ["programs"],
    queryFn: async (): Promise<WorkoutProgram[]> => {
      const { data, error } = await supabase
        .from("workout_programs")
        .select("*")
        .order("created_at", { ascending: false });
      if (error) throw error;
      return (data ?? []) as unknown as WorkoutProgram[];
    },
  });
}

export function useActiveSubscription() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["subscription", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<Subscription | null> => {
      const { data, error } = await supabase
        .from("subscriptions")
        .select("*")
        .eq("user_id", authUser!.id)
        .in("status", ["active", "trialing", "past_due"])
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (error) throw error;
      return data as unknown as Subscription | null;
    },
  });
}

export function useProgressHistory() {
  const { authUser } = useAuth();
  return useQuery({
    queryKey: ["progress", authUser?.id],
    enabled: !!authUser,
    queryFn: async (): Promise<ProgressEntry[]> => {
      const { data, error } = await supabase
        .from("progress_entries")
        .select("*")
        .eq("user_id", authUser!.id)
        .order("recorded_at", { ascending: true });
      if (error) throw error;
      return (data ?? []) as unknown as ProgressEntry[];
    },
  });
}
