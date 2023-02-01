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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=0861f3d0-f484-4c83-8f2d-f713c71c9814&filter%5Blocation_id%5D=36297f43-1c95-4063-95a3-b0d7e75d726e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "095320f4-1ccf-5cd1-857e-21d5e6356ff0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "16a3fac7-6d8f-49c0-b7e1-5976cd94f234",
        "item_id": "0861f3d0-f484-4c83-8f2d-f713c71c9814",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/16a3fac7-6d8f-49c0-b7e1-5976cd94f234"
          }
        }
      }
    },
    {
      "id": "c8f0552f-7a1a-5b26-ad27-0079a116ecfa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6faec6f7-537a-4276-9eff-5ff0b5ee6bb1",
        "item_id": "0861f3d0-f484-4c83-8f2d-f713c71c9814",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6faec6f7-537a-4276-9eff-5ff0b5ee6bb1"
          }
        }
      }
    },
    {
      "id": "61526de4-73da-54a2-88e1-81362f0998e4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dc1c3443-456c-419f-8130-21fee8dffb86",
        "item_id": "0861f3d0-f484-4c83-8f2d-f713c71c9814",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dc1c3443-456c-419f-8130-21fee8dffb86"
          }
        }
      }
    },
    {
      "id": "bf5e6ed8-6915-56d2-918c-d9d7febb0127",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d8789298-b31f-477a-9918-de23ed1f0b9e",
        "item_id": "0861f3d0-f484-4c83-8f2d-f713c71c9814",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d8789298-b31f-477a-9918-de23ed1f0b9e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:31:18Z`
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





