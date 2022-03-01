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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=62b4d8d3-c221-49ab-9ac1-b70a09719027&filter%5Blocation_id%5D=35d7a9b6-59da-46e1-8822-c3f3a22890c8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67e37aff-1c07-5f2a-9825-cd159e5636f9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "23c4d3a2-7f00-47e2-baa9-a99e073174c4",
        "item_id": "62b4d8d3-c221-49ab-9ac1-b70a09719027",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/23c4d3a2-7f00-47e2-baa9-a99e073174c4"
          }
        }
      }
    },
    {
      "id": "0a2fa1c0-f341-5f60-a2cb-8d477325c7eb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fd3e5b66-cd92-415b-aea6-aa9ef1113220",
        "item_id": "62b4d8d3-c221-49ab-9ac1-b70a09719027",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fd3e5b66-cd92-415b-aea6-aa9ef1113220"
          }
        }
      }
    },
    {
      "id": "94087a35-2385-5fe9-8fd2-82b9a49b67af",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3bff4da2-119b-46bb-a109-bf1e3649bb2a",
        "item_id": "62b4d8d3-c221-49ab-9ac1-b70a09719027",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3bff4da2-119b-46bb-a109-bf1e3649bb2a"
          }
        }
      }
    },
    {
      "id": "d02c5cd0-d7c6-551a-8dc8-211ecddcc437",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "185eaef3-f640-46f6-b640-ef670329e17b",
        "item_id": "62b4d8d3-c221-49ab-9ac1-b70a09719027",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/185eaef3-f640-46f6-b640-ef670329e17b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-01T09:34:21Z`
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





