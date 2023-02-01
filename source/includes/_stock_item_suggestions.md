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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f929c0c5-fb86-4eba-b900-29ef007c521b&filter%5Blocation_id%5D=1ab2d83c-b9cd-4617-9932-64d85505f5aa&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0860db99-3a69-576c-98d9-495249a94eeb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ee5446ae-a2cd-4abd-bdc3-66fe33b56d4a",
        "item_id": "f929c0c5-fb86-4eba-b900-29ef007c521b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ee5446ae-a2cd-4abd-bdc3-66fe33b56d4a"
          }
        }
      }
    },
    {
      "id": "d71d0a87-1d71-574c-817e-990b6171780f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fbbf6fe8-1535-442b-bdc8-cafa4355750f",
        "item_id": "f929c0c5-fb86-4eba-b900-29ef007c521b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fbbf6fe8-1535-442b-bdc8-cafa4355750f"
          }
        }
      }
    },
    {
      "id": "a6d4c1bf-6e01-5893-b946-c80501572549",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a7a14fc0-4ed4-4659-a6c2-d2719c4884d5",
        "item_id": "f929c0c5-fb86-4eba-b900-29ef007c521b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a7a14fc0-4ed4-4659-a6c2-d2719c4884d5"
          }
        }
      }
    },
    {
      "id": "0d11a115-f9cb-5440-89b1-7d3d1d1a0ddc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3899e436-38e2-4e6b-a8b7-a2ce63729fb5",
        "item_id": "f929c0c5-fb86-4eba-b900-29ef007c521b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3899e436-38e2-4e6b-a8b7-a2ce63729fb5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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





