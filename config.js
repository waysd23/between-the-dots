// Between the Dots — runtime config.
// Fill in once the Supabase project exists — see docs/DEPLOYMENT-SETUP.md.
// Safe to commit: the anon key is public-by-design and can only read data
// (see supabase/schema.sql for the row-level-security policy that enforces this).
// Until these are filled in, the site falls back to the bundled data/schools-india.json.
window.SBS_CONFIG = {
  SUPABASE_URL: "",
  SUPABASE_ANON_KEY: "",
};
