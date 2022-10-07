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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=be3c99a6-8afd-4102-aad3-4a3200304a74&filter%5Blocation_id%5D=6f16e8a2-ef7c-46d4-a8c1-7954a8cdfbf9&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4d9963b-a8f8-5f3a-9c24-1332de350041",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3b4680cf-692f-492a-a5f7-4c6537fd1832",
        "item_id": "be3c99a6-8afd-4102-aad3-4a3200304a74",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3b4680cf-692f-492a-a5f7-4c6537fd1832"
          }
        }
      }
    },
    {
      "id": "a35475cd-33b2-5d31-9a38-dd8b7c20d281",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9b3ce40b-4d8e-4f3e-a941-a238be99f1de",
        "item_id": "be3c99a6-8afd-4102-aad3-4a3200304a74",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9b3ce40b-4d8e-4f3e-a941-a238be99f1de"
          }
        }
      }
    },
    {
      "id": "e2b39728-0233-57d9-9bfb-d7efe2d4c37a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a64e82ee-8e21-4948-b2f5-7a1a03ca142d",
        "item_id": "be3c99a6-8afd-4102-aad3-4a3200304a74",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a64e82ee-8e21-4948-b2f5-7a1a03ca142d"
          }
        }
      }
    },
    {
      "id": "93e2eb36-26cb-55ed-b887-6d2cd5b29f3f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "739defe4-8609-47d2-9e98-e70f6430df0b",
        "item_id": "be3c99a6-8afd-4102-aad3-4a3200304a74",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/739defe4-8609-47d2-9e98-e70f6430df0b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T15:04:27Z`
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





