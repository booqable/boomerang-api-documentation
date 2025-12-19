# Order price recalculations

When the rental period of an order is changed, the prices of individual lines
and the total price of the order are not automatically recalculated to preserve
any manual changes that may have been made.

The `OrderPriceRecalculation` resource allows to request a recalculation for the
entire order and all its lines.

Optionally, a specific `charge_length` can be provided to set a custom charge
period for all items on the order. When `charge_length` is omitted, prices are
recalculated based on the order's rental period.

To recalculate the price of an individual line, set the `charge_length` of the
line to `null` as described [here](#lines-fields).

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>[Order](#orders) that needs to be recalculated. 


Check matching attributes under [Fields](#order-price-recalculations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`charge_length` | **integer** `writeonly` `readonly-after-create`<br>Charge length in seconds to apply to all items on the order. When provided, all items will be charged for this specific period, overriding any product-specific pricing rules. When omitted, prices are recalculated based on the order's rental period. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>[Order](#orders) that needs to be recalculated. 


## Recalculate prices


> Recalculate prices when rental period has changed:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_price_recalculations'
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

> Set a specific charge period for all items:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_price_recalculations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_price_recalculations",
           "attributes": {
             "order_id": "4242e277-f72e-40fb-85a8-26abd0f26b3d",
             "charge_length": 172800
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "a79ed17b-4853-4591-8039-b1df6c21c646",
      "type": "order_price_recalculations",
      "attributes": {
        "order_id": "4242e277-f72e-40fb-85a8-26abd0f26b3d"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/order_price_recalculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_price_recalculations]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][charge_length]` | **integer** <br>Charge length in seconds to apply to all items on the order. When provided, all items will be charged for this specific period, overriding any product-specific pricing rules. When omitted, prices are recalculated based on the order's rental period. 
`data[attributes][order_id]` | **uuid** <br>[Order](#orders) that needs to be recalculated. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>order</code>
    <ul>
      <li><code>lines</code></li>
      <li><code>tax_values</code></li>
    </ul>
  </li>
</ul>

