## Webhooks

Apps can subscribe to webhook events to receive real-time notifications when certain actions occur in Booqable. This allows your app to respond to user actions and maintain synchronization with the platform.

To learn more about how to use webhooks see the [Webhook Endpoints documentation](/v4.html#webhook-endpoints).

### Available app events

There are four webhook events specifically related to app lifecycle:

#### `app.installed`
Triggered when a user installs your app from the Booqable App Store.

#### `app.configured`
Triggered every time the subscription is saved while the app is configured, not only on the one-time transition into being configured. If a merchant edits already-configured settings again later, this fires again.

#### `app.plan_changed`
Triggered when a user upgrades or downgrades their app subscription plan.

#### `app.uninstalled`
Triggered when a user removes your app from their Booqable account.

### Webhook payload example

```jsonc
// app.installed payload
{
  "id": "22799991-8bc7-4823-a4d1-7eb6329d21b2",
  "type": "webhooks",
  "attributes": {
    "created_at": "2026-08-02T11:12:18.145359+00:00",
    "updated_at": "2026-08-02T11:12:18.145359+00:00",
    "event": "app.installed",
    "version": 4,
    "resource_type": "app_subscriptions",
    "data": {
      "identifier": "mailchimp",
      "app_id": "a2a94184-00f3-424f-bc36-c46a84eb1461",
      "plan_id": "18ad296f-16af-4172-a3de-44bd1218543f",
      "categories": ["marketing"],
      "price_in_cents": 1000,
      "paid": true,
      "free_during_beta": false,
      "configured": false,
      "name": "Mailchimp",
      "provider_name": "Booqable",
      "settings_values": {},
      "features": {},
      "oauth_status": null,
      "theme_blocks": []
    }
  }
}
```

All app webhook events share this envelope: `event`, `version`, and `resource_type` describe what happened, and the actual subscription fields are nested under `data`. Only `event` varies between `app.installed`, `app.configured`, `app.plan_changed`, and `app.uninstalled`.
