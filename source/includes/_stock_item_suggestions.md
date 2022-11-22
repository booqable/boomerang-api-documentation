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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7726aaeb-19f6-4e1a-b657-567bf79cc84e&filter%5Blocation_id%5D=8a5f393c-27e7-4a8d-aa92-41bb07ded1b7&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8c9bf02a-2adf-5baf-8ff6-68d9cdef5dd9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "93a27fac-e713-4876-b1ba-7fb7dadfb457",
        "item_id": "7726aaeb-19f6-4e1a-b657-567bf79cc84e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/93a27fac-e713-4876-b1ba-7fb7dadfb457"
          }
        }
      }
    },
    {
      "id": "d7a24726-c343-51a1-9bbb-72cc128abf44",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c9bdbd07-0589-4769-af04-68e8f209c65a",
        "item_id": "7726aaeb-19f6-4e1a-b657-567bf79cc84e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c9bdbd07-0589-4769-af04-68e8f209c65a"
          }
        }
      }
    },
    {
      "id": "fa84e19e-4762-5b33-b57c-c008d55c122d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0d9be5e2-a9a9-4d54-87f5-62dd901c1418",
        "item_id": "7726aaeb-19f6-4e1a-b657-567bf79cc84e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0d9be5e2-a9a9-4d54-87f5-62dd901c1418"
          }
        }
      }
    },
    {
      "id": "0a30700f-2cbd-590d-9264-024b8fbe3aa7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0119b3c6-b1e1-4471-a0cc-24dfa8d7c02e",
        "item_id": "7726aaeb-19f6-4e1a-b657-567bf79cc84e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0119b3c6-b1e1-4471-a0cc-24dfa8d7c02e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:32:09Z`
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





