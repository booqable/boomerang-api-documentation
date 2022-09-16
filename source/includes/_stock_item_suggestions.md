# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=5edc8df2-0350-4201-aa12-e1d4adff3024&filter%5Blocation_id%5D=3ab1f967-5a81-41d4-accd-f295296313f2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "875e24bf-c7d1-549b-b736-7ec2365be558",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ab1ae3c2-bebc-47b5-963a-9c8c3e2a42fa",
        "item_id": "5edc8df2-0350-4201-aa12-e1d4adff3024",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ab1ae3c2-bebc-47b5-963a-9c8c3e2a42fa"
          }
        }
      }
    },
    {
      "id": "f8ce4bbc-b834-537a-a285-3fe144dfeea4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bcbc2ac0-ec07-4bb7-8c0e-b3a3f08e2383",
        "item_id": "5edc8df2-0350-4201-aa12-e1d4adff3024",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bcbc2ac0-ec07-4bb7-8c0e-b3a3f08e2383"
          }
        }
      }
    },
    {
      "id": "0f8c4174-f56c-5f52-ae75-b3e14456a94e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5a6998d9-c80e-4918-9f57-7af8c24f4c02",
        "item_id": "5edc8df2-0350-4201-aa12-e1d4adff3024",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5a6998d9-c80e-4918-9f57-7af8c24f4c02"
          }
        }
      }
    },
    {
      "id": "dc497199-bfe6-57a7-9a33-7ddf5cd4c87d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1c761c51-3c76-41dc-a9b5-c3b823eec902",
        "item_id": "5edc8df2-0350-4201-aa12-e1d4adff3024",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1c761c51-3c76-41dc-a9b5-c3b823eec902"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T09:00:39Z`
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





