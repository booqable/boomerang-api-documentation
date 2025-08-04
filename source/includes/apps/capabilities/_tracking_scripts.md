## Tracking Scripts

Tracking scripts allow your app to inject JavaScript code into the customer-facing website to track user behavior and integrate with analytics services like Google Analytics, Meta Pixel and others.

### Configuration

```json
{
  "ui_extension": {
    "tracking_script": {
      "template": "templates/index.js.liquid"
    }
  }
}
```

To enable tracking scripts in your app you need to configure the [`tracking_script`](#reference-trackingscriptsettings) settings in your `meta.json` file. The `template` property specifies the path to your JavaScript template file that will be rendered and injected into the customer's website.

**Only JavaScript templates are allowed for tracking scripts.** Your template must be a `.js.liquid` file that contains only valid JavaScript code after processing.

### Consent management

TODO

### Global settings integration

```json
{
  "global_settings": {
    "api_key": {
      "type": "text",
      "required": true
    },
    "domain_verification": {
      "type": "text",
      "required": false
    }
  }
}
```

```javascript
// Access global settings
const apiKey = '{{ api_key }}'
const domainVerification = '{{ domain_verification }}'

// Use in your tracking script
this.initializeTracking(apiKey, domainVerification)
```

Access your app's global settings in your template using Liquid syntax. Settings defined in your `meta.json` are available as template variables.

TODO expand

### Booqable framework

TODO link to user framework

### Example implementation

To the right is a complete example of a Google Analytics tracking script, based on our own [Google Analytics app](https://green-snow.booqable.com/app-store/2f66048a-1e3b-4dae-b152-11b3fa98039d).

```javascript
/* global Booqable */
Booqable.registerApp('marketing', {
  name: "Google Analytics",
  description: "Track user behavior with Google Analytics",
  domain: "googletagmanager.com",

  onConsent: function () {
    // Update consent settings
    window.gtag('consent', 'update', {
      'ad_storage': 'granted',
      'analytics_storage': 'granted'
    })

    // Load Google Analytics
    Booqable.loadScript('https://www.googletagmanager.com/gtag/js?id=' + '{{ api_key }}')
  },

  onDeny: function() {
    // Update consent settings
    window.gtag('consent', 'update', {
      'ad_storage': 'denied',
      'analytics_storage': 'denied'
    })

    // Remove Google Analytics
    Booqable.unloadScript('https://www.googletagmanager.com/gtag/js?id=' + '{{ api_key }}')
  },

  init: function () {
    const trackingId = '{{ api_key }}'

    // Initialize Google Analytics
    window.dataLayer = window.dataLayer || []
    window.gtag = function () { window.dataLayer.push(arguments) }

    window.gtag('consent', 'default', {
      'ad_storage': 'denied',
      'analytics_storage': 'denied'
    })

    window.gtag('js', new Date())
    window.gtag('config', trackingId)

    // Track ecommerce events
    Booqable.on('viewProduct', function (data) {
      window.gtag('event', 'view_item', {
        currency: data.currency,
        value: data.value,
        items: data.items
      })
    })

    Booqable.on('addToCart', function (data) {
      window.gtag('event', 'add_to_cart', {
        currency: data.currency,
        value: data.value,
        items: data.items
      })
    })

    Booqable.on('completed', function () {
      window.gtag('event', 'purchase', {
        transaction_id: Booqable.cartData.cartId,
        value: Booqable.cartData.grandTotalWithTax,
        currency: Booqable.cartData.currency,
        items: Booqable.cartData.items
      })
    })
  }
})
```
