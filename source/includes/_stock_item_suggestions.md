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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=54ed7b02-1346-4abd-b2b4-1ffb85eee8de&filter%5Blocation_id%5D=6c1805f6-8c46-441a-b222-217d25e4dfa2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a53ce9a0-faf5-5ad5-82ca-dfb4c57b54b2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "88db0d7f-a881-4d4c-97a3-a1f488b29c67",
        "item_id": "54ed7b02-1346-4abd-b2b4-1ffb85eee8de",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/88db0d7f-a881-4d4c-97a3-a1f488b29c67"
          }
        }
      }
    },
    {
      "id": "2fe5a70c-c3af-5f24-85e3-7e2dc3bc71c7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4b575ca1-6e08-4592-81ea-100b0dc48969",
        "item_id": "54ed7b02-1346-4abd-b2b4-1ffb85eee8de",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4b575ca1-6e08-4592-81ea-100b0dc48969"
          }
        }
      }
    },
    {
      "id": "1273dbe9-3eca-5d4f-9209-3cca2ce6f4e9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "464266e6-6111-4290-835d-1984bd02c92f",
        "item_id": "54ed7b02-1346-4abd-b2b4-1ffb85eee8de",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/464266e6-6111-4290-835d-1984bd02c92f"
          }
        }
      }
    },
    {
      "id": "d67cb4a4-69a8-5c89-a1ae-7a4ee84cb7c1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "88a7cf41-6ebc-49ad-933d-f60de8060ce6",
        "item_id": "54ed7b02-1346-4abd-b2b4-1ffb85eee8de",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/88a7cf41-6ebc-49ad-933d-f60de8060ce6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-09T08:11:56Z`
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





