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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=8bb65111-470c-4523-a146-37ad4da725df&filter%5Blocation_id%5D=aa9e1584-a31a-4a8c-b406-17804cfe5260&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2b2272ab-a652-5105-a4b8-c212bb5218b8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0874f763-6703-4fbe-bd07-9553b8af7182",
        "item_id": "8bb65111-470c-4523-a146-37ad4da725df",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0874f763-6703-4fbe-bd07-9553b8af7182"
          }
        }
      }
    },
    {
      "id": "3b7b45cc-281b-5256-860f-1e5e8492c31b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5d2971f4-b826-457e-908a-5de74e41d318",
        "item_id": "8bb65111-470c-4523-a146-37ad4da725df",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5d2971f4-b826-457e-908a-5de74e41d318"
          }
        }
      }
    },
    {
      "id": "9288c923-62f4-50d9-9e36-c1a03340d454",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1240dd5a-1986-4e56-9ccb-ec414ca352ce",
        "item_id": "8bb65111-470c-4523-a146-37ad4da725df",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1240dd5a-1986-4e56-9ccb-ec414ca352ce"
          }
        }
      }
    },
    {
      "id": "98016022-cfe4-538c-878b-6cc5c14a0912",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6cf9fd6b-e210-4a2c-b765-5da190c0d605",
        "item_id": "8bb65111-470c-4523-a146-37ad4da725df",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6cf9fd6b-e210-4a2c-b765-5da190c0d605"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:40:43Z`
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





