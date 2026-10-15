/**
 * Реквизиты продавца (ИП в Армении, зарегистрировано 14.10.2026) — для
 * раздела «Свяжитесь с нами», подвала и оферты. Имя и адрес на разных
 * языках — в переводах (ключи company.name / company.address).
 * Банк (Америабанк, vPOS) требует на сайте email, телефон и физический адрес.
 */
export const COMPANY = {
  email: "donatellex@gmail.com",
  phone: "+374 43 537 716",
  phoneHref: "tel:+37443537716",
  tin: "20436549",
  regNo: "286.1617787",
  mapUrl: "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent("Yeznik Koghbatsi 1, Yerevan 0015, Armenia"),
} as const;
