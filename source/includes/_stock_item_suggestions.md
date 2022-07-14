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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=ae1beb98-766e-4dc2-9231-b369dd8258ba&filter%5Blocation_id%5D=19507046-706e-40fe-b8a4-c1e4e9508bb3&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1ae9be09-890a-580f-b150-cd5b6c97f61a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d5fec72b-b393-4313-b608-c520d30a8973",
        "item_id": "ae1beb98-766e-4dc2-9231-b369dd8258ba",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d5fec72b-b393-4313-b608-c520d30a8973"
          }
        }
      }
    },
    {
      "id": "c1ef004c-9f82-5834-8806-5bf07312b6be",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ca3eb5f8-2f7d-4b1d-91c1-90948ff64215",
        "item_id": "ae1beb98-766e-4dc2-9231-b369dd8258ba",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ca3eb5f8-2f7d-4b1d-91c1-90948ff64215"
          }
        }
      }
    },
    {
      "id": "f25edfbd-df63-5234-896b-188650a9be5c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "96662a0d-a2a0-4d95-a4ba-912cd99141b0",
        "item_id": "ae1beb98-766e-4dc2-9231-b369dd8258ba",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/96662a0d-a2a0-4d95-a4ba-912cd99141b0"
          }
        }
      }
    },
    {
      "id": "5c84c062-5c4d-57d2-a479-13b43a27c736",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0043a10c-810b-44fa-a31c-f6a63efae0b6",
        "item_id": "ae1beb98-766e-4dc2-9231-b369dd8258ba",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0043a10c-810b-44fa-a31c-f6a63efae0b6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T21:13:00Z`
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





