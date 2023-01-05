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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=60a4b224-1328-405e-bbd1-a0c0fcb7fbd2&filter%5Blocation_id%5D=14dd63a8-800f-4d71-8447-946b56407a72&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "82b7704d-767c-5b1a-b218-3cec0917b158",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9d760918-0a44-4d43-a51d-c8f0314ae2d5",
        "item_id": "60a4b224-1328-405e-bbd1-a0c0fcb7fbd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9d760918-0a44-4d43-a51d-c8f0314ae2d5"
          }
        }
      }
    },
    {
      "id": "af636e08-a01f-57ad-af78-d519b162ed3a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "baa74165-4849-48ec-86f9-60da93f75320",
        "item_id": "60a4b224-1328-405e-bbd1-a0c0fcb7fbd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/baa74165-4849-48ec-86f9-60da93f75320"
          }
        }
      }
    },
    {
      "id": "ed7f2865-b335-5ecc-8246-1542570c227d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f03eb43b-3908-42d5-a4a7-f5936e081461",
        "item_id": "60a4b224-1328-405e-bbd1-a0c0fcb7fbd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f03eb43b-3908-42d5-a4a7-f5936e081461"
          }
        }
      }
    },
    {
      "id": "f63f1566-97ee-5c80-9925-60296f809755",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "42b13afc-ce67-40cd-bfb7-87a73c84dc5f",
        "item_id": "60a4b224-1328-405e-bbd1-a0c0fcb7fbd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/42b13afc-ce67-40cd-bfb7-87a73c84dc5f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:25:38Z`
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





