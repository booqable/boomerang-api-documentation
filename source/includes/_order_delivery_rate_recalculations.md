# Order delivery rate recalculations

Recalculates the delivery rate of a delivery order.

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>Order that needs recalculation of its rates.


Check matching attributes under [Fields](#order-delivery-rate-recalculations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>Order that needs recalculation of its rates.


## Recalculating delivery rates


> How to recalculate delivery rates:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_delivery_rate_recalculations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_delivery_rate_recalculations",
           "attributes": {
             "order_id": "48b7ecd6-6758-4045-81ee-d430100bd349"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "0c68209e-69ed-4c80-8b11-3801b7280e42",
      "type": "order_delivery_rate_recalculations",
      "attributes": {
        "order_id": "48b7ecd6-6758-4045-81ee-d430100bd349"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_delivery_rate_recalculations]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **uuid** <br>Order that needs recalculation of its rates.


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`order_delivery_rate`







