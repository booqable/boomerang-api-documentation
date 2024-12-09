# Payments

A Payment holds information about a payment and its type (owner).

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The associated cart.
`order` | **[Order](#orders)** `required`<br>The associated order.
`owner` | **[Payment charge](#payment-charges), [Payment authorization](#payment-authorizations), [Payment refund](#payment-refunds)** `required`<br>The resource this payment belongs to.


Check matching attributes under [Fields](#payments-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** `readonly`<br>Amount in cents.
`cart_id` | **uuid** `readonly-after-create`<br>The associated cart.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** `readonly`<br>Currency.
`deposit_in_cents` | **integer** `readonly`<br>Deposit in cents.
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The associated order.
`owner_id` | **uuid** <br>The resource this payment belongs to.
`owner_type` | **string** <br>The resource type of the owner.
`status` | **string** `readonly`<br>Status dependent of the `owner`.
`total_in_cents` | **integer** `readonly`<br>Total amount in cents (amount + deposit).
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing payments


> How to fetch a list of payments:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payments'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d7796fe0-99e9-4f00-858b-eb3f1e28fd8f",
        "type": "payments",
        "attributes": {
          "created_at": "2028-11-19T02:39:01.000000+00:00",
          "updated_at": "2028-11-19T02:39:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[payments]=created_at,updated_at,status`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=owner,order,cart`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **string** <br>`eq`, `not_eq`
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

`owner`


`order`


`cart`






## Fetching a payment


> How to fetch a payment:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payments/bf92b7a9-88e9-43e2-85c0-49ff1418a448'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bf92b7a9-88e9-43e2-85c0-49ff1418a448",
      "type": "payments",
      "attributes": {
        "created_at": "2016-06-23T23:18:00.000000+00:00",
        "updated_at": "2016-06-23T23:18:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[payments]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships `?include=owner,order,cart`


### Includes

This request accepts the following includes:

`owner`


`order`


`cart`





