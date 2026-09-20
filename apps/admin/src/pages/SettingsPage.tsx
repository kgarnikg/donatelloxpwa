import { useForm } from "react-hook-form";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Save, CheckCircle2 } from "lucide-react";
import { supabase } from "@/lib/supabase";

/**
 * Настройки сайта — key-value (`site_settings`), читаются лендингом в
 * рантайме без редеплоя. Список полей намеренно вынесен отдельно от formы
 * — добавление новой настройки в будущем = одна новая запись здесь, а не
 * переписывание страницы.
 */
const SETTINGS_FIELDS: { key: string; label: string; placeholder: string; help: string }[] = [
  {
    key: "hero_showreel_url",
    label: "Видео на кнопке «Узнать больше» (лендинг)",
    placeholder: "https://… (YouTube или прямая ссылка на mp4)",
    help: "Подходит и YouTube-ссылка, и прямая ссылка на файл (например, из Cloudflare R2/Bunny Storage) — сайт сам определит, что перед ним. Пусто — кнопка просто скроллит к следующему блоку лендинга.",
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
        <form onSubmit={handleSubmit((v) => saveSettings.mutate(v))} className="card mt-6 max-w-xl space-y-5">
          {SETTINGS_FIELDS.map((field) => (
            <div key={field.key}>
              <label className="mb-1.5 block text-sm font-medium text-neutral-300">{field.label}</label>
              <input className="input-field" placeholder={field.placeholder} {...register(field.key)} />
              <p className="mt-1 text-xs text-neutral-500">{field.help}</p>
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
