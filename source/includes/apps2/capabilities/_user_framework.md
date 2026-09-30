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

Your template's top-level code runs immediately when Booqable inserts it into the page, with or without `registerApp`. What `registerApp` actually gets you is a structured `init` callback that fires later (on the window `load` event), plus the `onConsent`/`onDeny` consent hooks below. If your script doesn't need to wait for page load or react to consent, you don't need `registerApp` at all.

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

Available events: `viewProduct`, `addToCart`, `removeFromCart`, `viewCart`, `information`, `payment`, `completed`, `page-change`.

Only `viewProduct`, `addToCart`, and `removeFromCart` receive a `data` argument directly. Every other event fires with no argument at all, so read [`Booqable.cartData`](#capabilities-user-framework-booqable-cartdata) instead.

`page-change` fires on each checkout-step transition (cart, information, payment, completed). It does **not** fire on ordinary storefront navigation (home, product, listing, or static pages).

### `Booqable.cartData`

Maintained by Booqable. Your app should only read it, never assign to it. It includes:

`cartId`, `orderId`, `orderNumber`, `currency`, `coupon`, `couponDiscount`, `deposit`, `toBePaid`, `totalDueLater`, `grandTotal`, `grandTotalWithTax`, `tax`, `deliveryPrice`, `items`, `email`, `name`.

### Utilities

- **`Booqable.loadScript(url)`** / **`Booqable.unloadScript(url)`**: load or remove an external script, deduplicated by exact URL.
- **`Booqable.jQuery(callback)`**: loads jQuery **3.3.1** specifically (pinned, from a fixed CDN URL) and calls `callback` once it's ready. Deduplicated by exact script URL, so if the merchant's theme already loads a different jQuery build from a different URL, you'll end up with two separate jQuery instances on the page.
- **`Booqable._defer(condition, fn)`**: retries `fn` roughly every 50ms until `condition` passes, up to 200 attempts (about 10 seconds), then silently gives up with no error and no callback. Don't rely on it for something that must eventually run.

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
