# Between the Dots — Site Documentation & Review

**Repo:** `between-the-dots-try2` · **File:** single `index.html` (~1,900 lines) · **Last updated:** 2026-09-12

This document exists as a refresh point for the client, for the developer, and for future work sessions on this codebase. Part 1 describes what is currently built, tab by tab. Part 2 is a critical review of gaps, risks, and recommended fixes.

**2026-09-12 update:** added Tab 5 ("The Map"), a Supabase-backed schools directory (see `data/README.md` and `docs/DEPLOYMENT-SETUP.md`), and converted the contact form to Netlify Forms. Details in section 5 and the note at the end of section 3.

**2026-09-12 update (later the same day):** rebranded the entire site from the placeholder name "Stories Beyond Sight" to **Between the Dots**, matching the client's actual logo and the repo's own name — updated everywhere: title, hero headline, nav, footer, contact email subject lines, story/poem bylines, quote attribution, and the decorative Braille initials (was "SBS," now "BTD"). Also re-themed the entire site from dark (near-black + gold) to **light** (warm cream + deep maroon/burgundy, with a rust/terracotta secondary accent) to match the client-provided logo's palette — see section 6 below for the full color mapping.

**2026-09-12 update (once the client dropped the actual file in):** the real logo (`assets/logo.jpeg` — a circular badge: open book, rising Braille-style dots, "Between the Dots" wordmark, on a cream background) is now used as the browser favicon and in the nav bar, replacing the old decorative 6-dot grid mark. It works as a nav image without any cropping/masking because its own background color is nearly identical to the site's new page background — the square JPEG corners are invisible against the page. On mobile the logo image stays visible and only the adjacent text wordmark hides (previously both the dot-grid mark and text hid together). The footer intentionally was **not** given the raster logo too — it already carries a "Between the Dots" text line and a matching Braille-rendered "BTD" mark, and stacking the photographic logo on top would be redundant next to the nav's.

---

## 0. What this site is

A single self-contained `index.html` for **Between the Dots**, an organisation that writes original short fiction/poetry and distributes it in Braille, free, to blind schools in India. No framework, no build step. There is still no routing — five "tabs" are `<section>` elements toggled by JavaScript on one page. It now has one real backend dependency (Supabase, for the schools map) and one real integration (Netlify Forms, for the contact form) — see section 5. Fonts are loaded from Google Fonts (Cormorant Garamond, DM Mono, Lora); Leaflet.js (via CDN) powers the map.

**Global elements present on every tab:**
- Custom mouse cursor (a dot + trailing ring), with the native cursor hidden (`cursor: none` site-wide).
- A `<canvas>` background rendering a randomized grid of Braille-style dots as ambient texture; regenerates on window resize.
- An SVG film-grain overlay for texture.
- Fixed top nav: the client's real logo image (`assets/logo.jpeg`) + text wordmark, and a pill-shaped 5-tab switcher (Our Mission / The Work / Partner / Reading Room / The Map).
- Footer: tagline, decorative Braille rendering of "BTD", and a contact line with one email address (`rhea.divekar@gmail.com`).

---

## 1. Tab: Our Mission (`#tab1`)

