# Between the Dots — Site Documentation & Review

**Repo:** `between-the-dots-try2` · **File:** single `index.html` (~1,900 lines) · **Last updated:** 2026-09-12

This document exists as a refresh point for the client, for the developer, and for future work sessions on this codebase. Part 1 describes what is currently built, tab by tab. Part 2 is a critical review of gaps, risks, and recommended fixes.

**2026-09-12 update:** added Tab 5 ("The Map"), a Supabase-backed schools directory (see `data/README.md` and `docs/DEPLOYMENT-SETUP.md`), and converted the contact form to Netlify Forms. Details in section 5 and the note at the end of section 3.

**2026-09-12 update (later the same day):** rebranded the entire site from the placeholder name "Stories Beyond Sight" to **Between the Dots**, matching the client's actual logo and the repo's own name — updated everywhere: title, hero headline, nav, footer, contact email subject lines, story/poem bylines, quote attribution, and the decorative Braille initials (was "SBS," now "BTD"). Also re-themed the entire site from dark (near-black + gold) to **light** (warm cream + deep maroon/burgundy, with a rust/terracotta secondary accent) to match the client-provided logo's palette — see section 7 below for the full color mapping.

**2026-09-12 update (once the client dropped the actual file in):** the real logo (`assets/logo.jpeg` — a circular badge: open book, rising Braille-style dots, "Between the Dots" wordmark, on a cream background) is now used as the browser favicon and in the nav bar, replacing the old decorative 6-dot grid mark. It works as a nav image without any cropping/masking because its own background color is nearly identical to the site's new page background — the square JPEG corners are invisible against the page. On mobile the logo image stays visible and only the adjacent text wordmark hides (previously both the dot-grid mark and text hid together). The footer intentionally was **not** given the raster logo too — it already carries a "Between the Dots" text line and a matching Braille-rendered "BTD" mark, and stacking the photographic logo on top would be redundant next to the nav's.

---

## 0. What this site is

A single self-contained `index.html` for **Between the Dots**, an organisation that writes original short fiction/poetry and distributes it in Braille, free, to blind schools in India. No framework, no build step. There is still no routing — six "tabs" are `<section>` elements toggled by JavaScript on one page. It now has one real backend dependency (Supabase, for the schools map) and one real integration (Netlify Forms, for the contact form) — see section 5. Fonts are loaded from Google Fonts (Cormorant Garamond, DM Mono, Lora); Leaflet.js (via CDN) powers the map.

