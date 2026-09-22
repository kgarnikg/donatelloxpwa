-- 0065_add_ararat_provider_and_amd.sql
-- Фаза 3 (платежи): вместо Stripe основной провайдер — vPOS Араратбанка
-- (Ереван). Продавец — армянский ИП, валюта расчёта по умолчанию у
-- армянских vPOS — драм (AMD, ISO 4217 numeric 051).
--
-- Что делает миграция:
-- 1. Разрешает provider = 'ararat' в payments и subscriptions
--    (старые значения stripe/paypal/yookassa/usdt/gift оставлены — на них
--    могут ссылаться существующие строки и код вебхука).
-- 2. Разрешает currency = 'AMD' в payments.
-- 3. Добавляет payments.order_number — наш собственный номер заказа,
--    который уходит в банк как orderNumber при register.do. Банк свой
--    orderId возвращает только ПОСЛЕ регистрации заказа, а запись о
--    платеже нам нужна ДО этого (чтобы не потерять попытку оплаты, если
--    ответ банка не дойдёт). provider_payment_id на момент создания
--    заказа заполняется тем же order_number и заменяется на orderId банка,
--    когда он придёт.
-- 4. Добавляет payments.plan и payments.discount_percent — чтобы сервер
--    при подтверждении оплаты знал, какой срок доступа выдать и была ли
--    применена реферальная скидка, не доверяя данным из браузера.
--
-- Безопасно выполнять повторно.

-- 1. provider
alter table public.payments drop constraint if exists payments_provider_check;
alter table public.payments add constraint payments_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'ararat'));

alter table public.subscriptions drop constraint if exists subscriptions_provider_check;
alter table public.subscriptions add constraint subscriptions_provider_check
  check (provider in ('stripe', 'paypal', 'yookassa', 'usdt', 'gift', 'ararat'));

-- 2. currency
alter table public.payments drop constraint if exists payments_currency_check;
alter table public.payments add constraint payments_currency_check
  check (currency in ('EUR', 'USD', 'RUB', 'USDT', 'AMD'));

-- 3–4. поля заказа
alter table public.payments add column if not exists order_number text;
alter table public.payments add column if not exists plan text;
alter table public.payments add column if not exists discount_percent integer not null default 0;

alter table public.payments drop constraint if exists payments_plan_check;
alter table public.payments add constraint payments_plan_check
  check (plan is null or plan in ('monthly', 'quarterly', 'semiannual', 'annual'));

alter table public.payments drop constraint if exists payments_discount_percent_check;
alter table public.payments add constraint payments_discount_percent_check
  check (discount_percent between 0 and 100);

create unique index if not exists payments_order_number_key
  on public.payments (order_number) where order_number is not null;

notify pgrst, 'reload schema';
