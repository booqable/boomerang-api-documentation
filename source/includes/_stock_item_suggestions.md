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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=c8643c4a-6823-49f1-80d4-549461540c97&filter%5Blocation_id%5D=198091f5-0bd3-49e7-ac11-eb14b75ca756&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "725d07c5-400d-52a0-a5e6-b18cf0ff6647",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fb9de17d-3421-48af-b361-1fb2011b7a2a",
        "item_id": "c8643c4a-6823-49f1-80d4-549461540c97",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fb9de17d-3421-48af-b361-1fb2011b7a2a"
          }
        }
      }
    },
    {
      "id": "92249513-332a-5827-ac44-d5296fdc3302",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9c3ffca8-0b3e-4d4b-a5c6-c7f675d15bdf",
        "item_id": "c8643c4a-6823-49f1-80d4-549461540c97",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9c3ffca8-0b3e-4d4b-a5c6-c7f675d15bdf"
          }
        }
      }
    },
    {
      "id": "35d2deac-2eca-57c5-bd24-22215460c38e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f60d9a84-4d09-4e08-b2a6-2b3ce1e242a1",
        "item_id": "c8643c4a-6823-49f1-80d4-549461540c97",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f60d9a84-4d09-4e08-b2a6-2b3ce1e242a1"
          }
        }
      }
    },
    {
      "id": "accff1b4-b629-5b00-81b4-f760ae3213d9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a1690348-4cd2-4ca0-b9ee-38fd05fb0340",
        "item_id": "c8643c4a-6823-49f1-80d4-549461540c97",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a1690348-4cd2-4ca0-b9ee-38fd05fb0340"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-21T09:04:21Z`
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





