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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9b583f2d-8b8a-4640-8b96-17d69216046e&filter%5Blocation_id%5D=326a6fbe-c198-4b45-9e23-cdb265adf945&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a5e65639-bf55-55bd-a3dc-06c9da84dd22",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "68187243-e780-4193-8797-c8d46ef11c7c",
        "item_id": "9b583f2d-8b8a-4640-8b96-17d69216046e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/68187243-e780-4193-8797-c8d46ef11c7c"
          }
        }
      }
    },
    {
      "id": "9c0f61b4-b2e1-512d-9c1a-f23c685529ca",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "08176b9e-ff4d-4881-a88c-8fb1b12a1c21",
        "item_id": "9b583f2d-8b8a-4640-8b96-17d69216046e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/08176b9e-ff4d-4881-a88c-8fb1b12a1c21"
          }
        }
      }
    },
    {
      "id": "3cba2201-32c9-59ab-955c-8e08ed229126",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "971fcabf-56e1-4256-8039-d6ef4d6250d9",
        "item_id": "9b583f2d-8b8a-4640-8b96-17d69216046e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/971fcabf-56e1-4256-8039-d6ef4d6250d9"
          }
        }
      }
    },
    {
      "id": "1742784e-3e13-50e2-8d80-7ef7fb78cbed",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f945e892-07aa-48e5-9d54-f259d0d4075a",
        "item_id": "9b583f2d-8b8a-4640-8b96-17d69216046e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f945e892-07aa-48e5-9d54-f259d0d4075a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T11:43:24Z`
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





