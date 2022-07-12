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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=64cb6a1d-1986-4b9d-8450-d4c4472789ac&filter%5Blocation_id%5D=e83834f8-bfb5-42b9-9ae5-fe4360283351&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f0026d24-9550-566c-8c4e-a2b80e2a7a59",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8bc32bb2-0685-4424-b3a1-f10cf135dc24",
        "item_id": "64cb6a1d-1986-4b9d-8450-d4c4472789ac",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8bc32bb2-0685-4424-b3a1-f10cf135dc24"
          }
        }
      }
    },
    {
      "id": "9e57386a-0b45-503b-b6a8-1e35f111af8a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5a55d8df-7d01-41f3-90b9-3d7fc5984aea",
        "item_id": "64cb6a1d-1986-4b9d-8450-d4c4472789ac",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5a55d8df-7d01-41f3-90b9-3d7fc5984aea"
          }
        }
      }
    },
    {
      "id": "9f185bb0-4747-5e69-b2b9-6b243967bca8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "14d0e3ae-ddf6-4f8e-ac2d-102b681ffd0d",
        "item_id": "64cb6a1d-1986-4b9d-8450-d4c4472789ac",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/14d0e3ae-ddf6-4f8e-ac2d-102b681ffd0d"
          }
        }
      }
    },
    {
      "id": "c983657c-729e-5058-8ae4-52252a2885da",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2904a99c-df02-42a6-8bdd-8e1eede164f1",
        "item_id": "64cb6a1d-1986-4b9d-8450-d4c4472789ac",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2904a99c-df02-42a6-8bdd-8e1eede164f1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T08:46:40Z`
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





