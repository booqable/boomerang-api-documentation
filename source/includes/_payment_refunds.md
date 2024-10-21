# Payment refunds

Creates a `PaymentRefund` record. A `PaymentRefund` is a record of refund to the User that is used to track the refund status and details.

## Endpoints
`GET /api/boomerang/payment_refunds`

`GET /api/boomerang/payment_refunds/{id}`

`POST /api/boomerang/payment_refunds`

`PUT /api/boomerang/payment_refunds/{id}`

## Fields
Every payment refund has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** <br>Status. One of `[:created, "created"]`, `[:pending, "pending"]`, `[:action_required, "action_required"]`, `[:succeeded, "succeeded"]`, `[:failed, "failed"]`, `[:canceled, "canceled"]`, `[:expired, "expired"]`, `[:captured, "captured"]`
`amount_in_cents` | **Integer** <br>Amount in cents
`deposit_in_cents` | **Integer** <br>Deposit in cents
`total_in_cents` | **Integer** `readonly`<br>Total amount in cents (`amount + deposit`)
`currency` | **String** <br>Currency
`description` | **String** <br>Description
`failure_reason` | **String** <br>Failure reason
`reason` | **String** <br>Reason
`provider` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`provider_id` | **String** <br>External provider refund identification
`provider_method` | **String** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc.
`provider_secret` | **String** <br>Provider refund secret
`succeeded_at` | **Datetime** `readonly`<br>When payment refund succeeded
`failed_at` | **Datetime** `readonly`<br>When payment refund failed
`canceled_at` | **Datetime** `readonly`<br>When payment refund was canceled
`expired_at` | **Datetime** `readonly`<br>When payment refund expired
`employee_id` | **Uuid** <br>The associated Employee
`order_id` | **Uuid** <br>The associated Order
`customer_id` | **Uuid** <br>The associated Customer
`payment_charge_id` | **Uuid** <br>The associated Payment charge


## Relationships
Payment refunds have the following relationships:

Name | Description
-- | --
`customer` | **Customers** `readonly`<br>Associated Customer
`employee` | **Employees** `readonly`<br>Associated Employee
`order` | **Orders** `readonly`<br>Associated Order
`payment_charge` | **Payment charges** `readonly`<br>Associated Payment charge


## Listing payment refunds



> How to fetch a list of payment refunds:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "10df8b61-2e0e-42fd-8b45-e66403eea6c9",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2024-10-21T09:23:45.436757+00:00",
        "updated_at": "2024-10-21T09:23:45.436757+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_refunds]=created_at,updated_at,status`
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
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`failure_reason` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`reason` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_id` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`succeeded_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`expired_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`payment_charge_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`customer`






## Fetching a payment refund



> How to fetch a payment refund:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds/1c0fa04c-5b5a-4ec7-aa23-1d379a33f721' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c0fa04c-5b5a-4ec7-aa23-1d379a33f721",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-10-21T09:23:44.514942+00:00",
      "updated_at": "2024-10-21T09:23:44.514942+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_refunds]=created_at,updated_at,status`


### Includes

This request accepts the following includes:

`order`


`customer`






## Creating a payment refund



> How to create a payment refund:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds' \
    --header 'content-type: application/json' \
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
    "id": "8a9ea0cf-9bc4-4a50-98ef-619692bcdae6",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-10-21T09:23:45.030644+00:00",
      "updated_at": "2024-10-21T09:23:45.030644+00:00",
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
      "succeeded_at": "2024-10-21T09:23:45.029856+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "0d297416-e36e-4a6b-94a7-498a1837061e",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_refunds]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `[:created, "created"]`, `[:pending, "pending"]`, `[:action_required, "action_required"]`, `[:succeeded, "succeeded"]`, `[:failed, "failed"]`, `[:canceled, "canceled"]`, `[:expired, "expired"]`, `[:captured, "captured"]`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][failure_reason]` | **String** <br>Failure reason
`data[attributes][reason]` | **String** <br>Reason
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider refund identification
`data[attributes][provider_method]` | **String** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider refund secret
`data[attributes][employee_id]` | **Uuid** <br>The associated Employee
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][payment_charge_id]` | **Uuid** <br>The associated Payment charge


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment refund



> How to update a payment refund:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds/663041c8-ccb5-4c97-9b2f-c1d033f1b1b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "663041c8-ccb5-4c97-9b2f-c1d033f1b1b1",
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
    "id": "663041c8-ccb5-4c97-9b2f-c1d033f1b1b1",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-10-21T09:23:45.856786+00:00",
      "updated_at": "2024-10-21T09:23:45.856786+00:00",
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
      "succeeded_at": "2024-10-21T09:23:45.880918+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
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
`include` | **String** <br>List of comma seperated relationships `?include=order,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_refunds]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `[:created, "created"]`, `[:pending, "pending"]`, `[:action_required, "action_required"]`, `[:succeeded, "succeeded"]`, `[:failed, "failed"]`, `[:canceled, "canceled"]`, `[:expired, "expired"]`, `[:captured, "captured"]`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][failure_reason]` | **String** <br>Failure reason
`data[attributes][reason]` | **String** <br>Reason
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider refund identification
`data[attributes][provider_method]` | **String** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider refund secret
`data[attributes][employee_id]` | **Uuid** <br>The associated Employee
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][payment_charge_id]` | **Uuid** <br>The associated Payment charge


### Includes

This request accepts the following includes:

`order`


`customer`





