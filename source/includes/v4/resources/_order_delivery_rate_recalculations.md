# Order delivery rate recalculations

Recalculates the delivery rate of a delivery order.

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>[Order](#orders) that needs recalculation of its rates. 


Check matching attributes under [Fields](#order-delivery-rate-recalculations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`destination_coordinates` | **array** `readonly`<br>Coordinates of the delivery address as `[longitude, latitude]`. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>[Order](#orders) that needs recalculation of its rates. 
`origin_coordinates` | **array** `readonly`<br>Coordinates of the delivery origin as `[longitude, latitude]`. 
`route_restricted` | **boolean** `readonly`<br>Whether the calculated route has restrictions (e.g. it violates a blocked road). The rate is still calculated from the route's distance, but the route should be reviewed. 


## Recalculate delivery rates


> How to recalculate delivery rates:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_delivery_rate_recalculations'
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
        "route_restricted": false,
        "origin_coordinates": [
          -63.6347,
          44.6595
        ],
        "destination_coordinates": [
          -63.625,
          44.6621
        ],
        "order_id": "48b7ecd6-6758-4045-81ee-d430100bd349"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/order_delivery_rate_recalculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_delivery_rate_recalculations]=route_restricted,origin_coordinates,destination_coordinates`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **uuid** <br>[Order](#orders) that needs recalculation of its rates. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>order</code>
    <ul>
      <li><code>order_delivery_rate</code></li>
      <li><code>tax_values</code></li>
    </ul>
  </li>
</ul>

