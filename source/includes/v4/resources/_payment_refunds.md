# Payment refunds

PaymentRefunds represent refund transactions in Booqable. They are used to return funds to customers
for previously successful [PaymentCharges](#payment-charges), either partially or in full.

PaymentRefunds are one of three payment types in Booqable's payment system, alongside
[PaymentCharges](#payment-charges) (direct charges) and [PaymentAuthorizations](#payment-authorizations)
(pre-authorizations). While charges collect payment and authorizations reserve funds, refunds reverse
successful charges by returning money to the customer.

## Refund Capabilities

PaymentRefunds support several refund scenarios:

- **Full Refunds**: Return the entire charge amount to the customer
- **Partial Refunds**: Return only a portion of the original charge
- **Split Refunds**: Separately refund rental amounts and deposits
- **Manual Refunds**: Record cash or external refunds against any charge

## Status Lifecycle

PaymentRefunds follow a specific status lifecycle:

1. **created** → Initial state when a refund is created
   - Can transition to: `pending`, `canceled`, `succeeded`, `failed`
   - Set during creation based on provider type
   - For manual refunds, may transition directly to `succeeded`

2. **pending** → Refund is being processed by provider
   - Can transition to: `action_required`, `succeeded`, `failed`
   - Indicates the refund has been submitted to the payment provider
   - Typically a brief transitional state

3. **action_required** → Additional action needed to complete refund
   - Can transition to: `pending`, `canceled`, `succeeded`, `failed`
   - Rare for refunds but possible with some payment methods
   - May require manual intervention or verification

4. **succeeded** → Refund successfully processed
   - Can transition to: `failed`, `canceled` (for corrections only)
   - Funds have been returned to the customer
   - Updates the original charge's refunded amounts

5. **failed** → Refund attempt failed
   - Can transition to: `pending`, `succeeded` (recovery paths)
   - May occur due to provider issues or invalid payment methods
   - Allows retry by transitioning back to pending

6. **canceled** → Refund was canceled before completion
   - Can transition to: `succeeded`, `failed` (for late completions)
   - Prevents the refund from being processed
   - Cannot cancel after refund has succeeded

## Provider Support

Refunds can be processed through various providers:

- **Matching Provider**: Refund through the same provider as the original charge
- **Manual Provider**: Record manual refunds (cash, bank transfer) against any charge type
- **Mixed Refunds**: Combine provider and manual refunds for flexibility

## Refund Validation

The system enforces several rules to ensure refund integrity:

- Cannot refund more than the original charge amount
- Cannot refund more than the remaining refundable amount
- Provider must match the charge provider or be `none` for manual refunds
- Currency must match the original charge currency

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`customer` | **[Customer](#customers)** `required`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`employee` | **[Employee](#employees)** `required`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_charge` | **[Payment charge](#payment-charges)** `required`<br>The [PaymentCharge](#payment-charges) this refund is applied to.<br>Links the refund to the original successful charge being refunded. This relationship is required for connected refunds but optional for standalone manual refunds. The charge tracks cumulative refunded amounts across all associated refunds.<br>When a refund succeeds, it automatically updates the charge's refunded and refundable amounts. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods) used for this refund.<br>Typically inherited from the original charge, representing where the refund will be sent. For card payments, refunds go back to the original card. For manual refunds, this may be `null`.<br>The payment method determines how the customer receives their refund and may affect processing time. 


Check matching attributes under [Fields](#payment-refunds-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** <br>Main refund amount in cents (excluding deposit).<br>This represents the portion of the original charge's main amount being refunded. Must be non-negative and cannot exceed the remaining refundable amount on the charge. 
`canceled_at` | **datetime** `readonly`<br>Timestamp when the refund was canceled.<br>Will be `null` for refunds that haven't been canceled. Refunds can only be canceled before they succeed. 
`cart_id` | **uuid** `readonly-after-create`<br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>Always matches the currency of the original charge. Cannot be changed as refunds must be in the same currency as the original payment. 
`customer_id` | **uuid** `readonly-after-create`<br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`deposit_in_cents` | **integer** <br>Deposit refund amount in cents.<br>This represents the portion of the original charge's deposit amount being refunded. Must be non-negative and cannot exceed the remaining refundable deposit on the charge. 
`description` | **string** <br>Human-readable description of the refund reason or details.<br>Use this to provide context about why the refund was issued, special circumstances, or internal notes. This description may be visible to customers on receipts or statements depending on provider configuration. 
`employee_id` | **uuid** `readonly`<br>The [Employee](#employees) who created or processed this payment.<br>Automatically set by the system and cannot be modified through the API. 
`expired_at` | **datetime** `readonly`<br>Timestamp when the refund expired.<br>Most refunds don't expire, but this field is available for consistency with other payment types. Typically remains `null`. 
`failed_at` | **datetime** `readonly`<br>Timestamp when the refund attempt failed.<br>Will be `null` for refunds that haven't failed. Failed refunds can be retried by transitioning back to `pending` status. 
`failure_reason` | **string** <br>Detailed explanation of why the refund failed.<br>Contains provider-specific error messages or codes that help diagnose the failure. Only populated when status is `failed`. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`payment_charge_id` | **uuid** `readonly-after-create`<br>The [PaymentCharge](#payment-charges) this refund is applied to.<br>Links the refund to the original successful charge being refunded. This relationship is required for connected refunds but optional for standalone manual refunds. The charge tracks cumulative refunded amounts across all associated refunds.<br>When a refund succeeds, it automatically updates the charge's refunded and refundable amounts. 
`payment_method_id` | **uuid** `readonly`<br>The [PaymentMethod](#payment-methods) used for this refund.<br>Typically inherited from the original charge, representing where the refund will be sent. For card payments, refunds go back to the original card. For manual refunds, this may be `null`.<br>The payment method determines how the customer receives their refund and may affect processing time. 
`provider` | **enum** <br>The payment service provider processing this refund.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - Manual refund (cash, bank transfer, etc.)<br>For connected refunds, this usually matches the original charge provider. Manual refunds always use `none` regardless of the original charge provider. 
`provider_id` | **string** <br>Unique identifier from the payment provider for this refund.<br>For Stripe refunds, this contains the Refund ID. Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`provider_link` | **string** <br>Direct link to view this refund in the provider's dashboard.<br>Useful for support staff to quickly access refund details in the external payment system. Only available for provider-processed refunds. 
`provider_method` | **string** <br>The payment method type used for this refund.<br>Typically matches the original charge's payment method (e.g., `card`, `ideal`, `bancontact`). For manual refunds, this may indicate the refund method (e.g., `cash`, `bank_transfer`). 
`provider_secret` | **string** <br>Secret token used for client-side refund processing, if applicable.<br>Most refunds are processed server-side and don't require client secrets. This field is rarely used but maintained for consistency with other payment types. 
`reason` | **string** <br>The reason code for this refund, used for reporting and analysis.<br>Common values include `requested_by_customer`, `duplicate`, `fraudulent`. The specific values available may depend on your payment provider configuration. 
`status` | **enum** <br>Current status of the refund in its lifecycle.<br>One of: `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`.<br>Status transitions follow specific rules - for example, a refund cannot be canceled after it has succeeded. 
`succeeded_at` | **datetime** <br>Timestamp when the refund was successfully processed.<br>Will be `null` for refunds that haven't succeeded yet. Once set, the refund is complete and funds have been returned to the customer. 
`total_in_cents` | **integer** <br>Total refund amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount being returned to the customer. 
`type` | **string** `readonly`<br>Always returns `payment_refunds`.<br>To retrieve refunds along with other payment types, use the [Payments](#payments) endpoint which returns all payment types. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Create a payment refund


> How to create a payment refund:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/payment_refunds'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_refunds",
           "attributes": {
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
      "id": "f7983fdf-6655-4adf-8ee8-12f3d3e51898",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2014-04-24T08:32:00.000000+00:00",
        "updated_at": "2014-04-24T08:32:00.000000+00:00",
        "type": "payment_refunds",
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "succeeded_at": "2014-04-24T08:32:00.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": "a169cc22-50a0-4bf6-8a15-1516035f6501",
        "customer_id": null,
        "status": "succeeded",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "payment_charge_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/payment_refunds`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Main refund amount in cents (excluding deposit).<br>This represents the portion of the original charge's main amount being refunded. Must be non-negative and cannot exceed the remaining refundable amount on the charge. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>Always matches the currency of the original charge. Cannot be changed as refunds must be in the same currency as the original payment. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit refund amount in cents.<br>This represents the portion of the original charge's deposit amount being refunded. Must be non-negative and cannot exceed the remaining refundable deposit on the charge. 
`data[attributes][failure_reason]` | **string** <br>Detailed explanation of why the refund failed.<br>Contains provider-specific error messages or codes that help diagnose the failure. Only populated when status is `failed`. 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_charge_id]` | **uuid** <br>The [PaymentCharge](#payment-charges) this refund is applied to.<br>Links the refund to the original successful charge being refunded. This relationship is required for connected refunds but optional for standalone manual refunds. The charge tracks cumulative refunded amounts across all associated refunds.<br>When a refund succeeds, it automatically updates the charge's refunded and refundable amounts. 
`data[attributes][provider]` | **enum** <br>The payment service provider processing this refund.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - Manual refund (cash, bank transfer, etc.)<br>For connected refunds, this usually matches the original charge provider. Manual refunds always use `none` regardless of the original charge provider. 
`data[attributes][provider_id]` | **string** <br>Unique identifier from the payment provider for this refund.<br>For Stripe refunds, this contains the Refund ID. Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`data[attributes][provider_link]` | **string** <br>Direct link to view this refund in the provider's dashboard.<br>Useful for support staff to quickly access refund details in the external payment system. Only available for provider-processed refunds. 
`data[attributes][provider_method]` | **string** <br>The payment method type used for this refund.<br>Typically matches the original charge's payment method (e.g., `card`, `ideal`, `bancontact`). For manual refunds, this may indicate the refund method (e.g., `cash`, `bank_transfer`). 
`data[attributes][provider_secret]` | **string** <br>Secret token used for client-side refund processing, if applicable.<br>Most refunds are processed server-side and don't require client secrets. This field is rarely used but maintained for consistency with other payment types. 
`data[attributes][reason]` | **string** <br>The reason code for this refund, used for reporting and analysis.<br>Common values include `requested_by_customer`, `duplicate`, `fraudulent`. The specific values available may depend on your payment provider configuration. 
`data[attributes][status]` | **enum** <br>Current status of the refund in its lifecycle.<br>One of: `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`.<br>Status transitions follow specific rules - for example, a refund cannot be canceled after it has succeeded. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the refund was successfully processed.<br>Will be `null` for refunds that haven't succeeded yet. Once set, the refund is complete and funds have been returned to the customer. 
`data[attributes][total_in_cents]` | **integer** <br>Total refund amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount being returned to the customer. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>documents</code></li>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charge</code></li>
  <li><code>payment_method</code></li>
</ul>


## Update a payment refund


> How to update a payment refund:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/payment_refunds/d296895a-e933-4609-8b59-6850e2d29497'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "d296895a-e933-4609-8b59-6850e2d29497",
           "type": "payment_refunds",
           "attributes": {
             "status": "succeeded"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "d296895a-e933-4609-8b59-6850e2d29497",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2020-11-02T14:47:07.000000+00:00",
        "updated_at": "2020-11-02T14:47:07.000000+00:00",
        "type": "payment_refunds",
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "succeeded_at": "2020-11-02T14:47:07.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": null,
        "customer_id": null,
        "status": "succeeded",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "payment_charge_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/payment_refunds/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Main refund amount in cents (excluding deposit).<br>This represents the portion of the original charge's main amount being refunded. Must be non-negative and cannot exceed the remaining refundable amount on the charge. 
`data[attributes][cart_id]` | **uuid** <br>The [Cart](#carts) this payment is associated with. Once a cart is checked out and becomes an order, payments should be associated with the order instead.<br>Can only be set during payment creation. 
`data[attributes][currency]` | **string** <br>Three-letter ISO 4217 currency code (e.g., `USD`, `EUR`).<br>Always matches the currency of the original charge. Cannot be changed as refunds must be in the same currency as the original payment. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this payment belongs to.<br>Can only be set during creation. When not specified, it's inherited from the associated order or cart. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit refund amount in cents.<br>This represents the portion of the original charge's deposit amount being refunded. Must be non-negative and cannot exceed the remaining refundable deposit on the charge. 
`data[attributes][failure_reason]` | **string** <br>Detailed explanation of why the refund failed.<br>Contains provider-specific error messages or codes that help diagnose the failure. Only populated when status is `failed`. 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this payment is associated with. Most payments are order-related.<br>Can only be set during payment creation. Either `order` or `cart` should be specified, not both. 
`data[attributes][payment_charge_id]` | **uuid** <br>The [PaymentCharge](#payment-charges) this refund is applied to.<br>Links the refund to the original successful charge being refunded. This relationship is required for connected refunds but optional for standalone manual refunds. The charge tracks cumulative refunded amounts across all associated refunds.<br>When a refund succeeds, it automatically updates the charge's refunded and refundable amounts. 
`data[attributes][provider]` | **enum** <br>The payment service provider processing this refund.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Processed through Stripe<br>`app` - Processed through a third-party payment app<br>`none` - Manual refund (cash, bank transfer, etc.)<br>For connected refunds, this usually matches the original charge provider. Manual refunds always use `none` regardless of the original charge provider. 
`data[attributes][provider_id]` | **string** <br>Unique identifier from the payment provider for this refund.<br>For Stripe refunds, this contains the Refund ID. Use this to reconcile with external payment systems or for support inquiries with the payment provider. 
`data[attributes][provider_link]` | **string** <br>Direct link to view this refund in the provider's dashboard.<br>Useful for support staff to quickly access refund details in the external payment system. Only available for provider-processed refunds. 
`data[attributes][provider_method]` | **string** <br>The payment method type used for this refund.<br>Typically matches the original charge's payment method (e.g., `card`, `ideal`, `bancontact`). For manual refunds, this may indicate the refund method (e.g., `cash`, `bank_transfer`). 
`data[attributes][provider_secret]` | **string** <br>Secret token used for client-side refund processing, if applicable.<br>Most refunds are processed server-side and don't require client secrets. This field is rarely used but maintained for consistency with other payment types. 
`data[attributes][reason]` | **string** <br>The reason code for this refund, used for reporting and analysis.<br>Common values include `requested_by_customer`, `duplicate`, `fraudulent`. The specific values available may depend on your payment provider configuration. 
`data[attributes][status]` | **enum** <br>Current status of the refund in its lifecycle.<br>One of: `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`.<br>Status transitions follow specific rules - for example, a refund cannot be canceled after it has succeeded. 
`data[attributes][succeeded_at]` | **datetime** <br>Timestamp when the refund was successfully processed.<br>Will be `null` for refunds that haven't succeeded yet. Once set, the refund is complete and funds have been returned to the customer. 
`data[attributes][total_in_cents]` | **integer** <br>Total refund amount in cents.<br>Always equals `amount_in_cents` + `deposit_in_cents`. This is the total amount being returned to the customer. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>documents</code></li>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charge</code></li>
  <li><code>payment_method</code></li>
</ul>


## Delete a payment refund


> How to delete a payment refund:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/payment_refunds/4e0fcade-0031-4482-8298-8812aef4a22f'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4e0fcade-0031-4482-8298-8812aef4a22f",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2014-08-09T02:36:03.000000+00:00",
        "updated_at": "2014-08-09T02:36:03.000000+00:00",
        "type": "payment_refunds",
        "provider": "none",
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
        "status": "pending",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "payment_charge_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/payment_refunds/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>documents</code></li>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charge</code></li>
  <li><code>payment_method</code></li>
</ul>

