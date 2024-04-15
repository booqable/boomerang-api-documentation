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
          "order_id": "7044d185-80f6-4737-9614-9cbef79fe324",
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
    "id": "f9d08f6f-8e13-5103-812c-8b4545a9c78b",
    "type": "deposit_holds",
    "attributes": {
      "order_id": "7044d185-80f6-4737-9614-9cbef79fe324",
      "deposit_line_id": "868688d4-ed59-4e12-b38c-d0f30f5a8d27"
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







