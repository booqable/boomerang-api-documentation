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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=218f811f-67d2-4ba3-8e63-e1affea090d0&filter%5Blocation_id%5D=32c97e68-6c88-46f0-b441-092108e31062&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c634f714-d14f-559b-85b6-fd9abb2b1897",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "452aba80-8f1e-4c9e-8539-98f12bb4372e",
        "item_id": "218f811f-67d2-4ba3-8e63-e1affea090d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/452aba80-8f1e-4c9e-8539-98f12bb4372e"
          }
        }
      }
    },
    {
      "id": "a2fb0a83-5ef2-54d9-9bf1-7137bc9dd7f1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "43191ae7-69e7-4bc5-b84b-9c8708ab9d01",
        "item_id": "218f811f-67d2-4ba3-8e63-e1affea090d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/43191ae7-69e7-4bc5-b84b-9c8708ab9d01"
          }
        }
      }
    },
    {
      "id": "f7511e93-7910-5b56-a2b0-e5852766162c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "050cd32d-caa9-47f2-9a7f-2538549f407e",
        "item_id": "218f811f-67d2-4ba3-8e63-e1affea090d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/050cd32d-caa9-47f2-9a7f-2538549f407e"
          }
        }
      }
    },
    {
      "id": "77c8f8ef-d51e-5db4-ace0-301956544b00",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c0dd0a6d-65cc-477e-854a-7d6265159df9",
        "item_id": "218f811f-67d2-4ba3-8e63-e1affea090d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c0dd0a6d-65cc-477e-854a-7d6265159df9"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-07T06:50:41Z`
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





