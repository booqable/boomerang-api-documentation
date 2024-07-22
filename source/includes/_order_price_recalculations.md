# Order price recalculations

When the rental period of an order is changed, the prices of individual lines
and the total price of the order are not automatically recalculated to preserve
any manual changes that may have been made.

The `OrderPriceRecalculation` resource allows to request a recalculation for the
entire order and all its lines.

To recalculate the price of an individual line, set the `charge_length` of the
line to `null` as described [here](#lines-fields).

## Fields
Every order price recalculation has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order price recalculations have the following relationships:

Name | Description
-- | --
`order` | **Orders**<br>Associated Order


## Recalculate prices



> Recalculate prices when rental period has changed:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_price_recalculations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_price_recalculations",
        "attributes": {
          "order_id": "83f94a81-de05-4899-bc52-da5e00bb487c"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a6d9bab2-519a-5fce-9791-5dd94292048d",
    "type": "order_price_recalculations",
    "attributes": {
      "order_id": "83f94a81-de05-4899-bc52-da5e00bb487c"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/order_price_recalculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_price_recalculations]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order` => 
`lines`


`tax_values`







