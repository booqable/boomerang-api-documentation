# Payment charges

Creates a `PaymentCharge` record. A `PaymentCharge` is a record of payment of an User that is used to track the payment status and details.

## Endpoints
`GET /api/boomerang/payment_charges`

`GET /api/boomerang/payment_charges/{id}`

`POST /api/boomerang/payment_charges`

## Fields
Every payment charge has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** <br>Status. One of `[:created, "created"]`, `[:pending, "pending"]`, `[:action_required, "action_required"]`, `[:succeeded, "succeeded"]`, `[:failed, "failed"]`, `[:canceled, "canceled"]`, `[:expired, "expired"]`, `[:captured, "captured"]`
`amount_in_cents` | **Integer** <br>Amount in cents
`deposit_in_cents` | **Integer** <br>Deposit in cents
`total_in_cents` | **Integer** `readonly`<br>Total amount in cents (amount + deposit)
`currency` | **String** <br>Currency
`mode` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`description` | **String** <br>Description
`provider` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`provider_id` | **String** <br>External provider payment identification
`provider_method` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`provider_secret` | **String** <br>Provider payment secret
`refundable` | **Boolean** `readonly`<br>Whether the payment is refundable
`amount_refundable_in_cents` | **Integer** `readonly`<br>Refundable amount in cents
`amount_refunded_in_cents` | **Integer** `readonly`<br>Refunded amount in cents
`deposit_refundable_in_cents` | **Integer** `readonly`<br>Refundable deposit in cents
`deposit_refunded_in_cents` | **Integer** `readonly`<br>Refunded deposit in cents
`total_refundable_in_cents` | **Integer** `readonly`<br>Total refundable amount in cents (`amount_refundable + deposit_refundable`)
`total_refunded_in_cents` | **Integer** `readonly`<br>Total refunded amount in cents (`amount_refunded + deposit_refunded`)
`succeeded_at` | **Datetime** `readonly`<br>When payment charge succeeded
`failed_at` | **Datetime** `readonly`<br>When payment charge failed
`canceled_at` | **Datetime** `readonly`<br>When payment charge was canceled
`expired_at` | **Datetime** `readonly`<br>When payment charge expired
`employee_id` | **Uuid** <br>The associated Employee
`order_id` | **Uuid** <br>The associated Order
`customer_id` | **Uuid** <br>The associated Customer


## Relationships
Payment charges have the following relationships:

Name | Description
-- | --
`customer` | **Customers** `readonly`<br>Associated Customer
`employee` | **Employees** `readonly`<br>Associated Employee
`order` | **Orders** `readonly`<br>Associated Order


## Listing payment charges



> How to fetch a list of payment charges:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_charges' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0d72a93b-a25b-47df-b17c-211f926da186",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2024-10-21T09:26:02.905042+00:00",
        "updated_at": "2024-10-21T09:26:02.905042+00:00",
        "status": "created",
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "provider": null,
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
        "employee_id": null,
        "order_id": null,
        "customer_id": null
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_charges]=created_at,updated_at,status`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`amount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`currency` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`mode` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_id` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`refundable` | **Boolean** <br>`eq`
`amount_refundable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refundable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_refundable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`succeeded_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`expired_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`customer`






## Fetching a payment charge



> How to fetch a payment charge:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_charges/fa6473bb-5a4a-4214-b30c-712aa744527c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fa6473bb-5a4a-4214-b30c-712aa744527c",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-10-21T09:26:03.685095+00:00",
      "updated_at": "2024-10-21T09:26:03.685095+00:00",
      "status": "created",
      "amount_in_cents": 5000,
      "deposit_in_cents": 0,
      "total_in_cents": 5000,
      "currency": "usd",
      "mode": "request",
      "description": null,
      "provider": null,
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
      "employee_id": null,
      "order_id": null,
      "customer_id": null
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_charges]=created_at,updated_at,status`


### Includes

This request accepts the following includes:

`order`


`customer`






## Creating a payment charge



> How to create a payment charge:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/payment_charges' \
    --header 'content-type: application/json' \
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
    "id": "31fb5a1b-1c9f-4fce-b326-eedac7e39f94",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-10-21T09:26:04.420508+00:00",
      "updated_at": "2024-10-21T09:26:04.420508+00:00",
      "status": "succeeded",
      "amount_in_cents": 10000,
      "deposit_in_cents": 5000,
      "total_in_cents": 15000,
      "currency": "usd",
      "mode": "manual",
      "description": null,
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
      "succeeded_at": "2024-10-21T09:26:04.418461+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "e2499c1a-6876-4dd6-887b-dec298c08f00",
      "order_id": null,
      "customer_id": null
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_charges]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `[:created, "created"]`, `[:pending, "pending"]`, `[:action_required, "action_required"]`, `[:succeeded, "succeeded"]`, `[:failed, "failed"]`, `[:canceled, "canceled"]`, `[:expired, "expired"]`, `[:captured, "captured"]`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider payment identification
`data[attributes][provider_method]` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider payment secret
`data[attributes][employee_id]` | **Uuid** <br>The associated Employee
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`order`


`customer`





