// Письма, которые отправляет ежедневная задача (cron/daily.ts) через Resend:
// напоминание об окончании доступа и награда за приглашённого друга.
// Оформление — как у писем Supabase (supabase/email-templates): тёмный фон,
// лаймовая кнопка. {name} — "Имя, " (или пусто), {date} — дата на языке
// пользователя, {friend} — имя приглашённого друга.

export const EMAIL_LANGS = ["ru", "en", "es", "de", "it", "uk", "hy", "ar", "hi", "pa"] as const;
export type EmailLang = (typeof EMAIL_LANGS)[number];

interface EmailTexts {
  subject: string;
  title: string;
  text: string;
  button: string;
}

const STRINGS: Record<EmailLang, { reminder: EmailTexts; reward: EmailTexts; friend: string; footer: string }> = {
  "ru": {
    "reminder": {
      "subject": "Доступ к DonatelleX заканчивается {date}",
      "title": "Твой доступ скоро закончится",
      "text": "{name}оплаченный период заканчивается {date}. Продли доступ заранее, чтобы не прерывать тренировки и не терять темп.",
      "button": "Продлить доступ"
    },
    "reward": {
      "subject": "+1 месяц DonatelleX в подарок",
      "title": "Спасибо, что привёл друга!",
      "text": "{name}{friend} уже месяц тренируется с DonatelleX — дарим тебе месяц доступа. Твой доступ теперь действует до {date}.",
      "button": "Открыть приложение"
    },
    "friend": "Твой друг",
    "footer": "Тренировки и прогресс с Владимиром Donatellex"
  },
  "en": {
    "reminder": {
      "subject": "Your DonatelleX access ends on {date}",
      "title": "Your access ends soon",
      "text": "{name}your paid period ends on {date}. Renew in advance so your training doesn't stop and you keep your momentum.",
      "button": "Renew access"
    },
    "reward": {
      "subject": "+1 month of DonatelleX, on us",
      "title": "Thanks for inviting a friend!",
      "text": "{name}{friend} has been training with DonatelleX for a month — here's a free month for you. Your access is now valid until {date}.",
      "button": "Open the app"
    },
    "friend": "Your friend",
    "footer": "Workouts and progress with Vladimir Donatellex"
  },
  "es": {
    "reminder": {
      "subject": "Tu acceso a DonatelleX termina el {date}",
      "title": "Tu acceso termina pronto",
      "text": "{name}tu periodo pagado termina el {date}. Renueva con antelación para no interrumpir tus entrenamientos ni perder el ritmo.",
      "button": "Renovar acceso"
    },
    "reward": {
      "subject": "+1 mes de DonatelleX de regalo",
      "title": "¡Gracias por invitar a un amigo!",
      "text": "{name}{friend} lleva un mes entrenando con DonatelleX: te regalamos un mes de acceso. Tu acceso ahora es válido hasta el {date}.",
      "button": "Abrir la app"
    },
    "friend": "Tu amigo",
    "footer": "Entrenamientos y progreso con Vladimir Donatellex"
  },
  "de": {
    "reminder": {
      "subject": "Dein DonatelleX-Zugang endet am {date}",
      "title": "Dein Zugang endet bald",
      "text": "{name}dein bezahlter Zeitraum endet am {date}. Verlängere rechtzeitig, damit dein Training nicht unterbrochen wird.",
      "button": "Zugang verlängern"
    },
    "reward": {
      "subject": "+1 Monat DonatelleX geschenkt",
      "title": "Danke, dass du einen Freund eingeladen hast!",
      "text": "{name}{friend} trainiert seit einem Monat mit DonatelleX – dafür schenken wir dir einen Monat Zugang. Dein Zugang gilt jetzt bis {date}.",
      "button": "App öffnen"
    },
    "friend": "Dein Freund",
    "footer": "Training und Fortschritt mit Vladimir Donatellex"
  },
  "it": {
    "reminder": {
      "subject": "Il tuo accesso a DonatelleX scade il {date}",
      "title": "Il tuo accesso scade presto",
      "text": "{name}il tuo periodo pagato termina il {date}. Rinnova in anticipo per non interrompere gli allenamenti e non perdere il ritmo.",
      "button": "Rinnova accesso"
    },
    "reward": {
      "subject": "+1 mese di DonatelleX in regalo",
      "title": "Grazie per aver invitato un amico!",
      "text": "{name}{friend} si allena con DonatelleX da un mese: ti regaliamo un mese di accesso. Ora il tuo accesso è valido fino al {date}.",
      "button": "Apri l'app"
    },
    "friend": "Il tuo amico",
    "footer": "Allenamenti e progressi con Vladimir Donatellex"
  },
  "uk": {
    "reminder": {
      "subject": "Доступ до DonatelleX закінчується {date}",
      "title": "Твій доступ скоро закінчиться",
      "text": "{name}оплачений період закінчується {date}. Продовж доступ заздалегідь, щоб не переривати тренування і не втрачати темп.",
      "button": "Продовжити доступ"
    },
    "reward": {
      "subject": "+1 місяць DonatelleX у подарунок",
      "title": "Дякуємо, що запросив друга!",
      "text": "{name}{friend} уже місяць тренується з DonatelleX — даруємо тобі місяць доступу. Тепер твій доступ діє до {date}.",
      "button": "Відкрити застосунок"
    },
    "friend": "Твій друг",
    "footer": "Тренування і прогрес з Володимиром Donatellex"
  },
  "hy": {
    "reminder": {
      "subject": "DonatelleX-ի մուտքդ ավարտվում է {date}",
      "title": "Մուտքդ շուտով կավարտվի",
      "text": "{name}վճարված ժամկետն ավարտվում է {date}։ Երկարաձգիր նախօրոք, որ մարզումներդ չընդհատվեն։",
      "button": "Երկարաձգել մուտքը"
    },
    "reward": {
      "subject": "+1 ամիս DonatelleX՝ նվեր",
      "title": "Շնորհակալություն ընկերոջդ հրավիրելու համար!",
      "text": "{name}{friend}-ը արդեն մեկ ամիս մարզվում է DonatelleX-ով — նվիրում ենք քեզ մեկ ամիս մուտք։ Մուտքդ այժմ գործում է մինչև {date}։",
      "button": "Բացել հավելվածը"
    },
    "friend": "Ընկերդ",
    "footer": "Մարզումներ և առաջընթաց Վլադիմիր Donatellex-ի հետ"
  },
  "ar": {
    "reminder": {
      "subject": "ينتهي اشتراكك في DonatelleX في {date}",
      "title": "اشتراكك سينتهي قريبًا",
      "text": "{name}تنتهي فترتك المدفوعة في {date}. جدّد مسبقًا حتى لا تنقطع تمارينك وتحافظ على إيقاعك.",
      "button": "تجديد الاشتراك"
    },
    "reward": {
      "subject": "+شهر من DonatelleX هدية",
      "title": "شكرًا لدعوة صديقك!",
      "text": "{name}يتمرّن {friend} مع DonatelleX منذ شهر — نهديك شهرًا من الاشتراك. اشتراكك صالح الآن حتى {date}.",
      "button": "فتح التطبيق"
    },
    "friend": "صديقك",
    "footer": "تمارين وتقدّم مع فلاديمير Donatellex"
  },
  "hi": {
    "reminder": {
      "subject": "आपका DonatelleX एक्सेस {date} को खत्म हो रहा है",
      "title": "आपका एक्सेस जल्द खत्म होगा",
      "text": "{name}आपकी पेड अवधि {date} को खत्म हो रही है। पहले से रिन्यू करें ताकि आपकी ट्रेनिंग न रुके।",
      "button": "एक्सेस रिन्यू करें"
    },
    "reward": {
      "subject": "DonatelleX का +1 महीना उपहार में",
      "title": "दोस्त को बुलाने के लिए धन्यवाद!",
      "text": "{name}{friend} एक महीने से DonatelleX के साथ ट्रेनिंग कर रहे हैं — इसलिए हम आपको एक महीने का एक्सेस उपहार में दे रहे हैं। आपका एक्सेस अब {date} तक मान्य है।",
      "button": "ऐप खोलें"
    },
    "friend": "आपका दोस्त",
    "footer": "व्लादिमीर Donatellex के साथ वर्कआउट और प्रगति"
  },
  "pa": {
    "reminder": {
      "subject": "ਤੁਹਾਡਾ DonatelleX ਐਕਸੈਸ {date} ਨੂੰ ਖਤਮ ਹੋ ਰਿਹਾ ਹੈ",
      "title": "ਤੁਹਾਡਾ ਐਕਸੈਸ ਜਲਦੀ ਖਤਮ ਹੋਵੇਗਾ",
      "text": "{name}ਤੁਹਾਡੀ ਭੁਗਤਾਨ ਕੀਤੀ ਮਿਆਦ {date} ਨੂੰ ਖਤਮ ਹੋ ਰਹੀ ਹੈ। ਪਹਿਲਾਂ ਹੀ ਰੀਨਿਊ ਕਰੋ ਤਾਂ ਜੋ ਤੁਹਾਡੀ ਟ੍ਰੇਨਿੰਗ ਨਾ ਰੁਕੇ।",
      "button": "ਐਕਸੈਸ ਰੀਨਿਊ ਕਰੋ"
    },
    "reward": {
      "subject": "DonatelleX ਦਾ +1 ਮਹੀਨਾ ਤੋਹਫ਼ੇ ਵਜੋਂ",
      "title": "ਦੋਸਤ ਨੂੰ ਸੱਦਣ ਲਈ ਧੰਨਵਾਦ!",
      "text": "{name}{friend} ਇੱਕ ਮਹੀਨੇ ਤੋਂ DonatelleX ਨਾਲ ਟ੍ਰੇਨਿੰਗ ਕਰ ਰਹੇ ਹਨ — ਇਸ ਲਈ ਅਸੀਂ ਤੁਹਾਨੂੰ ਇੱਕ ਮਹੀਨੇ ਦਾ ਐਕਸੈਸ ਤੋਹਫ਼ੇ ਵਜੋਂ ਦੇ ਰਹੇ ਹਾਂ। ਤੁਹਾਡਾ ਐਕਸੈਸ ਹੁਣ {date} ਤੱਕ ਵੈਧ ਹੈ।",
      "button": "ਐਪ ਖੋਲ੍ਹੋ"
    },
    "friend": "ਤੁਹਾਡਾ ਦੋਸਤ",
    "footer": "ਵਲਾਦੀਮੀਰ Donatellex ਨਾਲ ਕਸਰਤ ਅਤੇ ਤਰੱਕੀ"
  }
};

