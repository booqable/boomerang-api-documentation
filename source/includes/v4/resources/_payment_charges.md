# Payment charges

PaymentCharges represent direct financial charges in Booqable. They are used to collect payments from
customers for orders or carts, either immediately or through various payment flows.

PaymentCharges are one of three payment types in Booqable's payment system, alongside
[PaymentAuthorizations](#payment-authorizations) (pre-authorizations) and [PaymentRefunds](#payment-refunds)
(refunds). While authorizations reserve funds for later capture, charges immediately collect payment from
the customer.

## Status Lifecycle

PaymentCharges follow a status lifecycle with specific transition rules and triggers:

### Status Lifecycle

PaymentCharges follow a specific status lifecycle:

1. **created** → Initial state when a charge is created
   - Can transition to: `started`, `action_required`, `canceled`, `expired`, `succeeded`, `failed`
   - Set during creation via mode-specific interactors
   - For Stripe charges, a payment intent is pre-created at this stage

2. **started** → Payment process has been initiated
   - Can transition to: `created`, `action_required`, `processing`, `succeeded`, `failed`, `expired`,
     `canceled`
   - Triggered when provider and payment method are set

3. **action_required** → Customer intervention needed
   - Can transition to: `created`, `started`, `processing`, `succeeded`, `failed`, `expired`, `canceled`
   - Common for 3D Secure authentication or additional verification
   - Customer must complete action before payment can proceed

4. **processing** → Payment is being processed by provider
   - Can transition to: `succeeded`, `failed`, `action_required`
   - Indicates payment is in provider's processing queue
   - Typically a brief transitional state

5. **succeeded** → Payment successfully collected
   - Can transition to: `failed` (for corrections only)
   - Sets `succeeded_at` timestamp and enables refunds
   - Captures authorization if charge was created from one
   - Triggers order creation for checkout mode charges

6. **failed** → Payment attempt failed
   - Can transition to: `created`, `started`, `succeeded` (recovery paths)
   - Sets `failed_at` timestamp
   - Allows retry by transitioning back to earlier states

7. **canceled** → Charge was canceled
   - Can transition to: `succeeded`, `failed` (for late completions)
   - Sets `canceled_at` timestamp
   - Cancels payment intent/app charge if exists
   - Cannot cancel after charge has succeeded

8. **expired** → Charge expired due to timeout
   - Can transition to: `succeeded`, `failed` (for late processing)
   - Sets `expired_at` timestamp
   - Triggered automatically by background job after timeout period

### Status Transition Rules

- Transitions are validated at the model level - invalid transitions raise validation errors
- Some transitions are restricted based on provider type (e.g., manual payments have limited transitions)
- Late transitions (succeeded/failed after canceled/expired) are allowed for provider corrections

## Payment Modes

Different modes control how the charge is processed:

- `manual`: Direct charge with no automated processing
- `off_session`: Charge saved payment method without customer present
- `request`: Send payment request to customer
- `terminal`: Process through physical payment terminal
- `capture`: Capture funds from existing authorization

## Refund Capabilities

Successful charges can be partially or fully refunded through [PaymentRefunds](#payment-refunds). The
charge tracks:

- How much has been refunded (`amount_refunded_in_cents`, `deposit_refunded_in_cents`)
- How much is still refundable (`amount_refundable_in_cents`, `deposit_refundable_in_cents`)
- Whether any amount remains refundable (`refundable`)

Refunds are created as separate PaymentRefund records linked to the original charge.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`customer` | **[Customer](#customers)** `required`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`employee` | **[Employee](#employees)** `required`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_authorization` | **[Payment authorization](#payment-authorizations)** `required`<br>The [PaymentAuthorization](#payment-authorizations) this charge captures from.<br>Only present for charges with mode `capture`. Links to the authorization that reserved the funds being captured. The authorization must have sufficient authorized amount to cover this charge.<br>Only settable during creation and required when mode is `capture`. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods) used for this charge.<br>Can be an existing saved payment method (for `off_session` mode) or a new method created during payment. The payment method stores the actual payment credentials or reference.<br>For charges using saved methods, this must be a valid method belonging to the customer. Only settable during creation. 
`payment_refunds` | **[Payment refunds](#payment-refunds)** `hasmany`<br>The [PaymentRefunds](#payment-refunds) issued against this charge.<br>Collection of all refunds that have been processed for this charge. Each refund reduces the refundable amounts and increases the refunded amounts. Refunds can only be created for charges with status `succeeded`.<br>Use this to track refund history and calculate total amounts refunded. 


Check matching attributes under [Fields](#payment-charges-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** <br>Main charge amount in cents (excluding deposit).<br>This typically represents the rental charges, services, or products. Must be non-negative and cannot be changed after creation. 
`amount_refundable_in_cents` | **integer** `readonly`<br>Remaining main amount that can still be refunded in cents.<br>Starts equal to `amount_in_cents` for succeeded charges and decreases as refunds are processed. 
`amount_refunded_in_cents` | **integer** `readonly`<br>Total main amount already refunded in cents.<br>Sum of all refund amounts applied to the main charge amount. Increases as refunds are processed. 
`canceled_at` | **datetime** `readonly`<br>Timestamp when the charge was canceled.<br>Will be `null` for charges that haven't been canceled. Charges can be canceled before completion, but not after they've succeeded. 
`cart_id` | **uuid** `readonly-after-create`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>All amounts for this charge are in this currency. Must match the currency of the associated order or cart. 
`customer_id` | **uuid** `readonly-after-create`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`deposit_in_cents` | **integer** <br>Deposit amount in cents.<br>Deposits are held separately from the main amount and may have different refund rules. Cannot be changed after creation. 
`deposit_refundable_in_cents` | **integer** `readonly`<br>Remaining deposit amount that can still be refunded in cents.<br>Starts equal to `deposit_in_cents` for succeeded charges and decreases as deposit refunds are processed. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>Total deposit amount already refunded in cents.<br>Sum of all refund amounts applied to the deposit. Increases as deposit refunds are processed. 
`description` | **string** <br>Optional description for this charge that can be displayed to customers.<br>Use this to provide context about what the charge is for, especially for partial payments or custom amounts. 
`employee_id` | **uuid** `readonly`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`expired_at` | **datetime** `readonly`<br>Timestamp when the charge expired.<br>Will be `null` for charges that haven't expired. Charges may expire if not completed within the provider's time limit. 
`failed_at` | **datetime** `readonly`<br>Timestamp when the charge failed.<br>Will be `null` for charges that haven't failed. Charges can fail due to insufficient funds, declined cards, or other payment processing issues. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>How the payment is collected. The mode determines the payment flow and cannot be changed after creation.<br>One of: `manual`, `off_session`, `request`, `terminal`, `capture`.<br>`manual` - Direct charge with manual payment marking (e.g., cash, bank transfer)<br>`off_session` - Charge a saved payment method without customer interaction<br>`request` - Send a payment request to the customer<br>`terminal` - Process through a physical payment terminal<br>`capture` - Capture funds from an existing [PaymentAuthorization](#payment-authorizations) 
`order_id` | **uuid** `readonly-after-create`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_authorization_id` | **uuid** `readonly-after-create`<br>The [PaymentAuthorization](#payment-authorizations) this charge captures from.<br>Only present for charges with mode `capture`. Links to the authorization that reserved the funds being captured. The authorization must have sufficient authorized amount to cover this charge.<br>Only settable during creation and required when mode is `capture`. 
`payment_method_id` | **uuid** `readonly-after-create`<br>The [PaymentMethod](#payment-methods) used for this charge.<br>Can be an existing saved payment method (for `off_session` mode) or a new method created during payment. The payment method stores the actual payment credentials or reference.<br>For charges using saved methods, this must be a valid method belonging to the customer. Only settable during creation. 
`provider` | **enum** <br>The payment service provider used to process this charge.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for `manual` mode)<br>For `app` providers, additional details are available in `provider_app`. 
`provider_id` | **string** <br>Unique identifier from the payment provider (e.g., Stripe charge ID).<br>Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`provider_link` | **string** <br>Direct link to view this payment in the provider's dashboard.<br>Useful for support staff to quickly access payment details in the external system. 
`provider_method` | **string** <br>The payment method type used for this charge (e.g., `card`, `ideal`, `bancontact`).<br>Available methods depend on the provider and its configuration. 
`provider_secret` | **string** <br>Secret token used for client-side payment processing.<br>For Stripe, this includes the client secret needed for Payment Element or confirmCardPayment. 
`redirect_url` | **string** <br>URL to redirect the customer to after payment completion.<br>The customer will be redirected here after successful payment, failure, or cancellation. Include any necessary parameters to identify the order or context. 
`refundable` | **boolean** `readonly`<br>Whether this charge can still be refunded.<br>Returns `true` if `total_refundable_in_cents` is greater than zero. Only succeeded charges can be refunded. 
`status` | **enum** <br>Current status of the charge in its lifecycle.<br>One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.<br>Status transitions follow specific rules - for example, a charge can move from `created` to `started`, but not directly to `succeeded` without going through `processing`. 
`succeeded_at` | **datetime** <br>Timestamp when the charge successfully completed.<br>Will be `null` for charges that haven't succeeded yet. Once set, the charge is considered successful and funds have been collected. 
`total_in_cents` | **integer** <br>Total charge amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount the customer will be charged. 
`total_refundable_in_cents` | **integer** `readonly`<br>Total amount still available for refund in cents.<br>Always equals `amount_refundable_in_cents` + `deposit_refundable_in_cents`. Use this to check maximum refund amount. 
`total_refunded_in_cents` | **integer** `readonly`<br>Total amount already refunded in cents.<br>Always equals `amount_refunded_in_cents` + `deposit_refunded_in_cents`. Tracks the complete refund history. 
`type` | **string** `readonly`<br>Always returns `payment_charges`.<br>To retrieve charges along with other payment types, use the [Payments](#payments) endpoint which returns all payment types. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Create a payment charge


> How to create a payment charge:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/payment_charges'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_charges",
           "attributes": {
             "mode": "manual",
             "provider": "none",
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
      "id": "173c372c-a487-4900-843d-17ca3a33c915",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2023-02-26T05:02:01.000000+00:00",
        "updated_at": "2023-02-26T05:02:01.000000+00:00",
        "type": "payment_charges",
        "provider": "none",
        "provider_id": null,
        "provider_method": "bank",
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "succeeded_at": "2023-02-26T05:02:01.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": "7dd1d262-ea22-442d-8f2b-551256cde93a",
        "customer_id": null,
        "status": "succeeded",
        "mode": "manual",
        "description": null,
        "redirect_url": null,
        "refundable": true,
        "amount_refundable_in_cents": 10000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 5000,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 15000,
        "total_refunded_in_cents": 0,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/payment_charges`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,cart,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Main charge amount in cents (excluding deposit).<br>This typically represents the rental charges, services, or products. Must be non-negative and cannot be changed after creation. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>All amounts for this charge are in this currency. Must match the currency of the associated order or cart. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit amount in cents.<br>Deposits are held separately from the main amount and may have different refund rules. Cannot be changed after creation. 
`data[attributes][mode]` | **enum** <br>How the payment is collected. The mode determines the payment flow and cannot be changed after creation.<br>One of: `manual`, `off_session`, `request`, `terminal`, `capture`.<br>`manual` - Direct charge with manual payment marking (e.g., cash, bank transfer)<br>`off_session` - Charge a saved payment method without customer interaction<br>`request` - Send a payment request to the customer<br>`terminal` - Process through a physical payment terminal<br>`capture` - Capture funds from an existing [PaymentAuthorization](#payment-authorizations) 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_authorization_id]` | **uuid** <br>The [PaymentAuthorization](#payment-authorizations) this charge captures from.<br>Only present for charges with mode `capture`. Links to the authorization that reserved the funds being captured. The authorization must have sufficient authorized amount to cover this charge.<br>Only settable during creation and required when mode is `capture`. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods) used for this charge.<br>Can be an existing saved payment method (for `off_session` mode) or a new method created during payment. The payment method stores the actual payment credentials or reference.<br>For charges using saved methods, this must be a valid method belonging to the customer. Only settable during creation. 
`data[attributes][provider]` | **enum** <br>The payment service provider used to process this charge.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for `manual` mode)<br>For `app` providers, additional details are available in `provider_app`. 
`data[attributes][provider_id]` | **string** <br>Unique identifier from the payment provider (e.g., Stripe charge ID).<br>Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`data[attributes][provider_link]` | **string** <br>Direct link to view this payment in the provider's dashboard.<br>Useful for support staff to quickly access payment details in the external system. 
`data[attributes][provider_method]` | **string** <br>The payment method type used for this charge (e.g., `card`, `ideal`, `bancontact`).<br>Available methods depend on the provider and its configuration. 
`data[attributes][provider_secret]` | **string** <br>Secret token used for client-side payment processing.<br>For Stripe, this includes the client secret needed for Payment Element or confirmCardPayment. 
`data[attributes][redirect_url]` | **string** <br>URL to redirect the customer to after payment completion.<br>The customer will be redirected here after successful payment, failure, or cancellation. Include any necessary parameters to identify the order or context. 
`data[attributes][status]` | **enum** <br>Current status of the charge in its lifecycle.<br>One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.<br>Status transitions follow specific rules - for example, a charge can move from `created` to `started`, but not directly to `succeeded` without going through `processing`. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the charge successfully completed.<br>Will be `null` for charges that haven't succeeded yet. Once set, the charge is considered successful and funds have been collected. 
`data[attributes][total_in_cents]` | **integer** <br>Total charge amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount the customer will be charged. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>cart</code></li>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_authorization</code></li>
  <li><code>payment_method</code></li>
  <li><code>payment_refunds</code></li>
</ul>


## Update a payment charge


> How to update a payment charge:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/payment_charges/04972b14-5348-4e61-8896-e61e346e3001'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "04972b14-5348-4e61-8896-e61e346e3001",
           "type": "payment_charges",
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
      "id": "04972b14-5348-4e61-8896-e61e346e3001",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2015-05-19T14:36:00.000000+00:00",
        "updated_at": "2015-05-19T14:36:00.000000+00:00",
        "type": "payment_charges",
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
        "refundable": true,
        "amount_refundable_in_cents": 5000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 5000,
        "total_refunded_in_cents": 0,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/payment_charges/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,cart,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Main charge amount in cents (excluding deposit).<br>This typically represents the rental charges, services, or products. Must be non-negative and cannot be changed after creation. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>All amounts for this charge are in this currency. Must match the currency of the associated order or cart. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit amount in cents.<br>Deposits are held separately from the main amount and may have different refund rules. Cannot be changed after creation. 
`data[attributes][mode]` | **enum** <br>How the payment is collected. The mode determines the payment flow and cannot be changed after creation.<br>One of: `manual`, `off_session`, `request`, `terminal`, `capture`.<br>`manual` - Direct charge with manual payment marking (e.g., cash, bank transfer)<br>`off_session` - Charge a saved payment method without customer interaction<br>`request` - Send a payment request to the customer<br>`terminal` - Process through a physical payment terminal<br>`capture` - Capture funds from an existing [PaymentAuthorization](#payment-authorizations) 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_authorization_id]` | **uuid** <br>The [PaymentAuthorization](#payment-authorizations) this charge captures from.<br>Only present for charges with mode `capture`. Links to the authorization that reserved the funds being captured. The authorization must have sufficient authorized amount to cover this charge.<br>Only settable during creation and required when mode is `capture`. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods) used for this charge.<br>Can be an existing saved payment method (for `off_session` mode) or a new method created during payment. The payment method stores the actual payment credentials or reference.<br>For charges using saved methods, this must be a valid method belonging to the customer. Only settable during creation. 
`data[attributes][provider]` | **enum** <br>The payment service provider used to process this charge.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - No payment provider (typically for `manual` mode)<br>For `app` providers, additional details are available in `provider_app`. 
`data[attributes][provider_id]` | **string** <br>Unique identifier from the payment provider (e.g., Stripe charge ID).<br>Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`data[attributes][provider_link]` | **string** <br>Direct link to view this payment in the provider's dashboard.<br>Useful for support staff to quickly access payment details in the external system. 
`data[attributes][provider_method]` | **string** <br>The payment method type used for this charge (e.g., `card`, `ideal`, `bancontact`).<br>Available methods depend on the provider and its configuration. 
`data[attributes][provider_secret]` | **string** <br>Secret token used for client-side payment processing.<br>For Stripe, this includes the client secret needed for Payment Element or confirmCardPayment. 
`data[attributes][redirect_url]` | **string** <br>URL to redirect the customer to after payment completion.<br>The customer will be redirected here after successful payment, failure, or cancellation. Include any necessary parameters to identify the order or context. 
`data[attributes][status]` | **enum** <br>Current status of the charge in its lifecycle.<br>One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.<br>Status transitions follow specific rules - for example, a charge can move from `created` to `started`, but not directly to `succeeded` without going through `processing`. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the charge successfully completed.<br>Will be `null` for charges that haven't succeeded yet. Once set, the charge is considered successful and funds have been collected. 
`data[attributes][total_in_cents]` | **integer** <br>Total charge amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount the customer will be charged. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>cart</code></li>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_authorization</code></li>
  <li><code>payment_method</code></li>
  <li><code>payment_refunds</code></li>
</ul>


## Delete a payment charge


> How to delete a payment charge:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/payment_charges/06860f88-3205-482e-82da-5ef680030bd4'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "06860f88-3205-482e-82da-5ef680030bd4",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2025-12-21T22:55:00.000000+00:00",
        "updated_at": "2025-12-21T22:55:00.000000+00:00",
        "type": "payment_charges",
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
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
        "status": "created",
        "mode": "manual",
        "description": null,
        "redirect_url": null,
        "refundable": true,
        "amount_refundable_in_cents": 5000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 5000,
        "total_refunded_in_cents": 0,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/payment_charges/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,cart,customer`


### Includes

This request accepts the following includes:

<ul>
  <li><code>cart</code></li>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_authorization</code></li>
  <li><code>payment_method</code></li>
  <li><code>payment_refunds</code></li>
</ul>