**Global elements present on every tab:**
- Custom mouse cursor (a dot + trailing ring), with the native cursor hidden (`cursor: none` site-wide).
- A `<canvas>` background rendering a randomized grid of Braille-style dots as ambient texture; regenerates on window resize.
- An SVG film-grain overlay for texture.
- Fixed top nav: the client's real logo image (`assets/logo.jpeg`) + text wordmark, and a pill-shaped 6-tab switcher (Our Mission / The Work / Partner / Transcribe Guide / The Map / About).
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
- **Events ("On the Ground") — added 2026-09-13, extended 2026-09-13**: an accordion of "placards," one per real event the client has attended in person. Sits right after the Braille alphabet showcase, before the tab's closing section.
  - **Placard header** (always visible): a category tag ("School Visit"), the school name, a location/date line, and a "View the Story" toggle. Clicking it expands the placard; only one is open at a time (opening a new one closes any other). **The most recently dated event opens automatically on page load** — sorted by each event's `dateValue`, so a visitor lands straight in the latest story and only has to choose if they want an older one instead.
  - **Expanded body**: a school-category tag + clickable school-website link, a short italic summary, a 3-paragraph first-person narrative, and a pull-quote with attribution — next to a photo stack.
  - **School tag & link**: reuses the exact same `CATEGORY_STYLE` color scheme (Government/NGO/Private/Unspecified) built for the schools map in Tab 5, so a school is colored identically everywhere on the site. That object was moved earlier in the script (before the Events section) so both features can read it. The school name links out to the school's own official site when one is confirmed — e.g. the Poona School's tag is styled "NGO-run" (green, matching the map) and its name links to `puneblindschool.org`, its real official homepage (verified live, not guessed). If a future event's school has no confirmed official site, `schoolUrl` should be left out rather than pointed at a directory/aggregator page.
  - **Photo stack**: a fanned "deck of photographs" effect (CSS transform/opacity/z-index computed per card, no library). Auto-advances every 3.2s once a placard is opened; tapping the stack or swiping also advances/reverses it and resets the auto-advance timer. Progress dots below the stack track position. Autoplay is paused whenever the visitor switches away from any nav tab (or from The Work tab specifically), and resumes if they come back with a placard still open — so it never runs invisibly in the background.
  - **Current content**: one event — "The Poona School and Home for the Blind Boys," Koregaon Park, Pune, July 2026 (client-provided date; the source photos carry no EXIF date, so July 2026 was supplied directly by the client rather than guessed). Narrative describes the client reading her own poetry aloud with the students. The two source photo folders the client provided (`assets/event1/`, `assets/event2/`) were of the same visit, so they were merged into one event and renumbered into `assets/events/poona-school-july-2026/1.jpeg`–`8.jpeg`.
  - **Extensibility (by design, per client request)**: adding a future event needs no HTML changes — add one object to the `EVENTS` array in the tab's inline `<script>` (id, tag, school, schoolCategory, schoolUrl, location, date, dateValue, summary, narrative paragraphs, quote, quoteAttr, photoCount) and drop its photos in `assets/events/<id>/1.jpeg, 2.jpeg, ...` in order. `dateValue` (an ISO date) drives both the sort order and which placard auto-opens; `date` stays the free-text display string (e.g. "July 2026"). The placard and photo stack are both generated from this data.

## 3. Tab: Partner (`#tab3`)

**Radically simplified 2026-09-13 at the client's (Rhea's) explicit request.** Previously had a "Why Partner With Us" 6-card grid, a placeholder founding-principle quote, 3 sponsorship tiers (Seed/Chapter/Patron) with mailto CTAs, a 4-category "Ways to Get Involved" grid, and a 5-question FAQ accordion — all removed. Her direction verbatim: *"the page should just contain the 'let's write this together' bit, with possibly a quote."*

