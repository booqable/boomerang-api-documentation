# Order duplications

Duplicates an `Order` with a selectable subset of fields and associations.

## Fields
Every order duplication has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`custom_lines` | **Boolean** <br>Indicates if custom Lines should be copied from the original Order.
`customer` | **Boolean** <br>Indicates if the Customer should be copied from the original Order.
`dates` | **Boolean** <br>Indicates if the rental dates should be copied from the original Order.
`discount` | **Boolean** <br>Indicates if discounts should be copied from the original Order.
`properties` | **Boolean** <br>Indicates if properties should be copied from the original Order.
`stock_item_plannings` | **Boolean** <br>Indicates if planned stock items should be copied from the original Order.
`tags` | **Boolean** <br>Indicates if tags should be copied from the original Order.
`deposit` | **String** <br>`current` copies the desposit from the original Order, `default` resets the deposit to the default for the company or customer, `none` removes the deposit. 
`original_order_id` | **Uuid** <br>The associated Original order
`new_order_id` | **Uuid** `readonly`<br>The associated New order


## Relationships
Order duplications have the following relationships:

Name | Description
-- | --
`new_order` | **Orders** `readonly`<br>Associated New order
`original_order` | **Orders** <br>Associated Original order


## Duplicate



> Duplicate an Order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_duplications' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_duplications",
        "attributes": {
          "original_order_id": "98f61dde-ce26-4409-a342-a085ddd02aa3",
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
    "id": "6448f44f-07df-5501-960d-c2b2a5916bc8",
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
      "original_order_id": "98f61dde-ce26-4409-a342-a085ddd02aa3",
      "new_order_id": "5aa699d8-ebdb-4293-a70a-5123dac497c9"
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
`include` | **String** <br>List of comma seperated relationships `?include=original_order,new_order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_duplications]=custom_lines,customer,dates`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][custom_lines]` | **Boolean** <br>Indicates if custom Lines should be copied from the original Order.
`data[attributes][customer]` | **Boolean** <br>Indicates if the Customer should be copied from the original Order.
`data[attributes][dates]` | **Boolean** <br>Indicates if the rental dates should be copied from the original Order.
`data[attributes][discount]` | **Boolean** <br>Indicates if discounts should be copied from the original Order.
`data[attributes][properties]` | **Boolean** <br>Indicates if properties should be copied from the original Order.
`data[attributes][stock_item_plannings]` | **Boolean** <br>Indicates if planned stock items should be copied from the original Order.
`data[attributes][tags]` | **Boolean** <br>Indicates if tags should be copied from the original Order.
`data[attributes][deposit]` | **String** <br>`current` copies the desposit from the original Order, `default` resets the deposit to the default for the company or customer, `none` removes the deposit. 
`data[attributes][original_order_id]` | **Uuid** <br>The associated Original order


### Includes

This request accepts the following includes:

`original_order`


`new_order`





