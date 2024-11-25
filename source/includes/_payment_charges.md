# Payment charges

Creates a `PaymentCharge` record. A `PaymentCharge` is a record of payment of an User that is used to track the payment status and details.

## Endpoints
`GET /api/boomerang/payment_charges`

`GET /api/boomerang/payment_charges/{id}`

`POST /api/boomerang/payment_charges`

`PUT /api/boomerang/payment_charges/{id}`

## Fields
Every payment charge has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
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
`employee_id` | **Uuid** <br>Associated Employee
`order_id` | **Uuid** <br>Associated Order
`customer_id` | **Uuid** <br>Associated Customer


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
      "id": "63788898-9d24-45da-986c-ca99d99ea4be",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2024-11-25T09:28:28.708625+00:00",
        "updated_at": "2024-11-25T09:28:28.708625+00:00",
        "status": "created",
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "mode": "request",
        "description": null,
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
    --url 'https://example.booqable.com/api/boomerang/payment_charges/26883f3b-7f2d-4350-a748-d6ab5c8b1938' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "26883f3b-7f2d-4350-a748-d6ab5c8b1938",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-11-25T09:28:29.482507+00:00",
      "updated_at": "2024-11-25T09:28:29.482507+00:00",
      "status": "created",
      "amount_in_cents": 5000,
      "deposit_in_cents": 0,
      "total_in_cents": 5000,
      "currency": "usd",
      "mode": "request",
      "description": null,
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
    "id": "ea90ee87-49eb-45a9-8304-0414d6aafd25",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-11-25T09:28:27.269094+00:00",
      "updated_at": "2024-11-25T09:28:27.269094+00:00",
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
      "succeeded_at": "2024-11-25T09:28:27.266810+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "1b7e476e-888b-472c-9fc8-85b37ab2c52f",
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
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider payment identification
`data[attributes][provider_method]` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider payment secret
`data[attributes][employee_id]` | **Uuid** <br>Associated Employee
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment charge



> How to update a payment charge:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/payment_charges/5ac74948-bd26-44d1-b5f9-4e67cd954879' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5ac74948-bd26-44d1-b5f9-4e67cd954879",
        "type": "payment_charges",
        "attributes": {
          "status": "started"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5ac74948-bd26-44d1-b5f9-4e67cd954879",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-11-25T09:28:26.624536+00:00",
      "updated_at": "2024-11-25T09:28:26.624536+00:00",
      "status": "started",
      "amount_in_cents": 5000,
      "deposit_in_cents": 0,
      "total_in_cents": 5000,
      "currency": "usd",
      "mode": "request",
      "description": null,
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

`PUT /api/boomerang/payment_charges/{id}`

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
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider payment identification
`data[attributes][provider_method]` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider payment secret
`data[attributes][employee_id]` | **Uuid** <br>Associated Employee
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`order`


`customer`





