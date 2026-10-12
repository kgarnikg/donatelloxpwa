-- 0092: согласие на данные о здоровье и удаление аккаунта самим пользователем.
--
-- 1. user_profiles.health_consent_at — когда человек отметил в анкете
--    "Согласен на обработку данных о моём здоровье и теле (рост, вес, замеры,
--    особенности здоровья) для подбора тренировок". По GDPR такие данные —
--    особая категория, на них нужно отдельное явное согласие.
--
-- 2. delete_my_account() — "Удалить аккаунт" в профиле (право на удаление,
--    GDPR ст. 17). Удаляется вход (auth.users) → public.users → каскадом всё
--    личное: анкета, тренировки, замеры, питание, награды, подписки,
--    обращения в поддержку. Записи об оплатах и заявки на возврат НЕ
--    удаляются, а обезличиваются (user_id → null, см. внешние ключи
--    "on delete set null") — их требует хранить налоговое законодательство.
--    Аккаунты админов/тренеров так не удаляются — только вручную.
--
-- Безопасно выполнять повторно.

alter table public.user_profiles
  add column if not exists health_consent_at timestamptz;

comment on column public.user_profiles.health_consent_at is
  'Когда дано явное согласие на обработку данных о здоровье и теле (анкета, 0092).';

create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Нужно войти в аккаунт' using errcode = '42501';
  end if;
  if exists (select 1 from public.users where id = v_uid and role in ('admin', 'superadmin', 'coach')) then
    raise exception 'Аккаунт администратора или тренера удаляется вручную' using errcode = '42501';
  end if;

  -- оплаты остаются для учёта, но без привязки к человеку
  update public.payments set user_id = null where user_id = v_uid;
  update public.refund_requests set user_id = null where user_id = v_uid;

  delete from auth.users where id = v_uid;
  delete from public.users where id = v_uid;
end;
$$;

revoke all on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;

notify pgrst, 'reload schema';
