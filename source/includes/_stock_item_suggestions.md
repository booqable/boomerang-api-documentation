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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=033ddb2a-b840-42aa-a571-765834fb6c1c&filter%5Blocation_id%5D=6e0e51bc-5a27-406d-8d4e-d74aa7881567&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8531244-ecd8-52f0-9115-7c3f15050674",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7d28222a-4242-4779-9a2c-6afaed63cf5c",
        "item_id": "033ddb2a-b840-42aa-a571-765834fb6c1c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7d28222a-4242-4779-9a2c-6afaed63cf5c"
          }
        }
      }
    },
    {
      "id": "66616ae6-897f-5f46-832a-85c1f344e57d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "53b5bf5b-e536-4f61-9a78-5bb7faaa4f98",
        "item_id": "033ddb2a-b840-42aa-a571-765834fb6c1c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/53b5bf5b-e536-4f61-9a78-5bb7faaa4f98"
          }
        }
      }
    },
    {
      "id": "0877f4f8-14c0-566a-bb6f-b1c27b2d0577",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "69fdacac-beaf-4c74-a71a-2f73df384f1f",
        "item_id": "033ddb2a-b840-42aa-a571-765834fb6c1c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/69fdacac-beaf-4c74-a71a-2f73df384f1f"
          }
        }
      }
    },
    {
      "id": "13605ae3-d0a8-5226-864f-923d855b0bfe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3158d077-331e-419e-8031-1bd9aacf1743",
        "item_id": "033ddb2a-b840-42aa-a571-765834fb6c1c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3158d077-331e-419e-8031-1bd9aacf1743"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:25Z`
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





