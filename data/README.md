# `schools-india.json`

A dataset of real, individually-sourced schools and institutions for blind/visually-impaired (VI) children across India, compiled 2026-09-12 for the "schools map" feature (Tab 5, "The Map").

**221 records**, each with: `id`, `name`, `state`, `city`, `address`, `lat`, `lng`, `geoPrecision` (`"city"` or `"district-approx"` — none are exact street-level yet), `type`, `sourceUrl`, and an occasional `note` for ambiguous/possibly-duplicate entries.

## `india-states.geojson`

The 36 state/UT boundaries drawn under the map, rendered with a dotted stroke (no basemap tiles, no roads/city clutter — see the note below on why). Extracted from the [Natural Earth admin-1 states/provinces layer](https://github.com/nvkelso/natural-earth-vector) (public domain, mirrored on GitHub), 50m resolution, then simplified locally with Douglas-Peucker (tolerance ~0.01°) from ~4,650 points to ~4,180. Each feature keeps its `name` and Natural Earth's own curated label point (`lat`/`lon`) — used to place the ambient state-name labels rather than a naive polygon centroid, which would land in the ocean for coastal/archipelago states. Attribution is shown in the map's corner per the source license. (An earlier version of this file only had the national outline, no internal state boundaries — replaced 2026-09-12 once state-level detail was requested.)

**Why no basemap tiles:** the map originally used standard OpenStreetMap tiles, but those bake in every town name, road, and administrative line regardless of relevance — exactly the "noise" a directory map like this doesn't want. Drawing just state outlines (dotted, so they read as texture rather than a real administrative map) and layering only our own school markers, city labels (gated to appear only once zoomed in, only for cities that actually have a school), and state-name labels (screen-space collision-thinned so they don't crowd each other, worst around Delhi/NCR and the Northeast) keeps the map legible at both country and regional zoom.

## Important caveats before this goes live

1. **None of these schools have a confirmed relationship with Between the Dots.** This is a public-awareness directory of known institutions, not a partner network. Do not label it "our schools" or "our network" on the site — that would misrepresent an affiliation that hasn't been established. Frame it as something like "Schools for the Blind Across India" or similar.
2. **Coordinates are city/district-level centroids, not exact campus locations.** No public source gave rooftop-accurate lat/lng for any entry. If the map needs to visually distinguish schools within the same city, these coordinates will need real geocoding against the street address first (e.g. via a geocoding API), or the map should acknowledge approximate placement.
3. **This is not exhaustive.** It reflects what's publicly documented and search-indexed, not every school that exists — but two of the biggest known gaps have already been chased down:
   - Odisha's official government special-education PDF (102 statewide special schools, ssepd.odisha.gov.in) **was successfully extracted** — it raised Odisha's count from 4 to 32 confirmed VI-specific institutions.
   - NIEPVD (formerly NIVH), Dehradun — India's national VI-education institute — turned out **not** to maintain a public affiliated-schools directory. One promising lead, a government portal called **DEEPAK** (`disability.ndl.gov.in`) that explicitly indexes "Blind Institution National and Regional," was completely unreachable from the research environment (DNS failure, not just slow) — worth checking manually in an ordinary browser, since it could be the best remaining source of a real consolidated national list.
4. **Coverage gaps (confirmed zero results, not unresearched):** Goa; Dadra & Nagar Haveli and Daman & Diu; Lakshadweep; Andaman & Nicobar Islands; Ladakh; Nagaland; Arunachal Pradesh. Sourced commentary suggests some of these genuinely lack a dedicated standalone institution — VI children may be mainstreamed into regular schools instead.
5. A few entries carry a `note` flagging possible campus overlap rather than true duplicates (e.g. two Bafna schools in Aurangabad, two Ramana Maharishi schools in Karnataka, NIEPVD's own institute vs. its attached CBSE model school in Dehradun) — kept as separate records since sourcing suggests they're genuinely different campuses/entities, but worth a human spot-check. One confirmed exact duplicate (a second "Sri Rakum School for the Blind" listing with an identical address) was removed during merge.
6. Six of the Odisha entries only have district-level confidence with no specific address, because the source PDF's multi-column layout scrambled some address text on extraction — flagged with a `note` each.

## Breakdown by state/UT

| State/UT | Count |
|---|---|
| Maharashtra | 47 |
| Odisha | 32 |
| West Bengal | 25 |
| Karnataka | 16 |
| Uttar Pradesh | 12 |
| Gujarat | 9 |
| Tamil Nadu | 9 |
| Punjab | 8 |
| Kerala | 7 |
| Haryana | 6 |
| Madhya Pradesh | 6 |
| Assam | 5 |
| Jharkhand | 5 |
| Andhra Pradesh | 4 |
| Bihar | 4 |
| Chhattisgarh | 4 |
| Rajasthan | 4 |
| Telangana | 4 |
| Uttarakhand | 3 |
| Delhi | 2 |
| Chandigarh | 1 |
| Himachal Pradesh | 1 |
| Jammu and Kashmir | 1 |
| Manipur | 1 |
| Meghalaya | 1 |
| Mizoram | 1 |
| Puducherry | 1 |
| Sikkim | 1 |
| Tripura | 1 |

## Provenance

Compiled in two passes:

1. Five parallel regional research passes (North, West, South, East, Central/Northeast India) using live web search against government special-education directories, NGO network listings (e.g. National Association for the Blind India affiliates), missionary/Christian institution histories, and school-directory aggregator sites.
2. A targeted follow-up pass extracting Odisha's official government PDF directly (via PDF text extraction, not just a raw fetch) and checking for a national directory via NIEPVD/RCI/DEPwD.

Every record carries a `sourceUrl`. No entries were invented to hit a target count — an original 500-school stretch target was not met, and regions/states that came up thin are reported as thin rather than padded.
