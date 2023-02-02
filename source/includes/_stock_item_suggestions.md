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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=92aa1d1d-c0c9-4352-9e29-fb0a60ec364b&filter%5Blocation_id%5D=ad4d5074-a697-4406-9066-7fa2e3f3baab&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ab8cf56e-f5f1-57a6-ad77-f09d062a73b0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a3fa8b76-fbd2-492e-b5b0-9969640d0dcd",
        "item_id": "92aa1d1d-c0c9-4352-9e29-fb0a60ec364b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a3fa8b76-fbd2-492e-b5b0-9969640d0dcd"
          }
        }
      }
    },
    {
      "id": "f70f9bc8-2b19-5a97-bf20-cafc4e79580b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "78a1a10e-5d0a-4380-8a3f-fa331d15d8f3",
        "item_id": "92aa1d1d-c0c9-4352-9e29-fb0a60ec364b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/78a1a10e-5d0a-4380-8a3f-fa331d15d8f3"
          }
        }
      }
    },
    {
      "id": "502df85a-771c-5ebd-b904-5725a58e61ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5026346c-b410-4d24-88d6-d02b98060b21",
        "item_id": "92aa1d1d-c0c9-4352-9e29-fb0a60ec364b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5026346c-b410-4d24-88d6-d02b98060b21"
          }
        }
      }
    },
    {
      "id": "fafc7f36-3383-5dc4-a0ec-2dae3537dabf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fd7a3baf-46c7-47e9-a310-f4a00a23fccd",
        "item_id": "92aa1d1d-c0c9-4352-9e29-fb0a60ec364b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fd7a3baf-46c7-47e9-a310-f4a00a23fccd"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T19:24:49Z`
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





