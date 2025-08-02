## Webhooks

Apps can subscribe to webhook events to receive real-time notifications when certain actions occur in Booqable. This allows your app to respond to user actions and maintain synchronization with the platform.

To learn more about how to use webhooks see the [Webhook Endpoints documentation](/v4.html#webhook-endpoints).

### Available app events

There are four webhook events specifically related to app lifecycle:

#### `app.installed`
Triggered when a user installs your app from the Booqable App Store.

#### `app.configured`
Triggered when all required app settings have been configured and the app becomes fully functional.

#### `app.plan_changed`
Triggered when a user upgrades or downgrades their app subscription plan.

#### `app.uninstalled`
Triggered when a user removes your app from their Booqable account.

### Webhook payload example

```json
{
  "id": "22799991-8bc7-4823-a4d1-7eb6329d21b2",
  "created_at": "2025-08-02T11:12:18.145359+00:00",
  "updated_at": "2025-08-02T11:12:18.145359+00:00",
  "identifier": "mailchimp",
  "app_id": "a2a94184-00f3-424f-bc36-c46a84eb1461",
  "plan_id": "18ad296f-16af-4172-a3de-44bd1218543f",
  "category": "marketing",
  "icon_cropped_url": null,
  "price_in_cents": 1000,
  "paid": true,
  "free_during_beta": false,
  "configured": false,
  "name": "Mailchimp",
  "provider_name": "Booqable",
  "settings": {
    "api_key": {
      "type": "text",
      "required": true,
      "label": "API key",
      "placeholder": "UA-12345678-1"
    }
  },
  "settings_values": {},
  "config_url": null,
  "support": {
    "email": "support@booqable.com",
    "website": "https://help.booqable.com"
  },
  "features": {},
  "oauth_status": null,
  "frames": null,
  "theme_blocks": []
}
```

To the right is an example of a payload for the app installation event.

All app webhook events use the same payload structure with only the `event` field value varying between `app.installed`, `app.configured`, `app.plan_changed`, and `app.uninstalled`.

