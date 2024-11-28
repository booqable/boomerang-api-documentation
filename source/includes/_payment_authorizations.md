# Payment authorizations

Creates a `PaymentAuthorization` record. A `PaymentAuthorization` is a record of payment authorization that is used to track the authorization status and details.

## Endpoints
`GET /api/boomerang/payment_authorizations`

`GET /api/boomerang/payment_authorizations/{id}`

`POST /api/boomerang/payment_authorizations`

`PUT /api/boomerang/payment_authorizations/{id}`

## Fields
Every payment authorization has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`
`amount_in_cents` | **Integer** <br>Amount in cents
`deposit_in_cents` | **Integer** <br>Deposit in cents
`total_in_cents` | **Integer** `readonly`<br>Total amount in cents (amount + deposit)
`currency` | **String** <br>Currency
`mode` | **String** <br>Mode. One of `off_session`, `checkout`, `request`, `terminal`.
`provider` | **String** <br>Provider. Can be one of `stripe`, `app`
`provider_id` | **String** <br>External provider authorization identification
`provider_method` | **String** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc.
`provider_secret` | **String** <br>Provider authorization secret
`capturable` | **Boolean** `readonly`<br>Whether the authorization is capturable
`amount_capturable_in_cents` | **Integer** `readonly`<br>Capturable amount in cents
`deposit_capturable_in_cents` | **Integer** `readonly`<br>Capturable deposit in cents
`total_capturable_in_cents` | **Integer** `readonly`<br>Total capturable amount in cents (`amount_capturable + deposit_capturable`)
`amount_captured_in_cents` | **Integer** `readonly`<br>Captured amount in cents
`deposit_captured_in_cents` | **Integer** `readonly`<br>Captured deposit in cents
`total_captured_in_cents` | **Integer** `readonly`<br>Total captured amount in cents (`amount_captured + deposit_captured`)
`captured_at` | **Datetime** `readonly`<br>When payment authorization was captured
`capture_before` | **Datetime** `readonly`<br>When payment authorization needs to be captured before
`succeeded_at` | **Datetime** `readonly`<br>When payment authorization succeeded
`failed_at` | **Datetime** `readonly`<br>When payment authorization failed
`canceled_at` | **Datetime** `readonly`<br>When payment authorization was canceled
`expired_at` | **Datetime** `readonly`<br>When payment authorization expired
`employee_id` | **Uuid** <br>Associated Employee
`order_id` | **Uuid** <br>Associated Order
`customer_id` | **Uuid** <br>Associated Customer
`payment_method_id` | **Uuid** <br>Associated Payment method


## Relationships
Payment authorizations have the following relationships:

Name | Description
-- | --
`customer` | **Customers** `readonly`<br>Associated Customer
`employee` | **Employees** `readonly`<br>Associated Employee
`order` | **Orders** `readonly`<br>Associated Order
`payment_method` | **Payment methods** `readonly`<br>Associated Payment method


## Listing payment authorizations



> How to fetch a list of payment authorizations:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_authorizations' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6186815d-212a-4174-832e-4fd8df230d81",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2024-11-25T09:27:45.708334+00:00",
        "updated_at": "2024-11-25T09:27:45.708334+00:00",
        "status": "created",
        "amount_in_cents": 100,
        "deposit_in_cents": 0,
        "total_in_cents": 100,
        "currency": "usd",
        "mode": "request",
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "capturable": true,
        "amount_capturable_in_cents": 100,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 100,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,payment_method`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_authorizations]=created_at,updated_at,status`
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
`provider` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_id` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`capturable` | **Boolean** <br>`eq`
`amount_capturable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_capturable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_capturable_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_captured_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_captured_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_captured_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`captured_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`capture_before` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`succeeded_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`expired_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`payment_method_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Fetching a payment authorization



> How to fetch a payment authorization:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_authorizations/25b71e63-993b-4ef6-82fd-730d31b80d28' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "25b71e63-993b-4ef6-82fd-730d31b80d28",
    "type": "payment_authorizations",
    "attributes": {
      "created_at": "2024-11-25T09:27:45.102658+00:00",
      "updated_at": "2024-11-25T09:27:45.102658+00:00",
      "status": "created",
      "amount_in_cents": 100,
      "deposit_in_cents": 0,
      "total_in_cents": 100,
      "currency": "usd",
      "mode": "request",
      "provider": "stripe",
      "provider_id": null,
      "provider_method": null,
      "provider_secret": null,
      "capturable": true,
      "amount_capturable_in_cents": 100,
      "deposit_capturable_in_cents": 0,
      "total_capturable_in_cents": 100,
      "amount_captured_in_cents": 0,
      "deposit_captured_in_cents": 0,
      "total_captured_in_cents": 0,
      "captured_at": null,
      "capture_before": null,
      "succeeded_at": null,
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": null,
      "order_id": null,
      "customer_id": null,
      "payment_method_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,payment_method`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_authorizations]=created_at,updated_at,status`


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Creating a payment authorization



> How to create a payment authorization:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/payment_authorizations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "payment_authorizations",
        "attributes": {
          "mode": "request",
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
    "id": "b7f7fffb-70ca-4df3-9a13-905189cf65ac",
    "type": "payment_authorizations",
    "attributes": {
      "created_at": "2024-11-25T09:27:43.442001+00:00",
      "updated_at": "2024-11-25T09:27:43.442001+00:00",
      "status": "created",
      "amount_in_cents": 10000,
      "deposit_in_cents": 5000,
      "total_in_cents": 15000,
      "currency": "usd",
      "mode": "request",
      "provider": null,
      "provider_id": null,
      "provider_method": null,
      "provider_secret": null,
      "capturable": false,
      "amount_capturable_in_cents": 10000,
      "deposit_capturable_in_cents": 5000,
      "total_capturable_in_cents": 15000,
      "amount_captured_in_cents": 0,
      "deposit_captured_in_cents": 0,
      "total_captured_in_cents": 0,
      "captured_at": null,
      "capture_before": null,
      "succeeded_at": null,
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": "4fe5b712-985f-4365-951d-1986a9c0604b",
      "order_id": null,
      "customer_id": null,
      "payment_method_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,payment_method`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_authorizations]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `stripe`, `app`