- **Hero**: her own quote — *"One visit can change the way you see the world. Come see what's possible when we choose to make stories accessible to everyone."* — used as the actual page headline (styled as a flowing italic quote, not the site's punchy 3-line tagline treatment used elsewhere, since a full sentence broke badly under that pattern — see note below) with an attribution line crediting her by name.
- **Contact section**: unchanged — left column is copy + a direct email display; right column is a real `<form>` (name, organisation, email, "interested in" dropdown, message) that submits via Netlify Forms. The dropdown's options were trimmed to remove the now-deleted sponsorship tier names (Seed/Chapter/Patron), replaced with a generic "Sponsorship or donation" option.
- All now-orphaned CSS (`.why-*`, `.tier-*`, `.tiers-grid`, `.partner-types-grid`, `.ptype-*`, the old `.quote-strip`/`.quote-text`/`.quote-attr`, `.faq-*`) and the now-unused `toggleFaq()` JS function were removed rather than left as dead code.
- **Design note**: `.partner-hero` used to be a huge (clamp 3–7rem) tagline style with a block-level `<em>`, tuned for short staccato headlines like "Help us put / a story / in every hand." Reusing it verbatim for a full quote sentence made the single emphasized word ("see") balloon into its own oversized line with a huge gap. Since `.partner-hero` is now used nowhere else, it was redefined as an actual quote treatment (smaller, italic by default, inline `<em>` accent) rather than adding a parallel class.

## 4. Tab: Transcribe Guide (`#tab4`) — replaced 2026-09-13

**Was "Reading Room"** (story excerpts, poems with a Web Speech API voice reader, and the Braille translator as a creative showcase). Rhea sent a Google Doc — "Braille Transcription Guide" — with real, structured content for teaching people to actually read and write Braille, and asked for this tab to become that teaching guide. Per her confirmed direction, the old showcase content was **replaced entirely**, not kept alongside the new guide.

- **Hero**: "Understand the dots." + a subhead crediting her as the guide's author.
- **Ways to Write Braille**: two cards — *Slate & Stylus* (what it is, 4-step how-to, a "you write backwards, read forwards" callout) and *Brailler* (what it is, how the 6 keys map to the 6 dots, how to type).
- **The Braille Alphabet**: the full A–Z reference grid — reused from the same generator already powering the identical showcase on The Work tab (the rendering function was generalized to `renderBrailleAlphabet(containerId)` so both call sites share one implementation instead of duplicating it).
- **Braille Grammar & Writing Rules**: Capital Letters (dot 6 + letter), Numbers (number sign dots 3-4-5-6, A=1...J=0), a Punctuation table (comma, full stop, question mark, exclamation mark, colon, semicolon, apostrophe, hyphen — each with its real dot code, taken directly from her doc), and Sentence Structure (5 rules, e.g. one blank cell between words, punctuation directly after the word with no space before it).
- **Practice**: the existing Braille translator, kept and reframed as a hands-on practice tool ("Try it yourself") rather than a creative toy — same underlying `translateToBraille()`/`clearTranslator()` JS, untouched.
- **Tips & Tricks**: her 7 tips verbatim (lightly copy-edited), e.g. "learn the six dots first," "proofread by reading the Braille itself, not just comparing it with the original text," "accuracy comes before speed."
- All now-orphaned CSS and JS from the old showcase were removed rather than left as dead code: the 3 story cards, the braille-facts-strip, both poems, the entire Web Speech API voice-reader system (`POEMS` data, `renderPoemBraille`, `switchPoemView`, `toggleVoice`, `setVoiceIdle`, `getBestVoice`, `voiceState`/`utterances`), and `toggleStory`.
- **Note on her punctuation dot codes vs. the site's own `BRAILLE` JS table**: worth flagging — the site's existing internal `BRAILLE` lookup object (used by the translator, alphabet showcase, and elsewhere) does *not* use the standard dot-number-to-array-position mapping directly (confirmed during the September 12 rebrand while computing new Braille hero text — the array order only makes sense after its own internal `dotsToDisplay()` remapping). This guide's punctuation table was typed in as **static text** matching Rhea's doc exactly, so it's accurate regardless — but the interactive translator's own punctuation set (`, . ! ? ' -`) was not re-verified against her values as part of this change. Worth a dedicated pass if punctuation accuracy in the live translator matters.
- **Braille Lens — added 2026-09-13**: a toggle switch (🔍 icon, right under the hero paragraph) that, once turned on, shows any word's Braille equivalent in a floating tooltip as the visitor hovers over it — anywhere in this tab's prose, including headings and list items. Scoped to `#tab4` only (not site-wide), since this is the page whose whole purpose is teaching Braille.
  - **How it works**: a single `mousemove` listener on `#tab4` uses `document.caretRangeFromPoint` (with a `caretPositionFromPoint` fallback) to find the text node under the cursor, then walks outward to the containing word's boundaries — no per-word `<span>` wrapping, so it works on the guide's existing markup unchanged. The tooltip only rebuilds when the hovered word actually changes, and is anchored to that word's own bounding rect (flipping below the word if there isn't room above), not to the raw cursor position.
  - **Rendering**: reuses the same `BRAILLE` dot-position map and `makeBrailleCell()`/`.t-cell`/`.t-dot` markup already used by the alphabet showcase and the practice translator, so a letter looks identical everywhere on the site.
  - **Exclusions**: the switch itself, the translator's input/output, the alphabet reference grid, and any button/link are excluded from triggering the tooltip (either because they're not prose, or because they already show Braille).
  - **Fixed 2026-09-13 — tooltip disappeared when scrolled**: the tooltip (`#brailleLensTooltip`) originally lived inside `#tab4`. The tab-switch fade-in (`.tab-fade-enter`, see the TAB SWITCHING JS) animates `transform`, and even after that animation settles on its `to { transform: none }` keyframe, the browser reports the section's computed transform as an identity matrix rather than the literal `none` — which still creates a new containing block for `position: fixed` descendants. That silently anchored the tooltip to the section instead of the viewport, so it drifted off-screen by however far the page had scrolled. Fixed by moving `#brailleLensTooltip` out of every tab section entirely, to the top of `<body>` alongside the other page-global fixed elements (`#cursor`, `#cursor-ring`) — it now positions correctly at any scroll position.

