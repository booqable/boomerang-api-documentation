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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6fc9ff90-dfd6-47b1-9fa6-f839cf26d7e2&filter%5Blocation_id%5D=a704b34e-c1ab-4b9d-afc6-f222dd9de278&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b7f361a9-156f-5c4d-a20d-bd03def8a8ea",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d3c4a514-6cad-46f7-918c-4ad6f05f06a3",
        "item_id": "6fc9ff90-dfd6-47b1-9fa6-f839cf26d7e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d3c4a514-6cad-46f7-918c-4ad6f05f06a3"
          }
        }
      }
    },
    {
      "id": "577f52df-4de4-50e0-b710-d53b3eb91679",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b3ce4cb1-0811-4120-91cf-2eedfef02770",
        "item_id": "6fc9ff90-dfd6-47b1-9fa6-f839cf26d7e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b3ce4cb1-0811-4120-91cf-2eedfef02770"
          }
        }
      }
    },
    {
      "id": "1064e233-e74a-5c4f-92e1-7f66900846d2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "31441dc0-d802-4702-889b-f43f3875dbc2",
        "item_id": "6fc9ff90-dfd6-47b1-9fa6-f839cf26d7e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/31441dc0-d802-4702-889b-f43f3875dbc2"
          }
        }
      }
    },
    {
      "id": "addd118b-737d-5180-9d59-b75b1fec7ff6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bbc8fd7d-898e-43b0-85d6-8390061b7005",
        "item_id": "6fc9ff90-dfd6-47b1-9fa6-f839cf26d7e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bbc8fd7d-898e-43b0-85d6-8390061b7005"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T12:11:21Z`
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





