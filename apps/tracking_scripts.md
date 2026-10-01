## Tracking Scripts

Tracking scripts let your app inject JavaScript into every storefront page — useful for analytics, marketing pixels, and similar integrations.

```jsonc
// booqable.json
{
  "tracking_script": {
    "template": { "asset": "templates/index.js.liquid" }
  }
}
```

Only JavaScript is allowed: the referenced template must be a [Liquid](https://shopify.github.io/liquid/) file that renders to valid JavaScript. It is inlined into the page inside a `load` handler and is not validated, so a syntax error will break your script. Declarations at the top level are not global, so attach anything other code needs to `window`.

Merchant-entered values (like an API key) come from a `configuration_page` form field, not a manifest key — see [Configuration](https://developers.booqable.com/apps.html#configuration). Whatever the merchant enters is available in your template as a variable named after the field, e.g. `const apiKey = '{{ api_key }}'`.

Your script only renders once the app is installed and configured, so if you have required form fields, nothing is injected until the merchant has saved them.

Inside your template, use the [User Framework](https://developers.booqable.com/apps.html#capabilities-user-framework) to hook into storefront events (`viewProduct`, `addToCart`, checkout steps, ...) and to register for cookie consent.

If your script sets cookies, register it with `Booqable.registerApp` so Booqable can gate it behind visitor consent. One real caveat: this only actually gates anything if the merchant has enabled the cookie notice in their theme. If they haven't, `onConsent` fires automatically for every visitor with no interaction at all — design your integration to tolerate either case.

### Example

```javascript
// templates/index.js.liquid
Booqable.registerApp('marketing', {
  name: "Google Analytics",
  domain: "googletagmanager.com",

  init: function () {
    window.dataLayer = window.dataLayer || []
    window.gtag = function () { window.dataLayer.push(arguments) }
    window.gtag('consent', 'default', { ad_storage: 'denied', analytics_storage: 'denied' })
    window.gtag('js', new Date())
    window.gtag('config', '{{ api_key }}')
    Booqable.loadScript('https://www.googletagmanager.com/gtag/js?id={{ api_key }}')
  },

  onConsent: function () {
    window.gtag('consent', 'update', { ad_storage: 'granted', analytics_storage: 'granted' })
  },

  onDeny: function () {
    window.gtag('consent', 'update', { ad_storage: 'denied', analytics_storage: 'denied' })
  }
})
```

This example does its setup in `init` (always called on page load) and relies on GA4's own consent mode (`gtag('consent', ...)`) rather than gating inside `onConsent`/`onDeny` directly — a valid alternative when the third-party library you're wrapping has its own consent-aware mode.
