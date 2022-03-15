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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=80969fbb-572d-453e-ac58-097359a05b42&filter%5Blocation_id%5D=3a5d7bc1-5367-40fe-aa72-5e8710b8869e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "844c5629-2930-5572-ba4b-32323c0190b3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e026e711-5f69-4afb-8abd-13d80f6623ca",
        "item_id": "80969fbb-572d-453e-ac58-097359a05b42",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e026e711-5f69-4afb-8abd-13d80f6623ca"
          }
        }
      }
    },
    {
      "id": "3cf19229-135f-5147-8dea-a9fb831f01ec",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b5059112-51df-42fa-8c6b-0ce85346e8dd",
        "item_id": "80969fbb-572d-453e-ac58-097359a05b42",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b5059112-51df-42fa-8c6b-0ce85346e8dd"
          }
        }
      }
    },
    {
      "id": "7b4ce6f7-c4a3-5794-8591-f5efe2c9eb06",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5be2b2db-8c8c-4d03-ba46-75048aa2e676",
        "item_id": "80969fbb-572d-453e-ac58-097359a05b42",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5be2b2db-8c8c-4d03-ba46-75048aa2e676"
          }
        }
      }
    },
    {
      "id": "e85d72f9-fccb-5967-8e3d-a705f189cef1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f025fe48-a9b0-452f-ba1b-2305bfe4b18c",
        "item_id": "80969fbb-572d-453e-ac58-097359a05b42",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f025fe48-a9b0-452f-ba1b-2305bfe4b18c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-15T16:22:59Z`
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





