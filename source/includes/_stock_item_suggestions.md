# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=60858d70-1a5a-4dea-837c-14bce0431963&filter%5Blocation_id%5D=4832735b-62c4-4e7d-85cd-46538594ac80&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b563c1e8-5bcb-57dc-99ff-6df54d0ca1be",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bedf36a8-06ae-4de5-ae90-a46f8eaf4be7",
        "item_id": "60858d70-1a5a-4dea-837c-14bce0431963",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bedf36a8-06ae-4de5-ae90-a46f8eaf4be7"
          }
        }
      }
    },
    {
      "id": "49a0d350-34a4-54e4-96e8-2f2653a82f55",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f27a6906-fe52-41c2-a2e5-24079fcff79e",
        "item_id": "60858d70-1a5a-4dea-837c-14bce0431963",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f27a6906-fe52-41c2-a2e5-24079fcff79e"
          }
        }
      }
    },
    {
      "id": "074221c5-f432-5c46-a317-7573584ec6dc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "785c0567-be31-43c8-b8cf-c71376babfc3",
        "item_id": "60858d70-1a5a-4dea-837c-14bce0431963",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/785c0567-be31-43c8-b8cf-c71376babfc3"
          }
        }
      }
    },
    {
      "id": "e6cc674a-183e-56bc-9084-64c01228aabb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "989a39ab-26a2-44ee-8fc7-25cc3fa88ce9",
        "item_id": "60858d70-1a5a-4dea-837c-14bce0431963",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/989a39ab-26a2-44ee-8fc7-25cc3fa88ce9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-23T11:33:07Z`
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





