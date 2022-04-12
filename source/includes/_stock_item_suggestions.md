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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=22947d2d-5f5a-4576-9dcb-68411274760c&filter%5Blocation_id%5D=dbcf28d8-3b8a-4f20-9b70-b059a09b600d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "40aa1a94-5d51-58de-b1a2-def54933a834",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "43efcb50-82bd-4fa5-80d0-ab37494fbae1",
        "item_id": "22947d2d-5f5a-4576-9dcb-68411274760c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/43efcb50-82bd-4fa5-80d0-ab37494fbae1"
          }
        }
      }
    },
    {
      "id": "0ed9f9a4-2b66-5e5f-87e1-99b31dd4d59c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "acce63cd-3d43-4501-8de7-e1bbddd840d9",
        "item_id": "22947d2d-5f5a-4576-9dcb-68411274760c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/acce63cd-3d43-4501-8de7-e1bbddd840d9"
          }
        }
      }
    },
    {
      "id": "c23aff7d-6d18-5e59-bc77-76d78943ce3d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "98f5c4f3-598f-4a59-9721-7f7d5b893800",
        "item_id": "22947d2d-5f5a-4576-9dcb-68411274760c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/98f5c4f3-598f-4a59-9721-7f7d5b893800"
          }
        }
      }
    },
    {
      "id": "6aad5c8f-ac1f-5a05-94bc-b8bd458b6375",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "80c99507-6404-4f73-b993-40fe0ae9c712",
        "item_id": "22947d2d-5f5a-4576-9dcb-68411274760c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/80c99507-6404-4f73-b993-40fe0ae9c712"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-12T18:24:25Z`
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





