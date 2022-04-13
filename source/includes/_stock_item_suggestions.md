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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=25f13977-7b90-4050-8e50-7f653c2aeaf7&filter%5Blocation_id%5D=adfa00d5-b88a-4209-aac4-b368bb4490d0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "14be5809-3543-58b6-9dbc-43a9d9c97145",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2509eb2b-9550-4c07-9d19-ec68c9895b8a",
        "item_id": "25f13977-7b90-4050-8e50-7f653c2aeaf7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2509eb2b-9550-4c07-9d19-ec68c9895b8a"
          }
        }
      }
    },
    {
      "id": "e3024cbd-7193-5354-bafe-38694f4dcf11",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b30ff4cb-a9f4-4b7a-82f8-28c3249e9500",
        "item_id": "25f13977-7b90-4050-8e50-7f653c2aeaf7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b30ff4cb-a9f4-4b7a-82f8-28c3249e9500"
          }
        }
      }
    },
    {
      "id": "fb2ad4c2-262e-57ad-8363-43eefe089d15",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e52479b2-7bc7-49b3-993b-76e079311127",
        "item_id": "25f13977-7b90-4050-8e50-7f653c2aeaf7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e52479b2-7bc7-49b3-993b-76e079311127"
          }
        }
      }
    },
    {
      "id": "b8523ccf-b7db-52d4-bb65-2250f4e59192",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "58b60869-2076-4fdd-83b7-bffd31ec7548",
        "item_id": "25f13977-7b90-4050-8e50-7f653c2aeaf7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/58b60869-2076-4fdd-83b7-bffd31ec7548"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T09:08:04Z`
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





