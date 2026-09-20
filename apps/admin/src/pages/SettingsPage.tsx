import { useForm } from "react-hook-form";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Save, CheckCircle2 } from "lucide-react";
import { supabase } from "@/lib/supabase";

/**
 * Настройки сайта — key-value (`site_settings`), читаются лендингом в
 * рантайме без редеплоя. Список полей намеренно вынесен отдельно от formы
 * — добавление новой настройки в будущем = одна новая запись здесь, а не
 * переписывание страницы.
 *
 * Видео на кнопке "Узнать больше" — отдельная ссылка под каждый язык
 * лендинга, у которого есть готовый ролик (пока 4: ru/en/es/hy — по числу
 * языков, на которые переведён и контент программ, см. PROJECT_PLAN.md,
 * Фаза 6). Сайт сам выбирает нужную по языку интерфейса посетителя, с
 * запасным вариантом на русский, если для текущего языка видео ещё нет.
 */
const SETTINGS_FIELDS: { key: string; label: string; placeholder: string; help: string; group?: string }[] = [
  {
    key: "hero_background_video_url",
    label: "Фоновое видео на главном экране лендинга",
    placeholder: "https:// … (прямая ссылка на mp4, желательно короткий зацикленный ролик без звука)",
    help: "Играет автоматически, без звука, зациклено, во весь экран под текстом. YouTube сюда не подходит (там нет прямой ссылки на файл, только встраиваемый плеер) — нужна прямая ссылка на .mp4, например из Cloudflare R2/Bunny Storage. Пусто — используется файл по умолчанию из самого проекта.",
    group: "Фон главного экрана",
  },
  {
    key: "hero_showreel_url_ru",
    label: "Русский (запасной вариант, если для языка посетителя видео нет)",
    placeholder: "https://… (YouTube или прямая ссылка на mp4)",
    help: "",
    group: "Видео на кнопке «Узнать больше» (лендинг) — по языкам",
  },
  {
    key: "hero_showreel_url_en",
    label: "English",
    placeholder: "https://…",
    help: "",
  },
  {
    key: "hero_showreel_url_es",
    label: "Español",
    placeholder: "https://…",
    help: "",
  },
  {
    key: "hero_showreel_url_hy",
    label: "Հայերեն (армянский)",
    placeholder: "https://…",
    help: "Подходит и YouTube-ссылка, и прямая ссылка на файл (например, из Cloudflare R2/Bunny Storage) — сайт сам определит, что перед ним. Пусто для конкретного языка — покажется русская версия; если и она пуста — кнопка просто скроллит к следующему блоку лендинга.",
  },
];

type FormValues = Record<string, string>;

export default function SettingsPage() {
  const queryClient = useQueryClient();

  const { data: settings, isLoading } = useQuery({
    queryKey: ["admin-site-settings"],
    queryFn: async (): Promise<Record<string, string>> => {
      const { data, error } = await supabase.from("site_settings").select("key, value");
      if (error) throw error;
      return Object.fromEntries((data ?? []).map((row) => [row.key, row.value ?? ""]));
    },
  });

  const {
    register,
    handleSubmit,
    reset,
    formState: { isDirty },
  } = useForm<FormValues>({
    values: settings ?? {},
  });

  const saveSettings = useMutation({
    mutationFn: async (values: FormValues) => {
      const rows = SETTINGS_FIELDS.map((f) => ({
        key: f.key,
        value: values[f.key]?.trim() || null,
        updated_at: new Date().toISOString(),
      }));
      const { error } = await supabase.from("site_settings").upsert(rows, { onConflict: "key" });
      if (error) throw error;
    },
    onSuccess: (_, values) => {
      queryClient.setQueryData(["admin-site-settings"], values);
      reset(values);
    },
  });

  return (
    <div>
      <h1 className="font-display text-2xl font-bold">Настройки сайта</h1>
      <p className="mt-1 text-neutral-400">
        Применяются на лендинге сразу, без редеплоя — сайт читает их при каждой загрузке.
      </p>

      {isLoading ? (
        <div className="card mt-6 h-40 animate-pulse bg-ink-800" />
      ) : (
        <form onSubmit={handleSubmit((v) => saveSettings.mutate(v))} className="card mt-6 max-w-xl space-y-4">
          {SETTINGS_FIELDS.map((field, i) => (
            <div key={field.key}>
              {field.group && (
                <>
                  {i > 0 && <div className="my-2 border-t border-ink-700" />}
                  <p className="mb-3 text-sm font-semibold text-neutral-200">{field.group}</p>
                </>
              )}
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">{field.label}</label>
              <input className="input-field" placeholder={field.placeholder} {...register(field.key)} />
              {field.help && <p className="mt-1 text-xs text-neutral-500">{field.help}</p>}
            </div>
          ))}

          {saveSettings.isError && (
            <div className="rounded-md border border-danger/30 bg-danger/10 px-3.5 py-2.5 text-sm text-danger">
              Не удалось сохранить.
            </div>
          )}
          {saveSettings.isSuccess && !isDirty && (
            <div className="flex items-center gap-2 text-sm text-volt-400">
              <CheckCircle2 size={16} /> Сохранено
            </div>
          )}

          <button type="submit" disabled={saveSettings.isPending || !isDirty} className="btn-primary">
            <Save size={16} /> {saveSettings.isPending ? "Сохраняем…" : "Сохранить"}
          </button>
        </form>
      )}
    </div>
  );
}
