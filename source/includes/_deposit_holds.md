# Deposit holds

A deposit hold is the resource responsible for managing the held deposit on an order.

## Relationships
Name | Description
-- | --
`deposit_line` | **[Line](#lines)** `required`<br>The [Line](#lines) that was created or updated to hold the deppsit. 
`order` | **[Order](#orders)** `required`<br>The order a new deposit needs to be added to. 


Check matching attributes under [Fields](#deposit-holds-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** `writeonly`<br>Amount to hold. If the order already has a hold, the amount will added to the previous one. The hold is clamped to `order.deposit_in_cents`. 
`deposit_line_id` | **uuid** `readonly`<br>The [Line](#lines) that was created or updated to hold the deppsit. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>The order a new deposit needs to be added to. 
`reason` | **string** `writeonly`<br>Reason for the hold. If the order already has a hold, the reason will overwrite the previous one. 


## Create


> Holding a deposit:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/deposit_holds'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "deposit_holds",
           "attributes": {
             "order_id": "f9863002-224c-4c7c-896e-d5331e84930b",
             "amount_in_cents": 5000,
             "reason": "damages"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "7603bbc7-4fbe-49cf-8555-b6930fc55411",
      "type": "deposit_holds",
      "attributes": {
        "order_id": "f9863002-224c-4c7c-896e-d5331e84930b",
        "deposit_line_id": "1cad0b8d-3f2f-47c0-85ba-84fbbbd0d05e"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/deposit_holds`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[deposit_holds]=order_id,deposit_line_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=deposit_line,order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount to hold. If the order already has a hold, the amount will added to the previous one. The hold is clamped to `order.deposit_in_cents`. 
`data[attributes][order_id]` | **uuid** <br>The order a new deposit needs to be added to. 
`data[attributes][reason]` | **string** <br>Reason for the hold. If the order already has a hold, the reason will overwrite the previous one. 


### Includes

This request accepts the following includes:

`deposit_line` => 
`tax_category`


`tax_values`




`order` => 
`tax_values`







