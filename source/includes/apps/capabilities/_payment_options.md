## Payment Options

This capability allows your app to add custom payment options for users during checkout.


### Routes

```json
{
  "routes": {
    "charge_url": "/paypal/charge",
    "cancel_charge_url": "/paypal/charge/:id/cancel",
    "authorization_url": "/paypal/auth",
    "capture_authorization_url": "/paypal/auth/:id/capture",
    "void_authorization_url": "/paypal/auth/:id/void",
    "refund_url": "/paypal/refund",
  }
}
```

Payment apps define their API routes in the [`routes` section of their `meta.json` file](#reference-routes). These routes tell Booqable where to send requests for different payment operations.

There are a total of 6 routes available:

- [`charge_url`](#capabilities-payment-options-configuration-available-routes-charge_url)
- [`cancel_charge_url`](#capabilities-payment-options-configuration-available-routes-cancel_charge_url)
- [`authorization_url`](#capabilities-payment-options-configuration-available-routes-authorization_url)
- [`capture_authorization_url`](#capabilities-payment-options-configuration-available-routes-capture_authorization_url)
- [`void_authorization_url`](#capabilities-payment-options-configuration-available-routes-void_authorization_url)
- [`refund_url`](#capabilities-payment-options-configuration-available-routes-refund_url)


### Configuration

```shell
curl --request POST \
  --url 'https://example.booqable.com/api/4/app_payment_options' \
  --header 'content-type: application/json' \
  --data '{
    "data": {
      "type": "app_payment_options",
      "attributes": {}
    }
  }'
```

After a user installs your payment app, you must create a PaymentOption record using Booqable's [Payment Options API endpoint](/internal.html#app-payment-options). The PaymentOption enables Booqable to show new payment options in the UI using the [routes configured in your app's `meta.json` file](#reference-routes). Users can then select your payment method during checkout, and Booqable will make authenticated requests to your app's endpoints using JWT tokens for security.

You should create the PaymentOption right after the app exchanges the authorization code for an access token or when a user has provided all necessary settings for your app to function.


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

This route is called when a user initiates a payment during checkout. Booqable sends the payment details including the total amount, customer address, and a return URL where the user should be redirected after payment completion. Your app should respond with a unique charge ID and a redirect URL where the user can complete the payment.

*Flow:*

1. Booqable sends a `POST` request to your `charge_url` with the payment details.
2. Respond with your internal charge `id` and a `redirect_url` for the customer.
3. Booqable redirects the customer to your `redirect_url` to complete payment.
4. Once the customer completes payment, [update the PaymentCharge](/v4.html#payment-charges-update-a-payment-charge) status (`succeeded`, `failed`).
5. Redirect the customer back to the `return_url` provided in step 1.

###### Request Parameters

```jsonc
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "customer_address": "123 Main St, City, State, Country",
  "total_in_cents": 5000,
  "currency": "USD",
  "return_url": "https://booqable.com/example-end-of-payment-callback"
}
```

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this charge in Booqable's system |
| `customer_address` | Customer's billing address for payment processing |
| `total_in_cents` | Total amount to charge in cents (e.g., 5000 = $50.00) |
| `currency` | Currency code for the payment (e.g., "USD", "EUR") |
| `return_url` | URL where the user should be redirected after payment completion |

###### Response Parameters

```jsonc
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

1. Booqable sends a `PUT` request to your `cancel_charge_url` with your charge ID in the URL path.
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
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "customer_address": "123 Main St, City, State",
  "total_in_cents": 5000,
  "currency": "USD",
  "return_url": "https://booqable.com/example-end-of-authorization-callback"
}
```

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this authorization in Booqable's system |
| `customer_address` | Customer's billing address for payment processing |
| `total_in_cents` | Total amount to authorize in cents (e.g., 5000 = $50.00) |
| `currency` | Currency code for the authorization (e.g., "USD", "EUR") |
| `return_url` | URL where the user should be redirected after authorization completion |

###### Response Parameters

```jsonc
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
       │                                   │  2. Capture funds on provider
       │                                   │
       │  3. Return 200 OK                 │
       │<──────────────────────────────────│
       │                                   │
       │  4. PUT /api/4/payment_charges    │
       │<──────────────────────────────────│
       │          (update status)          │
```

Capture funds from a previous authorization.

This route is called when capturing previously authorized funds, completing the deposit and hold flow. The authorization ID from your app is passed in the URL path, and the request body contains the final amount to capture along with the Booqable charge ID.

*Flow:*

1. Booqable sends a `PUT` request to your `capture_authorization_url` with the authorization ID in the URL path.
2. Capture the funds on your payment provider.
3. Respond with HTTP 200 OK and your capture `id`.
4. [Update the PaymentCharge](/v4.html#payment-charges-update-a-payment-charge) status.

###### Request Parameters

```jsonc
{
  "total_in_cents": 5000,
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c"
}
```

| Parameter | Description |
|-----------|-------------|
| `total_in_cents` | Final amount to capture in cents (may be less than or equal to the authorized amount) |
| `booqable_id` | The unique identifier of the new [PaymentCharge](/v4.html#payment-charges) representing the captured funds |

###### Response

The response should be an HTTP 200 OK status with an optional `id` field.

```jsonc
{
  "id": "your-capture-id"
}
```

##### `void_authorization_url`

```jsonc
// Example:
// PUT https://my-payments-app.com/authorization/authorization_123/void
```

Void/cancel a payment authorization.

This route is called when cancelling an unused authorization, typically when an order is cancelled before the authorization is captured or when the authorization expires. The authorization ID from your app is passed in the URL path, and you should respond with a success status to confirm the void operation.

*Flow:*

1. Booqable sends a `PUT` request to your `void_authorization_url` with the authorization ID in the URL path.
2. Release the held funds on your payment provider.
3. Respond with HTTP 200 OK to confirm the void.

**Note:** No API callback is required. Booqable handles the status update internally after receiving your success response.

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

This route is called when processing a refund for a completed payment. Booqable sends the refund details including the original charge ID, refund amount, and currency. Your app should respond with a unique refund ID to track the refund operation.

*Flow:*

1. Booqable sends a `POST` request to your `refund_url` with the refund details.
2. Respond immediately with your internal refund `id` (the refund is saved as `pending` in Booqable).
3. Process the refund on your payment provider (may be synchronous or asynchronous).
4. [Update the PaymentRefund](/v4.html#payment-refunds-update-a-payment-refund) status (`succeeded`, `failed`).

###### Request Parameters

```jsonc
{
  "booqable_id": "a3f1c9e2-4b7d-4e8a-9c2b-1f5e6d7a8b9c",
  "charge_id": "original_charge_id",
  "total_in_cents": 5000,
  "currency": "USD"
}
```

| Parameter | Description |
|-----------|-------------|
| `booqable_id` | The unique identifier of this [PaymentRefund](/v4.html#payment-refunds) in Booqable's system |
| `charge_id` | Your internal charge ID (`provider_id` from the original charge) being refunded |
| `total_in_cents` | Refund amount in cents (e.g., 5000 = $50.00) |
| `currency` | Currency code for the refund (e.g., "USD", "EUR") |

###### Response Parameters

```jsonc
{
  "id": "refund_123"
}
```

| Parameter | Description |
|-----------|-------------|
| `id` | Unique identifier for the refund, in your payment app's system |



### Notes

* For `charge_url` and `authorization_url` flows, always update the payment status via the Booqable API **before** redirecting the customer back to the `return_url`. The callback page polls the payment status and will wait indefinitely if the status is never updated.
* Even when a payment fails, update the status to `failed` before redirecting. Otherwise, the callback page polls indefinitely waiting for a status change.
* Always store the `booqable_id` from the initial request. You'll need it to update the payment status later, especially for asynchronous payment processing.
* Use the correct HTTP methods for the route:
  - `charge_url`, `authorization_url`, `refund_url` use **POST** to create new resources.
  - `cancel_charge_url`, `void_authorization_url`, `capture_authorization_url` use **PUT** to update existing resources.
