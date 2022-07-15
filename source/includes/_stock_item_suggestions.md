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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4154103e-9edb-4520-bf22-15009d1df124&filter%5Blocation_id%5D=e25d5b7c-f473-41c0-ada0-9af8aba225e4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "002916dd-da79-5cec-9581-568a1524c379",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ac966e44-1e53-4620-a84e-def41c9ff35a",
        "item_id": "4154103e-9edb-4520-bf22-15009d1df124",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ac966e44-1e53-4620-a84e-def41c9ff35a"
          }
        }
      }
    },
    {
      "id": "ae86d58e-f2d2-5379-8790-860eb3f9bcec",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8816192d-b227-44ab-9714-adb95be98267",
        "item_id": "4154103e-9edb-4520-bf22-15009d1df124",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8816192d-b227-44ab-9714-adb95be98267"
          }
        }
      }
    },
    {
      "id": "f2859e18-ac33-586b-901e-15f9d43e860a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c2f86bb7-6b2b-4f1c-a34e-dcb9e9c132d9",
        "item_id": "4154103e-9edb-4520-bf22-15009d1df124",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c2f86bb7-6b2b-4f1c-a34e-dcb9e9c132d9"
          }
        }
      }
    },
    {
      "id": "d1b05d6b-4176-58fc-907a-b5cf600a3f71",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "14da384a-eb6d-41ed-aea7-15e15b6120c1",
        "item_id": "4154103e-9edb-4520-bf22-15009d1df124",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/14da384a-eb6d-41ed-aea7-15e15b6120c1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:22:35Z`
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





