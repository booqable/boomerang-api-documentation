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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e64062e3-e6a1-48b4-bd1b-68ea9e744eab&filter%5Blocation_id%5D=c202866d-b5ac-4077-9421-2c2e34eaa816&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "accba4f2-11d4-5ae3-9c10-702e6def1eb4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eed988dc-c877-4e9f-8037-4dde02bab74e",
        "item_id": "e64062e3-e6a1-48b4-bd1b-68ea9e744eab",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eed988dc-c877-4e9f-8037-4dde02bab74e"
          }
        }
      }
    },
    {
      "id": "b915ae3b-ee3c-522e-90f4-5afbff595d9f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9ff72da0-3e10-4531-b103-e9cb409ad718",
        "item_id": "e64062e3-e6a1-48b4-bd1b-68ea9e744eab",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9ff72da0-3e10-4531-b103-e9cb409ad718"
          }
        }
      }
    },
    {
      "id": "35a2fda1-c9e6-52b2-ba7f-e8c7e908064c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "13bb4c0b-7e59-41f5-b8fc-7d445d86cb71",
        "item_id": "e64062e3-e6a1-48b4-bd1b-68ea9e744eab",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/13bb4c0b-7e59-41f5-b8fc-7d445d86cb71"
          }
        }
      }
    },
    {
      "id": "bf65ab95-2f65-530d-b48d-ec3c115023af",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "24695366-2fe9-45b3-ab24-b3419b42552b",
        "item_id": "e64062e3-e6a1-48b4-bd1b-68ea9e744eab",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/24695366-2fe9-45b3-ab24-b3419b42552b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T13:57:26Z`
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