## 5. Tab: The Map (`#tab5`) — added 2026-09-12

- **Hero + disclaimer**: framed explicitly as a public-awareness directory, not a confirmed partner network — see `data/README.md` for why that distinction matters.
- **Map**: Leaflet.js with no raster basemap at all — just India's 36 state/UT boundaries (`data/india-states.geojson`, public-domain Natural Earth data, simplified locally), drawn with a dotted stroke so internal borders read as texture rather than a real administrative map. (Two earlier approaches were tried and dropped: CartoDB's dark basemap now gates behind a paid API key, and standard OpenStreetMap tiles bake in every town/road/border regardless of relevance — real noise for a directory map like this.) Ambient state-name labels sit in their own map pane behind the markers, screen-space collision-thinned so they don't crowd each other. City labels only appear once zoomed in past a threshold, and only for cities with a school, gated the same way. Every dot is color-coded by operator type — Government (maroon), NGO-run (sage), Private/Missionary (terracotta), or Unspecified (neutral) when the research couldn't confidently tell — with a legend showing live counts per category. Clusters render as a donut/pie icon (CSS conic-gradient) showing the proportion of each type inside, not just a count. Click a dot (or a cluster to zoom in) to select it.
- **Detail panel**: shows name, type, city/state, address (or a note that only the locality is known), a location-precision label (none of the data is street-exact — see caveats below), and a link to the source the record was researched from.
- **State filter**: a dropdown narrows the map + marker count to one state/UT at a time.
- **Data source**: `data/schools-india.json` — **221 real, individually-sourced schools** for blind/visually-impaired children, researched via web search across every Indian state and UT (government special-education directories, NGO networks, missionary-school histories, and one successfully-extracted official Odisha government PDF). Full provenance, caveats, and known coverage gaps are in `data/README.md` — read it before presenting these numbers externally.
- **Backend**: the map reads from a Supabase (Postgres) table when configured (`config.js`), and automatically falls back to the bundled JSON file otherwise, so it always works. See `docs/DEPLOYMENT-SETUP.md` for the one-time Supabase setup — once done, the site owner manages schools (add/edit/remove) directly in Supabase's own Table Editor, no code changes needed.

## 6. Tab: About (`#tab6`) — added 2026-09-12

Founder bio page for Rhea Divekar. Appended as the last nav tab rather than reordered earlier in the sequence, to avoid renumbering every other tab's id/JS references.

- **Hero**: headline + a one-line framing of the origin story.
- **Intro**: her photo (`assets/RheaDP.jpeg`, cropped via CSS `object-fit: cover` since the source is a casual full-body photo, not a headshot) beside a short bio paragraph, a row of fact chips (age, school, dance training, neuroscience interest, published author), and a "Connect on LinkedIn" link (opens her real profile in a new tab).
- **Name in Braille — added 2026-09-13**: her name renders again in Braille, in a smaller row directly under the printed "Rhea Divekar," with every lit dot blinking on a staggered loop. This reuses the same blink treatment as the homepage hero's "BETWEEN" panel — the render function (`renderBrailleBlink`, formerly a one-off inline block just for the hero) was generalized to take a word, a target container id, and an optional layout class, so both call sites share one implementation instead of duplicating the dot-building/animation logic. The hero keeps its original fixed 7-column grid (`.braille-char-grid`, sized for "BETWEEN"); the name uses a new wrapping flex layout (`.braille-word-row`) instead, since a name of arbitrary length (with a space between first/last name) doesn't fit a fixed column count. The name's dots are also rendered at a smaller scale via scoped CSS overrides (`.about-name-braille .bd`, etc.) rather than a `transform: scale()` hack, matching how the codebase already sizes Braille dots differently per context (compare `.bc` vs `.t-dot` vs `.bd`).
- **Narrative**: four first-person sections in her own words — *The Magic I Find Behind Reading*, *My Love For Writing*, *Where My Passion For Braille Began*, *Where Between the Dots Started* — lightly copy-edited for web (fixed spelling, tightened a few sentences) but not rewritten; content and voice are hers.
- **Closing pull-quote**: "I wanted visually impaired kids to feel the spark I did with fictional novels." — deliberately echoes the site's existing footer tagline ("Every child deserves a story").
- Mentions her published novel *Eunoia of the Endless Horizon* (written at 13) by title only — no Amazon link included, since none was provided and a URL shouldn't be guessed.

