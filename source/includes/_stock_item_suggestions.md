# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid**<br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the item belonging to the suggested stock item
`status` | **String_enum** `readonly`<br>Status of the suggestion. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=ada3d2b7-7d61-4e99-9627-a0897b649841&filter%5Blocation_id%5D=bcf081aa-39c1-4777-8bcd-605ac3d83c04&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c2e294ec-690e-59ff-8f3b-a9f9f904ed07",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cbcc012c-9abb-42d5-b7c5-d46b52e14654",
        "item_id": "ada3d2b7-7d61-4e99-9627-a0897b649841",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cbcc012c-9abb-42d5-b7c5-d46b52e14654"
          }
        }
      }
    },
    {
      "id": "70d3014f-4e8f-5fae-bb52-fb22d312602c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "942ab367-fcde-4ce4-811f-499120e4e89a",
        "item_id": "ada3d2b7-7d61-4e99-9627-a0897b649841",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/942ab367-fcde-4ce4-811f-499120e4e89a"
          }
        }
      }
    },
    {
      "id": "832c7bc4-23b0-5cc3-8d4e-5a804109a00a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ed497a77-e8b1-4803-ae2a-8c41b7a8c4b3",
        "item_id": "ada3d2b7-7d61-4e99-9627-a0897b649841",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ed497a77-e8b1-4803-ae2a-8c41b7a8c4b3"
          }
        }
      }
    },
    {
      "id": "cbf67f23-fad8-52e7-bc90-b318d9fbd1e5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "36138a3c-167b-49fc-9065-1f431259fadd",
        "item_id": "ada3d2b7-7d61-4e99-9627-a0897b649841",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/36138a3c-167b-49fc-9065-1f431259fadd"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T13:10:10Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum**<br>`eq`
`order_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`action` | **String_enum**<br>`eq`
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`





