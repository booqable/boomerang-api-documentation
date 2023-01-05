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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6cf52e35-19a8-4aac-8ac9-71e8a9174329&filter%5Blocation_id%5D=11c1a334-6e35-4edb-9b01-ce9e77f8f91c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2fbe2b64-84eb-5fc2-b4c3-490d3f316e42",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2b034046-2cc5-4e15-87dd-635a605a29ad",
        "item_id": "6cf52e35-19a8-4aac-8ac9-71e8a9174329",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2b034046-2cc5-4e15-87dd-635a605a29ad"
          }
        }
      }
    },
    {
      "id": "c6e48760-7ce4-5f68-b458-4e47ba221f2e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4f714c33-b93e-4eea-8331-1e970a619df2",
        "item_id": "6cf52e35-19a8-4aac-8ac9-71e8a9174329",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4f714c33-b93e-4eea-8331-1e970a619df2"
          }
        }
      }
    },
    {
      "id": "47c043c9-ee06-5640-a3f9-ffa08c962b03",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0c4c3580-aec9-42b0-a5e4-8746b558b7f0",
        "item_id": "6cf52e35-19a8-4aac-8ac9-71e8a9174329",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0c4c3580-aec9-42b0-a5e4-8746b558b7f0"
          }
        }
      }
    },
    {
      "id": "470e8974-c63f-54fb-b5d0-8c4d1774dfd8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ef555ccd-f48e-48c9-8132-aa5923e6477b",
        "item_id": "6cf52e35-19a8-4aac-8ac9-71e8a9174329",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ef555ccd-f48e-48c9-8132-aa5923e6477b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:09Z`
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