- **Hero**: eyebrow label, large serif headline ("Between the Dots — reading reimagined"), a mission tagline paragraph, and a decorative side panel that spells "BETWEEN" in animated, pulsing Braille dots.
- **Mission cards** (4-up grid): *Original Works*, *Braille First*, *Free Distribution*, *Community Loop* — each with a decorative dot icon, number, title, and description.
- **Impact counters** (4-up): "6 Original Stories", "14 Schools in Network", "1,200+ Students Reached" (labeled as a year-one *target*), "100% Free, Always" — these animate a count-up when scrolled into view.
- A decorative, non-functional "Explore the work" scroll cue at the bottom (there is nothing to scroll to below it — it's cosmetic).

## 2. Tab: The Work (`#tab2`)

- **The Problem**: headline + 3 stat blocks (285M globally visually impaired; <10% of books ever made accessible; ~5M Braille readers globally). Only the first stat is cited ("NIH, 2023").
- **What's Missing vs. Our Answer**: a two-column layout — a 6-item problem list (scroll-reveal animation) next to a 5-item solution box (scroll-reveal animation).
- **Marquee strip**: an infinitely scrolling row of brand-differentiator tags ("Original not Translated," etc.).
- **How We Do It**: a 4-step process (Content Creation → Braille Production → Direct Distribution → Feedback Loop) shown as connected cards.
- **Impact section**: "What changes for students" — 6 icon+text items in a 3-column grid.
- **YouTube section**: an embedded video (hardcoded video ID) plus 4 sidebar facts (reading-by-touch speed, cognitive independence research, "stories aren't a luxury," 200 years of Braille history).
- **Braille alphabet showcase**: renders the full A–Z alphabet live as actual Braille dot patterns, generated from a JS lookup table.

## 3. Tab: Partner (`#tab3`)

- **Hero** + subhead pitching partnership.
- **Why Partner With Us**: 6 cards (Direct Impact, Measurable Outcomes, Scalable Model, Brand Alignment, NGO Access, Content Legacy).
- **Quote strip**: a pulled founding-principle quote.
- **Sponsorship tiers** (3): *Seed* (individual), *Chapter* (org/CSR — visually highlighted as "Most Impactful"), *Patron* (institutional). Each lists perks and links to a `mailto:` with a pre-filled subject/body, all pointing at the same personal Gmail address.
- **Ways to Get Involved** (4, informational only — no CTA links): Schools & Institutions, Writers & Storytellers, Corporates & CSR Teams, Volunteers & Advocates.
- **Contact section**: left column is copy + a direct email display; right column is a real `<form>` (name, organisation, email, "interested in" dropdown, message) that **submits via Netlify Forms** (`data-netlify="true"`, honeypot spam field, async submit with an on-page success/error message). ~~Previously only opened a `mailto:` link~~ — fixed 2026-09-12. If the POST fails (e.g. previewed off Netlify), it falls back to the old `mailto:` behavior rather than failing silently.
- **FAQ accordion** (5 Q&As): impact-tracking process, tax-deductibility (12A/80G registration **still pending**), school-specific sponsorship requests, languages (English only today; Hindi/regional planned), and writer contribution/IP terms.

## 4. Tab: Reading Room (`#tab4`)

- **Hero** + subhead.
- **Story cards** (3, accordion — only one open at a time): *"The Lighthouse and the Storm"* (Adventure, 8 min), *"Arjun's Orchestra"* (Slice of Life, 6 min), *"The Girl Who Named the Wind"* (Friendship, 10 min). Each expands to show a print excerpt (drop-cap styling), a live-rendered Braille version of a short title, and a "Did You Know" Braille fact.
- **Braille facts strip** (3 factoids): 6 dots per cell, 125 wpm average reading speed, 1824 (invention year).
- **Original poems** (2): *"The Stars I Know"*, *"What My Fingers Know"* — each has a Text/Braille view toggle (full poem rendered word-by-word as Braille dots, preserving stanza breaks) **and** a "Listen" button that uses the browser's Web Speech API to read the poem aloud, with a progress bar and a synced pulse animation on the Braille dots while speaking.
- **Braille translator**: a live text input (60-char max) that renders whatever the visitor types as Braille dots in real time, with a legend.

## 5. Tab: The Map (`#tab5`) — added 2026-09-12

- **Hero + disclaimer**: framed explicitly as a public-awareness directory, not a confirmed partner network — see `data/README.md` for why that distinction matters.
- **Map**: Leaflet.js with no raster basemap at all — just India's 36 state/UT boundaries (`data/india-states.geojson`, public-domain Natural Earth data, simplified locally), drawn with a dotted stroke so internal borders read as texture rather than a real administrative map. (Two earlier approaches were tried and dropped: CartoDB's dark basemap now gates behind a paid API key, and standard OpenStreetMap tiles bake in every town/road/border regardless of relevance — real noise for a directory map like this.) Ambient state-name labels sit in their own map pane behind the markers, screen-space collision-thinned so they don't crowd each other. City labels only appear once zoomed in past a threshold, and only for cities with a school, gated the same way. Every dot is color-coded by operator type — Government (maroon), NGO-run (sage), Private/Missionary (terracotta), or Unspecified (neutral) when the research couldn't confidently tell — with a legend showing live counts per category. Clusters render as a donut/pie icon (CSS conic-gradient) showing the proportion of each type inside, not just a count. Click a dot (or a cluster to zoom in) to select it.
- **Detail panel**: shows name, type, city/state, address (or a note that only the locality is known), a location-precision label (none of the data is street-exact — see caveats below), and a link to the source the record was researched from.
- **State filter**: a dropdown narrows the map + marker count to one state/UT at a time.
- **Data source**: `data/schools-india.json` — **221 real, individually-sourced schools** for blind/visually-impaired children, researched via web search across every Indian state and UT (government special-education directories, NGO networks, missionary-school histories, and one successfully-extracted official Odisha government PDF). Full provenance, caveats, and known coverage gaps are in `data/README.md` — read it before presenting these numbers externally.
- **Backend**: the map reads from a Supabase (Postgres) table when configured (`config.js`), and automatically falls back to the bundled JSON file otherwise, so it always works. See `docs/DEPLOYMENT-SETUP.md` for the one-time Supabase setup — once done, the site owner manages schools (add/edit/remove) directly in Supabase's own Table Editor, no code changes needed.

