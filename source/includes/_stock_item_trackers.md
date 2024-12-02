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
    --url 'https://example.booqable.com/api/boomerang/stock_item_trackers?filter%5Bproduct_group_id%5D%5B%5D=6519c404-453a-453f-b9f8-9817f4bdf962&include=stock_item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "93d90492-ddc3-430a-8b53-11c0c50395d6",
      "type": "stock_item_trackers",
      "attributes": {
        "created_at": "2024-12-02T13:04:17.863367+00:00",
        "updated_at": "2024-12-02T13:04:17.863367+00:00",
        "quantity": 1,
        "product_tracker_id": "1888f31c-1299-49b9-b5a1-c3dc1e3c2732",
        "stock_item_id": "91d94c6c-e1fb-4b32-99fa-5078cdb5aa99"
      },
      "relationships": {
        "stock_item": {
          "data": {
            "type": "stock_items",
            "id": "91d94c6c-e1fb-4b32-99fa-5078cdb5aa99"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "91d94c6c-e1fb-4b32-99fa-5078cdb5aa99",
      "type": "stock_items",
      "attributes": {
        "created_at": "2024-12-02T13:04:17.776666+00:00",
        "updated_at": "2024-12-02T13:04:17.776666+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000056",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "6519c404-453a-453f-b9f8-9817f4bdf962",
        "properties": {},
        "product_id": "075bb5f0-71a4-4460-acf8-f38ac6c14c2a",
        "location_id": "d708dc14-80ee-4918-9fc3-24934d222dd0"
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





