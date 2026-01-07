# Payment authorizations

PaymentAuthorizations represent pre-authorized payment reservations in Booqable. They reserve funds
on a customer's payment method without immediately collecting them, allowing for flexible payment
collection at a later time through [PaymentCharges](#payment-charges).

PaymentAuthorizations are one of three payment types in Booqable's payment system, alongside
[PaymentCharges](#payment-charges) (direct charges) and [PaymentRefunds](#payment-refunds) (refunds).
While charges immediately collect payment, authorizations only reserve funds that can be captured
later, providing flexibility for rental businesses where final amounts may change.

## Authorization Workflow

The typical authorization workflow follows these steps:

1. **Authorization Creation**: Reserve funds on customer's payment method
2. **Funds Held**: Customer sees pending charge, funds unavailable but not collected
3. **Capture or Release**: Either capture some/all funds via PaymentCharge or let authorization expire
4. **Completion**: Authorization marked as captured, expired, or canceled

## Key Concepts

### Capturable Amounts
Authorizations track what can still be captured:

- `amount_capturable_in_cents`: Rental amount available for capture
- `deposit_capturable_in_cents`: Deposit amount available for capture
- `total_capturable_in_cents`: Total available (amount + deposit)

### Captured Amounts
Authorizations track what has been captured via charges:

- `amount_captured_in_cents`: Rental amount already captured
- `deposit_captured_in_cents`: Deposit amount already captured
- `total_captured_in_cents`: Total captured (amount + deposit)

### Capture Window

- `capture_before`: Deadline for capturing funds before automatic expiration
- After this time, the authorization expires and funds are released
- Typically 7 days for most payment providers

## Status Lifecycle

PaymentAuthorizations follow a specific status lifecycle:

1. **created** → Initial state when authorization is created
   - Can transition to: `started`, `action_required`, `canceled`, `expired`, `succeeded`, `failed`
   - Set during creation based on mode

2. **started** → Authorization process has been initiated
   - Can transition to: `created`, `action_required`, `succeeded`, `failed`, `expired`, `canceled`
   - Indicates provider processing has begun

3. **action_required** → Customer intervention needed
   - Can transition to: `created`, `started`, `succeeded`, `failed`, `expired`, `canceled`
   - Common for 3D Secure authentication
   - Customer must complete action to proceed

4. **succeeded** → Authorization successfully placed
   - Can transition to: `captured`, `canceled`, `expired`, `failed`
   - Funds are reserved and available for capture
   - Sets `succeeded_at` timestamp

5. **failed** → Authorization attempt failed
   - Can transition to: `created`, `started`, `succeeded`
   - Allows retry by transitioning back to earlier states
   - Sets `failed_at` timestamp

6. **canceled** → Authorization was canceled
   - Can transition to: `succeeded`, `failed` (for late completions)
   - Releases reserved funds back to customer
   - Sets `canceled_at` timestamp

7. **expired** → Authorization expired without capture
   - Can transition to: `succeeded`, `failed` (for late processing)
   - Automatically set when `capture_before` passes
   - Releases reserved funds back to customer
   - Sets `expired_at` timestamp

8. **captured** → Authorization fully or partially captured
   - Can transition to: `failed` (for corrections only)
   - Set when PaymentCharge captures from this authorization
   - Indicates at least partial funds were collected

## Payment Modes

Different modes control how the authorization is created:

- `off_session`: Merchant-initiated without customer present
- `checkout`: Part of checkout flow, customer present
- `request`: On-demand request, often for additional charges
- `terminal`: Physical payment terminal transaction

## Capture Capabilities

Successful authorizations can be partially or fully captured via PaymentCharges. The authorization
tracks:

- How much has been captured (`amount_captured_in_cents`, `deposit_captured_in_cents`)
- How much is still capturable (`amount_capturable_in_cents`, `deposit_capturable_in_cents`)
- Whether any amount remains capturable (`capturable`)

Captures are created as separate PaymentCharge records linked to the original authorization.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`customer` | **[Customer](#customers)** `required`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`employee` | **[Employee](#employees)** `required`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_charges` | **[Payment charges](#payment-charges)** `hasmany`<br>The [PaymentCharges](#payment-charges) that capture funds from this authorization. A charge reduces the capturable amounts and the authorization becomes non-capturable. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods) used for this authorization. Links to the saved customer payment details (like a specific card) being authorized. Required for off_session mode where saved payment methods are charged without customer presence. 


Check matching attributes under [Fields](#payment-authorizations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_capturable_in_cents` | **integer** `readonly`<br>Rental amount still available for capture in cents. Starts equal to amount_in_cents and decreases as PaymentCharges capture funds. When fully captured, this becomes zero. 
`amount_captured_in_cents` | **integer** `readonly`<br>Rental amount already captured via PaymentCharges in cents. Starts at zero and increases as charges capture funds. Cannot exceed the original amount_in_cents. 
`amount_in_cents` | **integer** <br>The rental amount to authorize in cents. This represents the main charge amount excluding any deposit. Set during creation and cannot be changed. Combined with deposit_in_cents to determine total authorization. 
`amount_released_in_cents` | **integer** `readonly`<br>Rental amount that was not captured in cents. Calculated as the difference between the original amount_in_cents and amount_captured_in_cents. This represents funds that were authorized but ultimately not collected from the customer. 
`canceled_at` | **datetime** `readonly`<br>Timestamp when the authorization was canceled, releasing any reserved funds back to the customer. Authorizations cannot be canceled after being captured. 
`capturable` | **boolean** `readonly`<br>Whether this authorization can currently be captured. True when status is `succeeded` and the authorization hasn't expired. When false, attempts to create PaymentCharges from this authorization will fail. 
`capture_before` | **datetime** `readonly`<br>Deadline for capturing this authorization before it automatically expires. After this time, reserved funds are released back to the customer. Typically 7 days after creation but varies by payment provider. 
`captured_at` | **datetime** `readonly`<br>Timestamp when the authorization was first captured via a PaymentCharge. Once captured, the authorization cannot be canceled and capturable amounts are adjusted based on what was captured. 
`cart_id` | **uuid** `readonly-after-create`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`). Must match the currency of any associated order or cart. Set during creation and cannot be changed. 
`customer_id` | **uuid** `readonly-after-create`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`deposit_capturable_in_cents` | **integer** `readonly`<br>Deposit amount still available for capture in cents. Starts equal to deposit_in_cents and decreases as PaymentCharges capture funds. When fully captured, this becomes zero. 
`deposit_captured_in_cents` | **integer** `readonly`<br>Deposit amount already captured via PaymentCharges in cents. Starts at zero and increases as charges capture funds. Cannot exceed the original deposit_in_cents. 
`deposit_in_cents` | **integer** <br>The deposit amount to authorize in cents. This represents the security deposit for the rental. Set during creation and cannot be changed. Combined with amount_in_cents to determine total authorization. 
`deposit_released_in_cents` | **integer** `readonly`<br>Deposit amount that was not captured in cents. Calculated as the difference between the original deposit_in_cents and deposit_captured_in_cents. This represents deposit funds that were authorized but ultimately not collected from the customer. 
`description` | **string** <br>Human-readable description of what this authorization is for. Useful for displaying to customers on statements or in payment interfaces. Often includes order or rental details. 
`employee_id` | **uuid** `readonly`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`expired_at` | **datetime** `readonly`<br>Timestamp when the authorization expired without being captured. Expiration releases reserved funds back to the customer. Usually occurs when `capture_before` is reached. 
`failed_at` | **datetime** `readonly`<br>Timestamp when the authorization attempt failed. Failed authorizations can be retried by transitioning back to `created` or `started` status. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>How the authorization is created and processed. Each mode has different validation requirements and processing flows.<br>One of: `off_session`, `checkout`, `request`, `terminal`.<br>`off_session` - Merchant-initiated without customer present<br>`checkout` - Part of checkout flow, customer present<br>`request` - On-demand request, often for additional charges<br>`terminal` - Physical payment terminal transaction 
`order_id` | **uuid** `readonly-after-create`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_method_id` | **uuid** `readonly-after-create`<br>The [PaymentMethod](#payment-methods) used for this authorization. Links to the saved customer payment details (like a specific card) being authorized. Required for off_session mode where saved payment methods are charged without customer presence. 
`provider` | **enum** <br>The payment service provider that processes this authorization. Determines which provider-specific implementation is used for authorization and capture operations.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for manual mode) 
`provider_id` | **string** <br>External identifier from the payment provider for this authorization. For Stripe authorizations, this contains the PaymentIntent ID. Used for syncing status updates and debugging provider-specific issues. 
`provider_link` | **string** <br>Direct URL to view this authorization in the payment provider's dashboard. Useful for support teams to investigate issues or view detailed transaction information not available in Booqable. 
`provider_method` | **string** <br>The payment method type used at the provider level, such as `card`, `ideal`, or `bancontact`. This indicates how the customer's payment method is processed by the provider. 
`provider_secret` | **string** <br>Secret value used for secure client-side payment flows. For Stripe, this is the client secret allowing customer's browser to directly communicate with Stripe for authentication. This value is write-only for security. 
`redirect_url` | **string** <br>URL to redirect the customer after completing any required authentication or action. Used in checkout flows to return customers to the appropriate success or failure page after interacting with the payment provider. 
`status` | **enum** <br>Current status of the authorization in its lifecycle. Determines available actions and whether funds can be captured.<br>One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`. 
`succeeded_at` | **datetime** <br>Timestamp when the authorization was successfully placed and funds were reserved. Once set, the authorization can be captured until it expires or is canceled. 
`total_capturable_in_cents` | **integer** `readonly`<br>Total amount still available for capture in cents (amount + deposit). This is the maximum that can be collected via new PaymentCharges against this authorization. 
`total_captured_in_cents` | **integer** `readonly`<br>Total amount already captured via PaymentCharges in cents (amount + deposit). When this equals total_in_cents, the authorization is fully captured. 
`total_in_cents` | **integer** <br>Total amount authorized in cents (amount + deposit). This is the full amount reserved on the customer's payment method. Set during creation and cannot be changed. 
`total_released_in_cents` | **integer** `readonly`<br>Total amount that was not captured in cents (amount + deposit). This represents the portion of the original authorization that was released back to the customer. Updated when captures are applied to reflect the uncaptured portion. 
`type` | **string** `readonly`<br>Always returns `payment_authorizations` to identify this PaymentAuthorization resource. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Create a payment authorization


> How to create a payment authorization:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/payment_authorizations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_authorizations",
           "attributes": {
             "mode": "request",
             "amount_in_cents": 10000,
             "deposit_in_cents": 5000
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "8aaa4100-cf5f-4fa4-80ba-fe3f05745629",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2018-07-05T22:55:03.000000+00:00",
        "updated_at": "2018-07-05T22:55:03.000000+00:00",
        "type": "payment_authorizations",
        "provider": null,
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": "c6505e37-c8ba-4ebf-8345-3c74edbd6182",
        "customer_id": null,
        "status": "created",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "capturable": false,
        "amount_capturable_in_cents": 0,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 0,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "amount_released_in_cents": 0,
        "deposit_released_in_cents": 0,
        "total_released_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>The rental amount to authorize in cents. This represents the main charge amount excluding any deposit. Set during creation and cannot be changed. Combined with deposit_in_cents to determine total authorization. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`). Must match the currency of any associated order or cart. Set during creation and cannot be changed. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>The deposit amount to authorize in cents. This represents the security deposit for the rental. Set during creation and cannot be changed. Combined with amount_in_cents to determine total authorization. 
`data[attributes][mode]` | **enum** <br>How the authorization is created and processed. Each mode has different validation requirements and processing flows.<br>One of: `off_session`, `checkout`, `request`, `terminal`.<br>`off_session` - Merchant-initiated without customer present<br>`checkout` - Part of checkout flow, customer present<br>`request` - On-demand request, often for additional charges<br>`terminal` - Physical payment terminal transaction 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods) used for this authorization. Links to the saved customer payment details (like a specific card) being authorized. Required for off_session mode where saved payment methods are charged without customer presence. 
`data[attributes][provider]` | **enum** <br>The payment service provider that processes this authorization. Determines which provider-specific implementation is used for authorization and capture operations.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for manual mode) 
`data[attributes][provider_id]` | **string** <br>External identifier from the payment provider for this authorization. For Stripe authorizations, this contains the PaymentIntent ID. Used for syncing status updates and debugging provider-specific issues. 
`data[attributes][provider_link]` | **string** <br>Direct URL to view this authorization in the payment provider's dashboard. Useful for support teams to investigate issues or view detailed transaction information not available in Booqable. 
`data[attributes][provider_method]` | **string** <br>The payment method type used at the provider level, such as `card`, `ideal`, or `bancontact`. This indicates how the customer's payment method is processed by the provider. 
`data[attributes][provider_secret]` | **string** <br>Secret value used for secure client-side payment flows. For Stripe, this is the client secret allowing customer's browser to directly communicate with Stripe for authentication. This value is write-only for security. 
`data[attributes][redirect_url]` | **string** <br>URL to redirect the customer after completing any required authentication or action. Used in checkout flows to return customers to the appropriate success or failure page after interacting with the payment provider. 
`data[attributes][status]` | **enum** <br>Current status of the authorization in its lifecycle. Determines available actions and whether funds can be captured.<br>One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the authorization was successfully placed and funds were reserved. Once set, the authorization can be captured until it expires or is canceled. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount authorized in cents (amount + deposit). This is the full amount reserved on the customer's payment method. Set during creation and cannot be changed. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charges</code></li>
  <li><code>payment_method</code></li>
</ul>


## Update a payment authorization


> How to update a payment authorization:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/payment_authorizations/1ed150c8-95c1-4995-84f1-2d34064f48ed'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "1ed150c8-95c1-4995-84f1-2d34064f48ed",
           "type": "payment_authorizations",
           "attributes": {
             "status": "started",
             "provider": "stripe",
             "provider_method": "card"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1ed150c8-95c1-4995-84f1-2d34064f48ed",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2018-11-07T01:48:04.000000+00:00",
        "updated_at": "2018-11-07T01:48:04.000000+00:00",
        "type": "payment_authorizations",
        "provider": "stripe",
        "provider_id": null,
        "provider_method": "card",
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": null,
        "customer_id": null,
        "status": "started",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "capturable": false,
        "amount_capturable_in_cents": 0,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 0,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "amount_released_in_cents": 0,
        "deposit_released_in_cents": 0,
        "total_released_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>The rental amount to authorize in cents. This represents the main charge amount excluding any deposit. Set during creation and cannot be changed. Combined with deposit_in_cents to determine total authorization. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`). Must match the currency of any associated order or cart. Set during creation and cannot be changed. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>The deposit amount to authorize in cents. This represents the security deposit for the rental. Set during creation and cannot be changed. Combined with amount_in_cents to determine total authorization. 
`data[attributes][mode]` | **enum** <br>How the authorization is created and processed. Each mode has different validation requirements and processing flows.<br>One of: `off_session`, `checkout`, `request`, `terminal`.<br>`off_session` - Merchant-initiated without customer present<br>`checkout` - Part of checkout flow, customer present<br>`request` - On-demand request, often for additional charges<br>`terminal` - Physical payment terminal transaction 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods) used for this authorization. Links to the saved customer payment details (like a specific card) being authorized. Required for off_session mode where saved payment methods are charged without customer presence. 
`data[attributes][provider]` | **enum** <br>The payment service provider that processes this authorization. Determines which provider-specific implementation is used for authorization and capture operations.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for manual mode) 
`data[attributes][provider_id]` | **string** <br>External identifier from the payment provider for this authorization. For Stripe authorizations, this contains the PaymentIntent ID. Used for syncing status updates and debugging provider-specific issues. 
`data[attributes][provider_link]` | **string** <br>Direct URL to view this authorization in the payment provider's dashboard. Useful for support teams to investigate issues or view detailed transaction information not available in Booqable. 
`data[attributes][provider_method]` | **string** <br>The payment method type used at the provider level, such as `card`, `ideal`, or `bancontact`. This indicates how the customer's payment method is processed by the provider. 
`data[attributes][provider_secret]` | **string** <br>Secret value used for secure client-side payment flows. For Stripe, this is the client secret allowing customer's browser to directly communicate with Stripe for authentication. This value is write-only for security. 
`data[attributes][redirect_url]` | **string** <br>URL to redirect the customer after completing any required authentication or action. Used in checkout flows to return customers to the appropriate success or failure page after interacting with the payment provider. 
`data[attributes][status]` | **enum** <br>Current status of the authorization in its lifecycle. Determines available actions and whether funds can be captured.<br>One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the authorization was successfully placed and funds were reserved. Once set, the authorization can be captured until it expires or is canceled. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount authorized in cents (amount + deposit). This is the full amount reserved on the customer's payment method. Set during creation and cannot be changed. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charges</code></li>
  <li><code>payment_method</code></li>
</ul>

