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
- | -
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order price recalculations have the following relationships:

Name | Description
- | -
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
          "order_id": "9cc4216a-d6e3-4693-be19-50c86518982a"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "de1e6570-b4b2-515a-adca-6982691a4f9e",
    "type": "order_price_recalculations",
    "attributes": {
      "order_id": "9cc4216a-d6e3-4693-be19-50c86518982a"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/order_price_recalculations`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_price_recalculations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`





