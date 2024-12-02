# Stock item trackers

StockItemTrackers describe the history of pickups and returns of a StockItem.

Check the associated ProductTracker for additional information
about product, order, etc.

## Fields
Every stock item tracker has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`quantity` | **Integer** `readonly`<br>Either 1 (pickup) or -1 (return). 
`product_tracker_id` | **Uuid** `readonly`<br>The associated product tracker. 
`stock_item_id` | **Uuid** `readonly`<br>Associated Stock item


## Relationships
Stock item trackers have the following relationships:

Name | Description
-- | --
`product_tracker` | **[Product tracker](#product-trackers)** <br>Associated Product tracker
`stock_item` | **[Stock item](#stock-items)** <br>Associated Stock item


## Listing stock item trackers



> How to fetch StockItemTrackers for a ProductGroup:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_trackers?filter%5Bproduct_group_id%5D%5B%5D=3333235d-47f3-4921-8fe2-e19d462d1638&include=stock_item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e4ce6a92-a483-46d2-8618-16b6d16684a8",
      "type": "stock_item_trackers",
      "attributes": {
        "created_at": "2024-12-02T09:23:58.621843+00:00",
        "updated_at": "2024-12-02T09:23:58.621843+00:00",
        "quantity": 1,
        "product_tracker_id": "4f89b121-3d5f-4d5b-82b9-870ec136f1b0",
        "stock_item_id": "1434446e-0634-402d-9851-7210d640916b"
      },
      "relationships": {
        "stock_item": {
          "data": {
            "type": "stock_items",
            "id": "1434446e-0634-402d-9851-7210d640916b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1434446e-0634-402d-9851-7210d640916b",
      "type": "stock_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:58.523019+00:00",
        "updated_at": "2024-12-02T09:23:58.523019+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000052",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "3333235d-47f3-4921-8fe2-e19d462d1638",
        "properties": {},
        "product_id": "464da61c-7e8a-42e4-9c48-444db449322b",
        "location_id": "430ae865-a78a-46af-b780-2a3aeacfe42e"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_item_trackers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product_tracker,stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_trackers]=created_at,quantity,product_tracker_id`
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

`product_tracker` => 
`employee`


`order` => 
`customer`




`product`




`stock_item`





