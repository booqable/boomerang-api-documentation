## User Framework

The Booqable User Framework is a collection of Javascript APIs that app developers can use in their app templates. It provides a standardized way to interact with the Booqable platform, handle events, manage scripts, and integrate with third-party services.

The framework is available globally as the `Booqable` object and provides several categories of functionality:

#### App registration

**`Booqable.registerApp(category, appConfig)`**

```javascript
Booqable.registerApp('marketing', {
  name: "Your App Name",
  description: "Description of your app",
  domain: "your-domain.com",

  init: function () {
    // Called when the page loads
  },

  onConsent: function () {
    // Called when user grants consent
  },

  onDeny: function () {
    // Called when user denies consent
  }
})
```

Allows you to register your app with Booqable's cookie consent manager.

**Parameters:**

- `category` - App category (`'marketing'` or `'essential'`).
- `appConfig` - Configuration object with app details and callbacks.

**Available categories:**

- `marketing` - Marketing and analytics apps.
- `essential` - Core functionality apps.

#### Event system

**`Booqable.on(event, callback, context)`**

Listen to Booqable events to track user interactions and page changes.

```javascript
// Track page views
Booqable.on('page-change', function () {
  console.log('User navigated to a new page')
})

// Track product views
Booqable.on('viewProduct', function (data) {
  console.log('User viewed product:', data)
})

// Track cart interactions
Booqable.on('addToCart', function (data) {
  console.log('User added item to cart:', data)
})
```

**`Booqable.off(event, callback)`**

Remove an event listener.

```javascript
const myCallback = function(data) { /* ... */ }
Booqable.on('viewProduct', myCallback)
Booqable.off('viewProduct', myCallback)
```

**Available events:**

- `page-change` - User navigates to a different page.
- `viewProduct` - User views a product page.
- `addToCart` - User adds an item to cart.
- `removeFromCart` - User removes an item from cart.
- `viewCart` - User views the cart page.
- `information` - User reaches checkout information step.
- `payment` - User reaches checkout payment step.
- `completed` - User completes a purchase.

#### Script management

**`Booqable.loadScript(src)`**

Dynamically load external JavaScript files.

```javascript
Booqable.loadScript('https://cdn.example.com/script.js')
```

**`Booqable.unloadScript(src)`**

Remove previously loaded scripts.

```javascript
Booqable.unloadScript('https://cdn.example.com/script.js')
```

**`Booqable.jQuery(callback)`**

Load jQuery and execute a callback when ready.

```javascript
Booqable.jQuery(function() {
  // jQuery is now available
  $('.my-element').hide()
})
```

#### Cart data

**`Booqable.cartData`**

Access current cart information. Available properties:

```javascript
Booqable.cartData = {
  cartId: "cart_123",
  currency: "USD",
  grandTotalWithTax: 99.99,
  tax: 8.99,
  coupon: "SAVE10",
  items: [
    {
      item_id: "prod_123",
      item_name: "Product Name",
      quantity: 1,
      price: 89.99
    }
  ]
}
```

#### Location and origin

**`Booqable.location`**

Get the current page path.

```javascript
console.log(Booqable.location) // "/products/123"
```

**`Booqable.origin`**

Get or set the origin value stored in localStorage.

```javascript
Booqable.origin = "https://example.com"
console.log(Booqable.origin) // "https://example.com"
```

#### Utility functions

**`Booqable._once(func)`**

Ensure a function runs only once.

```javascript
const setupApp = Booqable._once(function() {
  console.log('App setup completed')
})

setupApp() // Runs
setupApp() // Ignored
```

**`Booqable._defer(condition, method, attempt)`**

Execute a method when a condition is met, with retry logic.

```javascript
Booqable._defer(
  function() { return window.myLibrary !== undefined },
  function() { console.log('Library loaded!') }
)
```

**`Booqable._prependChild(parentElement, element)`**

Insert an element at the beginning of a parent element.

```javascript
const newElement = document.createElement('div')
Booqable._prependChild(document.body, newElement)
```

### Example implementation

To the right is an example of a app might do when using the user framework to track shopping behavior.

```javascript
/* global Booqable */
Booqable.registerApp('marketing', {
  name: "My Tracking App",
  description: "Track shopping behavior with the MTA custom analytics platform.",
  domain: "mytrackingapp.example.com",

  init: function () {
    // Initialize when page loads
    console.log('My tracking app initialized')
  },

  onConsent: function () {
    // Load tracking script when user consents
    Booqable.loadScript('https://cdn.mytrackingapp.example.com/tracker.js')

    // Track page views
    Booqable.on('page-change', function () {
      this.trackPageView()
    })

    // Track ecommerce events
    Booqable.on('viewProduct', function (data) {
      this.trackProductView(data)
    })

    Booqable.on('completed', function () {
      this.trackPurchase()
    })
  },

  trackPageView: function () {
    // Custom tracking implementation
    console.log('Page view tracked')
  },

  trackProductView: function (data) {
    console.log('Product view tracked:', data)
  },

  trackPurchase: function () {
    console.log('Purchase tracked:', Booqable.cartData)
  }
})
```
