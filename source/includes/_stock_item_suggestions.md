# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid**<br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the item belonging to the suggested stock item
`status` | **String_enum** `readonly`<br>Status of the suggestion. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=c0ac3d2a-59d2-4d28-b2c5-27881b916122&filter%5Blocation_id%5D=c71de298-b56b-40a6-8be7-dbf1b8a23148&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3bfba381-7920-5db0-a7bb-374b58f69831",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a02c24d8-ce48-4896-8221-66af4efbabcf",
        "item_id": "c0ac3d2a-59d2-4d28-b2c5-27881b916122",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a02c24d8-ce48-4896-8221-66af4efbabcf"
          }
        }
      }
    },
    {
      "id": "a989ad77-2c43-543f-bdeb-fe316247d1fb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "beb8485d-68eb-4dcd-8079-1e70d88dd3a0",
        "item_id": "c0ac3d2a-59d2-4d28-b2c5-27881b916122",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/beb8485d-68eb-4dcd-8079-1e70d88dd3a0"
          }
        }
      }
    },
    {
      "id": "bd81d295-3a1e-5258-9eb1-8b1107ddcd32",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "58512394-4772-4ced-9b45-4151417936ed",
        "item_id": "c0ac3d2a-59d2-4d28-b2c5-27881b916122",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/58512394-4772-4ced-9b45-4151417936ed"
          }
        }
      }
    },
    {
      "id": "73d88b9c-1303-539b-9290-6aed9158aa98",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "37dea654-7ae8-4fd6-a2df-2e19eb30d8e7",
        "item_id": "c0ac3d2a-59d2-4d28-b2c5-27881b916122",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/37dea654-7ae8-4fd6-a2df-2e19eb30d8e7"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:16Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum**<br>`eq`
`order_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`action` | **String_enum**<br>`eq`
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`





