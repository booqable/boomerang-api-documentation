## App Store Listing

Your app's store listing — the card in the App Store, its detail page, and its plan picker — is built entirely from fields in `booqable.json`'s `app_store` object and `plans` array:

- **`title`** — shown on the listing card and detail page. Required.
- **`description.short`** — shown on the listing card. Required.
- **`description.long`** — shown on the detail page. Required.
- **`categories`** — drives listing filters and detail-page pills.
- **`icon`** — shown on the listing card and detail page. Required.
- **`features`** — bulleted list on the detail page.
- **`website`** — link on the detail page.
- **`youtube`** — embedded video on the detail page.
- **`setup_minutes`** — "Setup time" on the detail page.
- **`support`** — populates the Support tab.

Each plan under `plans` has its own listing fields:

- **`id`** — a stable identifier for the plan (e.g. `free`, `pro`).
- **`price_in_cents`** — required.
- **`app_store.title`** / **`app_store.description`** / **`app_store.features`** — the plan's own store-facing copy shown on the plan picker.
- **`features`** — internal feature flags (`{id, enabled}`) your app reads to know which capabilities are active for a given subscription — distinct from the display copy above.
- **`most_popular`** — shows a "Most popular" pill on the plan picker.
- **`paid_during_beta`** — when `false` (the default), the plan is free while your app is in Booqable's beta program; `true` keeps it paid throughout.
