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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f3aed647-17b2-4a25-9886-18458dcae218&filter%5Blocation_id%5D=e86aeed3-393b-44d4-af7b-9f0caf1c26d0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3800aa2b-cb02-5dac-b516-efbc82626a97",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1c7901b6-77c1-4763-94c4-17d954564dea",
        "item_id": "f3aed647-17b2-4a25-9886-18458dcae218",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1c7901b6-77c1-4763-94c4-17d954564dea"
          }
        }
      }
    },
    {
      "id": "cc4acad2-6a9e-581a-9864-1aec2644ece0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f8d21345-cf81-471e-920c-82ee30939fac",
        "item_id": "f3aed647-17b2-4a25-9886-18458dcae218",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f8d21345-cf81-471e-920c-82ee30939fac"
          }
        }
      }
    },
    {
      "id": "d228326d-e465-5987-a9c4-50d998509a3f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a8864d62-1ee0-4cdf-9aae-040c8bcb9c06",
        "item_id": "f3aed647-17b2-4a25-9886-18458dcae218",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a8864d62-1ee0-4cdf-9aae-040c8bcb9c06"
          }
        }
      }
    },
    {
      "id": "f9ef768c-d6c6-5a08-b398-9516559db438",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "785a7ab0-74df-42f6-abd4-8abfe78d404d",
        "item_id": "f3aed647-17b2-4a25-9886-18458dcae218",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/785a7ab0-74df-42f6-abd4-8abfe78d404d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T10:04:07Z`
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





