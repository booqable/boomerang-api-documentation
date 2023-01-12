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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7fd8afd4-a521-4572-b919-cb0f89e7b2b6&filter%5Blocation_id%5D=6ed4354e-1168-4ece-a733-33db08bf6634&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "212b2daf-67c8-5476-859f-e4e8291d360d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fddd5c26-bdf6-4f6b-9614-4d9b0fdd1734",
        "item_id": "7fd8afd4-a521-4572-b919-cb0f89e7b2b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fddd5c26-bdf6-4f6b-9614-4d9b0fdd1734"
          }
        }
      }
    },
    {
      "id": "4379b700-4a52-5701-b587-ca4ff7cca600",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ab93f9b4-e343-43e1-b049-c3c607235044",
        "item_id": "7fd8afd4-a521-4572-b919-cb0f89e7b2b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ab93f9b4-e343-43e1-b049-c3c607235044"
          }
        }
      }
    },
    {
      "id": "48005156-15ef-5d14-92fa-e4177927cf64",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9fb67b23-656c-425b-8eb1-4acee597641e",
        "item_id": "7fd8afd4-a521-4572-b919-cb0f89e7b2b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9fb67b23-656c-425b-8eb1-4acee597641e"
          }
        }
      }
    },
    {
      "id": "ae7308c5-2d43-57dc-ae44-135dd6c4e63f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a47c0bcc-2296-475e-b82b-fa875274a530",
        "item_id": "7fd8afd4-a521-4572-b919-cb0f89e7b2b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a47c0bcc-2296-475e-b82b-fa875274a530"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-12T14:26:09Z`
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





