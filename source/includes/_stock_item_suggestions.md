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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9b2b36bd-53f3-475a-8c49-9a1f4cf7486d&filter%5Blocation_id%5D=b848e5f5-0caa-412f-bd8e-d289d4df9007&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a6a9bd6b-fe5e-5e7e-96ad-9640081a7b90",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dca49b52-16a0-4d18-8b45-eaaed8b9f677",
        "item_id": "9b2b36bd-53f3-475a-8c49-9a1f4cf7486d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dca49b52-16a0-4d18-8b45-eaaed8b9f677"
          }
        }
      }
    },
    {
      "id": "9cd58deb-f7e3-58a8-8b29-884f995020fa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c0bebffb-7ec4-4e5a-997b-749cb8cdc1df",
        "item_id": "9b2b36bd-53f3-475a-8c49-9a1f4cf7486d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c0bebffb-7ec4-4e5a-997b-749cb8cdc1df"
          }
        }
      }
    },
    {
      "id": "8ad0ee23-77ea-5c55-bf8c-e9c4d30f4c07",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "815ea399-39bd-49ad-9497-ca4e51df9056",
        "item_id": "9b2b36bd-53f3-475a-8c49-9a1f4cf7486d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/815ea399-39bd-49ad-9497-ca4e51df9056"
          }
        }
      }
    },
    {
      "id": "88046aeb-cf37-52d5-b867-bde950e9580b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c30f4de0-890d-4f76-8209-7959905de3c7",
        "item_id": "9b2b36bd-53f3-475a-8c49-9a1f4cf7486d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c30f4de0-890d-4f76-8209-7959905de3c7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-27T06:41:48Z`
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





