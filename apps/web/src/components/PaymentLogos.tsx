import visa from "@/assets/payments/visa.svg";
import mastercard from "@/assets/payments/mastercard.svg";
import arca from "@/assets/payments/arca.svg";
import applePay from "@/assets/payments/apple-pay.svg";
import googlePay from "@/assets/payments/google-pay.svg";

/**
 * Цветные логотипы способов оплаты (требование банка, Америабанк vPOS).
 * Visa / Mastercard / Apple Pay / Google Pay — из пакета @iconify-json/logos
 * (CC0), ArCa — официальный логотип с arca.am. На тёмном фоне логотипы
 * стоят на белых плашках, как на карточках.
 */
export const PAYMENT_LOGOS = [
  { src: visa, alt: "Visa" },
  { src: mastercard, alt: "Mastercard" },
  { src: arca, alt: "ArCa" },
  { src: applePay, alt: "Apple Pay" },
  { src: googlePay, alt: "Google Pay" },
] as const;

export function PaymentLogos({ size = "md", className = "" }: { size?: "sm" | "md"; className?: string }) {
  const box = size === "sm" ? "h-6 w-10 px-1" : "h-8 w-14 px-1.5";
  return (
    <div className={`flex flex-wrap items-center gap-1.5 ${className}`} dir="ltr">
      {PAYMENT_LOGOS.map(({ src, alt }) => (
        <span key={alt} className={`flex items-center justify-center rounded-md bg-white ${box}`} title={alt}>
          <img src={src} alt={alt} className="max-h-[60%] w-full object-contain" loading="lazy" />
        </span>
      ))}
    </div>
  );
}
