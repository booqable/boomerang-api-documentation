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
`status` | **String** <br>Status. One of `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
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
`succeeded_at` | **Datetime** <br>When payment refund succeeded
`failed_at` | **Datetime** `readonly`<br>When payment refund failed
`canceled_at` | **Datetime** `readonly`<br>When payment refund was canceled
`expired_at` | **Datetime** `readonly`<br>When payment refund expired
`employee_id` | **Uuid** `readonly`<br>Associated Employee
`order_id` | **Uuid** `readonly-after-create`<br>Associated Order
`customer_id` | **Uuid** `readonly-after-create`<br>Associated Customer
`payment_charge_id` | **Uuid** `readonly-after-create`<br>Associated Payment charge


## Relationships
Payment refunds have the following relationships:

Name | Description
-- | --
`customer` | **[Customer](#customers)** <br>Associated Customer
`employee` | **[Employee](#employees)** <br>Associated Employee
`order` | **[Order](#orders)** <br>Associated Order
`payment_charge` | **[Payment charge](#payment-charges)** <br>Associated Payment charge


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
      "id": "cfcb54c4-6e28-44c2-bacc-ae28ba7a8d54",
      "type": "payment_refunds",
      "attributes": {
        "created_at": "2024-12-02T09:26:43.073483+00:00",
        "updated_at": "2024-12-02T09:26:43.073483+00:00",
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
`amount_in_cents` | **Array** <br>`sum`
`deposit_in_cents` | **Array** <br>`sum`
`total_in_cents` | **Array** <br>`sum`


### Includes

This request accepts the following includes:

`order`


`customer`






## Fetching a payment refund



> How to fetch a payment refund:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds/dc13b316-f646-42fd-95bb-b63998b62678' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dc13b316-f646-42fd-95bb-b63998b62678",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-12-02T09:26:43.482523+00:00",
      "updated_at": "2024-12-02T09:26:43.482523+00:00",
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
    "id": "3f951d33-7bc5-4443-bbb8-97d4fb7c8881",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-12-02T09:26:42.310141+00:00",
      "updated_at": "2024-12-02T09:26:42.310141+00:00",
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
      "succeeded_at": "2024-12-02T09:26:42.308728+00:00",
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "91973ffa-a040-4d8a-8e3e-a615287fd820",
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
`data[attributes][status]` | **String** <br>Status. One of `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][failure_reason]` | **String** <br>Failure reason
`data[attributes][reason]` | **String** <br>Reason
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider refund identification
`data[attributes][provider_method]` | **String** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider refund secret
`data[attributes][succeeded_at]` | **Datetime** <br>When payment refund succeeded
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_charge_id]` | **Uuid** <br>Associated Payment charge


### Includes

This request accepts the following includes:

`order`


`customer`






## Updating a payment refund



> How to update a payment refund:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/payment_refunds/a0309d20-bad6-4dc5-bd44-999690bccfbc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0309d20-bad6-4dc5-bd44-999690bccfbc",
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
    "id": "a0309d20-bad6-4dc5-bd44-999690bccfbc",
    "type": "payment_refunds",
    "attributes": {
      "created_at": "2024-12-02T09:26:43.989610+00:00",
      "updated_at": "2024-12-02T09:26:43.989610+00:00",
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
      "succeeded_at": "2024-12-02T09:26:44.015736+00:00",
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
`data[attributes][status]` | **String** <br>Status. One of `created`, `pending`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][failure_reason]` | **String** <br>Failure reason
`data[attributes][reason]` | **String** <br>Reason
`data[attributes][provider]` | **String** <br>Provider. Can be one of `[:stripe, "stripe"]`, `[:app, "app"]`, `[:none, "none"]`
`data[attributes][provider_id]` | **String** <br>External provider refund identification
`data[attributes][provider_method]` | **String** <br>Provider refund method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider refund secret
`data[attributes][succeeded_at]` | **Datetime** <br>When payment refund succeeded
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_charge_id]` | **Uuid** <br>Associated Payment charge


### Includes

This request accepts the following includes:

`order`


`customer`





