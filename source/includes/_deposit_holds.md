# Deposit holds

A deposit hold is the resource responsible for managing the held deposit on an order.

## Fields
Every deposit hold has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`amount_in_cents` | **Integer** `writeonly`<br>Amount to hold. If the order already has a hold, the amount will added to the previous one. The hold is clamped to `order.deposit_in_cents`. 
`reason` | **String** `writeonly`<br>Reason for the hold. If the order already has a hold, the reason will overwrite the previous one. 
`order_id` | **Uuid** <br>Associated Order
`deposit_line_id` | **Uuid** `readonly`<br>Associated Deposit line


## Relationships
Deposit holds have the following relationships:

Name | Description
-- | --
`deposit_line` | **[Line](#lines)** <br>Associated Deposit line
`order` | **[Order](#orders)** <br>Associated Order


## Create



> Holding a deposit:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/deposit_holds' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "deposit_holds",
        "attributes": {
          "order_id": "f6d7e276-f35a-4e62-9af6-1be9737df38b",
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
    "id": "fbdfc314-75b9-5b65-8f4e-5afe30eae8e5",
    "type": "deposit_holds",
    "attributes": {
      "order_id": "f6d7e276-f35a-4e62-9af6-1be9737df38b",
      "deposit_line_id": "bae72d61-c89b-46c1-a475-37870df60076"
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
`include` | **String** <br>List of comma seperated relationships `?include=deposit_line,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[deposit_holds]=order_id,deposit_line_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **Integer** <br>Amount to hold. If the order already has a hold, the amount will added to the previous one. The hold is clamped to `order.deposit_in_cents`. 
`data[attributes][reason]` | **String** <br>Reason for the hold. If the order already has a hold, the reason will overwrite the previous one. 
`data[attributes][order_id]` | **Uuid** <br>Associated Order


### Includes

This request accepts the following includes:

`deposit_line` => 
`tax_category`


`tax_values`




`order` => 
`tax_values`







