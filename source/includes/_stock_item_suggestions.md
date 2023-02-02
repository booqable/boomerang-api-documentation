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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=68000051-b3c7-4fac-b526-5a4bb4a967e3&filter%5Blocation_id%5D=fdb2c488-4120-4143-ab0c-fa4a67c3a654&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "06ef7418-719f-5426-bf44-849e836dd0cd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f864fdc4-9e7c-4266-be34-30c25e95befc",
        "item_id": "68000051-b3c7-4fac-b526-5a4bb4a967e3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f864fdc4-9e7c-4266-be34-30c25e95befc"
          }
        }
      }
    },
    {
      "id": "97e62cbd-8f77-527b-8aa7-3156c69aec1b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fc875643-0862-45df-acc1-963f43ae7a64",
        "item_id": "68000051-b3c7-4fac-b526-5a4bb4a967e3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fc875643-0862-45df-acc1-963f43ae7a64"
          }
        }
      }
    },
    {
      "id": "239ac779-2149-55e0-b059-c49e5ed8241a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4881f83d-b673-4b1f-86d4-44ac7c06622f",
        "item_id": "68000051-b3c7-4fac-b526-5a4bb4a967e3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4881f83d-b673-4b1f-86d4-44ac7c06622f"
          }
        }
      }
    },
    {
      "id": "9122e68f-d124-5682-bf29-33e9f1a2d28a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "740ed704-2120-4803-a518-0e82c6c26e20",
        "item_id": "68000051-b3c7-4fac-b526-5a4bb4a967e3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/740ed704-2120-4803-a518-0e82c6c26e20"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T11:14:17Z`
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





