# Order duplications

Duplicates an [Order](#orders) with a selectable subset of fields and associations.

## Relationships
Name | Description
-- | --
`new_order` | **[Order](#orders)** `required`<br>The newly created [Order](#orders). 
`original_order` | **[Order](#orders)** `required`<br>The [Order](#orders) to be duplicated. 


Check matching attributes under [Fields](#order-duplications-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`custom_lines` | **boolean** <br>Indicates if custom [Lines](#lines) should be copied from the original [Order](#orders). 
`customer` | **boolean** <br>Indicates if the [Customer](#customers) should be copied from the original [Order](#orders). 
`dates` | **boolean** <br>Indicates if the rental dates should be copied from the original [Order](#orders). 
`deposit` | **enum** <br>`current` copies the deposit from the original [Order](#orders), `default` resets the deposit to the default for the company or customer, `none` removes the deposit.<br> One of: `current`, `default`, `none`.
`discount` | **boolean** <br>Indicates if discounts should be copied from the original [Order](#orders). 
`id` | **uuid** `readonly`<br>Primary key.
`new_order_id` | **uuid** `readonly`<br>The newly created [Order](#orders). 
`original_order_id` | **uuid** <br>The [Order](#orders) to be duplicated. 
`properties` | **boolean** <br>Indicates if [Properties](#properties) should be copied from the original [Order](#orders). 
`stock_item_plannings` | **boolean** <br>Indicates if planned [StockItems](#stock-items) should be copied from the original [Order](#orders). 
`tags` | **boolean** <br>Indicates if tags should be copied from the original [Order](#orders). 


## Duplicate


> Duplicate an Order:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_duplications'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_duplications",
           "attributes": {
             "original_order_id": "98b169c9-83a5-458d-8632-2f95c87b4189",
             "custom_lines": true,
             "customer": true,
             "dates": true,
             "deposit": "current",
             "discount": true,
             "properties": true,
             "stock_item_plannings": true,
             "tags": true
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bf7bb0d8-adc7-4776-8a85-e70e36ab59ff",
      "type": "order_duplications",
      "attributes": {
        "custom_lines": true,
        "customer": true,
        "dates": true,
        "discount": true,
        "properties": true,
        "stock_item_plannings": true,
        "tags": true,
        "deposit": "current",
        "original_order_id": "98b169c9-83a5-458d-8632-2f95c87b4189",
        "new_order_id": "e026832d-8b0c-45e9-81f7-84832585106b"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_duplications`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_duplications]=custom_lines,customer,dates`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=original_order,new_order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][custom_lines]` | **boolean** <br>Indicates if custom [Lines](#lines) should be copied from the original [Order](#orders). 
`data[attributes][customer]` | **boolean** <br>Indicates if the [Customer](#customers) should be copied from the original [Order](#orders). 
`data[attributes][dates]` | **boolean** <br>Indicates if the rental dates should be copied from the original [Order](#orders). 
`data[attributes][deposit]` | **enum** <br>`current` copies the deposit from the original [Order](#orders), `default` resets the deposit to the default for the company or customer, `none` removes the deposit.<br> One of: `current`, `default`, `none`.
`data[attributes][discount]` | **boolean** <br>Indicates if discounts should be copied from the original [Order](#orders). 
`data[attributes][original_order_id]` | **uuid** <br>The [Order](#orders) to be duplicated. 
`data[attributes][properties]` | **boolean** <br>Indicates if [Properties](#properties) should be copied from the original [Order](#orders). 
`data[attributes][stock_item_plannings]` | **boolean** <br>Indicates if planned [StockItems](#stock-items) should be copied from the original [Order](#orders). 
`data[attributes][tags]` | **boolean** <br>Indicates if tags should be copied from the original [Order](#orders). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>new_order</code></li>
  <li><code>original_order</code></li>
</ul>

