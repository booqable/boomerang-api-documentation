# Order delivery rates

Order delivery rates hold information about the delivery rate associated with a delivery order.
This data is relevant only for orders that have a `delivery` fulfillment type.

## Endpoints
`GET /api/boomerang/order_delivery_rates`

`GET /api/boomerang/order_delivery_rates/{id}`

`POST /api/boomerang/order_delivery_rates`

`PUT /api/boomerang/order_delivery_rates/{id}`

`DELETE /api/boomerang/order_delivery_rates/{id}`

## Fields
Every order delivery rate has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`identifier` | **String** <br>The identifier of the delivery rate
`price_in_cents` | **Integer** <br>The price of the delivery rate in cents
`rate_id` | **String** <br>The rate id returned by a delivery app
`minimum_order_amount_in_cents` | **Integer** <br>The minimum order amount in cents for this delivery rate'
`carrier_id` | **Uuid** `readonly-after-create`<br>Associated Carrier
`order_id` | **Uuid** `readonly-after-create`<br>Associated Order


## Relationships
Order delivery rates have the following relationships:

Name | Description
-- | --
`carrier` | **[Carrier](#carriers)** <br>Associated Carrier
`order` | **[Order](#orders)** <br>Associated Order


## Fetching rates from all installed delivery apps for an order



> How to fetch a list of rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates?order_id=a0d18838-aac7-4e15-be6f-7457df237e80' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "delivery_rates": [
    {
      "id": "a92e6b5b-a831-4146-b89a-c09a1985abcb",
      "type": "flat",
      "carrier_id": "80cdb598-0cb2-4c89-bf6f-1ebeeefb55af",
      "price_in_cents": 1000,
      "label": "standard_delivery",
      "range": "10 km",
      "minimum_order_amount_in_cents": 0,
      "description": "Standard delivery",
      "errors": []
    },
    {
      "id": "a7a6bf6f-7ff8-4567-bb3b-b82983c2b161",
      "type": "calculated",
      "carrier_id": "80cdb598-0cb2-4c89-bf6f-1ebeeefb55af",
      "price_in_cents": 2500,
      "label": "fast_delivery",
      "range": "8.75 km",
      "minimum_order_amount_in_cents": 1000,
      "description": "Fast delivery",
      "errors": [
        "under_minimum_order_amount"
      ]
    }
  ]
}
```

### HTTP Request

`GET /api/boomerang/order_delivery_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=carrier,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
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
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`rate_id` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`minimum_order_amount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`carrier_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`carrier`


`order`






## Fetching an order delivery rate



> How to fetch a rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/d29daefc-c068-40c3-99e1-5bbfaa62bf15' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d29daefc-c068-40c3-99e1-5bbfaa62bf15",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T13:07:12.834731+00:00",
      "updated_at": "2024-12-02T13:07:12.834731+00:00",
      "identifier": "Xpress",
      "price_in_cents": 10000,
      "rate_id": "1e878ebf-8cc8-49ec-8733-10dd049b8c34",
      "minimum_order_amount_in_cents": 0,
      "carrier_id": "463ebf4d-9bcb-414c-8c2b-47dfc5a3159d",
      "order_id": "4a49e9f9-f9c5-4042-9e53-a3341d4075ab"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/order_delivery_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=carrier,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`


### Includes

This request accepts the following includes:

`carrier`


`order`






## Creating an order delivery rate



> How to create an order delivery rate:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_delivery_rates",
        "attributes": {
          "identifier": "Custom rate",
          "price_in_cents": 5000,
          "rate_id": null,
          "carrier_id": null,
          "order_id": "660a78b3-b021-45d4-b7f1-007cf25c304f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "326ee6a6-2185-4198-a356-604549f532a8",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T13:07:09.150759+00:00",
      "updated_at": "2024-12-02T13:07:09.150759+00:00",
      "identifier": "Custom rate",
      "price_in_cents": 5000,
      "rate_id": null,
      "minimum_order_amount_in_cents": null,
      "carrier_id": null,
      "order_id": "660a78b3-b021-45d4-b7f1-007cf25c304f"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/order_delivery_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=carrier,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The identifier of the delivery rate
`data[attributes][price_in_cents]` | **Integer** <br>The price of the delivery rate in cents
`data[attributes][rate_id]` | **String** <br>The rate id returned by a delivery app
`data[attributes][minimum_order_amount_in_cents]` | **Integer** <br>The minimum order amount in cents for this delivery rate'
`data[attributes][carrier_id]` | **Uuid** <br>Associated Carrier
`data[attributes][order_id]` | **Uuid** <br>Associated Order


### Includes

This request accepts the following includes:

`carrier`


`order`






## Updating an order delivery rate



> How to update an order delivery rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/c6c0e679-854b-44a2-92a8-107648b0cd99' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_delivery_rates",
        "id": "c6c0e679-854b-44a2-92a8-107648b0cd99",
        "attributes": {
          "identifier": "Standard",
          "price_in_cents": 5000,
          "rate_id": "4e733d4e-ccbc-4b4a-b38d-de08aa1d1410"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c6c0e679-854b-44a2-92a8-107648b0cd99",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T13:07:11.333761+00:00",
      "updated_at": "2024-12-02T13:07:11.353632+00:00",
      "identifier": "Standard",
      "price_in_cents": 5000,
      "rate_id": "4e733d4e-ccbc-4b4a-b38d-de08aa1d1410",
      "minimum_order_amount_in_cents": 0,
      "carrier_id": "d20ca0dc-570e-4b13-917a-c8e598c6682f",
      "order_id": "c3ff6b1a-7b68-48fd-b721-e4f71cdcdb24"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/order_delivery_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=carrier,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The identifier of the delivery rate
`data[attributes][price_in_cents]` | **Integer** <br>The price of the delivery rate in cents
`data[attributes][rate_id]` | **String** <br>The rate id returned by a delivery app
`data[attributes][minimum_order_amount_in_cents]` | **Integer** <br>The minimum order amount in cents for this delivery rate'
`data[attributes][carrier_id]` | **Uuid** <br>Associated Carrier
`data[attributes][order_id]` | **Uuid** <br>Associated Order


### Includes

This request accepts the following includes:

`carrier`


`order`






## Deleting an order delivery rate



> How to delete an order delivery rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/95b2ab80-6dc6-4bac-98a6-f77d1c840627' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/order_delivery_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=carrier,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`


### Includes

This request accepts the following includes:

`carrier`


`order`





