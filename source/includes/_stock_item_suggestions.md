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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7182ef73-3d7b-4b75-8248-517e1f922faf&filter%5Blocation_id%5D=7a04cb12-784a-45ab-9f7f-f6603c787710&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b8438a73-6ab3-597b-bf5e-0fdc000ce7a4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b9c00745-ef7c-4214-919d-2b575570319e",
        "item_id": "7182ef73-3d7b-4b75-8248-517e1f922faf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b9c00745-ef7c-4214-919d-2b575570319e"
          }
        }
      }
    },
    {
      "id": "f25c34a9-4801-5247-bf22-644faa9ff11f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e0368c16-63db-4394-b1d8-2e4ce35e3bfe",
        "item_id": "7182ef73-3d7b-4b75-8248-517e1f922faf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e0368c16-63db-4394-b1d8-2e4ce35e3bfe"
          }
        }
      }
    },
    {
      "id": "c178591c-1ab5-502a-b964-279344c59a68",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f18c9768-ca0d-4ff6-bcc5-ee9124e700b9",
        "item_id": "7182ef73-3d7b-4b75-8248-517e1f922faf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f18c9768-ca0d-4ff6-bcc5-ee9124e700b9"
          }
        }
      }
    },
    {
      "id": "7c1838a7-5028-5fca-833a-314ece7e8d8c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "076dc520-e874-4877-9e48-fc91e5a6e521",
        "item_id": "7182ef73-3d7b-4b75-8248-517e1f922faf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/076dc520-e874-4877-9e48-fc91e5a6e521"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:27:22Z`
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





