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
`status` | **String** <br>Status. One of `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`
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
`succeeded_at` | **Datetime** <br>When payment charge succeeded
`failed_at` | **Datetime** `readonly`<br>When payment charge failed
`canceled_at` | **Datetime** `readonly`<br>When payment charge was canceled
`expired_at` | **Datetime** `readonly`<br>When payment charge expired
`employee_id` | **Uuid** `readonly`<br>Associated Employee
`order_id` | **Uuid** `readonly-after-create`<br>Associated Order
`customer_id` | **Uuid** `readonly-after-create`<br>Associated Customer
`payment_method_id` | **Uuid** <br>Associated Payment method
`payment_authorization_id` | **Uuid** `readonly-after-create`<br>Associated Payment authorization


## Relationships
Payment charges have the following relationships:

Name | Description
-- | --
`customer` | **[Customer](#customers)** <br>Associated Customer
`employee` | **[Employee](#employees)** <br>Associated Employee
`order` | **[Order](#orders)** <br>Associated Order
`payment` | **[Payment](#payments)** <br>Associated Payment
`payment_authorization` | **[Payment authorization](#payment-authorizations)** <br>Associated Payment authorization
`payment_method` | **[Payment method](#payment-methods)** <br>Associated Payment method
`payment_refunds` | **[Payment refunds](#payment-refunds)** <br>Associated Payment refunds


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
      "id": "05bf5291-ce72-4d8e-989a-eff578e64dc2",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2024-12-02T09:22:05.398979+00:00",
        "updated_at": "2024-12-02T09:22:05.398979+00:00",
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
`payment_method_id` | **Uuid** <br>`eq`, `not_eq`
`payment_authorization_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`amount_in_cents` | **Array** <br>`sum`
`deposit_in_cents` | **Array** <br>`sum`
`total_in_cents` | **Array** <br>`sum`


### Includes

This request accepts the following includes:

`order`


`customer`






## Fetching a payment charge



> How to fetch a payment charge:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_charges/b9d5c001-040f-430d-98b5-788aee7e6d61' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b9d5c001-040f-430d-98b5-788aee7e6d61",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-12-02T09:22:03.992706+00:00",
      "updated_at": "2024-12-02T09:22:03.992706+00:00",
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
    "id": "03ec16df-d5ae-489d-a214-eb345df4fe52",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-12-02T09:22:04.476405+00:00",
      "updated_at": "2024-12-02T09:22:04.476405+00:00",
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
      "succeeded_at": "2024-12-02T09:22:04.475339+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "9ef4e788-b8f1-44df-b645-cd70e5595d4d",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_charges]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider payment identification
`data[attributes][provider_method]` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider payment secret
`data[attributes][succeeded_at]` | **Datetime** <br>When payment charge succeeded
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_method_id]` | **Uuid** <br>Associated Payment method
`data[attributes][payment_authorization_id]` | **Uuid** <br>Associated Payment authorization


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment charge



> How to update a payment charge:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/payment_charges/6c733a25-1ccb-4caf-9d71-0feb106f7bce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6c733a25-1ccb-4caf-9d71-0feb106f7bce",
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
    "id": "6c733a25-1ccb-4caf-9d71-0feb106f7bce",
    "type": "payment_charges",
    "attributes": {
      "created_at": "2024-12-02T09:22:04.945679+00:00",
      "updated_at": "2024-12-02T09:22:04.945679+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_charges]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `processing`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `manual`, `off_session`, `request`, `terminal`, `capture`. `checkout` mode is reserved for checkout payments, not available for API.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider payment identification
`data[attributes][provider_method]` | **String** <br>Provider payment method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider payment secret
`data[attributes][succeeded_at]` | **Datetime** <br>When payment charge succeeded
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_method_id]` | **Uuid** <br>Associated Payment method
`data[attributes][payment_authorization_id]` | **Uuid** <br>Associated Payment authorization


### Includes

This request accepts the following includes:

`order`


`customer`





