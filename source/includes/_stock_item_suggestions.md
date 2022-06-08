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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=b921b761-511c-468f-8454-74050a3854fa&filter%5Blocation_id%5D=9c660c31-4fdb-429f-821e-79a41c921e8b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d0fafbba-ddf1-5333-bbfe-d6a15a171989",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b52c2f46-af74-4786-8db1-a6eb9841c36b",
        "item_id": "b921b761-511c-468f-8454-74050a3854fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b52c2f46-af74-4786-8db1-a6eb9841c36b"
          }
        }
      }
    },
    {
      "id": "dc81d337-a0a5-5b0b-a4b3-d4c0cc333298",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dadb5097-91e8-4c29-90f7-7a0650350341",
        "item_id": "b921b761-511c-468f-8454-74050a3854fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dadb5097-91e8-4c29-90f7-7a0650350341"
          }
        }
      }
    },
    {
      "id": "a683d499-263e-52f9-bce2-9897625d9c48",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aaea51db-e6c1-45e4-8b5a-e1c7b2b3a2f6",
        "item_id": "b921b761-511c-468f-8454-74050a3854fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aaea51db-e6c1-45e4-8b5a-e1c7b2b3a2f6"
          }
        }
      }
    },
    {
      "id": "c1f53980-1644-534c-9a65-892139c08797",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b86f6ddc-a2e4-44fd-810c-a204ee1101bf",
        "item_id": "b921b761-511c-468f-8454-74050a3854fa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b86f6ddc-a2e4-44fd-810c-a204ee1101bf"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T08:04:43Z`
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





