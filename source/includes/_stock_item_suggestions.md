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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=11d3dc2a-abf7-44f8-ac8d-b4d10a2d9d36&filter%5Blocation_id%5D=9dc857a1-83c3-4d3c-8286-e8c54c0ec76b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c3cba33e-2b54-55b0-9d28-3fa1562302b2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4c4dfe20-4138-4771-950e-c3762382468c",
        "item_id": "11d3dc2a-abf7-44f8-ac8d-b4d10a2d9d36",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4c4dfe20-4138-4771-950e-c3762382468c"
          }
        }
      }
    },
    {
      "id": "b22ca2d9-f102-520d-89f6-181b8035b464",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fdbe1482-f454-46cb-8c57-7846a67e58ec",
        "item_id": "11d3dc2a-abf7-44f8-ac8d-b4d10a2d9d36",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fdbe1482-f454-46cb-8c57-7846a67e58ec"
          }
        }
      }
    },
    {
      "id": "16fc498e-6136-5dd3-8a5d-3618f641879f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d9e30a58-afcc-42ee-9f67-51e944c20dc3",
        "item_id": "11d3dc2a-abf7-44f8-ac8d-b4d10a2d9d36",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d9e30a58-afcc-42ee-9f67-51e944c20dc3"
          }
        }
      }
    },
    {
      "id": "02ca3375-8551-5b60-aa56-8a62e3cd8198",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b6ecb280-0a50-4cf0-8cc5-c5d49d06f943",
        "item_id": "11d3dc2a-abf7-44f8-ac8d-b4d10a2d9d36",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b6ecb280-0a50-4cf0-8cc5-c5d49d06f943"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:31:34Z`
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