`data[attributes][provider_id]` | **String** <br>External provider authorization identification
`data[attributes][provider_method]` | **String** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider authorization secret
`data[attributes][employee_id]` | **Uuid** <br>Associated Employee
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_method_id]` | **Uuid** <br>Associated Payment method


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Updating a payment authorization



> How to update a payment authorization:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/payment_authorizations/d6f8a181-3477-4ce5-814c-590aae7a4115' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d6f8a181-3477-4ce5-814c-590aae7a4115",
        "type": "payment_authorizations",
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
    "id": "d6f8a181-3477-4ce5-814c-590aae7a4115",
    "type": "payment_authorizations",
    "attributes": {
      "created_at": "2024-11-25T09:27:44.224497+00:00",
      "updated_at": "2024-11-25T09:27:44.224497+00:00",
      "status": "started",
      "amount_in_cents": 100,
      "deposit_in_cents": 0,
      "total_in_cents": 100,
      "currency": "usd",
      "mode": "request",
      "provider": "stripe",
      "provider_id": null,
      "provider_method": null,
      "provider_secret": null,
      "capturable": true,
      "amount_capturable_in_cents": 100,
      "deposit_capturable_in_cents": 0,
      "total_capturable_in_cents": 100,
      "amount_captured_in_cents": 0,
      "deposit_captured_in_cents": 0,
      "total_captured_in_cents": 0,
      "captured_at": null,
      "capture_before": null,
      "succeeded_at": null,
      "failed_at": null,
      "canceled_at": null,
      "expired_at": null,
      "employee_id": null,
      "order_id": null,
      "customer_id": null,
      "payment_method_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,payment_method`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_authorizations]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][status]` | **String** <br>Status. One of `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`
`data[attributes][amount_in_cents]` | **Integer** <br>Amount in cents
`data[attributes][deposit_in_cents]` | **Integer** <br>Deposit in cents
`data[attributes][currency]` | **String** <br>Currency
`data[attributes][mode]` | **String** <br>Mode. One of `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][provider]` | **String** <br>Provider. Can be one of `stripe`, `app`
`data[attributes][provider_id]` | **String** <br>External provider authorization identification
`data[attributes][provider_method]` | **String** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc.
`data[attributes][provider_secret]` | **String** <br>Provider authorization secret
`data[attributes][employee_id]` | **Uuid** <br>Associated Employee
`data[attributes][order_id]` | **Uuid** <br>Associated Order
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer
`data[attributes][payment_method_id]` | **Uuid** <br>Associated Payment method


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`




