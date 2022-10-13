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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7e10c8e4-4079-4968-b4c0-5278bc536ce8&filter%5Blocation_id%5D=63fb3a06-ab63-48c8-a301-bfca3120750b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a0ad822b-8928-5d28-b9fa-830d1748b94c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7e19bb0b-d991-4da4-9a4e-bb0e5c6d1661",
        "item_id": "7e10c8e4-4079-4968-b4c0-5278bc536ce8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7e19bb0b-d991-4da4-9a4e-bb0e5c6d1661"
          }
        }
      }
    },
    {
      "id": "8392a278-e5da-57f4-b721-71e3ee376caf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "080b4fd4-42ef-4a10-8bab-3b72d89a4da1",
        "item_id": "7e10c8e4-4079-4968-b4c0-5278bc536ce8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/080b4fd4-42ef-4a10-8bab-3b72d89a4da1"
          }
        }
      }
    },
    {
      "id": "64368640-d50e-5bff-8387-9fbb61b861e3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4893663d-3e81-4133-ba43-d431c64b1c62",
        "item_id": "7e10c8e4-4079-4968-b4c0-5278bc536ce8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4893663d-3e81-4133-ba43-d431c64b1c62"
          }
        }
      }
    },
    {
      "id": "c934bb60-aa5f-5bfc-b74b-eefa1ec0d7c3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3c0f3136-613e-4131-bd69-b061bed1a510",
        "item_id": "7e10c8e4-4079-4968-b4c0-5278bc536ce8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3c0f3136-613e-4131-bd69-b061bed1a510"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T08:55:37Z`
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





