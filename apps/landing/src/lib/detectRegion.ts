import { regionFromCountry, type Region } from "@donatellox/types";

/**
 * Регион по стране посетителя (IP → страна считает Vercel, см. api/geo.ts).
 * null — если функция недоступна (локальная разработка, сеть, таймаут):
 * тогда остаётся догадка по часовому поясу/языку устройства.
 */
export async function detectRegionByCountry(timeoutMs = 2500): Promise<Region | null> {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const res = await fetch("/api/geo", { signal: controller.signal, cache: "no-store" });
    if (!res.ok) return null;
    const data = (await res.json()) as { country?: string };
    return regionFromCountry(data.country);
  } catch {
    return null;
  } finally {
    clearTimeout(timer);
  }
}