export function pickLang(locale: string | null | undefined): EmailLang {
  const l = (locale ?? "").slice(0, 2).toLowerCase();
  return (EMAIL_LANGS as readonly string[]).includes(l) ? (l as EmailLang) : "en";
}

function escapeHtml(s: string): string {
  return s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c] as string);
}

export function formatDate(iso: string, lang: EmailLang): string {
  try {
    return new Intl.DateTimeFormat(lang, { day: "numeric", month: "long" }).format(new Date(iso));
  } catch {
    return iso.slice(0, 10);
  }
}

function fill(tpl: string, vars: Record<string, string>): string {
  return tpl.replace(/\{(\w+)\}/g, (_, k: string) => vars[k] ?? "");
}

/** "Имя, " для обращения в начале текста (с заглавной первой буквой остального текста — не нужно, текст начинается с маленькой). */
function greeting(firstName: string | null | undefined, lang: EmailLang): string {
  const n = (firstName ?? "").trim();
  if (!n) return "";
  return lang === "ar" ? `${n}، ` : `${n}, `;
}

function capitalizeFirst(s: string): string {
  return s.charAt(0).toLocaleUpperCase() + s.slice(1);
}

export function buildEmail(
  kind: "reminder" | "reward",
  lang: EmailLang,
  vars: { firstName?: string | null; date: string; friend?: string | null; url: string },
): { subject: string; html: string } {
  const s = STRINGS[lang];
  const t = s[kind];
  const values = {
    name: escapeHtml(greeting(vars.firstName, lang)),
    date: escapeHtml(vars.date),
    friend: escapeHtml((vars.friend ?? "").trim() || s.friend),
  };
  const text = capitalizeFirst(fill(t.text, values));
  const subject = fill(t.subject, { date: vars.date, name: "", friend: "" });
  const rtl = lang === "ar";
  const align = rtl ? "right" : "left";
  const url = escapeHtml(vars.url);
  const html = `<!doctype html>
<html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="color-scheme" content="dark"><title>DonatelleX</title></head>
<body style="margin:0;padding:0;background:#0A0B0D;font-family:Manrope,-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,'Noto Sans Armenian','Noto Sans Arabic','Noto Sans Devanagari','Noto Sans Gurmukhi',sans-serif">
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#0A0B0D" style="background:#0A0B0D"><tr><td align="center" style="padding:32px 16px">
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="max-width:520px">
<tr><td style="padding:0 4px 20px"><table role="presentation" cellspacing="0" cellpadding="0" border="0"><tr>
<td width="36" height="36" align="center" bgcolor="#A8E000" style="border-radius:10px;font-size:18px;font-weight:800;color:#0A0B0D">D</td>
<td style="padding-left:10px;font-size:18px;font-weight:800;color:#FFFFFF">DonatelleX</td>
</tr></table></td></tr>
<tr><td bgcolor="#111318" style="background:#111318;border:1px solid #23272F;border-radius:20px;padding:36px 28px">
<div dir="${rtl ? "rtl" : "ltr"}" style="text-align:${align}">
<h1 style="margin:0 0 14px;font-size:24px;line-height:1.25;font-weight:800;color:#FFFFFF">${escapeHtml(t.title)}</h1>
<p style="margin:0 0 28px;font-size:16px;line-height:1.6;color:#B4B9C2">${text}</p>
<table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%"><tr><td align="center" bgcolor="#A8E000" style="border-radius:12px">
<a href="${url}" style="display:block;padding:16px 24px;font-size:16px;font-weight:800;color:#0A0B0D;text-decoration:none">${escapeHtml(t.button)}</a>
</td></tr></table>
</div>
</td></tr>
<tr><td align="center" style="padding:22px 8px 0;font-size:12px;line-height:1.6;color:#4B505A">${escapeHtml(s.footer)}<br>donatellex.com</td></tr>
</table></td></tr></table>
</body></html>`;
  return { subject, html };
}
