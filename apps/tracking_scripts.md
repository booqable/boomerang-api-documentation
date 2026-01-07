## Tracking Scripts

Tracking scripts allow your app to inject JavaScript code into the customer-facing websites to track user behavior and integrate with analytics services like Google Analytics, Meta Pixel and others.

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

**Only JavaScript templates are allowed for tracking scripts.** Your template must be a [Liquid](https://shopify.github.io/liquid/) file that contains only valid JavaScript code after rendering.

### Global settings integration

```jsonc
// meta.json
{
  // ...
  "global_settings": {
    "api_key": {
      "type": "text",
      "required": true
    },
  }
}
```

```javascript
// Global app settings are available as template variables
const apiKey = '{{ api_key }}'
this.initializeTracking(apiKey)
```

You can access your app's global settings in the app templates using Liquid syntax. When rendering templates all global settings defined in your `meta.json` are available as template variables.


### User framework

Inside your app's templates you can write Javascript code that uses the Booqable User Framework to load custom scripts and respond to events like `viewProduct`, `addToCart` and more. See the [User framework documentation](#how-apps-work-user-framework) for more details.


### Consent management

If your app installs cookies in the user's browser (for example, for analytics, marketing, or personalization), you **must** integrate with Booqable's consent management framework. This is done via the User Framework by using [`Booqable.registerApp`](#how-apps-work-user-framework-app-registration).

When you register your app using `registerApp`, Booqable will automatically manage when your tracking scripts are allowed to set cookies, based on the user's consent preferences.


### Example implementation

```jsonc
// meta.json
{
  // ...
  "ui_extension": {
    "tracking_script": {
      "template": "templates/index.js.liquid"
    }
  }
}
```

```javascript
// templates/index.js.liquid
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

To the right is an example implementation of app that integrates with Google Analytics.

This example is just for demonstration purposes. If you wish to integrate Google Analytics into your Booqable account you can use our Google Analytics app already available in the Booqable App Store.
