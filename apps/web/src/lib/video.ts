/**
 * Универсальный плеер для упражнений — видео может быть либо прямой ссылкой
 * на файл (mp4 и т.п., напр. Cloudflare R2 / Bunny Storage), либо ссылкой
 * на YouTube. Эта функция определяет, какой перед нами случай, и для
 * YouTube достаёт ID видео, чтобы собрать чистый embed-URL.
 *
 * modestbranding=1 и rel=0 — по максимуму убирают лого YouTube и подсказки
 * чужих видео в конце ролика, чтобы плеер меньше выбивался из ощущения
 * "своего" приложения.
 */
export function getYouTubeEmbedUrl(url: string | null | undefined): string | null {
  if (!url) return null;
  const patterns = [
    /(?:youtube\.com\/watch\?v=|youtube\.com\/embed\/|youtu\.be\/|youtube\.com\/shorts\/)([\w-]{11})/,
  ];
  for (const re of patterns) {
    const match = url.match(re);
    if (match) {
      return `https://www.youtube-nocookie.com/embed/${match[1]}?modestbranding=1&rel=0&playsinline=1&autoplay=1`;
    }
  }
  return null;
}
