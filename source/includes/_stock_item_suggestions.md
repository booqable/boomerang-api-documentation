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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=5245e4fe-ee5f-49e4-b539-f63f56b4823a&filter%5Blocation_id%5D=2ff03d3e-f00c-43bd-a25b-004bcbd6c12b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5c7f1703-ac09-52ba-bea0-9d5790d4ee6f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ec2bcac5-1316-41da-84f3-4a6f776c1ffb",
        "item_id": "5245e4fe-ee5f-49e4-b539-f63f56b4823a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ec2bcac5-1316-41da-84f3-4a6f776c1ffb"
          }
        }
      }
    },
    {
      "id": "ea2c5ccc-7033-57ee-b060-e244e92721ca",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "846059f7-a197-4d30-bcb6-dd667ad406ba",
        "item_id": "5245e4fe-ee5f-49e4-b539-f63f56b4823a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/846059f7-a197-4d30-bcb6-dd667ad406ba"
          }
        }
      }
    },
    {
      "id": "e359da84-169a-5050-976c-b76aeda14eb9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f3312cd0-cdcd-46e8-941f-d34474dc3b02",
        "item_id": "5245e4fe-ee5f-49e4-b539-f63f56b4823a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f3312cd0-cdcd-46e8-941f-d34474dc3b02"
          }
        }
      }
    },
    {
      "id": "34b2e671-1b08-529c-a12a-bdcb3ad0525c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0b69fc9d-1ce6-428d-b808-1833358dfabd",
        "item_id": "5245e4fe-ee5f-49e4-b539-f63f56b4823a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0b69fc9d-1ce6-428d-b808-1833358dfabd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-24T14:44:44Z`
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





