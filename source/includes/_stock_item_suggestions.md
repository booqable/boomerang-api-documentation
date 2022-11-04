# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=8e11809e-1b43-495f-966b-d0f9679d8ea9&filter%5Blocation_id%5D=c9d4650d-ec25-410c-a9b6-b181c5ddb00b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ddbfab2f-1f22-574c-b866-d0f61ed552f3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ecf6b61d-66c2-4d97-a361-c69e0aa8a2e6",
        "item_id": "8e11809e-1b43-495f-966b-d0f9679d8ea9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ecf6b61d-66c2-4d97-a361-c69e0aa8a2e6"
          }
        }
      }
    },
    {
      "id": "a9c1fd9d-9755-58bc-8d7d-f282ed77a494",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d96b12fe-7930-4ade-a976-6c8b53ae0cca",
        "item_id": "8e11809e-1b43-495f-966b-d0f9679d8ea9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d96b12fe-7930-4ade-a976-6c8b53ae0cca"
          }
        }
      }
    },
    {
      "id": "8e507796-22c2-5148-8386-789c627abd13",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1a49e486-4439-4d40-be0d-e3ec10c4aa7f",
        "item_id": "8e11809e-1b43-495f-966b-d0f9679d8ea9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1a49e486-4439-4d40-be0d-e3ec10c4aa7f"
          }
        }
      }
    },
    {
      "id": "f39d9af8-43ec-5eea-9302-f95a1626cf4a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "92a469aa-5442-4550-9554-04e806fd8917",
        "item_id": "8e11809e-1b43-495f-966b-d0f9679d8ea9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/92a469aa-5442-4550-9554-04e806fd8917"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:45Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`action` | **String_enum** <br>`eq`
`q` | **String** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





