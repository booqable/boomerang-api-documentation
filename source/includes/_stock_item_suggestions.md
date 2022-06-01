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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=065f0605-d4bc-44fa-97f2-820a1528ae2b&filter%5Blocation_id%5D=323af13e-f498-4ca7-8149-f830004447b6&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "878bfffc-3052-5d72-871b-81ec44a926da",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ac3b4d2d-9774-43f0-8925-33062dc83b36",
        "item_id": "065f0605-d4bc-44fa-97f2-820a1528ae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ac3b4d2d-9774-43f0-8925-33062dc83b36"
          }
        }
      }
    },
    {
      "id": "e0c341a1-776d-514e-856e-6a99035a142a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5313d3ce-4788-4981-b109-6182a9053815",
        "item_id": "065f0605-d4bc-44fa-97f2-820a1528ae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5313d3ce-4788-4981-b109-6182a9053815"
          }
        }
      }
    },
    {
      "id": "aa68ec7b-60ef-5045-9c7d-edc2e60afb9d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1c39edef-279d-4412-91ae-11d8348a09f0",
        "item_id": "065f0605-d4bc-44fa-97f2-820a1528ae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1c39edef-279d-4412-91ae-11d8348a09f0"
          }
        }
      }
    },
    {
      "id": "cdaaef5b-c9af-55ef-98a3-ad5d1f2e3ffd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6ee4803f-20f0-4414-80d5-62d877f360ff",
        "item_id": "065f0605-d4bc-44fa-97f2-820a1528ae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6ee4803f-20f0-4414-80d5-62d877f360ff"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-01T08:55:20Z`
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





