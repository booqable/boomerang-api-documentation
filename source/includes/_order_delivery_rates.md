# Order delivery rates

Order delivery rates hold information about the delivery rate associated with a delivery order.
This data is relevant only for orders that have a `delivery` fulfillment type.

## Relationships
Name | Description
-- | --
`carrier` | **[Carrier](#carriers)** `required`<br>The selected carrier for this order.
`order` | **[Order](#orders)** `required`<br>The delivery order this rate is for.


Check matching attributes under [Fields](#order-delivery-rates-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`carrier_id` | **uuid** `readonly-after-create`<br>The selected carrier for this order.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>The identifier of the delivery rate.
`minimum_order_amount_in_cents` | **integer** <br>The minimum order amount in cents for this delivery rate.
`order_id` | **uuid** `readonly-after-create`<br>The delivery order this rate is for.
`price_in_cents` | **integer** <br>The price of the delivery rate in cents.
`rate_id` | **string** <br>The rate id returned by a delivery app.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Fetching rates from all installed delivery apps for an order


> How to fetch a list of rates:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/order_delivery_rates'
       --header 'content-type: application/json'
       --data-urlencode 'order_id=511097b6-24a3-4291-8141-095dcff3eb32'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "2370b233-cede-4a13-807c-be861a8e3cbd",
        "type": "delivery_rates",
        "attributes": {
          "type": "flat",
          "carrier_id": "04fc2f33-2196-4bbf-80be-31bdddf2a302",
          "price_in_cents": 1000,
          "label": "standard_delivery",
          "range": "10 km",
          "minimum_order_amount_in_cents": 0,
          "description": "Standard delivery",
          "errors": []
        }
      },
      {
        "id": "2bad4bc7-ab29-43ba-8c99-61c895023e9f",
        "type": "delivery_rates",
        "attributes": {
          "type": "calculated",
          "carrier_id": "04fc2f33-2196-4bbf-80be-31bdddf2a302",
          "price_in_cents": 2500,
          "label": "fast_delivery",
          "range": "8.75 km",
          "minimum_order_amount_in_cents": 1000,
          "description": "Fast delivery",
          "errors": [
            "under_minimum_order_amount"
          ]
        }
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=carrier,order`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`carrier_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`minimum_order_amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`rate_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`carrier`


`order`






## Fetching an order delivery rate


> How to fetch a rate:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/order_delivery_rates/92882618-2029-4da8-84ce-00546ba482bf'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "92882618-2029-4da8-84ce-00546ba482bf",
      "type": "order_delivery_rates",
      "attributes": {
        "created_at": "2025-11-19T18:45:00.000000+00:00",
        "updated_at": "2025-11-19T18:45:00.000000+00:00",
        "identifier": "Xpress",
        "price_in_cents": 10000,
        "rate_id": "5d74673e-ac2b-4853-8a69-66982a001b26",
        "minimum_order_amount_in_cents": 0,
        "carrier_id": "02745660-23b2-4aea-84e5-d7b8dab1c31d",
        "order_id": "0dfa2277-bb9f-48aa-8d5a-eeba5ff88cc6"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships `?include=carrier,order`


### Includes

This request accepts the following includes:

`carrier`


`order`






## Creating an order delivery rate


> How to create an order delivery rate:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_delivery_rates'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_delivery_rates",
           "attributes": {
             "identifier": "Custom rate",
             "price_in_cents": 5000,
             "rate_id": null,
             "carrier_id": null,
             "order_id": "614e2067-a249-44aa-899c-e0e493f52f34"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "3b1f144e-04a1-4bc3-829d-e1eb2c56f060",
      "type": "order_delivery_rates",
      "attributes": {
        "created_at": "2026-03-19T10:24:00.000000+00:00",
        "updated_at": "2026-03-19T10:24:00.000000+00:00",
        "identifier": "Custom rate",
        "price_in_cents": 5000,
        "rate_id": null,
        "minimum_order_amount_in_cents": null,
        "carrier_id": null,
        "order_id": "614e2067-a249-44aa-899c-e0e493f52f34"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships `?include=carrier,order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][carrier_id]` | **uuid** <br>The selected carrier for this order.
`data[attributes][identifier]` | **string** <br>The identifier of the delivery rate.
`data[attributes][minimum_order_amount_in_cents]` | **integer** <br>The minimum order amount in cents for this delivery rate.
`data[attributes][order_id]` | **uuid** <br>The delivery order this rate is for.
`data[attributes][price_in_cents]` | **integer** <br>The price of the delivery rate in cents.
`data[attributes][rate_id]` | **string** <br>The rate id returned by a delivery app.


### Includes

This request accepts the following includes:

`carrier`


`order`






## Updating an order delivery rate


> How to update an order delivery rate:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/00380853-f61f-4ade-8d98-f1cbcbfe2d7f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_delivery_rates",
           "id": "00380853-f61f-4ade-8d98-f1cbcbfe2d7f",
           "attributes": {
             "identifier": "Standard",
             "price_in_cents": 5000,
             "rate_id": "02309205-57de-4518-85c4-551531c6aba6"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "00380853-f61f-4ade-8d98-f1cbcbfe2d7f",
      "type": "order_delivery_rates",
      "attributes": {
        "created_at": "2016-08-26T07:41:01.000000+00:00",
        "updated_at": "2016-08-26T07:41:01.000000+00:00",
        "identifier": "Standard",
        "price_in_cents": 5000,
        "rate_id": "02309205-57de-4518-85c4-551531c6aba6",
        "minimum_order_amount_in_cents": 0,
        "carrier_id": "3bc89c75-2f3e-410c-8254-8676ee3430e1",
        "order_id": "0c1a8b23-fb1a-4f8f-8a73-f9ac40f80aa7"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships `?include=carrier,order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][carrier_id]` | **uuid** <br>The selected carrier for this order.
`data[attributes][identifier]` | **string** <br>The identifier of the delivery rate.
`data[attributes][minimum_order_amount_in_cents]` | **integer** <br>The minimum order amount in cents for this delivery rate.
`data[attributes][order_id]` | **uuid** <br>The delivery order this rate is for.
`data[attributes][price_in_cents]` | **integer** <br>The price of the delivery rate in cents.
`data[attributes][rate_id]` | **string** <br>The rate id returned by a delivery app.


### Includes

This request accepts the following includes:

`carrier`


`order`






## Deleting an order delivery rate


> How to delete an order delivery rate:

```shell
  curl --request DELETE \
       --url 'https://example.booqable.com/api/boomerang/order_delivery_rates/e1bbed39-2b7f-4c41-806e-4d3259929112'
       --header 'content-type: application/json'
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_delivery_rates]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships `?include=carrier,order`


### Includes

This request accepts the following includes:

`carrier`


`order`





