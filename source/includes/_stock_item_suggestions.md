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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=82ae7fa9-9a98-488c-9641-6fbb2a08ef82&filter%5Blocation_id%5D=a041c811-5052-4fb1-84b8-f08b5ff88ce3&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8948127f-e2dd-5e41-8c41-d13ece888ae6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eeaabbc8-3ebd-4953-8a4c-2fff10019661",
        "item_id": "82ae7fa9-9a98-488c-9641-6fbb2a08ef82",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eeaabbc8-3ebd-4953-8a4c-2fff10019661"
          }
        }
      }
    },
    {
      "id": "c0ce9170-6253-57fa-9ade-6ad99b045c5f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "454b7410-83f6-4e54-a982-470ec1cef483",
        "item_id": "82ae7fa9-9a98-488c-9641-6fbb2a08ef82",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/454b7410-83f6-4e54-a982-470ec1cef483"
          }
        }
      }
    },
    {
      "id": "3fd9c0e6-c8da-5392-968d-292c03a67c5d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5f0c1d73-74e7-4635-8143-d4716e2c773c",
        "item_id": "82ae7fa9-9a98-488c-9641-6fbb2a08ef82",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5f0c1d73-74e7-4635-8143-d4716e2c773c"
          }
        }
      }
    },
    {
      "id": "eca7707a-6c86-56c5-82cd-9d04d951aef5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a850c718-b0a0-45bb-89ed-0e702c058153",
        "item_id": "82ae7fa9-9a98-488c-9641-6fbb2a08ef82",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a850c718-b0a0-45bb-89ed-0e702c058153"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-15T08:04:20Z`
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





