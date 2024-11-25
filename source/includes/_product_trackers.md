# Product trackers

ProductTrackers describe the history of pickups and returns of a Product.

For trackable products, the StockItemTracker resource
provides additional details about individual StockItems.

For products with multiple variations, the `product_group_id`
filter can be used to get the history for all variations at once.

## Fields
Every product tracker has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the pickup/returned happenend. 
`quantity` | **Integer** `readonly`<br>The quantitiy of the product being picked up or returned. Positive values are pickups, negative values are returns. 
`product_id` | **Uuid** `readonly`<br>The product whose history is recorded. 
`employee_id` | **Uuid** `readonly`<br>The employee who handled the pickup/return. 
`order_id` | **Uuid** `readonly`<br>The order the pickup/return was part of. 


## Relationships
Product trackers have the following relationships:

Name | Description
-- | --
`employee` | **Employees** `readonly`<br>The employee who handled the pickup/return. 
`order` | **Orders** `readonly`<br>The order the pickup/return was part of. 
`product` | **Products** `readonly`<br>The product that was picked up/returned. 
`stock_item_trackers` | **Stock item trackers** `readonly`<br>The StockItems that were picked up/returned. 


## Listing product trackers



> How to fetch ProductTrackers for a ProductGroup:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/product_trackers?filter%5Bproduct_group_id%5D%5B%5D=12efdf8d-c9e8-4da0-a787-eb6f2fc34796' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "65b961c5-0a89-4531-984e-56681a7ddca7",
      "type": "product_trackers",
      "attributes": {
        "created_at": "2024-11-25T09:25:42.855183+00:00",
        "updated_at": "2024-11-25T09:25:42.855183+00:00",
        "quantity": 3,
        "product_id": "37d01889-b864-4e9c-b346-9c1f9a633535",
        "employee_id": "1a499e53-75b1-41ea-9b3e-25593c47da69",
        "order_id": "85830d40-0d8a-4863-a648-b2d4cb2eea97"
      },
      "relationships": {}
    },
    {
      "id": "04597cab-17f1-4543-8838-dca1f732f2f3",
      "type": "product_trackers",
      "attributes": {
        "created_at": "2024-11-25T09:25:42.950591+00:00",
        "updated_at": "2024-11-25T09:25:42.950591+00:00",
        "quantity": -2,
        "product_id": "37d01889-b864-4e9c-b346-9c1f9a633535",
        "employee_id": "e5543270-f828-4e68-a14b-000ebf5aa6d5",
        "order_id": "85830d40-0d8a-4863-a648-b2d4cb2eea97"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/product_trackers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,order,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_trackers]=created_at,quantity,product_id`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_id` | **String** <br>`eq`, `not_eq`
`product_group_id` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`employee`


`order` => 
`customer`




`product`





