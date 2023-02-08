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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e33facde-6a8c-433a-9944-4dbbfc4778fa&filter%5Blocation_id%5D=d58d3a4c-096b-468a-8fe4-418d6186c07b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4869509-0b70-537d-a574-4d8f5438c1a8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "47606b7d-dfd2-40cd-a0bc-ac42d6e0ea27",
        "item_id": "e33facde-6a8c-433a-9944-4dbbfc4778fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/47606b7d-dfd2-40cd-a0bc-ac42d6e0ea27"
          }
        }
      }
    },
    {
      "id": "425f6c90-c9e2-5da6-8796-5d8a7a75e049",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e060045d-f0e9-4124-b99a-2d94cba49c9e",
        "item_id": "e33facde-6a8c-433a-9944-4dbbfc4778fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e060045d-f0e9-4124-b99a-2d94cba49c9e"
          }
        }
      }
    },
    {
      "id": "3077cad2-4e4c-599c-a4a1-8e56ddc36cf1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b6d9af5a-8407-47f6-907d-cc693007689b",
        "item_id": "e33facde-6a8c-433a-9944-4dbbfc4778fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b6d9af5a-8407-47f6-907d-cc693007689b"
          }
        }
      }
    },
    {
      "id": "5c6f4e56-524b-5688-b599-2e6e0bf48854",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6a03ae41-f439-4109-b1ad-d9c8b117436a",
        "item_id": "e33facde-6a8c-433a-9944-4dbbfc4778fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6a03ae41-f439-4109-b1ad-d9c8b117436a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:34:22Z`
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





