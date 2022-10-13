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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f4b5d62c-a26f-4b2a-aa00-d250b72e4ddc&filter%5Blocation_id%5D=46f1c3d5-fa8f-4a64-bea7-ce26d55e13c5&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7243b09a-41f9-56e7-b852-60215b77975a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "93b6f043-d134-4958-ade7-028e124d7376",
        "item_id": "f4b5d62c-a26f-4b2a-aa00-d250b72e4ddc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/93b6f043-d134-4958-ade7-028e124d7376"
          }
        }
      }
    },
    {
      "id": "ab6bd3a3-2985-5bb5-9f35-73672df8548f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a52d12ef-04a1-4962-af29-cbb99ccdf968",
        "item_id": "f4b5d62c-a26f-4b2a-aa00-d250b72e4ddc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a52d12ef-04a1-4962-af29-cbb99ccdf968"
          }
        }
      }
    },
    {
      "id": "92344637-cd86-541c-b7e6-f11d8338f260",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2591b2c2-7a31-4b9d-a5d1-6aa0ce95eec5",
        "item_id": "f4b5d62c-a26f-4b2a-aa00-d250b72e4ddc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2591b2c2-7a31-4b9d-a5d1-6aa0ce95eec5"
          }
        }
      }
    },
    {
      "id": "9ee9b95c-659d-583a-9dac-a976af83e683",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "377de98a-88f6-49c3-b00a-ec083ba71ccd",
        "item_id": "f4b5d62c-a26f-4b2a-aa00-d250b72e4ddc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/377de98a-88f6-49c3-b00a-ec083ba71ccd"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T14:28:03Z`
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





