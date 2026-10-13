-- 0093: журнал ошибок сайта, приложения, админки и серверных функций.
--
-- Браузер пишет через log_client_error() (anon/authenticated, с защитой от
-- флуда), серверные функции Vercel — напрямую ключом service_role.
-- Читают только админы: раздел «Ошибки» в админке, одинаковые ошибки
-- сгруппированы по fingerprint. Записи старше 90 дней удаляет ежедневный
-- cron (purge_app_errors).
-- В журнал не пишутся пароли, данные карт, токены: адрес страницы
-- сохраняется без параметров, тексты обрезаются.

create table if not exists public.app_errors (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  app         text not null check (app in ('web', 'landing', 'admin', 'api')),
  level       text not null default 'error' check (level in ('warning', 'error', 'critical')),
  source      text,                 -- для api: имя функции (create-checkout, payment-return…)
  message     text not null,
  stack       text,
  url         text,
  user_id     uuid references public.users (id) on delete set null,
  user_agent  text,
  app_version text,
  context     jsonb,
  fingerprint text not null default ''
);

create index if not exists app_errors_created_idx on public.app_errors (created_at desc);
create index if not exists app_errors_fp_idx on public.app_errors (fingerprint, created_at desc);
create index if not exists app_errors_user_idx on public.app_errors (user_id) where user_id is not null;

-- Группа ошибок помечена «Решено»: скрыта, пока не повторится после этого момента
create table if not exists public.app_error_resolved (
  fingerprint text primary key,
  resolved_at timestamptz not null default now(),
  resolved_by uuid references public.users (id) on delete set null
);

alter table public.app_errors enable row level security;
alter table public.app_error_resolved enable row level security;

drop policy if exists app_errors_admin_read on public.app_errors;
create policy app_errors_admin_read on public.app_errors
  for select using (public.is_admin());

drop policy if exists app_error_resolved_admin on public.app_error_resolved;
create policy app_error_resolved_admin on public.app_error_resolved
  for all using (public.is_admin()) with check (public.is_admin());

-- Обрезка полей и отпечаток группы: цифры и id заменяются на #, чтобы
-- «payment 4687001 not found» и «payment 4687002 not found» были одной группой.
create or replace function public.app_errors_prepare()
returns trigger
language plpgsql
as $$
begin
  new.message := left(coalesce(nullif(btrim(new.message), ''), '(без текста)'), 1000);
  new.stack := left(new.stack, 4000);
  new.url := left(split_part(split_part(new.url, '?', 1), '#', 1), 500);
  new.user_agent := left(new.user_agent, 300);
  new.app_version := left(new.app_version, 40);
  new.source := left(new.source, 80);
  if new.context is not null and length(new.context::text) > 4000 then
    new.context := jsonb_build_object('truncated', left(new.context::text, 4000));
  end if;
  new.fingerprint := md5(
    new.app || ':' || coalesce(new.source, '') || ':' ||
    regexp_replace(
      regexp_replace(lower(new.message), '[0-9a-f]{8}-[0-9a-f-]{27,}', '#', 'g'),
      '[0-9]+', '#', 'g'
    )
  );
  return new;
end;
$$;

drop trigger if exists app_errors_prepare on public.app_errors;
create trigger app_errors_prepare
  before insert on public.app_errors
  for each row execute function public.app_errors_prepare();

