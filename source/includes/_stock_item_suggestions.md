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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f35e001a-40b9-43d9-a941-cda81874ea01&filter%5Blocation_id%5D=27b955bc-5af5-4796-94a6-1ff05c18d73c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "19f43a20-d5f1-5fa4-8a66-d6c1bf4cd277",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b523a9a2-6249-4f2d-859a-ada70f18f508",
        "item_id": "f35e001a-40b9-43d9-a941-cda81874ea01",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b523a9a2-6249-4f2d-859a-ada70f18f508"
          }
        }
      }
    },
    {
      "id": "3cdbf896-9d05-5e4b-8b8d-9deaf3b8e5dc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3e9db5ca-08f5-4c06-b9b7-21d1beabf304",
        "item_id": "f35e001a-40b9-43d9-a941-cda81874ea01",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3e9db5ca-08f5-4c06-b9b7-21d1beabf304"
          }
        }
      }
    },
    {
      "id": "11e28d45-c031-513b-a0e2-e0dfd2e7e933",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8bff07f5-dc87-4a80-8fab-64405839e6ce",
        "item_id": "f35e001a-40b9-43d9-a941-cda81874ea01",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8bff07f5-dc87-4a80-8fab-64405839e6ce"
          }
        }
      }
    },
    {
      "id": "3e47cb19-8466-5327-b435-2078252d9a7b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bc837285-3007-49bb-bb94-6c721853073c",
        "item_id": "f35e001a-40b9-43d9-a941-cda81874ea01",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bc837285-3007-49bb-bb94-6c721853073c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-31T14:14:33Z`
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





