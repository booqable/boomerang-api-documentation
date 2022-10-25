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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=a4934138-fec9-40a6-bd0b-94dcd9b6ab6f&filter%5Blocation_id%5D=18feadc7-9e80-4534-9437-6f75a31a36d8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d58a816-cc24-5497-ad53-a167e172d637",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9cbd24ab-13f7-424f-9018-cc8469f677a4",
        "item_id": "a4934138-fec9-40a6-bd0b-94dcd9b6ab6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9cbd24ab-13f7-424f-9018-cc8469f677a4"
          }
        }
      }
    },
    {
      "id": "7c0a590b-bd2d-553f-b477-b9f154b2639c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a7a2534e-d089-4400-a39f-9686de1e6db0",
        "item_id": "a4934138-fec9-40a6-bd0b-94dcd9b6ab6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a7a2534e-d089-4400-a39f-9686de1e6db0"
          }
        }
      }
    },
    {
      "id": "cd1c725a-eefb-5500-b869-db4b19cd613a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d8d7080b-a7c6-4453-a53b-724594e31ae5",
        "item_id": "a4934138-fec9-40a6-bd0b-94dcd9b6ab6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d8d7080b-a7c6-4453-a53b-724594e31ae5"
          }
        }
      }
    },
    {
      "id": "98b269f0-3355-5fe6-adb4-3291a636282b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bad36deb-6b99-4fc1-9cc9-8c9d7b90b339",
        "item_id": "a4934138-fec9-40a6-bd0b-94dcd9b6ab6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bad36deb-6b99-4fc1-9cc9-8c9d7b90b339"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T16:29:21Z`
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





