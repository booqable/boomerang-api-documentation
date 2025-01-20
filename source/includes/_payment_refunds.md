# Payment refunds

A PaymentRefund is a record of refund to the User that is used to track the refund status and details.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The associated cart.
`customer` | **[Customer](#customers)** `required`<br>The associated customer.
`employee` | **[Employee](#employees)** `required`<br>The associated employee.
`order` | **[Order](#orders)** `required`<br>The associated order.
`payment_charge` | **[Payment charge](#payment-charges)** `required`<br>The charge being refunded. 


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
`customer_id` | **uuid** `readonly-after-create`<br>The associated customer.
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The associated employee.
`expired_at` | **datetime** `readonly`<br>When payment refund expired. 
`failed_at` | **datetime** `readonly`<br>When payment refund failed. 
`failure_reason` | **string** <br>Failure reason. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The associated order.
`payment_charge_id` | **uuid** `readonly-after-create`<br>The charge being refunded. 
`possible_actions` | **array** `readonly`<br>Possible actions to be taken on the payment charge. 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`provider_id` | **string** <br>External provider refund identification. 
`provider_method` | **string** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc... 
`provider_secret` | **string** <br>Provider refund secret. 
`reason` | **string** <br>Reason. 
`status` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `expired`.
`succeeded_at` | **datetime** <br>When payment refund succeeded. 
`total_in_cents` | **integer** <br>Total amount in cents (`amount + deposit`). 
`type` | **string** `readonly`<br>Always `payment_refunds`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Create a payment refund


> How to create a payment refund:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/payment_refunds'
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
        "possible_actions": [],
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
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
        "payment_charge_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/payment_refunds`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart.
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer.
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][failure_reason]` | **string** <br>Failure reason. 
`data[attributes][order_id]` | **uuid** <br>The associated order.
`data[attributes][payment_charge_id]` | **uuid** <br>The charge being refunded. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider refund identification. 
`data[attributes][provider_method]` | **string** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc... 
`data[attributes][provider_secret]` | **string** <br>Provider refund secret. 
`data[attributes][reason]` | **string** <br>Reason. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment refund succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (`amount + deposit`). 


### Includes

This request accepts the following includes:

`order`


`customer`






## Update a payment refund


> How to update a payment refund:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/payment_refunds/d296895a-e933-4609-8b59-6850e2d29497'
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
        "possible_actions": [],
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
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
        "payment_charge_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/payment_refunds/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart.
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer.
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][failure_reason]` | **string** <br>Failure reason. 
`data[attributes][order_id]` | **uuid** <br>The associated order.
`data[attributes][payment_charge_id]` | **uuid** <br>The charge being refunded. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider refund identification. 
`data[attributes][provider_method]` | **string** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc... 
`data[attributes][provider_secret]` | **string** <br>Provider refund secret. 
`data[attributes][reason]` | **string** <br>Reason. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `pending`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment refund succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (`amount + deposit`). 


### Includes

This request accepts the following includes:

`order`


`customer`





