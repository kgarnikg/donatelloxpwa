-- 0094: кто может менять роли.
--
-- Было: любой админ мог поставить любую роль кому угодно — в том числе
-- сделать кого-то суперадмином или понизить суперадмина до админа (и тогда
-- уже заблокировать/удалить его). Защита суперадмина из 0083 держалась на
-- честности админов.
--
-- Стало (проверяет база, а не только админка):
--   • свою роль не меняет никто (чтобы случайно не лишиться доступа);
--   • суперадмин назначает и снимает любые роли;
--   • обычный админ меняет только «Пользователь» ↔ «Тренер» и не трогает
--     админов и суперадминов;
--   • сервер (service_role), SQL Editor и доверенные функции — без ограничений.
--
-- Суперадмин — Гар (kgarnikg@gmail.com), назначается ниже.

create or replace function public.protect_user_privileged_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_caller_role text;
begin
  -- SQL Editor / сервер / доверенные функции — как раньше, без ограничений
  if coalesce(auth.role(), '') = 'service_role'
     or auth.uid() is null
     or coalesce(current_setting('donatellex.trusted', true), '') = 'on' then
    return new;
  end if;

  if public.is_admin() then
    if new.role is distinct from old.role then
      select role into v_caller_role from public.users where id = auth.uid();
      if old.id = auth.uid() then
        raise exception 'Свою роль поменять нельзя' using errcode = '42501';
      end if;
      if v_caller_role <> 'superadmin'
         and (old.role in ('admin', 'superadmin') or new.role in ('admin', 'superadmin')) then
        raise exception 'Назначать и снимать админов может только суперадмин' using errcode = '42501';
      end if;
    end if;
    return new;
  end if;

  -- Обычный пользователь: служебные поля не меняются (0083, 0088)
  new.id := old.id;
  new.email := old.email;
  new.role := old.role;
  new.auth_provider := old.auth_provider;
  new.email_verified := old.email_verified;
  new.referral_code := old.referral_code;
  new.pending_discount_percent := old.pending_discount_percent;
  new.pending_discount_reason := old.pending_discount_reason;
  new.is_blocked := old.is_blocked;
  new.blocked_at := old.blocked_at;
  new.blocked_reason := old.blocked_reason;
  new.session_kicks := old.session_kicks;
  new.last_session_kick_at := old.last_session_kick_at;
  new.created_at := old.created_at;
  return new;
end;
$$;

-- Владелец проекта — суперадмин
update public.users
set role = 'superadmin'
where lower(email) = 'kgarnikg@gmail.com'
  and role is distinct from 'superadmin';

-- Проверка: кто сейчас админ / суперадмин
select email, role from public.users where role in ('admin', 'superadmin') order by role desc, email;
