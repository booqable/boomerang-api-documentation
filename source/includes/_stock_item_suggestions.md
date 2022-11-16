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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=b81f4230-a62a-489f-9a09-bbad0ed88397&filter%5Blocation_id%5D=cb18a8b7-3cc6-4c07-b57b-fc90b5f07419&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cb2af0c6-ad6d-56ee-ac5d-f2802e8a83b7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0dae0d1f-8203-4829-a0cb-14e4a0d46b23",
        "item_id": "b81f4230-a62a-489f-9a09-bbad0ed88397",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0dae0d1f-8203-4829-a0cb-14e4a0d46b23"
          }
        }
      }
    },
    {
      "id": "ba802c68-24db-5a35-a279-22b40ef227ec",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "173c8648-ee7d-4fb8-9e1c-dfbc2c118f5c",
        "item_id": "b81f4230-a62a-489f-9a09-bbad0ed88397",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/173c8648-ee7d-4fb8-9e1c-dfbc2c118f5c"
          }
        }
      }
    },
    {
      "id": "a7124b83-0559-567e-8397-4d18ce32bbb9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f3465494-4868-47cb-99e7-b58c6ab9295d",
        "item_id": "b81f4230-a62a-489f-9a09-bbad0ed88397",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f3465494-4868-47cb-99e7-b58c6ab9295d"
          }
        }
      }
    },
    {
      "id": "3ea52675-e5b6-5257-956c-62180a81dde7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7976465c-8897-47b2-a663-a3abf7886944",
        "item_id": "b81f4230-a62a-489f-9a09-bbad0ed88397",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7976465c-8897-47b2-a663-a3abf7886944"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:21:49Z`
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





