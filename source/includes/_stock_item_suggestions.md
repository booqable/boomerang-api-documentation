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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=5ca69895-93f6-4d55-875e-2f6d933758b7&filter%5Blocation_id%5D=553cca5c-b43e-4ac2-bbc5-ba02d7314f87&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cc90db99-b3d6-526d-8aff-086f00d94492",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e3f3c3b6-44aa-4dcb-88a2-40d827191d19",
        "item_id": "5ca69895-93f6-4d55-875e-2f6d933758b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e3f3c3b6-44aa-4dcb-88a2-40d827191d19"
          }
        }
      }
    },
    {
      "id": "902fa116-0e2b-5ec7-a649-3ad80c8f4fde",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5db01f3a-5540-4813-a1ae-b87ece1b126a",
        "item_id": "5ca69895-93f6-4d55-875e-2f6d933758b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5db01f3a-5540-4813-a1ae-b87ece1b126a"
          }
        }
      }
    },
    {
      "id": "351fce9d-84aa-5d5e-a262-bb67a46f8f8a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d4390c78-d397-479c-a891-b832dc8780bb",
        "item_id": "5ca69895-93f6-4d55-875e-2f6d933758b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d4390c78-d397-479c-a891-b832dc8780bb"
          }
        }
      }
    },
    {
      "id": "75f72f31-5d16-5bcb-abee-6102fb46f2d8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3697a940-3547-4d9e-8185-2bea2028d274",
        "item_id": "5ca69895-93f6-4d55-875e-2f6d933758b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3697a940-3547-4d9e-8185-2bea2028d274"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:40:56Z`
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





