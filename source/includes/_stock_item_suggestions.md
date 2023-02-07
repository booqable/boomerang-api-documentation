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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=14581704-3485-41b4-a260-343d96a1d7b8&filter%5Blocation_id%5D=de4b91b4-b109-4d46-957d-a6939e59ee52&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6cafeee6-2810-555c-80d3-8ff5a76b6486",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b20dc8ce-2728-4524-9bf2-26ad5872b40b",
        "item_id": "14581704-3485-41b4-a260-343d96a1d7b8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b20dc8ce-2728-4524-9bf2-26ad5872b40b"
          }
        }
      }
    },
    {
      "id": "e50fe9f5-3de1-5143-bebb-8ce0cdd1940a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cdb831b7-82b4-4f5a-a353-bf4aa5a907c9",
        "item_id": "14581704-3485-41b4-a260-343d96a1d7b8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cdb831b7-82b4-4f5a-a353-bf4aa5a907c9"
          }
        }
      }
    },
    {
      "id": "6ccffba8-4b09-501c-85b9-21541ff76873",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bdb4c372-dfeb-430b-bdd1-3875c6589b4b",
        "item_id": "14581704-3485-41b4-a260-343d96a1d7b8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bdb4c372-dfeb-430b-bdd1-3875c6589b4b"
          }
        }
      }
    },
    {
      "id": "c3983102-c1e6-5db7-a6d6-9f093e33abad",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "80344680-c055-4c7c-9cf7-150d81a2b0fb",
        "item_id": "14581704-3485-41b4-a260-343d96a1d7b8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/80344680-c055-4c7c-9cf7-150d81a2b0fb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:56:31Z`
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





