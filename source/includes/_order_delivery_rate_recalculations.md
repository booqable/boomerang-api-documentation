# Order delivery rate recalculations

It recalculates the delivery rate of a delivery order.

## Fields
Every order delivery rate recalculation has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`order_id` | **Uuid** <br>Associated Order


## Relationships
Order delivery rate recalculations have the following relationships:

Name | Description
-- | --
`order` | **[Order](#orders)** <br>Associated Order


## Recalculating delivery rates



> How to recalculate delivery rates:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_delivery_rate_recalculations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_delivery_rate_recalculations",
        "attributes": {
          "order_id": "5bc3e63e-5f38-4eab-8624-6e8aabdeb55d"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "083f1182-5a1e-5ef5-bd47-d663f558a46e",
    "type": "order_delivery_rate_recalculations",
    "attributes": {
      "order_id": "5bc3e63e-5f38-4eab-8624-6e8aabdeb55d"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/order_delivery_rate_recalculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_delivery_rate_recalculations]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **Uuid** <br>Associated Order


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`order_delivery_rate`







