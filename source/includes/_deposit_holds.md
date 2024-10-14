# Deposit holds

A deposit hold is the resource responsible for managing the held deposit on an order.

## Fields
Every deposit hold has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`amount_in_cents` | **Integer** `writeonly`<br>Amount to hold. If the order already has a hold, the amount will added to the previous one. The hold is clamped to `order.deposit_in_cents`. 
`reason` | **String** `writeonly`<br>Reason for the hold. If the order already has a hold, the reason will overwrite the previous one. 
`order_id` | **Uuid** <br>The associated Order
`deposit_line_id` | **Uuid** <br>The associated Deposit line


## Relationships
Deposit holds have the following relationships:

Name | Description
-- | --
`deposit_line` | **Lines** `readonly`<br>Associated Deposit line
`order` | **Orders** `readonly`<br>Associated Order


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
          "order_id": "8a7e8211-140c-41d5-a293-c078dd0add9c",
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
    "id": "a7cbba35-e9ab-590c-afa7-f0291bdb97d4",
    "type": "deposit_holds",
    "attributes": {
      "order_id": "8a7e8211-140c-41d5-a293-c078dd0add9c",
      "deposit_line_id": "4db45250-1d35-4462-83d7-ad9914c88639"
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
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][deposit_line_id]` | **Uuid** <br>The associated Deposit line


### Includes

This request accepts the following includes:

`deposit_line` => 
`tax_category`


`tax_values`




`order` => 
`tax_values`







