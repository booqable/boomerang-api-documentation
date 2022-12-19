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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7845b826-ea9c-44f7-b9bb-9bdbaa5b0dbc&filter%5Blocation_id%5D=792eb5da-f80f-490c-9534-9e5b438c0541&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1942bae1-4382-50c3-bfd2-e9037031b57c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a996a6d1-5854-4d64-9de7-c274f1c6318d",
        "item_id": "7845b826-ea9c-44f7-b9bb-9bdbaa5b0dbc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a996a6d1-5854-4d64-9de7-c274f1c6318d"
          }
        }
      }
    },
    {
      "id": "e4b7cff1-994f-5157-8c4d-816f94ac683f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e7df89af-7891-4546-8bc0-c8eca7ee0d43",
        "item_id": "7845b826-ea9c-44f7-b9bb-9bdbaa5b0dbc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e7df89af-7891-4546-8bc0-c8eca7ee0d43"
          }
        }
      }
    },
    {
      "id": "d71707b3-346d-50e6-aafe-cf2ee12361d3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a5f3da32-2631-4a8d-bac7-7cb7270c9c77",
        "item_id": "7845b826-ea9c-44f7-b9bb-9bdbaa5b0dbc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a5f3da32-2631-4a8d-bac7-7cb7270c9c77"
          }
        }
      }
    },
    {
      "id": "7a4126bb-590e-5b76-8213-c26b633ebc8c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "671f8952-e1bf-4cfb-98a8-621b0aab14e5",
        "item_id": "7845b826-ea9c-44f7-b9bb-9bdbaa5b0dbc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/671f8952-e1bf-4cfb-98a8-621b0aab14e5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-19T08:45:39Z`
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





