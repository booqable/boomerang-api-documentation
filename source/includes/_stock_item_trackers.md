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
`product_tracker` | **Product trackers** `readonly`<br>Associated Product tracker
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item trackers



> How to fetch StockItemTrackers for a ProductGroup:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_trackers?filter%5Bproduct_group_id%5D%5B%5D=f89f229b-3dfe-4ea3-a66a-e21fc26c9d68&include=stock_item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8a7f1c09-21f8-48ad-9e8c-89aa21502ecc",
      "type": "stock_item_trackers",
      "attributes": {
        "created_at": "2024-11-25T09:30:26.136002+00:00",
        "updated_at": "2024-11-25T09:30:26.136002+00:00",
        "quantity": 1,
        "product_tracker_id": "9697ccea-a1b0-49fe-97a6-f98f860571dd",
        "stock_item_id": "c93d812a-f032-4762-b8cf-1b0c7c665c19"
      },
      "relationships": {
        "stock_item": {
          "data": {
            "type": "stock_items",
            "id": "c93d812a-f032-4762-b8cf-1b0c7c665c19"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c93d812a-f032-4762-b8cf-1b0c7c665c19",
      "type": "stock_items",
      "attributes": {
        "created_at": "2024-11-25T09:30:26.032635+00:00",
        "updated_at": "2024-11-25T09:30:26.032635+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000152",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "f89f229b-3dfe-4ea3-a66a-e21fc26c9d68",
        "properties": {},
        "product_id": "1ceaafc1-6b38-47d5-96d1-140aabf5a99a",
        "location_id": "19c33502-714b-4db4-8881-2d8f5d539400"
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





