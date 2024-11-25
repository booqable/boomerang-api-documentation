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
`id` | **Uuid** `readonly`<br>Primary key
`order_id` | **Uuid** <br>Order that needs to be recalculated.


## Relationships
Order price recalculations have the following relationships:

Name | Description
-- | --
`order` | **Orders** <br>Associated Order


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
          "order_id": "aff624a8-2e84-4b62-90b1-cdb703a71e98"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb88ee7b-180c-52c4-b3d1-d7af12f5afc4",
    "type": "order_price_recalculations",
    "attributes": {
      "order_id": "aff624a8-2e84-4b62-90b1-cdb703a71e98"
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
`data[attributes][order_id]` | **Uuid** <br>Order that needs to be recalculated.


### Includes

This request accepts the following includes:

`order` => 
`lines`


`tax_values`







