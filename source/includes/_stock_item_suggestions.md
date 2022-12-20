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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bda8d258-73d1-40c9-81fb-ff1bd8ca065b&filter%5Blocation_id%5D=15517bd0-7f95-4399-87a0-0b5455a99a8c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "06146a72-260f-55c8-9b08-85002df8d857",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b328885a-d998-4f73-a1ad-0472b64fbb91",
        "item_id": "bda8d258-73d1-40c9-81fb-ff1bd8ca065b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b328885a-d998-4f73-a1ad-0472b64fbb91"
          }
        }
      }
    },
    {
      "id": "9f1f7dba-9c78-5833-88d4-fb6108deacbb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fc38cd96-49db-4c93-b6e9-3453fd208b33",
        "item_id": "bda8d258-73d1-40c9-81fb-ff1bd8ca065b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fc38cd96-49db-4c93-b6e9-3453fd208b33"
          }
        }
      }
    },
    {
      "id": "84bd1c47-2836-5a67-a718-28811c22390d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "631f431c-4cdc-428b-b168-f74c6f3437aa",
        "item_id": "bda8d258-73d1-40c9-81fb-ff1bd8ca065b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/631f431c-4cdc-428b-b168-f74c6f3437aa"
          }
        }
      }
    },
    {
      "id": "152278c1-cdb8-5d15-9b1a-af918234f0df",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5649e99c-7379-4ce4-9e19-f2cd3d3e7a74",
        "item_id": "bda8d258-73d1-40c9-81fb-ff1bd8ca065b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5649e99c-7379-4ce4-9e19-f2cd3d3e7a74"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-20T14:47:46Z`
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





