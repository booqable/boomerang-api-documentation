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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6386dc5c-d9bf-4937-a6b3-f01878cb2f8a&filter%5Blocation_id%5D=5fbb9216-9011-4cda-b980-2d4df0fe9743&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4fdeff7b-8d5c-5488-9bda-f2ef8a926673",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "29a4095f-668c-404d-adc7-e798c957c500",
        "item_id": "6386dc5c-d9bf-4937-a6b3-f01878cb2f8a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/29a4095f-668c-404d-adc7-e798c957c500"
          }
        }
      }
    },
    {
      "id": "967ba7d3-cb55-5dce-a2fc-63d78e114893",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8d51c8ef-a828-4c5f-8428-d59c6bd4cdc0",
        "item_id": "6386dc5c-d9bf-4937-a6b3-f01878cb2f8a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8d51c8ef-a828-4c5f-8428-d59c6bd4cdc0"
          }
        }
      }
    },
    {
      "id": "3422eeff-8eeb-51f9-b0bf-67bb348f74ce",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fc8a7ef2-a21a-4cdb-b5ac-e62dbf7937f2",
        "item_id": "6386dc5c-d9bf-4937-a6b3-f01878cb2f8a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fc8a7ef2-a21a-4cdb-b5ac-e62dbf7937f2"
          }
        }
      }
    },
    {
      "id": "c68e527e-aafe-59f1-991c-2c5d657a0515",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0eb9a972-7c95-46bd-8bd5-62534b6de383",
        "item_id": "6386dc5c-d9bf-4937-a6b3-f01878cb2f8a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0eb9a972-7c95-46bd-8bd5-62534b6de383"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:15:47Z`
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





