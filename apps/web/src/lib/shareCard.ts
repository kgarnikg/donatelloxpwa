import type { TFunction } from "i18next";
import type { WorkoutSummaryData } from "@/components/WorkoutSummary";

/**
 * Картинка "итог тренировки" для сторис (1080×1920, 9:16) — рисуем на
 * canvas в фирменном стиле и отдаём PNG. Делится через системное окно
 * "Поделиться" (Instagram, TikTok, WhatsApp, Telegram…) — у сайтов нет
 * прямого доступа к сторис Instagram/TikTok, это стандартный путь.
 */

const W = 1080;
const H = 1920;
const FONT = '"Manrope","Noto Sans Arabic","Noto Sans Armenian","Noto Sans Devanagari","Noto Sans Gurmukhi",system-ui,sans-serif';
const INK_950 = "#0A0B0D";
const INK_900 = "#111318";
const INK_700 = "#262A33";
const VOLT = "#A8E000";
const EMBER = "#FF7A45";
const MUTED = "#8B919C";

// Иконка кубка (lucide "trophy", сетка 24×24)
const TROPHY_PATHS = [
  "M6 9H4.5a2.5 2.5 0 0 1 0-5H6",
  "M18 9h1.5a2.5 2.5 0 0 0 0-5H18",
  "M4 22h16",
  "M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22",
  "M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22",
  "M18 2H6v7a6 6 0 0 0 12 0V2Z",
];

function wrap(ctx: CanvasRenderingContext2D, text: string, maxWidth: number, maxLines: number): string[] {
  const words = text.split(/\s+/).filter(Boolean);
  const lines: string[] = [];
  let line = "";
  for (const word of words) {
    const test = line ? `${line} ${word}` : word;
    if (ctx.measureText(test).width <= maxWidth || !line) line = test;
    else {
      lines.push(line);
      line = word;
    }
  }
  if (line) lines.push(line);
  if (lines.length > maxLines) {
    const kept = lines.slice(0, maxLines);
    kept[maxLines - 1] = kept[maxLines - 1].replace(/\s*\S*$/, "") + "…";
    return kept;
  }
  return lines;
}

function roundRect(ctx: CanvasRenderingContext2D, x: number, y: number, w: number, h: number, r: number) {
  ctx.beginPath();
  ctx.moveTo(x + r, y);
  ctx.arcTo(x + w, y, x + w, y + h, r);
  ctx.arcTo(x + w, y + h, x, y + h, r);
  ctx.arcTo(x, y + h, x, y, r);
  ctx.arcTo(x, y, x + w, y, r);
  ctx.closePath();
}

export interface ShareStat {
  value: string;
  label: string;
  accent?: boolean;
}

