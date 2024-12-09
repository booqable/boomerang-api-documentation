# Order price recalculations

When the rental period of an order is changed, the prices of individual lines
and the total price of the order are not automatically recalculated to preserve
any manual changes that may have been made.

The `OrderPriceRecalculation` resource allows to request a recalculation for the
entire order and all its lines.

To recalculate the price of an individual line, set the `charge_length` of the
line to `null` as described [here](#lines-fields).

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>Order that needs to be recalculated.


Check matching attributes under [Fields](#order-price-recalculations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>Order that needs to be recalculated.


## Recalculate prices


> Recalculate prices when rental period has changed:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_price_recalculations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_price_recalculations",
           "attributes": {
             "order_id": "f9d1343a-593e-4557-86c1-de4af6faf4d2"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "9ee14a59-1417-4289-8959-a877624c6cb1",
      "type": "order_price_recalculations",
      "attributes": {
        "order_id": "f9d1343a-593e-4557-86c1-de4af6faf4d2"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_price_recalculations]=order_id`
`include` | **string** <br>List of comma seperated relationships `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **uuid** <br>Order that needs to be recalculated.


### Includes

This request accepts the following includes:

`order` => 
`lines`


`tax_values`







