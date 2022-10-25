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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d896b23f-6d0c-4531-9cd4-360e9c7250a9&filter%5Blocation_id%5D=6e32ddda-cb8e-4378-8334-5b987aaaf8e8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d26917ee-940d-5f48-8264-8656ff7dbe01",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9216407f-e287-42e2-aab7-e439e5edee2f",
        "item_id": "d896b23f-6d0c-4531-9cd4-360e9c7250a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9216407f-e287-42e2-aab7-e439e5edee2f"
          }
        }
      }
    },
    {
      "id": "6ec1f613-0e3c-5979-9892-6db81d0091a9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d2237bf4-3a50-410f-80c9-7431c8985c49",
        "item_id": "d896b23f-6d0c-4531-9cd4-360e9c7250a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d2237bf4-3a50-410f-80c9-7431c8985c49"
          }
        }
      }
    },
    {
      "id": "9aa87591-ce8d-5f19-89be-e926db3defbf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c8c7576f-5060-4136-a10a-6a2dd77f3b62",
        "item_id": "d896b23f-6d0c-4531-9cd4-360e9c7250a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c8c7576f-5060-4136-a10a-6a2dd77f3b62"
          }
        }
      }
    },
    {
      "id": "982d8a8b-bad9-5bf0-bd26-fd5c47ca2d88",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "44632236-d34f-4c93-8061-2c187c55a81f",
        "item_id": "d896b23f-6d0c-4531-9cd4-360e9c7250a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/44632236-d34f-4c93-8061-2c187c55a81f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T19:08:43Z`
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





