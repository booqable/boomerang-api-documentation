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
`employee` | **[Employee](#employees)** <br>The employee who handled the pickup/return. 
`order` | **[Order](#orders)** <br>The order the pickup/return was part of. 
`product` | **[Product](#products)** <br>The product that was picked up/returned. 
`stock_item_trackers` | **[Stock item trackers](#stock-item-trackers)** <br>The StockItems that were picked up/returned. 


## Listing product trackers



> How to fetch ProductTrackers for a ProductGroup:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/product_trackers?filter%5Bproduct_group_id%5D%5B%5D=9ef53203-3a6a-48e9-b567-aa6bfc04465d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67bf9923-61ec-4491-94e8-9289614d4209",
      "type": "product_trackers",
      "attributes": {
        "created_at": "2024-12-02T13:01:34.706607+00:00",
        "updated_at": "2024-12-02T13:01:34.706607+00:00",
        "quantity": 3,
        "product_id": "bfcb5ec3-c184-4afd-8188-2994134f30fa",
        "employee_id": "40c42b4b-4f89-4c41-835a-f88535c1934f",
        "order_id": "d68b447a-c4b9-4207-8cd1-22dc8c1db245"
      },
      "relationships": {}
    },
    {
      "id": "50ca7ecd-90d4-4122-b9b6-4513ded00a99",
      "type": "product_trackers",
      "attributes": {
        "created_at": "2024-12-02T13:01:34.780717+00:00",
        "updated_at": "2024-12-02T13:01:34.780717+00:00",
        "quantity": -2,
        "product_id": "bfcb5ec3-c184-4afd-8188-2994134f30fa",
        "employee_id": "1e37f212-b99c-447f-9050-57cc86f6367d",
        "order_id": "d68b447a-c4b9-4207-8cd1-22dc8c1db245"
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





