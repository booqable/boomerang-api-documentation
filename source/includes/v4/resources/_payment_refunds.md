# Payment refunds

A payment refund is a record of refund to the user that is used to track the refund status and details.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The associated cart. 
`customer` | **[Customer](#customers)** `required`<br>The associated [Customer](#customers). 
`employee` | **[Employee](#employees)** `required`<br>The associated [Employee](#employees). 
`order` | **[Order](#orders)** `required`<br>The associated [Order](#orders). 
`payment_charge` | **[Payment charge](#payment-charges)** `required`<br>The [PaymentCharge](#payment-charges) being refunded. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods) used to refund the payment. This is the same as the payment method of the payment charge attached to this refund. 


Check matching attributes under [Fields](#payment-refunds-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** <br>Amount in cents. 
`canceled_at` | **datetime** `readonly`<br>When payment refund was canceled. 
`cart_id` | **uuid** `readonly-after-create`<br>The associated cart. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated [Customer](#customers). 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The associated [Employee](#employees). 
`expired_at` | **datetime** `readonly`<br>When payment refund expired. 
`failed_at` | **datetime** `readonly`<br>When payment refund failed. 
`failure_reason` | **string** <br>Failure reason. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The associated [Order](#orders). 
`payment_charge_id` | **uuid** `readonly-after-create`<br>The [PaymentCharge](#payment-charges) being refunded. 
`payment_method_id` | **uuid** `readonly`<br>The [PaymentMethod](#payment-methods) used to refund the payment. This is the same as the payment method of the payment charge attached to this refund. 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`provider_id` | **string** <br>External provider refund identification. 
`provider_link` | **string** <br>Provider refund link. 
`provider_method` | **string** <br>Provider refund method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`provider_secret` | **string** <br>Provider refund secret. 
`reason` | **string** <br>Reason. 
`status` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `action_required`.
`succeeded_at` | **datetime** <br>When payment refund succeeded. 
`total_in_cents` | **integer** <br>Total amount in cents (`amount + deposit`). 
`type` | **string** `readonly`<br>Always `payment_refunds`. 
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
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][failure_reason]` | **string** <br>Failure reason. 
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_charge_id]` | **uuid** <br>The [PaymentCharge](#payment-charges) being refunded. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider refund identification. 
`data[attributes][provider_link]` | **string** <br>Provider refund link. 
`data[attributes][provider_method]` | **string** <br>Provider refund method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider refund secret. 
`data[attributes][reason]` | **string** <br>Reason. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `action_required`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment refund succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (`amount + deposit`). 


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
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][failure_reason]` | **string** <br>Failure reason. 
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_charge_id]` | **uuid** <br>The [PaymentCharge](#payment-charges) being refunded. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider refund identification. 
`data[attributes][provider_link]` | **string** <br>Provider refund link. 
`data[attributes][provider_method]` | **string** <br>Provider refund method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider refund secret. 
`data[attributes][reason]` | **string** <br>Reason. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `action_required`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment refund succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (`amount + deposit`). 


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
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charge</code></li>
  <li><code>payment_method</code></li>
</ul>

