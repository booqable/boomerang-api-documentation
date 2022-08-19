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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=921f44b2-dd0c-4696-ae60-4c4b4d41ae4a&filter%5Blocation_id%5D=24576141-3ed8-48b0-80bf-cae898e1f42b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8df6a66c-bf26-5304-b241-268b94935e72",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2911fb65-a541-494f-8b59-403a4671c31a",
        "item_id": "921f44b2-dd0c-4696-ae60-4c4b4d41ae4a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2911fb65-a541-494f-8b59-403a4671c31a"
          }
        }
      }
    },
    {
      "id": "22d1fe56-89af-5e3c-9a05-762374bb0948",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "434956c3-b43d-43c2-a4ef-ec25e773478c",
        "item_id": "921f44b2-dd0c-4696-ae60-4c4b4d41ae4a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/434956c3-b43d-43c2-a4ef-ec25e773478c"
          }
        }
      }
    },
    {
      "id": "c437e2ad-3ad3-5dd5-b828-b936373066ff",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fbbe836a-aff8-4bac-a9b7-f3be66564489",
        "item_id": "921f44b2-dd0c-4696-ae60-4c4b4d41ae4a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fbbe836a-aff8-4bac-a9b7-f3be66564489"
          }
        }
      }
    },
    {
      "id": "baf90e20-d922-5dcc-84ba-8fddcfd8ec3e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1259cb5d-77de-4553-86d9-f086a5566f02",
        "item_id": "921f44b2-dd0c-4696-ae60-4c4b4d41ae4a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1259cb5d-77de-4553-86d9-f086a5566f02"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-19T07:55:06Z`
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





