# Payments

A `Payment` holds information about a payment and its type (owner).

## Endpoints
`GET /api/boomerang/payments`

`GET /api/boomerang/payments/{id}`

## Fields
Every payment has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** `readonly`<br>Status dependent of the `owner`
`amount_in_cents` | **Integer** `readonly`<br>Amount in cents
`deposit_in_cents` | **Integer** `readonly`<br>Deposit in cents
`total_in_cents` | **Integer** `readonly`<br>Total amount in cents (amount + deposit)
`currency` | **String** `readonly`<br>Currency
`owner_id` | **Uuid** <br>Id of the owner
`owner_type` | **String** <br>Type of the owner
`cart_id` | **Uuid** `readonly`<br>Associated Cart
`order_id` | **Uuid** `readonly`<br>Associated Order


## Relationships
Payments have the following relationships:

Name | Description
-- | --
`cart` | **Carts** `readonly`<br>Associated Cart
`order` | **Orders** `readonly`<br>Associated Order
`owner` | **Payment charge, Payment authorization, Payment refund** <br>Associated Owner


## Listing payments



> How to fetch a list of payments:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payments' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1bfaa092-81ce-4f3d-bf93-72f0248b5754",
      "type": "payments",
      "attributes": {
        "created_at": "2024-11-25T09:30:58.023961+00:00",
        "updated_at": "2024-11-25T09:30:58.023961+00:00",
        "status": "created",
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "owner_id": null,
        "owner_type": null,
        "cart_id": null,
        "order_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/payments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,order,cart`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payments]=created_at,updated_at,status`
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
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`order`


`cart`






## Fetching a payment



> How to fetch a payment:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payments/df7c7f08-a176-49c0-aa16-d51ac1420886' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df7c7f08-a176-49c0-aa16-d51ac1420886",
    "type": "payments",
    "attributes": {
      "created_at": "2024-11-25T09:30:56.919186+00:00",
      "updated_at": "2024-11-25T09:30:56.919186+00:00",
      "status": "created",
      "amount_in_cents": 5000,
      "deposit_in_cents": 0,
      "total_in_cents": 5000,
      "currency": "usd",
      "owner_id": null,
      "owner_type": null,
      "cart_id": null,
      "order_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/payments/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,order,cart`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payments]=created_at,updated_at,status`


### Includes

This request accepts the following includes:

`owner`


`order`


`cart`





