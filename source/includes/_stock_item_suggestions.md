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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=584e62f0-b8e7-42ac-bd51-33aa0f0f955a&filter%5Blocation_id%5D=d0a7c4c6-c2f7-4b08-87b3-3971ff82145b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4fb01255-8c24-577b-aec0-d8dc8eb83ee2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0a5a136d-3e92-446f-a8f4-4e10bce1a817",
        "item_id": "584e62f0-b8e7-42ac-bd51-33aa0f0f955a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0a5a136d-3e92-446f-a8f4-4e10bce1a817"
          }
        }
      }
    },
    {
      "id": "7134f3dd-d010-586f-a60f-1d8b2f81958a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b631e8e2-603e-4b81-acc0-48bf38a9b4dd",
        "item_id": "584e62f0-b8e7-42ac-bd51-33aa0f0f955a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b631e8e2-603e-4b81-acc0-48bf38a9b4dd"
          }
        }
      }
    },
    {
      "id": "53749a6b-8039-5937-b17d-1a48c34e5475",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9cedbdf8-72ad-417f-ab7e-4a9a2cdf161a",
        "item_id": "584e62f0-b8e7-42ac-bd51-33aa0f0f955a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9cedbdf8-72ad-417f-ab7e-4a9a2cdf161a"
          }
        }
      }
    },
    {
      "id": "d687ad3a-dfbb-5073-a506-995a433234a1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7923c5cb-bf77-45d4-823d-abb0ff190853",
        "item_id": "584e62f0-b8e7-42ac-bd51-33aa0f0f955a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7923c5cb-bf77-45d4-823d-abb0ff190853"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T12:36:39Z`
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





