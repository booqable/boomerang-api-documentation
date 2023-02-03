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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=edbe4d65-88ed-4994-bd60-f7bd8ed1973a&filter%5Blocation_id%5D=d60bb0ca-7ec1-49bb-8dae-db506d896bd1&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eb78cc02-739a-577b-9834-dad1a2a2b215",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a3d2be62-f258-45d5-a7d4-2cd2d18383b6",
        "item_id": "edbe4d65-88ed-4994-bd60-f7bd8ed1973a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a3d2be62-f258-45d5-a7d4-2cd2d18383b6"
          }
        }
      }
    },
    {
      "id": "0232c490-f29c-5049-8b2a-a17978a7d169",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "27c37e44-62f6-4d6c-9b7e-d4dbaea8bd13",
        "item_id": "edbe4d65-88ed-4994-bd60-f7bd8ed1973a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/27c37e44-62f6-4d6c-9b7e-d4dbaea8bd13"
          }
        }
      }
    },
    {
      "id": "cb9e85f6-27e0-5f68-9ada-51b0fb328940",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "16014e97-56d8-468f-b43b-35dfb97bc440",
        "item_id": "edbe4d65-88ed-4994-bd60-f7bd8ed1973a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/16014e97-56d8-468f-b43b-35dfb97bc440"
          }
        }
      }
    },
    {
      "id": "1e4bf3f0-18b4-5f82-a130-b6f1332e622d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6f490519-3df6-43e4-b8e0-6153142d3e98",
        "item_id": "edbe4d65-88ed-4994-bd60-f7bd8ed1973a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6f490519-3df6-43e4-b8e0-6153142d3e98"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:08:37Z`
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





