## User Framework

The User Framework is a client-side JavaScript API, available as `window.Booqable` inside your [Tracking Scripts](#capabilities-tracking-scripts) and [Theme Blocks](#capabilities-theme-blocks) templates. It doesn't apply to any other capability.

### Registering your app

```javascript
Booqable.registerApp('marketing', {
  name: "My App",
  domain: "example.com",

  init: function () {
    // Always runs on page load, regardless of consent.
  },

  onConsent: function () {
    // See "Consent gating" below: not guaranteed to run.
  },

  onDeny: function () {
    // See "Consent gating" below: not guaranteed to run.
  }
})
```

Your template's top-level code runs with or without `registerApp`. In a theme block it runs as the page is parsed. In a tracking script it runs on the window `load` event, since the script is wrapped in a `load` handler. What `registerApp` actually gets you is a structured `init` callback that fires on the window `load` event, plus the `onConsent`/`onDeny` consent hooks below. If your script doesn't need to react to consent, you don't need `registerApp` at all. Call `registerApp` synchronously at the top level of your template. Registering later, for example inside a timeout or a callback, won't get `init`.

The first argument is a category: `marketing` or `essential`. In practice almost every real app registers as `marketing`. The two categories aren't symmetric (see below), and `essential` is rarely used.

### Consent gating

`onConsent`/`onDeny` are meant to gate cookie-setting behind the visitor's choice, but whether they fire at all depends on a setting the merchant controls, not something your app can see or influence:

- **If the merchant has the cookie notice enabled** in their theme, `onConsent`/`onDeny` fire for `marketing`-category apps as the visitor accepts, denies, or changes their choice. **`essential`-category apps never get `onConsent`/`onDeny` called in this case at all**, only `init` runs for them.
- **If the merchant has not enabled the cookie notice**, `onConsent` fires automatically for every registered app regardless of category, on every page load, with zero visitor interaction. `onDeny` is never called in this case.

Practical implication: don't assume `onConsent`/`onDeny` reflect real, deliberate visitor consent. A merchant without the cookie notice enabled effectively grants blanket consent to every app on every page load. If your integration has real compliance requirements, treat this as a merchant configuration issue to flag, not something your app code can enforce on its own.

### Events

```javascript
Booqable.on('addToCart', function (data) {
  // data: { value, currency, items: [{ item_id, item_name, quantity, price }] }
})

Booqable.on('completed', function () {
  // no argument, read Booqable.cartData instead
})
```

Available events: `viewProduct`, `addToCart`, `removeFromCart`, `information`, `payment`, `completed`, `page-change`.

Only `viewProduct`, `addToCart`, and `removeFromCart` receive a `data` argument directly. Every other event fires with no argument at all, so read [`Booqable.cartData`](#capabilities-user-framework-booqable-cartdata) instead.

`page-change` fires once per checkout page load (information, payment, completed). It does **not** fire on ordinary storefront navigation (home, product, listing, or static pages).

### `Booqable.cartData`

Only available in the checkout events (`information`, `payment`, `completed`). Your app should only read it, never assign to it. It includes:

`cartId`, `orderId`, `orderNumber`, `currency`, `coupon`, `couponDiscount`, `deposit`, `toBePaid`, `totalDueLater`, `grandTotal`, `grandTotalWithTax`, `tax`, `deliveryPrice`, `items`, `email`, `name`.

### Utilities

- **`Booqable.loadScript(url)`** / **`Booqable.unloadScript(url)`**: load or remove an external script, deduplicated by exact URL.
- **`Booqable.jQuery(callback)`**: runs `callback` once jQuery is available on the page as `window.$`, loading jQuery if needed. The version isn't guaranteed. If the theme already provides jQuery, you get that one.

`window.Booqable` also exposes additional methods used internally by Booqable's own first-party integrations. These aren't part of this API and may change without notice, so stick to what's documented here.

### Example

```javascript
Booqable.registerApp('marketing', {
  name: "Example Tracker",
  domain: "example.com",

  onConsent: function () {
    Booqable.on('page-change', function () { /* ... */ })
    Booqable.on('viewProduct', function (data) { /* ... */ })
    Booqable.on('completed', function () {
      var total = Booqable.cartData.grandTotalWithTax
      // ...
    })
  }
})
```

This pattern, subscribing to events only inside `onConsent`, is the safe default when the library you're integrating has no consent-aware mode of its own. If it does (as GA4's `gtag('consent', ...)` does), setting up in `init` and relying on the library's own gating is a valid alternative. See the [Tracking Scripts](#capabilities-tracking-scripts) example.
