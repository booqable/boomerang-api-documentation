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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=137bfa34-215e-42bf-acda-4a6bafe65069&filter%5Blocation_id%5D=ef470a5b-f110-4480-8199-9299db3277e4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "94f0c400-7d0d-5f0c-95f4-f50fa8d926de",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "364b1cc0-5e7f-4be8-a51e-8712ece95856",
        "item_id": "137bfa34-215e-42bf-acda-4a6bafe65069",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/364b1cc0-5e7f-4be8-a51e-8712ece95856"
          }
        }
      }
    },
    {
      "id": "aaa0b5fa-5ab4-579f-92ee-479de9d8abfa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "601a0f04-f169-429c-8dc8-36a64262a1b9",
        "item_id": "137bfa34-215e-42bf-acda-4a6bafe65069",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/601a0f04-f169-429c-8dc8-36a64262a1b9"
          }
        }
      }
    },
    {
      "id": "71c9a435-08a8-57e0-abe8-f14593d0021c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aade343d-4700-46a4-9eaa-d28d0980ca9a",
        "item_id": "137bfa34-215e-42bf-acda-4a6bafe65069",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aade343d-4700-46a4-9eaa-d28d0980ca9a"
          }
        }
      }
    },
    {
      "id": "f3def6e8-9341-5984-a6a3-95eef426b8f6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "37bffd4c-b699-4b4a-9372-bd1fd57c4e01",
        "item_id": "137bfa34-215e-42bf-acda-4a6bafe65069",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/37bffd4c-b699-4b4a-9372-bd1fd57c4e01"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:21Z`
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





