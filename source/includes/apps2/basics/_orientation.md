# The Basics

Booqable apps are modular extensions that add new functionality to a Booqable account or its online store. They're built by third-party developers and distributed through the App Store, where merchants discover, install, and manage them.

An app is fundamentally one file — a `booqable.json` manifest — plus whatever templates, assets, and backend code it needs. Depending on what your app does, it can:

| You want to...                                 | Build |
|-------------------------------------------------|-------|
| Add an analytics/marketing script                | [Tracking Scripts](#capabilities-tracking-scripts) |
| Add custom content blocks to the website builder | [Theme Blocks](#capabilities-theme-blocks) |
| Offer custom shipping rates at checkout           | [Delivery Carriers](#capabilities-delivery-carriers) |
| Process payments, authorizations, or refunds      | [Payment Options](#capabilities-payment-options) |
| Embed a full page or dashboard inside Booqable    | [Embedded Pages](#capabilities-embedded-pages) |

An app can combine more than one of these — the [example payment app](https://github.com/booqable/example-payments-app) on GitHub shows a complete OAuth + payment-options + embedded-page integration if you want a working reference to read alongside these docs.
