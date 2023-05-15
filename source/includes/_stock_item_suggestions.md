# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
-- | --
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> Retrieve stock item suggestions for booking:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Baction%5D=book&filter%5Bitem_id%5D=4552e897-ca4a-46b0-b9ea-393e09c4a291&filter%5Border_id%5D=2af23c65-766f-472a-9ffe-27330f2f3272' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d469b933-2e5f-56fc-9fd7-db8d3ad9b84d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d640a4ad-fd80-4489-b5ba-a26db928d693",
        "item_id": "4552e897-ca4a-46b0-b9ea-393e09c4a291",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d640a4ad-fd80-4489-b5ba-a26db928d693"
          }
        }
      }
    },
    {
      "id": "7ebc4d60-6d7b-5d78-a3fc-4f6bdf92c882",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aa6a8771-83cb-4ca3-bd9b-d8ae1bc5b791",
        "item_id": "4552e897-ca4a-46b0-b9ea-393e09c4a291",
        "status": "unavailable"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aa6a8771-83cb-4ca3-bd9b-d8ae1bc5b791"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_item_suggestions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_suggestions]=stock_item_id,item_id,status`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum** <br>`eq`
`order_id` | **Uuid** `required`<br>`eq`
`action` | **String_enum** `required`<br>`eq`
`q` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





