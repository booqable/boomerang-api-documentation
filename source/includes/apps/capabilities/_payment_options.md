## Payment Options

This capability allows your app to add custom payment options for users during checkout.

### Routes

```jsonc
// booqable.json
{
  "base_url": "https://my-payments-app.com",
  "payments": {
    "routes": {
      "charge_url": { "relative": "/mypay/charge" },
      "cancel_charge_url": { "relative": "/mypay/charge/:id/cancel" },
      "authorization_url": { "relative": "/mypay/auth" },
      "capture_authorization_url": { "relative": "/mypay/auth/:id/capture" },
      "void_authorization_url": { "relative": "/mypay/auth/:id/void" },
      "refund_url": { "relative": "/mypay/refund" }
    },
    "pay_button": { "asset": "assets/pay-button.svg" }
  }
}
```

Payment apps define their API routes under the [`payments.routes` object of their `booqable.json` file](#reference-paymentroutes). These routes tell Booqable where to send requests for different payment operations. Routes are relative to your manifest's `base_url`, or absolute URLs. `pay_button` is a separate, optional asset reference rendered as the clickable payment button in checkout.

There are a total of 6 routes available:

- [`charge_url`](#capabilities-payment-options-configuration-available-routes-charge_url)
- [`cancel_charge_url`](#capabilities-payment-options-configuration-available-routes-cancel_charge_url)
- [`authorization_url`](#capabilities-payment-options-configuration-available-routes-authorization_url)
- [`capture_authorization_url`](#capabilities-payment-options-configuration-available-routes-capture_authorization_url)
- [`void_authorization_url`](#capabilities-payment-options-configuration-available-routes-void_authorization_url)
- [`refund_url`](#capabilities-payment-options-configuration-available-routes-refund_url)

### Configuration

```jsonc
// POST /api/4/app_payment_options (request)
{
  "data": {
    "type": "app_payment_options",
    "attributes": {}
  }
}
```

After a user installs your payment app, you must create a PaymentOption record using Booqable's [Payment Options API endpoint](/internal.html#app-payment-options). The PaymentOption enables Booqable to show new payment options in the UI using the routes configured in your app's `booqable.json` file. Users can then select your payment method during checkout, and Booqable will make authenticated requests to your app's endpoints using JWT tokens for security.

An empty `attributes` object is enough: `name`, `identifier`, and all 6 routes are copied from your manifest automatically.

Create the PaymentOption right after your app exchanges its OAuth code for an access token (see [OAuth](#booqable-interop-oauth)), or once the user has provided any other settings your app needs.

**Tip:** If you're using the [Booqable App Rails engine](https://github.com/booqable/booqable_app_rails), you can schedule the PaymentOption creation in a background job from the `AppInstalledJob` hook.

There's no update endpoint for a payment option once created. To change a route later, archive and recreate it.

#### Available Routes

##### `charge_url`

```jsonc
// Example:
// POST https://my-payments-app.com/charge
```

```
┌──────────────┐                    ┌──────────────┐                    ┌─────────────┐
│   Booqable   │                    │  Payment App │                    │  Customer   │
└──────┬───────┘                    └──────┬───────┘                    └──────┬──────┘
       │                                   │                                   │
       │  1. POST to charge_url            │                                   │
       │──────────────────────────────────>│                                   │
       │                                   │                                   │
       │  2. Return { id, redirect_url }   │                                   │
       │<──────────────────────────────────│                                   │
       │                                   │                                   │
       │  3. Booqable redirects to `redirect_url`                              │
       │──────────────────────────────────>│                                   │
       │                                   │                                   │
       │                                   │  4. Customer completes payment    │
       │                                   │<──────────────────────────────────│
       │                                   │                                   │
       │  5. PUT /api/4/payment_charges    │                                   │
       │<──────────────────────────────────│                                   │
       │         (update status)           │                                   │
       │                                   │                                   │
       │  6. Redirect to `return_url`      │                                   │
       │<──────────────────────────────────│                                   │
       │                                   │                                   │
       │  7. Customer sees success page    │                                   │
       │<──────────────────────────────────────────────────────────────────────│
```

Process payment charges.

This route is called when a user initiates a payment during checkout. Booqable sends the payment details including the total amount, deposit amount, customer address, and a return URL where the user should be redirected after payment completion. Your app should respond with a unique charge ID and a redirect URL where the user can complete the payment.

*Flow:*

1. Booqable sends a `POST` request to your `charge_url` with the payment details.
2. Respond with your internal charge `id` and a `redirect_url` for the customer.
3. Booqable redirects the customer to your `redirect_url` to complete payment.
4. Once the customer completes payment, [update the PaymentCharge](/v4.html#payment-charges-update-a-payment-charge) status (`succeeded`, `failed`).
5. Redirect the customer back to the `return_url` provided in step 1.

###### Request Parameters

```jsonc
// POST charge_url (request)
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "customer_address": "123 Main St, City, State, Country",
  "total_in_cents": 5000,
  "deposit_in_cents": 1000,
  "currency": "USD",
  "return_url": "https://booqable.com/example-end-of-payment-callback"
}
```

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this charge in Booqable's system |
| `customer_address` | The customer's default address as a single line, or `null` if there isn't one |
| `total_in_cents` | Total amount to charge in cents (e.g., 5000 = $50.00) |
| `deposit_in_cents` | The portion of `total_in_cents` that is a deposit, in cents |
| `currency` | Currency code for the payment (e.g., "USD", "EUR") |
| `return_url` | URL where the user should be redirected after payment completion |

###### Response Parameters

```jsonc
// your charge_url responds with this (response)
{
  "id": "charge_123",
  "redirect_url": "https://my-payments-app.com/redirect"
}
```

| Parameter | Description |
|-----------|-------------|
| `id` | Unique identifier for the charge, in your payment app's system |
| `redirect_url` | URL where the user should be redirected to, from Booqable, to complete the payment |

##### `cancel_charge_url`

```jsonc
// Example:
// PUT https://my-payments-app.com/charge/charge_123/cancel
```

Cancel a payment charge.

This route is called when a payment needs to be cancelled, typically when an order is cancelled or when a shopping cart is invalidated. The charge ID from your app is passed in the URL path, and you should respond with a success status to confirm the cancellation.

*Flow:*

1. Booqable sends a `PUT` request to your `cancel_charge_url` with your charge ID in the URL path and an empty JSON body (`{}`).
2. Cancel the pending charge on your payment provider (if applicable).
3. Respond with HTTP 200 OK to confirm cancellation.

**Note:** No API callback is required. Booqable handles the status update internally after receiving your success response. Errors are logged but don't block cancellation on Booqable's side.

###### Request Parameters

| Parameter | Description |
|-----------|-------------|
| `:id` (URL path) | The charge ID, in your payment app's system, to cancel |

###### Response

The response should be an HTTP 200 OK status.

##### `authorization_url`

```jsonc
// Example:
// POST https://my-payments-app.com/authorization
```

```
┌──────────────┐                    ┌──────────────┐                    ┌─────────────┐
│   Booqable   │                    │  Payment App │                    │  Customer   │
└──────┬───────┘                    └──────┬───────┘                    └──────┬──────┘
       │                                   │                                   │
       │  1. POST to authorization_url     │                                   │
       │──────────────────────────────────>│                                   │
       │                                   │                                   │
       │  2. Return { id, redirect_url }   │                                   │
       │<──────────────────────────────────│                                   │
       │                                   │                                   │
       │  3. Booqable redirects to `redirect_url`                              │
       │──────────────────────────────────>│                                   │
       │                                   │                                   │
       │                                   │  4. Customer authorizes hold      │
       │                                   │<──────────────────────────────────│
       │                                   │                                   │
       │  5. PUT /api/4/payment_authorizations                                 │
       │<──────────────────────────────────│                                   │
       │          (update status)          │                                   │
       │                                   │                                   │
       │  6. Redirect to `return_url`      │                                   │
       │<──────────────────────────────────│                                   │
```

Create payment authorizations for deposit/capture flows.

This route is called when creating a payment authorization for later capture, typically used for deposit and hold scenarios where funds are authorized but not immediately charged. The response should include an authorization ID and redirect URL for the user to complete the authorization process.

*Flow:*

1. Booqable sends a `POST` request to your `authorization_url` with the authorization details.
2. Respond with your internal authorization `id` and a `redirect_url` for the customer.
3. Booqable redirects the customer to your `redirect_url` to complete the authorization.
4. Once the customer authorizes the hold, [update the PaymentAuthorization](/v4.html#payment-authorizations-update-a-payment-authorization) status (`succeeded`, `failed`).
5. Redirect the customer back to the `return_url` provided in step 1.

###### Request Parameters

```jsonc
// POST authorization_url (request)
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "customer_address": "123 Main St, City, State",
  "total_in_cents": 5000,
  "currency": "USD",
  "return_url": "https://booqable.com/example-end-of-authorization-callback"
}
```

Unlike `charge_url`, this request has no `deposit_in_cents` field.

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this authorization in Booqable's system |
| `customer_address` | The customer's default address as a single line, or `null` if there isn't one |
| `total_in_cents` | Total amount to authorize in cents (e.g., 5000 = $50.00) |
| `currency` | Currency code for the authorization (e.g., "USD", "EUR") |
| `return_url` | URL where the user should be redirected after authorization completion |

###### Response Parameters

```jsonc
// your authorization_url responds with this (response)
{
  "id": "authorization_123",
  "redirect_url": "https://my-payments-app.com/redirect"
}
```

| Parameter | Description |
|-----------|-------------|
| `id` | Unique identifier for the authorization in your payment app's system |
| `redirect_url` | URL where the user should be redirected to, from Booqable, to complete the authorization |

##### `capture_authorization_url`

```jsonc
// Example:
// PUT https://my-payments-app.com/authorization/authorization_123/capture
```

```
┌──────────────┐                    ┌──────────────┐
│   Booqable   │                    │  Payment App │
└──────┬───────┘                    └──────┬───────┘
       │                                   │
       │  1. PUT to capture_authorization_url
       │──────────────────────────────────>│
       │                                   │
       │  2. Return 200 OK                 │
       │<──────────────────────────────────│
       │                                   │
       │                                   │  3. Capture funds on provider
       │                                   │
       │  4. PUT /api/4/payment_charges    │
       │<──────────────────────────────────│
       │          (update status)          │
```

Capture funds from a previous authorization.

This route is called when capturing previously authorized funds, completing the deposit and hold flow. The authorization ID from your app is passed in the URL path, and the request body contains the final amount to capture along with the Booqable charge ID. Your app should respond immediately with HTTP 200 OK. After the actual capture of the funds is complete you must update the PaymentCharge status via the Booqable API.

*Flow:*

1. Booqable sends a `PUT` request to your `capture_authorization_url` with the authorization ID in the URL path.
2. Respond immediately with HTTP 200 OK (the charge is saved as `started` in Booqable).
3. Capture the funds on your payment provider.
4. [Update the PaymentCharge](/v4.html#payment-charges-update-a-payment-charge) status (`succeeded`, `failed`).

###### Request Parameters

```jsonc
// PUT capture_authorization_url/:id (request)
{
  "total_in_cents": 5000,
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c"
}
```

| Parameter | Description |
|-----------|-------------|
| `total_in_cents` | Final amount to capture in cents (may be less than or equal to the authorized amount) |
| `booqable_id` | The unique identifier of the new [PaymentCharge](/v4.html#payment-charges) representing the captured funds |

**Note:** Authorizations can only be captured once. If you capture less than the authorized amount, the remaining funds are released back to the customer.

###### Response

The response should be an HTTP 200 OK status. The body is ignored. If you respond with an error status, Booqable discards the new PaymentCharge and the capture fails. Include a JSON `error` message to explain why.

##### `void_authorization_url`

```jsonc
// Example:
// PUT https://my-payments-app.com/authorization/authorization_123/void
```

Void/cancel a payment authorization.

This route is called when cancelling an unused authorization, typically when an order is cancelled before the authorization is captured or when the authorization expires. The authorization ID from your app is passed in the URL path, and you should respond with a success status to confirm the void operation.

*Flow:*

1. Booqable sends a `PUT` request to your `void_authorization_url` with the authorization ID in the URL path and an empty JSON body (`{}`).
2. Release the held funds on your payment provider.
3. Respond with HTTP 200 OK to confirm the void.

**Note:** No API callback is required. Booqable handles the status update internally after receiving your success response. A 404 response is treated as an already-voided authorization, not an error.

###### Request Parameters

| Parameter | Description |
|-----------|-------------|
| `:id` (URL path) | The authorization ID, in your payment app's system, to void |

###### Response

The response should be an HTTP 200 OK status.

##### `refund_url`

```jsonc
// Example:
// POST https://my-payments-app.com/refund
```

```
┌──────────────┐                    ┌──────────────┐
│   Booqable   │                    │  Payment App │
└──────┬───────┘                    └──────┬───────┘
       │                                   │
       │  1. POST to refund_url            │
       │──────────────────────────────────>│
       │                                   │
       │  2. Return { id }                 │
       │<──────────────────────────────────│
       │                                   │
       │                                   │  3. Process refund on provider
       │                                   │
       │  4. PUT to /api/4/payment_refunds │
       │<──────────────────────────────────│
       │          (update status)          │
```

Process payment refunds.

This route is called when processing a refund for a completed payment. Booqable sends the refund details including the original charge ID, refund amount, deposit amount, and currency. Your app should respond with a unique refund ID to track the refund operation.

*Flow:*

1. Booqable sends a `POST` request to your `refund_url` with the refund details.
2. Respond immediately with your internal refund `id` (the refund is saved as `pending` in Booqable).
3. Process the refund on your payment provider.
4. [Update the PaymentRefund](/v4.html#payment-refunds-update-a-payment-refund) status (`succeeded`, `failed`).

###### Request Parameters

```jsonc
// POST refund_url (request)
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "charge_id": "original_charge_id",
  "total_in_cents": 5000,
  "deposit_in_cents": 1000,
  "currency": "USD"
}
```

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this [PaymentRefund](/v4.html#payment-refunds) in Booqable's system |
| `charge_id` | Your internal charge ID (`provider_id` from the original charge) being refunded |
| `total_in_cents` | Refund amount in cents (e.g., 5000 = $50.00) |
| `deposit_in_cents` | The portion of `total_in_cents` that is a deposit refund, in cents |
| `currency` | Currency code for the refund (e.g., "USD", "EUR") |

###### Response Parameters

```jsonc
// your refund_url responds with this (response)
{
  "id": "refund_123"
}
```

| Parameter | Description |
|-----------|-------------|
| `id` | Unique identifier for the refund, in your payment app's system |

### Notes

* Every request to your routes is authenticated with a `Bearer` JWT in the `Authorization` header, identifying the company. This token doesn't expire, so treat it as a long-lived credential and validate it on every request, not just accept it once.
* For `charge_url` and `authorization_url` flows, always update the payment status via the Booqable API **before** redirecting the customer back to the `return_url`. The callback page polls the payment status and will wait indefinitely if the status is never updated.
* Even when a payment fails, update the status to `failed` before redirecting. Otherwise, the callback page polls indefinitely waiting for a status change.
* Always store the `booqable_id` from the initial request. You'll need it to update the payment status later, especially for asynchronous payment processing.
* Use the correct HTTP methods for the route:
  - `charge_url`, `authorization_url`, `refund_url` use **POST** to create new resources.
  - `cancel_charge_url`, `void_authorization_url`, `capture_authorization_url` use **PUT** to update existing resources.
* A failed request to any route (429, 500, 502, 503, or 504 response) is retried by Booqable up to twice before giving up.