-- Запись из браузера. Ничего не возвращает и никогда не падает.
create or replace function public.log_client_error(
  p_app text,
  p_level text,
  p_message text,
  p_stack text default null,
  p_url text default null,
  p_user_agent text default null,
  p_app_version text default null,
  p_context jsonb default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_recent int;
begin
  if p_app not in ('web', 'landing', 'admin') then return; end if;

  -- Защита от флуда: не больше 20 записей в минуту с одного аккаунта / браузера
  -- и не больше 3000 в час всего.
  select count(*) into v_recent
  from public.app_errors
  where created_at > now() - interval '1 minute'
    and (case when v_uid is not null then user_id = v_uid
              else user_id is null and user_agent = left(p_user_agent, 300) end);
  if v_recent >= 20 then return; end if;

  select count(*) into v_recent
  from public.app_errors where created_at > now() - interval '1 hour';
  if v_recent >= 3000 then return; end if;

  insert into public.app_errors (app, level, message, stack, url, user_id, user_agent, app_version, context)
  values (
    p_app,
    case when p_level in ('warning', 'error', 'critical') then p_level else 'error' end,
    coalesce(p_message, ''),
    p_stack, p_url,
    case when exists (select 1 from public.users where id = v_uid) then v_uid end,
    p_user_agent, p_app_version, p_context
  );
exception when others then
  return;
end;
$$;

revoke all on function public.log_client_error(text, text, text, text, text, text, text, jsonb) from public;
grant execute on function public.log_client_error(text, text, text, text, text, text, text, jsonb) to anon, authenticated;

-- Группы для админки
create or replace function public.admin_error_groups(
  p_since timestamptz,
  p_app text default null,
  p_include_resolved boolean default false
)
returns table (
  fingerprint text,
  app text,
  source text,
  level text,
  message text,
  occurrences bigint,
  users bigint,
  first_seen timestamptz,
  last_seen timestamptz,
  last_url text,
  last_version text,
  resolved_at timestamptz
)
language sql
security definer
set search_path = public
stable
as $$
  with g as (
    select
      e.fingerprint,
      count(*) as occurrences,
      count(distinct e.user_id) as users,
      min(e.created_at) as first_seen,
      max(e.created_at) as last_seen,
      -- самый серьёзный уровень в группе
      (array_agg(e.level order by case e.level when 'critical' then 0 when 'error' then 1 else 2 end))[1] as level
    from public.app_errors e
    where public.is_admin()
      and e.created_at >= p_since
      and (p_app is null or e.app = p_app)
    group by e.fingerprint
  )
  select
    g.fingerprint,
    last.app, last.source, g.level, last.message,
    g.occurrences, g.users, g.first_seen, g.last_seen,
    last.url, last.app_version,
    r.resolved_at
  from g
  cross join lateral (
    select e.app, e.source, e.message, e.url, e.app_version
    from public.app_errors e
    where e.fingerprint = g.fingerprint
    order by e.created_at desc
    limit 1
  ) last
  left join public.app_error_resolved r on r.fingerprint = g.fingerprint
  where p_include_resolved or r.resolved_at is null or g.last_seen > r.resolved_at
  order by g.last_seen desc
  limit 300;
$$;

grant execute on function public.admin_error_groups(timestamptz, text, boolean) to authenticated;

-- «Решено» / «Вернуть»
create or replace function public.admin_resolve_error(p_fingerprint text, p_resolved boolean default true)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'forbidden';
  end if;
  if p_resolved then
    insert into public.app_error_resolved (fingerprint, resolved_at, resolved_by)
    values (p_fingerprint, now(), auth.uid())
    on conflict (fingerprint) do update set resolved_at = now(), resolved_by = auth.uid();
  else
    delete from public.app_error_resolved where fingerprint = p_fingerprint;
  end if;
end;
$$;

grant execute on function public.admin_resolve_error(text, boolean) to authenticated;

-- Хранение 90 дней (вызывает ежедневный cron ключом service_role)
create or replace function public.purge_app_errors()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_deleted integer;
begin
  delete from public.app_errors where created_at < now() - interval '90 days';
  get diagnostics v_deleted = row_count;
  delete from public.app_error_resolved r
  where not exists (select 1 from public.app_errors e where e.fingerprint = r.fingerprint);
  return v_deleted;
end;
$$;

revoke all on function public.purge_app_errors() from public, anon, authenticated;
grant execute on function public.purge_app_errors() to service_role;
