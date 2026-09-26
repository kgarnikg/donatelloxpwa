import { regionFromCountry, type Region } from "@donatellox/types";

/**
 * Регион по стране посетителя (IP → страна считает Vercel, см. api/geo.ts).
 * null — если функция недоступна (локальная разработка, сеть, таймаут):
 * тогда остаётся догадка по часовому поясу/языку устройства.
 */
export async function detectRegionByCountry(timeoutMs = 2500): Promise<Region | null> {
  return regionFromCountry(await detectCountry(timeoutMs));
}

/** Код страны посетителя ("ES", "AM") по IP — или null, если не удалось. */
export async function detectCountry(timeoutMs = 2500): Promise<string | null> {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const res = await fetch("/api/geo", { signal: controller.signal, cache: "no-store" });
    if (!res.ok) return null;
    const data = (await res.json()) as { country?: string };
    const code = (data.country ?? "").trim().toUpperCase();
    return /^[A-Z]{2}$/.test(code) ? code : null;
  } catch {
    return null;
  } finally {
    clearTimeout(timer);
  }
}
