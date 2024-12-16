# Order duplications

Duplicates an Order with a selectable subset of fields and associations.

## Relationships
Name | Description
-- | --
`new_order` | **[Order](#orders)** `required`<br>The newly created Order. 
`original_order` | **[Order](#orders)** `required`<br>The Order to be duplicated. 


Check matching attributes under [Fields](#order-duplications-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`custom_lines` | **boolean** <br>Indicates if custom Lines should be copied from the original Order. 
`customer` | **boolean** <br>Indicates if the Customer should be copied from the original Order. 
`dates` | **boolean** <br>Indicates if the rental dates should be copied from the original Order. 
`deposit` | **string** <br>`current` copies the desposit from the original Order, `default` resets the deposit to the default for the company or customer, `none` removes the deposit. 
`discount` | **boolean** <br>Indicates if discounts should be copied from the original Order. 
`id` | **uuid** `readonly`<br>Primary key.
`new_order_id` | **uuid** `readonly`<br>The newly created Order. 
`original_order_id` | **uuid** <br>The Order to be duplicated. 
`properties` | **boolean** <br>Indicates if properties should be copied from the original Order. 
`stock_item_plannings` | **boolean** <br>Indicates if planned stock items should be copied from the original Order. 
`tags` | **boolean** <br>Indicates if tags should be copied from the original Order. 


## Duplicate


> Duplicate an Order:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_duplications'
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
`data[attributes][custom_lines]` | **boolean** <br>Indicates if custom Lines should be copied from the original Order. 
`data[attributes][customer]` | **boolean** <br>Indicates if the Customer should be copied from the original Order. 
`data[attributes][dates]` | **boolean** <br>Indicates if the rental dates should be copied from the original Order. 
`data[attributes][deposit]` | **string** <br>`current` copies the desposit from the original Order, `default` resets the deposit to the default for the company or customer, `none` removes the deposit. 
`data[attributes][discount]` | **boolean** <br>Indicates if discounts should be copied from the original Order. 
`data[attributes][original_order_id]` | **uuid** <br>The Order to be duplicated. 
`data[attributes][properties]` | **boolean** <br>Indicates if properties should be copied from the original Order. 
`data[attributes][stock_item_plannings]` | **boolean** <br>Indicates if planned stock items should be copied from the original Order. 
`data[attributes][tags]` | **boolean** <br>Indicates if tags should be copied from the original Order. 


### Includes

This request accepts the following includes:

`original_order`


`new_order`





