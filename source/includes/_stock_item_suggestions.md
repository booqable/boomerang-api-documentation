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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=cf21dbc2-8cbe-4caa-98a7-c91b120c2c29&filter%5Blocation_id%5D=84f48fd4-342f-4069-9d8b-16209b302266&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2b093867-c80f-56f0-96d9-5ed49f1c0a00",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dd3952dd-16c8-43f7-b318-b823028bdf68",
        "item_id": "cf21dbc2-8cbe-4caa-98a7-c91b120c2c29",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dd3952dd-16c8-43f7-b318-b823028bdf68"
          }
        }
      }
    },
    {
      "id": "bbb64892-5113-57b4-9b94-212593d4d415",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b0c6a71e-fb79-479d-8da6-57b5c79cfb13",
        "item_id": "cf21dbc2-8cbe-4caa-98a7-c91b120c2c29",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b0c6a71e-fb79-479d-8da6-57b5c79cfb13"
          }
        }
      }
    },
    {
      "id": "67cfbac4-a6de-5089-847e-88728b01984f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ad84bf82-61f8-4e2a-b6a4-042e9ddcc7d8",
        "item_id": "cf21dbc2-8cbe-4caa-98a7-c91b120c2c29",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ad84bf82-61f8-4e2a-b6a4-042e9ddcc7d8"
          }
        }
      }
    },
    {
      "id": "fe31875a-2d06-5eda-b192-b4674d5a1c57",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "34c8232c-0e21-415c-8500-7f3c3cf57314",
        "item_id": "cf21dbc2-8cbe-4caa-98a7-c91b120c2c29",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/34c8232c-0e21-415c-8500-7f3c3cf57314"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:49:01Z`
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





