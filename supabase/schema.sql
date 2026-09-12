-- Between the Dots — Supabase schema
-- Run this once in the Supabase SQL editor (Project → SQL Editor → New query) before importing schools-seed.csv.

create table if not exists public.schools (
  id            text primary key,
  name          text not null,
  state         text not null,
  city          text,
  address       text,
  lat           double precision not null,
  lng           double precision not null,
  geo_precision text not null default 'city' check (geo_precision in ('exact','city','district-approx')),
  type          text,
  source_url    text,
  note          text,
  created_at    timestamptz not null default now()
);

comment on table public.schools is 'Directory of known schools for blind/visually-impaired children across India, shown on the public map. Not a confirmed partner list — see data/README.md in the repo.';

-- Row Level Security: the site's map reads this table with the public anon key,
-- so only allow public SELECT. All writes (add/edit/remove a school) happen from
-- the Supabase Table Editor by whoever the project owner is, logged into the
-- Supabase dashboard directly — never from the public website.
alter table public.schools enable row level security;

drop policy if exists "Public can read schools" on public.schools;
create policy "Public can read schools"
  on public.schools
  for select
  to anon
  using (true);

-- ── Contact form submissions (optional second table) ──
-- Netlify Forms already captures every submission with no setup below.
-- This table only exists if you later want submissions queryable/joinable
-- from the same database instead of (or in addition to) the Netlify dashboard.
create table if not exists public.contact_submissions (
  id              uuid primary key default gen_random_uuid(),
  name            text not null,
  organisation    text,
  email           text not null,
  interest        text,
  message         text,
  submitted_at    timestamptz not null default now()
);

alter table public.contact_submissions enable row level security;
-- No public policies are created for this table — it's written to only via
-- a Netlify Function using the Supabase *service role* key (server-side only,
-- never exposed to the browser), so no anon insert/select policy is needed.
