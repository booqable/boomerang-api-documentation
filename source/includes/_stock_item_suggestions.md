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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=cd5f1bd8-f901-4992-aa43-8867aac7c31f&filter%5Blocation_id%5D=e8f3cedb-6e70-4650-a7fc-ac6bb287f52d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "66682970-8f28-5dfe-9ef6-20012549c51c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e75d630b-3843-40b7-9acf-d741f14ab628",
        "item_id": "cd5f1bd8-f901-4992-aa43-8867aac7c31f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e75d630b-3843-40b7-9acf-d741f14ab628"
          }
        }
      }
    },
    {
      "id": "5c3ee83c-5f1a-54b2-b203-93ea947a85ac",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1cd8cfa0-8022-4ead-b4b6-3f061f8721fe",
        "item_id": "cd5f1bd8-f901-4992-aa43-8867aac7c31f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1cd8cfa0-8022-4ead-b4b6-3f061f8721fe"
          }
        }
      }
    },
    {
      "id": "9fdc341c-aced-5444-b7d6-dbef8da3107c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d67f1c4f-e5db-4ccb-a396-26873f026346",
        "item_id": "cd5f1bd8-f901-4992-aa43-8867aac7c31f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d67f1c4f-e5db-4ccb-a396-26873f026346"
          }
        }
      }
    },
    {
      "id": "2464b174-7069-5140-9d26-ad4924c96b6b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9e2a3273-450b-4bda-8f8b-1579b929befb",
        "item_id": "cd5f1bd8-f901-4992-aa43-8867aac7c31f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9e2a3273-450b-4bda-8f8b-1579b929befb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-06T15:12:23Z`
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





