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

The `plans` field itself is optional, defaulting to an empty array for a free app, for example, but if given then each plan under it has its own listing fields:

- **`id`** — a stable identifier for the plan (e.g. `free`, `pro`). Required.
- **`price_in_cents`** — integer, `0` or more. Required.
- **`app_store.title`** — the plan's name on the plan picker. Required.
- **`app_store.description`** / **`app_store.features`** — optional store-facing copy shown on the plan picker.
- **`features`** — internal feature flags (`{id, enabled}`) your app reads to know which capabilities are active for a given subscription — distinct from the display copy above.
- **`most_popular`** — shows a "Most popular" pill on the plan picker.
- **`paid_during_beta`** — paid plans are shown as free while your manifest's `version` is `"beta"`. Set to `true` to keep this plan paid during beta. Defaults to `false`.
