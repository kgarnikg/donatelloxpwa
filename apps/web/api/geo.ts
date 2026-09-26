// Vercel Edge Function: GET /api/geo → { "country": "AM" }
// Страну посетителя Vercel сам кладёт в заголовок x-vercel-ip-country
// (по IP). Нужна, чтобы гости из Армении сразу видели цены в драмах
// (требование армянского банка), а не угадывать по языку браузера.
export const config = { runtime: "edge" };

export default function handler(request: Request): Response {
  const country = request.headers.get("x-vercel-ip-country") ?? "";
  return new Response(JSON.stringify({ country }), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "cache-control": "private, no-store",
    },
  });
}
