# Deployment Setup — Supabase + Netlify

This is the one-time setup the site owner needs to do to get the live database and contact form working. Nothing on the site is fake in the meantime — the map falls back to the bundled `data/schools-india.json` file until Supabase is connected, so the site works fully before and after this setup.

## 1. Create the Supabase project

1. Go to [supabase.com](https://supabase.com) and create a free account/project (pick any region close to India, e.g. Singapore).
2. Once the project is ready, open **SQL Editor** in the left sidebar → **New query**, paste in the contents of `supabase/schema.sql` from this repo, and run it. This creates the `schools` table and locks it to public *read-only* access — nobody can add or change data except you, logged into this dashboard.
3. Open **Table Editor** → select the `schools` table → **Insert** → **Import data from CSV** → upload `supabase/schools-seed.csv` from this repo. This loads the 221 researched schools.
4. Go to **Project Settings → API**. Copy two values:
   - **Project URL** (looks like `https://xxxxxxxx.supabase.co`)
   - **anon / public key** (a long token — this one is *meant* to be public; it can only read, because of the policy set up in step 2)

## 2. Connect the site to it

Open `config.js` in the repo root and fill in the two values from step 1:

```js
window.SBS_CONFIG = {
  SUPABASE_URL: "https://xxxxxxxx.supabase.co",
  SUPABASE_ANON_KEY: "eyJ...",
};
```

Commit that change. On the next Netlify deploy, the map on **The Map** tab will pull live from Supabase instead of the bundled fallback file.

## 3. Managing schools going forward

To add, edit, or remove a school: log into Supabase → **Table Editor → schools** → edit the row directly, like a spreadsheet. Changes appear on the live site immediately (no redeploy needed) — the map fetches fresh data on every page load.

## 4. The contact form (Netlify Forms — already wired up, no setup needed)

The Partner-tab contact form now submits via **Netlify Forms**, which is automatic once the site is deployed on Netlify — no extra account or config. Submissions show up under your Netlify site's **Forms** tab in the dashboard, and you can turn on an email notification there (**Forms → Settings and usage → Form notifications**) so a message doesn't just sit unseen.

## 5. (Optional, later) Netlify Functions for anything server-side

Nothing currently requires this — Netlify Forms handles the contact form, and Supabase's anon key handles public read-only map data directly from the browser. If you later want something like "review a school submission before it goes public" or "email the team when a new contact form comes in via Supabase instead of Netlify's own notification," that's a small serverless function under `netlify/functions/`, using Supabase's *service role* key (kept as a Netlify environment variable, never in the repo or the browser). Ask for this when the need actually comes up — no reason to build it speculatively.