## 7. Technical notes worth knowing

- The Braille lookup table covers **A–Z, 0–9, and only `, . ! ? ' -`** — no support for other punctuation, accents, or the actual Grade-1 numeric indicator. All on-page "Braille" is simplified, uncontracted (Grade 1) letter substitution — it is *not* real Grade 2 (contracted) Braille, despite the site's own copy describing production books as "Grade 1 or Grade 2."
- Story, poem, FAQ, tier, and counter content on tabs 1–4 is still hardcoded in the HTML file — only the schools map (tab 5) now has a real backend. Adding a story/poem/FAQ still means editing code.
- No analytics, no tests, no linting/build tooling.
- New dependencies, all loaded via CDN (no build step introduced): Leaflet.js + Leaflet.markercluster for the map.
- **Color palette (light theme, since 2026-09-12):** the CSS custom properties keep their *original names* from the dark theme (`--ink`, `--deep`, `--cream`, `--gold`, `--gold-light`, `--rust`) but now hold different, in some cases confusingly-named, values — `--gold` is now a deep maroon (`#6b1937`), not gold. This was a deliberate tradeoff (renaming every var() usage sitewide was higher-risk than swapping values), but it's a real maintainability wart worth a cleanup pass eventually. Current mapping: `--ink` (page background) = `#faf3e3` warm cream; `--deep` (card/surface background) = `#f0e3c7` slightly deeper tan; `--cream` (body text) = `#2b141b` dark maroon-black ink; `--gold` (primary accent) = `#6b1937` deep maroon; `--gold-light` (hover/lift variant) = `#9c2d54`; `--rust` (secondary accent / error state) = `#a83c2d`; `--sage` (voice-reader / NGO map category) unchanged at `#6b8c6e`. The map's "Private/Missionary" category deliberately uses a fourth, separate terracotta tone (`#c76a3a`) rather than reusing `--rust`, so all four map categories stay visually distinct.

---

## 8. Critical Review — What Should Be Implemented or Corrected

Ranked roughly by priority.

### High priority — functional & credibility risk

1. ~~**Contact form has no real backend.**~~ **Fixed 2026-09-12** — now submits via Netlify Forms with on-page success/error feedback, falling back to `mailto:` only if the POST itself fails.

2. ~~**Numbers on the site don't add up.** The Mission tab claims "6 Original Stories… written & ready for print," but the Reading Room only shows 3 stories + 2 poems.~~ **Moot as of 2026-09-13** — the Reading Room (and its 3 stories + 2 poems) was replaced entirely by the Transcribe Guide, at the client's request. The Mission tab's "6 Original Stories" counter still exists with nothing on the site to visually back it up now — worth another look, but the specific mismatch this finding described no longer applies.

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

6. ~~**Tax-exemption status (80G/12A) is pending**, per the FAQ's own wording.~~ **Moot as of 2026-09-13** — the FAQ that disclosed this was removed along with the rest of the Partner tab's content, at the client's request. The underlying question (is the org actually 12A/80G registered yet?) still matters for any real donation/sponsorship materials going forward — just no longer surfaced on this page.

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
