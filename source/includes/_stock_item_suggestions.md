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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4411533b-f86a-4fbc-980a-e5daaa2ea49e&filter%5Blocation_id%5D=9de9f0db-888b-4f1d-801e-e795455ea8e2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4ca765ca-d157-52b0-b5eb-7cbdf676e0e9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2c6968df-9c01-40b3-aca6-1d745e1ed842",
        "item_id": "4411533b-f86a-4fbc-980a-e5daaa2ea49e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2c6968df-9c01-40b3-aca6-1d745e1ed842"
          }
        }
      }
    },
    {
      "id": "332d3c5b-e5d1-5c8e-89c3-d4d22bf628f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a44a3363-d853-4eb7-97ef-aa81c2345147",
        "item_id": "4411533b-f86a-4fbc-980a-e5daaa2ea49e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a44a3363-d853-4eb7-97ef-aa81c2345147"
          }
        }
      }
    },
    {
      "id": "06e4831b-be03-5641-a173-e55632fd69f5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "25c5067c-616c-41dc-9e02-eaf8be5f0edd",
        "item_id": "4411533b-f86a-4fbc-980a-e5daaa2ea49e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/25c5067c-616c-41dc-9e02-eaf8be5f0edd"
          }
        }
      }
    },
    {
      "id": "325a8037-0b8a-5783-86d0-dfd27bc05f08",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d8dcf66e-c074-41dd-8e30-a28ce469469f",
        "item_id": "4411533b-f86a-4fbc-980a-e5daaa2ea49e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d8dcf66e-c074-41dd-8e30-a28ce469469f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:11:10Z`
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