export async function renderShareCard(
  data: WorkoutSummaryData,
  stats: ShareStat[],
  t: TFunction,
  lang: string,
): Promise<Blob> {
  try {
    await Promise.all([document.fonts.load(`800 80px ${FONT}`), document.fonts.load(`500 40px ${FONT}`)]);
  } catch {
    // шрифт не догрузился — нарисуем системным
  }

  const canvas = document.createElement("canvas");
  canvas.width = W;
  canvas.height = H;
  const ctx = canvas.getContext("2d")!;
  ctx.direction = lang === "ar" ? "rtl" : "ltr";
  ctx.textAlign = "center";
  ctx.textBaseline = "alphabetic";

  // Фон + вольтовое свечение сверху
  ctx.fillStyle = INK_950;
  ctx.fillRect(0, 0, W, H);
  const glow = ctx.createRadialGradient(W / 2, 470, 0, W / 2, 470, 900);
  glow.addColorStop(0, "rgba(168,224,0,0.22)");
  glow.addColorStop(1, "rgba(168,224,0,0)");
  ctx.fillStyle = glow;
  ctx.fillRect(0, 0, W, H);

  // Бренд и дата
  ctx.fillStyle = VOLT;
  ctx.font = `800 54px ${FONT}`;
  if ("letterSpacing" in ctx) (ctx as CanvasRenderingContext2D & { letterSpacing: string }).letterSpacing = "8px";
  ctx.fillText("DONATELLEX", W / 2, 160);
  if ("letterSpacing" in ctx) (ctx as CanvasRenderingContext2D & { letterSpacing: string }).letterSpacing = "0px";
  ctx.fillStyle = MUTED;
  ctx.font = `500 36px ${FONT}`;
  ctx.fillText(new Date().toLocaleDateString(lang, { day: "numeric", month: "long", year: "numeric" }), W / 2, 225);

  // Кубок
  ctx.fillStyle = VOLT;
  ctx.beginPath();
  ctx.arc(W / 2, 470, 140, 0, Math.PI * 2);
  ctx.fill();
  ctx.save();
  const scale = 7.5;
  ctx.translate(W / 2 - 12 * scale, 470 - 12 * scale);
  ctx.scale(scale, scale);
  ctx.strokeStyle = INK_950;
  ctx.lineWidth = 2;
  ctx.lineCap = "round";
  ctx.lineJoin = "round";
  for (const d of TROPHY_PATHS) ctx.stroke(new Path2D(d));
  ctx.restore();

  // Заголовок и название тренировки
  ctx.fillStyle = "#FFFFFF";
  ctx.font = `800 78px ${FONT}`;
  let y = 740;
  for (const line of wrap(ctx, t("workout.summary.title"), W - 140, 2)) {
    ctx.fillText(line, W / 2, y);
    y += 90;
  }
  ctx.fillStyle = MUTED;
  ctx.font = `600 44px ${FONT}`;
  y += 5;
  for (const line of wrap(ctx, data.title, W - 160, 2)) {
    ctx.fillText(line, W / 2, y);
    y += 56;
  }

  // Плитки 2×2
  const top = Math.max(y + 40, 960);
  const boxW = 450;
  const boxH = 270;
  const gap = 40;
  const left = (W - boxW * 2 - gap) / 2;
  stats.slice(0, 4).forEach((s, i) => {
    const col = lang === "ar" ? 1 - (i % 2) : i % 2;
    const x = left + col * (boxW + gap);
    const by = top + Math.floor(i / 2) * (boxH + gap);
    roundRect(ctx, x, by, boxW, boxH, 44);
    ctx.fillStyle = INK_900;
    ctx.fill();
    ctx.lineWidth = 3;
    ctx.strokeStyle = s.accent ? "rgba(255,122,69,0.45)" : INK_700;
    ctx.stroke();

    ctx.fillStyle = s.accent ? EMBER : "#FFFFFF";
    let size = 92;
    ctx.font = `800 ${size}px ${FONT}`;
    while (ctx.measureText(s.value).width > boxW - 60 && size > 50) {
      size -= 6;
      ctx.font = `800 ${size}px ${FONT}`;
    }
    ctx.fillText(s.value, x + boxW / 2, by + 140);
    ctx.fillStyle = MUTED;
    ctx.font = `500 36px ${FONT}`;
    ctx.fillText(wrap(ctx, s.label, boxW - 50, 1)[0] ?? "", x + boxW / 2, by + 205);
  });

  // Подвал
  ctx.fillStyle = "#D4D7DD";
  ctx.font = `600 42px ${FONT}`;
  ctx.fillText(t("workout.summary.shareTagline"), W / 2, H - 200);
  ctx.fillStyle = VOLT;
  ctx.font = `800 48px ${FONT}`;
  ctx.fillText("app.donatellex.com", W / 2, H - 130);

  return new Promise((resolve, reject) =>
    canvas.toBlob((b) => (b ? resolve(b) : reject(new Error("toBlob failed"))), "image/png"),
  );
}

/** Системное "Поделиться" с картинкой; нет поддержки — скачиваем файл. */
export async function shareImage(blob: Blob, fileName: string): Promise<"shared" | "downloaded" | "cancelled"> {
  const file = new File([blob], fileName, { type: "image/png" });
  const nav = navigator as Navigator & { canShare?: (d: ShareData) => boolean };
  if (nav.share && nav.canShare?.({ files: [file] })) {
    try {
      await nav.share({ files: [file] });
      return "shared";
    } catch (e) {
      if ((e as Error).name === "AbortError") return "cancelled";
      // не вышло — падаем в скачивание
    }
  }
  downloadImage(blob, fileName);
  return "downloaded";
}

export function downloadImage(blob: Blob, fileName: string) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = fileName;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 2000);
}
