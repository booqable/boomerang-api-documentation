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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=54ae18a0-8687-421d-9a60-cbe0c94822cc&filter%5Blocation_id%5D=53ef10e9-607c-482c-9cb8-5347c5138a07&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "92310d8c-da15-56ea-bf02-69f98927207d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3cdd0e69-fd66-4207-b4f7-498974dc17be",
        "item_id": "54ae18a0-8687-421d-9a60-cbe0c94822cc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3cdd0e69-fd66-4207-b4f7-498974dc17be"
          }
        }
      }
    },
    {
      "id": "2fbbcca0-39e8-599c-af7e-c5529ff43e0f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7ba396ca-0474-45a4-8f77-3843e369137b",
        "item_id": "54ae18a0-8687-421d-9a60-cbe0c94822cc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7ba396ca-0474-45a4-8f77-3843e369137b"
          }
        }
      }
    },
    {
      "id": "ae7198c0-33e9-5cec-b59d-b4ddce2570ea",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dfb4875e-b0a7-4f19-9106-98c5fd3ae900",
        "item_id": "54ae18a0-8687-421d-9a60-cbe0c94822cc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dfb4875e-b0a7-4f19-9106-98c5fd3ae900"
          }
        }
      }
    },
    {
      "id": "f7fce091-4efd-5eb1-a2af-3c88b94d7780",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "78d618ad-6d5c-4cad-a839-8aeace8f31c7",
        "item_id": "54ae18a0-8687-421d-9a60-cbe0c94822cc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/78d618ad-6d5c-4cad-a839-8aeace8f31c7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T11:08:20Z`
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





