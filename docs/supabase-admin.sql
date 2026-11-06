-- Rastreamento e painel admin do site da Cris Reis
-- Rodar no SQL Editor do Supabase. Depois: criar o usuário da Cris em Authentication > Users
-- e trocar 'EMAIL_DA_CRIS@exemplo.com' pelo e-mail dela (e o do Judson) na tabela admins.

create table if not exists public.events (
  id text primary key,
  ts timestamptz not null default now(),
  vid text not null,
  sid text not null,
  type text not null,
  page text,
  data jsonb not null default '{}'::jsonb
);
create index if not exists events_ts_idx on public.events (ts);
create index if not exists events_vid_idx on public.events (vid);

create table if not exists public.leads (
  id text primary key,
  ts timestamptz not null default now(),
  vid text,
  sid text,
  kind text not null,
  page text,
  source text,
  email_key text,
  phone_key text,
  payload jsonb not null default '{}'::jsonb
);
create index if not exists leads_email_idx on public.leads (email_key);
create index if not exists leads_phone_idx on public.leads (phone_key);

create table if not exists public.lead_meta (
  person_key text primary key,
  status text,
  note text,
  updated_at timestamptz default now()
);

create table if not exists public.admins (email text primary key);
insert into public.admins (email) values ('EMAIL_DA_CRIS@exemplo.com') on conflict do nothing;

alter table public.events enable row level security;
alter table public.leads enable row level security;
alter table public.lead_meta enable row level security;
alter table public.admins enable row level security;

create or replace function public.is_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admins where email = (auth.jwt() ->> 'email'));
$$;

-- Visitantes (chave anon) só podem inserir. Só admins leem.
create policy "site insere eventos" on public.events for insert to anon, authenticated with check (true);
create policy "admin lê eventos" on public.events for select to authenticated using (public.is_admin());
create policy "site insere leads" on public.leads for insert to anon, authenticated with check (true);
create policy "admin lê leads" on public.leads for select to authenticated using (public.is_admin());
create policy "admin gerencia anotações" on public.lead_meta for all to authenticated using (public.is_admin()) with check (public.is_admin());