## 6. Technical notes worth knowing

- The Braille lookup table covers **A–Z, 0–9, and only `, . ! ? ' -`** — no support for other punctuation, accents, or the actual Grade-1 numeric indicator. All on-page "Braille" is simplified, uncontracted (Grade 1) letter substitution — it is *not* real Grade 2 (contracted) Braille, despite the site's own copy describing production books as "Grade 1 or Grade 2."
- Story, poem, FAQ, tier, and counter content on tabs 1–4 is still hardcoded in the HTML file — only the schools map (tab 5) now has a real backend. Adding a story/poem/FAQ still means editing code.
- No analytics, no tests, no linting/build tooling.
- New dependencies, all loaded via CDN (no build step introduced): Leaflet.js + Leaflet.markercluster for the map.
- **Color palette (light theme, since 2026-09-12):** the CSS custom properties keep their *original names* from the dark theme (`--ink`, `--deep`, `--cream`, `--gold`, `--gold-light`, `--rust`) but now hold different, in some cases confusingly-named, values — `--gold` is now a deep maroon (`#6b1937`), not gold. This was a deliberate tradeoff (renaming every var() usage sitewide was higher-risk than swapping values), but it's a real maintainability wart worth a cleanup pass eventually. Current mapping: `--ink` (page background) = `#faf3e3` warm cream; `--deep` (card/surface background) = `#f0e3c7` slightly deeper tan; `--cream` (body text) = `#2b141b` dark maroon-black ink; `--gold` (primary accent) = `#6b1937` deep maroon; `--gold-light` (hover/lift variant) = `#9c2d54`; `--rust` (secondary accent / error state) = `#a83c2d`; `--sage` (voice-reader / NGO map category) unchanged at `#6b8c6e`. The map's "Private/Missionary" category deliberately uses a fourth, separate terracotta tone (`#c76a3a`) rather than reusing `--rust`, so all four map categories stay visually distinct.

---

## 7. Critical Review — What Should Be Implemented or Corrected

Ranked roughly by priority.

### High priority — functional & credibility risk

1. ~~**Contact form has no real backend.**~~ **Fixed 2026-09-12** — now submits via Netlify Forms with on-page success/error feedback, falling back to `mailto:` only if the POST itself fails.

2. **Numbers on the site don't add up.** The Mission tab claims "6 Original Stories… written & ready for print," but the Reading Room only shows 3 stories + 2 poems. If a funder or school cross-checks the claim against the visible content, it looks inflated. Either add the missing content or correct the counter.

3. **Achieved vs. target metrics are visually indistinguishable.** "1,200+ Students Reached" is captioned "our target for year one" (i.e., not yet true) but is styled and animated identically to "100% Free, Always" (a fact). A CSR partner doing diligence could reasonably read this as a false claim of current reach. Separate "achieved" stats from "projected/target" stats visually.

