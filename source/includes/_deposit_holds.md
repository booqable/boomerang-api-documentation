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
`order` | **Orders** `readonly`<br>Associated Order
`deposit_line` | **Lines** `readonly`<br>Associated Deposit line


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
          "order_id": "f3fe3f03-1d56-4502-a497-306a22447428",
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
    "id": "095b81c8-124c-5444-9a44-80ca7439d81d",
    "type": "deposit_holds",
    "attributes": {
      "order_id": "f3fe3f03-1d56-4502-a497-306a22447428",
      "deposit_line_id": "5d9c4e87-4ad7-4b5c-92b9-aad799a1a952"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "deposit_line": {
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







