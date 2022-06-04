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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=27c59c9b-bd8b-47c3-9546-a3d1c460b53f&filter%5Blocation_id%5D=dd4c33b3-d37d-4fb9-b819-af96de19cd6d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1999bd71-a2ee-5b8c-8bd2-b5133974b459",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "023328c5-d569-4225-a394-d28c234f13f8",
        "item_id": "27c59c9b-bd8b-47c3-9546-a3d1c460b53f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/023328c5-d569-4225-a394-d28c234f13f8"
          }
        }
      }
    },
    {
      "id": "9f97488f-fa30-5106-b892-1e349caf6620",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c65ade9c-babc-4441-a7df-3bf513a77b0d",
        "item_id": "27c59c9b-bd8b-47c3-9546-a3d1c460b53f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c65ade9c-babc-4441-a7df-3bf513a77b0d"
          }
        }
      }
    },
    {
      "id": "1d49fb1f-4650-5080-9bff-0967006517b4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "69861cc7-6d98-4db1-9cf2-14a3370c2b43",
        "item_id": "27c59c9b-bd8b-47c3-9546-a3d1c460b53f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/69861cc7-6d98-4db1-9cf2-14a3370c2b43"
          }
        }
      }
    },
    {
      "id": "a1359305-271b-5053-912f-c4ab4bfd12b9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d7b2d3fe-c9ae-426d-b277-5336f0049364",
        "item_id": "27c59c9b-bd8b-47c3-9546-a3d1c460b53f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d7b2d3fe-c9ae-426d-b277-5336f0049364"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-04T09:50:01Z`
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





