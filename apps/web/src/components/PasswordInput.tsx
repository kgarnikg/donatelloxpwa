import { forwardRef, useState } from "react";
import { Eye, EyeOff } from "lucide-react";
import clsx from "clsx";
import { useTranslation } from "react-i18next";

interface PasswordInputProps extends React.InputHTMLAttributes<HTMLInputElement> {}

/** Поле ввода пароля с кнопкой-глазиком для показа/скрытия введённого текста. */
export const PasswordInput = forwardRef<HTMLInputElement, PasswordInputProps>(
  ({ className, ...props }, ref) => {
    const { t } = useTranslation();
    const [visible, setVisible] = useState(false);

    return (
      <div className="relative">
        <input
          ref={ref}
          type={visible ? "text" : "password"}
          className={clsx("input-field pr-11", className)}
          {...props}
        />
        <button
          type="button"
          tabIndex={-1}
          onClick={() => setVisible((v) => !v)}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-neutral-500 hover:text-neutral-300"
          aria-label={visible ? t("auth.hidePassword") : t("auth.showPassword")}
        >
          {visible ? <EyeOff size={18} /> : <Eye size={18} />}
        </button>
      </div>
    );
  },
);

PasswordInput.displayName = "PasswordInput";
