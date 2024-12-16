# Payment refunds

A PaymentRefund is a record of refund to the User that is used to track the refund status and details.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>The associated customer. 
`employee` | **[Employee](#employees)** `required`<br>The employee who issued this refund. 
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
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated customer. 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The employee who issued this refund. 
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
`total_in_cents` | **integer** `readonly`<br>Total amount in cents (`amount + deposit`). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing payment refunds


> How to fetch a list of payment refunds:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_refunds'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "7ea1a363-fc84-4e97-84fc-c02f561b6afd",
        "type": "payment_refunds",
        "attributes": {
          "created_at": "2022-07-28T01:00:00.000000+00:00",
          "updated_at": "2022-07-28T01:00:00.000000+00:00",
          "status": "created",
          "amount_in_cents": 100,
          "deposit_in_cents": 0,
          "total_in_cents": 100,
          "currency": "usd",
          "description": null,
          "failure_reason": null,
          "reason": null,
          "provider": "none",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
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
          "payment_charge_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_refunds`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,status`
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
`canceled_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`currency` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`expired_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failure_reason` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`payment_charge_id` | **uuid** <br>`eq`, `not_eq`
`provider` | **string_enum** <br>`eq`
`provider_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`reason` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **string_enum** <br>`eq`
`succeeded_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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






## Fetching a payment refund


> How to fetch a payment refund:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_refunds/4436dae4-b75e-4a33-8eea-f5f0cc97ba32'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4436dae4-b75e-4a33-8eea-f5f0cc97ba32",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2017-01-02T10:29:00.000000+00:00",
        "updated_at": "2017-01-02T10:29:00.000000+00:00",
        "status": "created",
        "amount_in_cents": 100,
        "deposit_in_cents": 0,
        "total_in_cents": 100,
        "currency": "usd",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
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
        "payment_charge_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_refunds/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Includes

This request accepts the following includes:

`order`


`customer`






## Creating a payment refund


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
        "status": "succeeded",
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "succeeded_at": "2014-04-24T08:32:00.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [],
        "employee_id": "a169cc22-50a0-4bf6-8a15-1516035f6501",
        "order_id": null,
        "customer_id": null,
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
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


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment refund


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
        "status": "succeeded",
        "amount_in_cents": 100,
        "deposit_in_cents": 0,
        "total_in_cents": 100,
        "currency": "usd",
        "description": null,
        "failure_reason": null,
        "reason": null,
        "provider": "none",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "succeeded_at": "2020-11-02T14:47:07.000000+00:00",
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [],
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_refunds]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
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


### Includes

This request accepts the following includes:

`order`


`customer`





