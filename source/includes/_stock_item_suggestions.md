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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d98b23f7-1223-4381-a6ae-47b580e1dc1a&filter%5Blocation_id%5D=83f0b1bf-fac3-41a6-ac0f-3f10d8d3d662&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "85a37f0e-7b1d-54e2-b73f-69e84e8d54c1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "27f46428-ada9-478c-9fb4-faf12fe964f5",
        "item_id": "d98b23f7-1223-4381-a6ae-47b580e1dc1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/27f46428-ada9-478c-9fb4-faf12fe964f5"
          }
        }
      }
    },
    {
      "id": "6d7d6a95-09da-5725-925f-11ca7ac426ad",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1650e3a6-c523-4faa-b481-f24e001a9438",
        "item_id": "d98b23f7-1223-4381-a6ae-47b580e1dc1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1650e3a6-c523-4faa-b481-f24e001a9438"
          }
        }
      }
    },
    {
      "id": "a5dbd4e7-03ec-5422-a50a-3ff1b6452515",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "87a0c929-5a17-43b2-a94a-94640edf45b3",
        "item_id": "d98b23f7-1223-4381-a6ae-47b580e1dc1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/87a0c929-5a17-43b2-a94a-94640edf45b3"
          }
        }
      }
    },
    {
      "id": "98211554-77c9-5112-84ff-2b2a550295c8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bc1e8ec3-dab7-4132-a697-b35c5b14510e",
        "item_id": "d98b23f7-1223-4381-a6ae-47b580e1dc1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bc1e8ec3-dab7-4132-a697-b35c5b14510e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:34:00Z`
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





