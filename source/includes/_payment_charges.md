# Payment charges

A PaymentCharge is a record of payment of an User that is used to track the payment status and details.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>The associated customer. 
`employee` | **[Employee](#employees)** `required`<br>The employee who created this charge. 
`order` | **[Order](#orders)** `required`<br>The associated order. 
`payment` | **[Payment](#payments)** `optional`<br>The payment. 
`payment_authorization` | **[Payment authorization](#payment-authorizations)** `required`<br>The authorization under which this charge is made. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The payment method. 
`payment_refunds` | **[Payment refunds](#payment-refunds)** `hasmany`<br>The associated refunds. 


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
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated customer. 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`deposit_refundable_in_cents` | **integer** `readonly`<br>Refundable deposit in cents. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>Refunded deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The employee who created this charge. 
`expired_at` | **datetime** `readonly`<br>When payment charge expired. 
`failed_at` | **datetime** `readonly`<br>When payment charge failed. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`order_id` | **uuid** `readonly-after-create`<br>The associated order. 
`payment_authorization_id` | **uuid** `readonly-after-create`<br>The authorization under which this charge is made. 
`payment_method_id` | **uuid** <br>The payment method. 
`possible_actions` | **array** `readonly`<br>Possible actions to be taken on the payment charge. 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`provider_id` | **string** <br>External provider payment identification. 
`provider_method` | **string** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.. 
`provider_secret` | **string** <br>Provider payment secret. 
`redirect_url` | **string** <br>Redirect URL to redirect to external payment provider. 
`refundable` | **boolean** `readonly`<br>Whether the payment is refundable. 
`status` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`succeeded_at` | **datetime** <br>When payment charge succeeded. 
`total_in_cents` | **integer** `readonly`<br>Total amount in cents (amount + deposit). 
`total_refundable_in_cents` | **integer** `readonly`<br>Total refundable amount in cents (`amount_refundable + deposit_refundable`). 
`total_refunded_in_cents` | **integer** `readonly`<br>Total refunded amount in cents (`amount_refunded + deposit_refunded`). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing payment charges


> How to fetch a list of payment charges:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_charges'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "cf983158-4c16-463d-83f2-287e163c6316",
        "type": "payment_charges",
        "attributes": {
          "created_at": "2019-02-04T06:20:01.000000+00:00",
          "updated_at": "2019-02-04T06:20:01.000000+00:00",
          "status": "created",
          "amount_in_cents": 5000,
          "deposit_in_cents": 0,
          "total_in_cents": 5000,
          "currency": "usd",
          "mode": "request",
          "description": null,
          "redirect_url": null,
          "provider": "stripe",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
          "refundable": true,
          "amount_refundable_in_cents": 5000,
          "amount_refunded_in_cents": 0,
          "deposit_refundable_in_cents": 0,
          "deposit_refunded_in_cents": 0,
          "total_refundable_in_cents": 5000,
          "total_refunded_in_cents": 0,
          "succeeded_at": null,
          "failed_at": null,
          "canceled_at": null,
          "expired_at": null,
          "possible_actions": [
            "cancel"
          ],
          "employee_id": null,
          "order_id": null,
          "customer_id": null,
          "payment_method_id": null,
          "payment_authorization_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_charges`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,status`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_refundable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`currency` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refundable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`expired_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`mode` | **string_enum** <br>`eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`payment_authorization_id` | **uuid** <br>`eq`, `not_eq`
`payment_method_id` | **uuid** <br>`eq`, `not_eq`
`provider` | **string_enum** <br>`eq`
`provider_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`redirect_url` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`refundable` | **boolean** <br>`eq`
`status` | **string_enum** <br>`eq`
`succeeded_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_refundable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_in_cents` | **array** <br>`sum`
`deposit_in_cents` | **array** <br>`sum`
`total` | **array** <br>`count`
`total_in_cents` | **array** <br>`sum`


### Includes

This request accepts the following includes:

`order`


`customer`






## Fetching a payment charge


> How to fetch a payment charge:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_charges/832f8d67-c53b-44e6-8852-154d491b0b0e'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "832f8d67-c53b-44e6-8852-154d491b0b0e",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2025-06-23T03:53:07.000000+00:00",
        "updated_at": "2025-06-23T03:53:07.000000+00:00",
        "status": "created",
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "refundable": true,
        "amount_refundable_in_cents": 5000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 5000,
        "total_refunded_in_cents": 0,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [
          "cancel"
        ],
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_charges/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Includes

This request accepts the following includes:

`order`


`customer`






## Creating a payment charge


> How to create a payment charge:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/payment_charges'
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
        "status": "succeeded",
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "mode": "manual",
        "description": null,
        "redirect_url": null,
        "provider": "none",
        "provider_id": null,
        "provider_method": "bank",
        "provider_secret": null,
        "refundable": true,
        "amount_refundable_in_cents": 10000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 5000,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 15000,
        "total_refunded_in_cents": 0,
        "succeeded_at": "2023-02-26T05:02:01.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [],
        "employee_id": "7dd1d262-ea22-442d-8f2b-551256cde93a",
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/payment_charges`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`data[attributes][order_id]` | **uuid** <br>The associated order. 
`data[attributes][payment_authorization_id]` | **uuid** <br>The authorization under which this charge is made. 
`data[attributes][payment_method_id]` | **uuid** <br>The payment method. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider payment identification. 
`data[attributes][provider_method]` | **string** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.. 
`data[attributes][provider_secret]` | **string** <br>Provider payment secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment charge succeeded. 


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment charge


> How to update a payment charge:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/payment_charges/04972b14-5348-4e61-8896-e61e346e3001'
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
        "status": "started",
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "provider": "stripe",
        "provider_id": null,
        "provider_method": "card",
        "provider_secret": null,
        "refundable": true,
        "amount_refundable_in_cents": 5000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 5000,
        "total_refunded_in_cents": 0,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [],
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/payment_charges/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_charges]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode. `checkout` mode is reserved for checkout payments, not available for API.<br> One of: `manual`, `off_session`, `request`, `terminal`, `capture`.
`data[attributes][order_id]` | **uuid** <br>The associated order. 
`data[attributes][payment_authorization_id]` | **uuid** <br>The authorization under which this charge is made. 
`data[attributes][payment_method_id]` | **uuid** <br>The payment method. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider payment identification. 
`data[attributes][provider_method]` | **string** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.. 
`data[attributes][provider_secret]` | **string** <br>Provider payment secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment charge succeeded. 


### Includes

This request accepts the following includes:

`order`


`customer`