4. **The site's own accessibility is weak — a serious inconsistency for an org whose mission is accessibility.**
   - `cursor: none` site-wide plus a custom JS-driven cursor breaks the visual affordance for anyone not using a mouse, and there's no accessible fallback.
   - No visible keyboard focus states on nav tabs, FAQ rows, story toggles, or buttons.
   - Large amounts of body text sit at 15–50% opacity on a dark background — likely fails WCAG AA contrast in many places.
   - Interactive controls (tab switcher, FAQ questions, story headers) are non-semantic `div`s with `onclick` rather than real buttons with `aria-expanded`/`aria-selected` — a screen-reader user can't perceive or operate their state.
   - No skip-to-content link, no `aria-live` announcement on tab change, decorative canvas/grain not marked `aria-hidden`.
   - Recommend an actual Lighthouse/axe accessibility audit before this goes in front of a school, funder, or disability-advocacy contact — right now it would likely score poorly, which undercuts the org's credibility on its own subject matter.

5. **The interactive Braille throughout the site is decorative, not accurate**, and nothing on the page discloses that. A Braille-literate visitor (e.g., a partner school) could reasonably expect the "translator" or story-title renders to be correct Grade 2 Braille when it's actually simplified Grade 1 letter substitution with an incomplete character set. A one-line disclaimer would prevent this from reading as a factual error.

### Medium priority — trust, legal, content

6. **Tax-exemption status (80G/12A) is pending**, per the FAQ's own wording. Flag this so it gets updated the moment registration completes, and make sure no partnership material overstates it in the meantime.

7. **Every CTA on the site funnels to one personal Gmail address**, with no organisational domain, phone number, physical address, or social presence. This is a plausible trust gap for institutional/CSR partners doing due diligence before writing a cheque.

8. **The embedded YouTube video is dead.** Confirmed live on 2026-09-12 — it now renders YouTube's own "Video unavailable" placeholder. The hardcoded ID also carries a leftover comment saying "replace VIDEO_ID," suggesting it may have been a placeholder left over from prototyping rather than the org's own rights-cleared content. Needs a real video or the section removed.

9. **No privacy policy or terms**, despite the contact form collecting name, email, organisation, and message.

### Lower priority — architecture, SEO, polish

10. **Everything lives in one ~1,640-line HTML file** with inline CSS/JS. Fine for a prototype; will get harder to maintain as more stories, poems, and tiers are added. Worth raising with the client whether they'll want to add content themselves — if so, this architecture has no CMS, so every update is a code change.

11. **No SEO basics**: no favicon, no Open Graph/Twitter card meta tags (so shared links on social/WhatsApp render with no preview image or title), no `robots.txt`/sitemap, no Organization/NGO structured data.

12. **No analytics.** There's no way to know whether the tab navigation, the contact form, or the "Explore the work" cue are actually being used.

13. **The canvas background fully re-randomizes on every resize event** with no debounce — minor, but a cheap perf fix.

14. **The Web Speech API "Listen" feature is a nice engagement touch, but its voice quality is entirely OS/browser-dependent** and isn't the real accessible-reading experience the org provides (physical Braille). Worth labeling it clearly as a demo/bonus feature so it doesn't get conflated with the org's actual accessibility work in a client or funder's mind.

15. **No automated tests**, unsurprising for a static prototype, but worth planning for once the contact form and any future donation flow go live.

16. ~~**The client's actual logo hasn't been embedded on the site yet.**~~ **Fixed 2026-09-12** — `assets/logo.jpeg` is now the favicon and the nav mark.

17. **CSS variable names no longer match what they hold**, post-retheme. `--gold` is a deep maroon (`#6b1937`), `--ink` is a light cream, `--cream` is a dark ink color — kept as-is to avoid the higher risk of a sitewide var-rename, but this is a real trap for whoever touches this CSS next without reading this doc first. Worth a proper rename pass (`--gold`→`--maroon`, `--ink`→`--bg`, `--cream`→`--ink-text`, etc.) once things settle.

---

*This document should be kept up to date as features are added or the client's requirements come in. If the client sends new feature requirements, add them as a "Requested Changes" section above the critical review, and update this file's tab-by-tab section as those changes ship.*
