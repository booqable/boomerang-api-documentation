# Payment charges

A payment charge is a record of payment of a user that is used to track the payment status and details.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The associated cart. 
`customer` | **[Customer](#customers)** `required`<br>The associated [Customer](#customers). 
`employee` | **[Employee](#employees)** `required`<br>The associated [Employee](#employees). 
`order` | **[Order](#orders)** `required`<br>The associated [Order](#orders). 
`payment_authorization` | **[Payment authorization](#payment-authorizations)** `required`<br>The [PaymentAuthorization](#payment-authorizations) under which this charge is made. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods). 
`payment_refunds` | **[Payment refunds](#payment-refunds)** `hasmany`<br>The associated [PaymentRefunds](#payment-refunds). 


Check matching attributes under [Fields](#payment-charges-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** <br>Amount in cents. 
`amount_refundable_in_cents` | **integer** `readonly`<br>Refundable amount in cents. 
`amount_refunded_in_cents` | **integer** `readonly`<br>Refunded amount in cents. 
`canceled_at` | **datetime** `readonly`<br>When payment charge was canceled. 
`cart_id` | **uuid** `readonly-after-create`<br>The associated cart. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated [Customer](#customers). 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`deposit_refundable_in_cents` | **integer** `readonly`<br>Refundable deposit in cents. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>Refunded deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The associated [Employee](#employees). 
`expired_at` | **datetime** `readonly`<br>When payment charge expired. 
`failed_at` | **datetime** `readonly`<br>When payment charge failed. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`order_id` | **uuid** `readonly-after-create`<br>The associated [Order](#orders). 
`payment_authorization_id` | **uuid** `readonly-after-create`<br>The [PaymentAuthorization](#payment-authorizations) under which this charge is made. 
`payment_method_id` | **uuid** `readonly-after-create`<br>The [PaymentMethod](#payment-methods). 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`provider_id` | **string** <br>External provider payment identification. 
`provider_link` | **string** <br>Provider payment link. 
`provider_method` | **string** <br>Provider payment method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`provider_secret` | **string** <br>Provider payment secret. 
`redirect_url` | **string** <br>Redirect URL to redirect to external payment provider. 
`refundable` | **boolean** `readonly`<br>Whether the payment is refundable. 
`status` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`succeeded_at` | **datetime** <br>When payment charge succeeded. 
`total_in_cents` | **integer** <br>Total amount in cents (amount + deposit). 
`total_refundable_in_cents` | **integer** `readonly`<br>Total refundable amount in cents (`amount_refundable + deposit_refundable`). 
`total_refunded_in_cents` | **integer** `readonly`<br>Total refunded amount in cents (`amount_refunded + deposit_refunded`). 
`type` | **string** `readonly`<br>Always `payment_charges`. 
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_authorization_id]` | **uuid** <br>The [PaymentAuthorization](#payment-authorizations) under which this charge is made. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods). 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider payment identification. 
`data[attributes][provider_link]` | **string** <br>Provider payment link. 
`data[attributes][provider_method]` | **string** <br>Provider payment method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider payment secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment charge succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (amount + deposit). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_authorization_id]` | **uuid** <br>The [PaymentAuthorization](#payment-authorizations) under which this charge is made. 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods). 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider payment identification. 
`data[attributes][provider_link]` | **string** <br>Provider payment link. 
`data[attributes][provider_method]` | **string** <br>Provider payment method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider payment secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment charge succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (amount + deposit). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
</ul>

