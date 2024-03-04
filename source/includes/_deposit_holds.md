# Deposit holds

A deposit hold is the resource responsible for managing the held deposit on an order. The maximum held value is clamped to the order's `deposit_held_in_cents` value, when multiple holds are done on the same order a new hold adds to the total held but if a new reason is given the previous reason is overwritten.

## Fields
Every deposit hold has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`amount_in_cents` | **Integer** `writeonly`<br>Amount to hold, clamped to the order's deposit_hold_in_cents value.
`reason` | **String** `writeonly`<br>Reason for hold, if the order already has a reason providing a new reason will overwrite the previous one.
`order_id` | **Uuid** <br>The associated Order


## Relationships
Deposit holds have the following relationships:

Name | Description
-- | --
`order` | **Orders** `readonly`<br>Associated Order


## Holding a deposit



> Holds the specified amount as deposit for this order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/deposit_holds' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "deposit_holds",
        "attributes": {
          "order_id": "08766ce2-1a24-440f-b450-e6a5107a0972",
          "amount_in_cents": 500,
          "reason": "Reason for deposit"
        },
        "include": "order"
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1174a9f9-d535-5345-aff1-2297ac1e204d",
    "type": "deposit_holds",
    "attributes": {
      "order_id": "08766ce2-1a24-440f-b450-e6a5107a0972"
    },
    "relationships": {
      "order": {
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
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[deposit_holds]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **Integer** <br>Amount to hold, clamped to the order's deposit_hold_in_cents value.
`data[attributes][reason]` | **String** <br>Reason for hold, if the order already has a reason providing a new reason will overwrite the previous one.
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`lines`







