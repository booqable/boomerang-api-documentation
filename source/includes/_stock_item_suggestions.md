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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f9be77c1-3e22-4408-aaae-8eacb8eeb175&filter%5Blocation_id%5D=c312a72d-c47a-481e-9c58-b91339bae391&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "46becdfc-322a-5be0-90f8-7e43c79f3ac4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "94e8825b-842f-49be-bf72-cdc7dce32004",
        "item_id": "f9be77c1-3e22-4408-aaae-8eacb8eeb175",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/94e8825b-842f-49be-bf72-cdc7dce32004"
          }
        }
      }
    },
    {
      "id": "2c9e6032-5de9-596e-ad76-84b6f8c01f1a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a816b8aa-08bb-4ed1-af36-56523456596e",
        "item_id": "f9be77c1-3e22-4408-aaae-8eacb8eeb175",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a816b8aa-08bb-4ed1-af36-56523456596e"
          }
        }
      }
    },
    {
      "id": "b7b46d36-24d8-5475-9bb9-04fd0d8b3208",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a3ee19e5-6866-4608-b31d-f95f7292bcc7",
        "item_id": "f9be77c1-3e22-4408-aaae-8eacb8eeb175",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a3ee19e5-6866-4608-b31d-f95f7292bcc7"
          }
        }
      }
    },
    {
      "id": "da630890-1a50-5d50-ae1e-196e2ccfeea8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9b44d5f8-5b66-46aa-8aa4-60398e2bb7c0",
        "item_id": "f9be77c1-3e22-4408-aaae-8eacb8eeb175",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9b44d5f8-5b66-46aa-8aa4-60398e2bb7c0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:57:52Z`
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





