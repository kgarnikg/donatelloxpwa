-- 0011_referral_program.sql
-- Реферальная программа: у каждого пользователя есть свой короткий код
-- приглашения. Друг, зарегистрировавшийся по ссылке с этим кодом,
-- получает флаг на 50% скидку на первый оплаченный месяц подписки.
--
-- Применение самой скидки к реальному платежу — на стороне Фазы 3
-- (подключение платёжных провайдеров), когда там будет реализован расчёт
-- цены. Сейчас фиксируется только сам факт связи "кто кого пригласил" и
-- флаг "скидка ещё не использована".
--
-- Безопасно выполнять повторно.

alter table public.users
  add column if not exists referral_code text unique;

alter table public.users
  add column if not exists pending_discount_percent smallint,
  add column if not exists pending_discount_reason text;

create table if not exists public.referrals (
  id uuid primary key default gen_random_uuid(),
  referrer_id uuid not null references public.users (id) on delete cascade,
  referred_id uuid not null unique references public.users (id) on delete cascade,
  discount_percent smallint not null default 50,
  reward_applied boolean not null default false,
  created_at timestamptz not null default now(),
  -- Пользователь не может пригласить сам себя.
  constraint referrals_no_self_referral check (referrer_id <> referred_id)
);

create index if not exists referrals_referrer_id_idx on public.referrals (referrer_id);

alter table public.referrals enable row level security;

create policy "referrals_select_own" on public.referrals
  for select using (referrer_id = auth.uid() or referred_id = auth.uid() or public.is_admin());

-- Генерирует короткий уникальный код на основе id пользователя (первые 8
-- символов UUID без дефисов, в верхнем регистре) — коротко, читаемо,
-- достаточно уникально для реферальных ссылок.
create or replace function public.generate_referral_code(p_user_id uuid)
returns text
language sql
immutable
as $$
  select upper(substr(replace(p_user_id::text, '-', ''), 1, 8));
$$;

-- Расширяем ensure_user_profile: заодно гарантирует наличие referral_code
-- у пользователя, если его почему-то ещё нет.
create or replace function public.ensure_user_profile()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_email text;
  v_full_name text;
  v_avatar_url text;
  v_provider text;
  v_email_confirmed boolean;
begin
  if auth.uid() is null then
    return;
  end if;

  select
    au.email,
    coalesce(au.raw_user_meta_data ->> 'full_name', au.raw_user_meta_data ->> 'name', ''),
    coalesce(au.raw_user_meta_data ->> 'avatar_url', au.raw_user_meta_data ->> 'picture'),
    coalesce(au.raw_app_meta_data ->> 'provider', 'email'),
    au.email_confirmed_at is not null
  into v_email, v_full_name, v_avatar_url, v_provider, v_email_confirmed
  from auth.users au
  where au.id = auth.uid();

  if v_email is null then
    return;
  end if;

  insert into public.users (id, email, full_name, avatar_url, auth_provider, email_verified, referral_code)
  values (
    auth.uid(), v_email, v_full_name, v_avatar_url, v_provider, v_email_confirmed,
    public.generate_referral_code(auth.uid())
  )
  on conflict (id) do update set
    email = excluded.email,
    email_verified = excluded.email_verified,
    referral_code = coalesce(public.users.referral_code, excluded.referral_code);
end;
$$;

grant execute on function public.ensure_user_profile() to authenticated;
grant execute on function public.generate_referral_code(uuid) to authenticated;

-- Подтягиваем referral_code всем существующим пользователям, у кого его нет.
update public.users
set referral_code = public.generate_referral_code(id)
where referral_code is null;

-- RPC, которую вызывает страница регистрации, если пользователь пришёл по
-- реферальной ссылке. Идемпотентна: если связь уже создана — просто выходит.
create or replace function public.apply_referral(p_referral_code text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_referrer_id uuid;
begin
  if auth.uid() is null or p_referral_code is null then
    return;
  end if;

  select id into v_referrer_id from public.users where referral_code = upper(p_referral_code);

  if v_referrer_id is null or v_referrer_id = auth.uid() then
    return;
  end if;

  insert into public.referrals (referrer_id, referred_id, discount_percent)
  values (v_referrer_id, auth.uid(), 50)
  on conflict (referred_id) do nothing;

  update public.users
  set pending_discount_percent = 50,
      pending_discount_reason = 'referral'
  where id = auth.uid()
    and pending_discount_percent is null;
end;
$$;

grant execute on function public.apply_referral(text) to authenticated;
