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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=072ce4c8-2867-4fd4-afc6-0ecf3e2e95e7&filter%5Blocation_id%5D=c741dde8-4271-491a-b522-a3763092d702&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f80efbcc-1c0e-5dd6-96b5-7d04382d082d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f9e5d957-b0c4-41e1-aaad-b2a4e286b045",
        "item_id": "072ce4c8-2867-4fd4-afc6-0ecf3e2e95e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f9e5d957-b0c4-41e1-aaad-b2a4e286b045"
          }
        }
      }
    },
    {
      "id": "c341341b-6d3b-51aa-a0da-35e8aa61f2dc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c4b2703a-f0c8-458b-bb99-8846dceb6f52",
        "item_id": "072ce4c8-2867-4fd4-afc6-0ecf3e2e95e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c4b2703a-f0c8-458b-bb99-8846dceb6f52"
          }
        }
      }
    },
    {
      "id": "33a8ed14-9913-58a1-b39a-f12e0b59f487",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "30ed054d-590d-4468-8dbe-bf50ad0c3fe3",
        "item_id": "072ce4c8-2867-4fd4-afc6-0ecf3e2e95e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/30ed054d-590d-4468-8dbe-bf50ad0c3fe3"
          }
        }
      }
    },
    {
      "id": "38be2d6d-ad56-53b0-acb1-9ec28e5b62f2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "607a6134-441a-4c44-b0df-d88f72bba1c1",
        "item_id": "072ce4c8-2867-4fd4-afc6-0ecf3e2e95e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/607a6134-441a-4c44-b0df-d88f72bba1c1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T12:15:33Z`
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





