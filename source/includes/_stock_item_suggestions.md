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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1a92f62e-4710-4709-b60e-252cd3c8eb6f&filter%5Blocation_id%5D=ce075540-c797-4ec2-ab89-124f8da484c2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5dca1a09-2304-5c46-81a1-b128b7880bd0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9656dc2c-249b-4b1c-81c4-87860e20fa05",
        "item_id": "1a92f62e-4710-4709-b60e-252cd3c8eb6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9656dc2c-249b-4b1c-81c4-87860e20fa05"
          }
        }
      }
    },
    {
      "id": "1c37a6be-07ed-5479-bc43-c8f110202008",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "66490ffc-df90-4020-b15f-16a1ccc7eaf0",
        "item_id": "1a92f62e-4710-4709-b60e-252cd3c8eb6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/66490ffc-df90-4020-b15f-16a1ccc7eaf0"
          }
        }
      }
    },
    {
      "id": "b2872941-7624-5402-b2bb-6300da2d0da4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c1134af0-9664-4e0b-93b4-1abc2508501b",
        "item_id": "1a92f62e-4710-4709-b60e-252cd3c8eb6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c1134af0-9664-4e0b-93b4-1abc2508501b"
          }
        }
      }
    },
    {
      "id": "ddddbd02-cf23-514d-a7ac-2c5e9f61dfbf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5eb7f490-7589-4d1e-aa95-bc8b5ac3d9e3",
        "item_id": "1a92f62e-4710-4709-b60e-252cd3c8eb6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5eb7f490-7589-4d1e-aa95-bc8b5ac3d9e3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:13:30Z`
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





