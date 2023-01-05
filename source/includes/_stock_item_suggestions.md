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
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4229fffe-5bd2-46fa-ab18-c3d3d7179c2a&filter%5Blocation_id%5D=31308dae-e8db-4ad1-8a63-03ea8740de86&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a1011a6e-e4f8-5b78-af29-e5bbd9f02dc5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "de0f06f6-0ceb-48da-b22e-2a18289f4e4a",
        "item_id": "4229fffe-5bd2-46fa-ab18-c3d3d7179c2a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/de0f06f6-0ceb-48da-b22e-2a18289f4e4a"
          }
        }
      }
    },
    {
      "id": "833abc73-92e3-5254-91d8-737501df0819",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ef05565f-006f-4c66-a783-9a8318163bc9",
        "item_id": "4229fffe-5bd2-46fa-ab18-c3d3d7179c2a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ef05565f-006f-4c66-a783-9a8318163bc9"
          }
        }
      }
    },
    {
      "id": "a3c72db0-0102-5de3-88e8-f17d63f7b8f8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e4d30d74-c672-4c3a-ad3f-da2cbfe1c802",
        "item_id": "4229fffe-5bd2-46fa-ab18-c3d3d7179c2a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e4d30d74-c672-4c3a-ad3f-da2cbfe1c802"
          }
        }
      }
    },
    {
      "id": "def50937-51df-5c15-ba3a-302e180269db",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3edea55e-d747-4541-8ac6-095bf6868176",
        "item_id": "4229fffe-5bd2-46fa-ab18-c3d3d7179c2a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3edea55e-d747-4541-8ac6-095bf6868176"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:07:32Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`action` | **String_enum** <br>`eq`
`q` | **String** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





