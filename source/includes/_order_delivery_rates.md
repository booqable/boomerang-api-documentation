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
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates?order_id=e5812166-cc02-479f-a63c-e77e56e84e83' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "delivery_rates": [
    {
      "id": "7d33c33b-d1ab-48aa-a95c-98d392c51238",
      "type": "flat",
      "carrier_id": "8bbf5f83-f95b-4fc3-9ae3-8a8fc0d9c558",
      "price_in_cents": 1000,
      "label": "standard_delivery",
      "range": "10 km",
      "minimum_order_amount_in_cents": 0,
      "description": "Standard delivery",
      "errors": []
    },
    {
      "id": "31fa374d-fc31-4cab-a90d-5103839c6ced",
      "type": "calculated",
      "carrier_id": "8bbf5f83-f95b-4fc3-9ae3-8a8fc0d9c558",
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
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/8be1eab7-3750-4dba-9b71-bbf466aaebba' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8be1eab7-3750-4dba-9b71-bbf466aaebba",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T09:22:09.645472+00:00",
      "updated_at": "2024-12-02T09:22:09.645472+00:00",
      "identifier": "Xpress",
      "price_in_cents": 10000,
      "rate_id": "021e8bd9-f43a-49c1-9e57-2ce360ea233b",
      "minimum_order_amount_in_cents": 0,
      "carrier_id": "ec87c621-e217-4492-aa6f-072c570820c7",
      "order_id": "f4af4e36-b881-4a3e-9a57-c5b8ff13de17"
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
          "order_id": "1105fffd-87f5-4931-ac4b-33a68551a779"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0e9cd80f-2326-4f10-b688-a057b38d5b50",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T09:22:10.169987+00:00",
      "updated_at": "2024-12-02T09:22:10.169987+00:00",
      "identifier": "Custom rate",
      "price_in_cents": 5000,
      "rate_id": null,
      "minimum_order_amount_in_cents": null,
      "carrier_id": null,
      "order_id": "1105fffd-87f5-4931-ac4b-33a68551a779"
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
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/c15d873b-3072-44ec-ac2f-18e70219d6a2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_delivery_rates",
        "id": "c15d873b-3072-44ec-ac2f-18e70219d6a2",
        "attributes": {
          "identifier": "Standard",
          "price_in_cents": 5000,
          "rate_id": "31d2f147-cdfc-41ad-bad9-d6da1c038549"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c15d873b-3072-44ec-ac2f-18e70219d6a2",
    "type": "order_delivery_rates",
    "attributes": {
      "created_at": "2024-12-02T09:22:08.212525+00:00",
      "updated_at": "2024-12-02T09:22:08.228660+00:00",
      "identifier": "Standard",
      "price_in_cents": 5000,
      "rate_id": "31d2f147-cdfc-41ad-bad9-d6da1c038549",
      "minimum_order_amount_in_cents": 0,
      "carrier_id": "4f690bd8-8a98-4337-ad47-f4839d16dbf6",
      "order_id": "c873bd6e-d7e0-4d9c-81f8-b41b06d6796c"
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
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/153afcbd-029b-4183-a52e-488718806c65' \
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





