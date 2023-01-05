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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=50dfcd80-3787-4d7a-9bec-5a0311d87c38&filter%5Blocation_id%5D=9955a5e9-4adb-44e4-b974-eaf1f90d115c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3de3b347-6641-54e1-8679-8ff20c62b4e8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fd310064-1e06-49a7-bbb5-5d5d0bc152a2",
        "item_id": "50dfcd80-3787-4d7a-9bec-5a0311d87c38",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fd310064-1e06-49a7-bbb5-5d5d0bc152a2"
          }
        }
      }
    },
    {
      "id": "939d9789-403e-5759-b98b-8e325cd81541",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "745d979e-2ef2-4a60-84be-a8be45cceac2",
        "item_id": "50dfcd80-3787-4d7a-9bec-5a0311d87c38",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/745d979e-2ef2-4a60-84be-a8be45cceac2"
          }
        }
      }
    },
    {
      "id": "d4bc62d6-009d-51dd-9cb3-18043d095cb6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dde7e91c-dcae-4da1-b11d-cf41d223e029",
        "item_id": "50dfcd80-3787-4d7a-9bec-5a0311d87c38",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dde7e91c-dcae-4da1-b11d-cf41d223e029"
          }
        }
      }
    },
    {
      "id": "cd47a408-2ce1-5a4a-808f-c28a7bcda52d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "79b05281-8191-483a-a28a-898482792e69",
        "item_id": "50dfcd80-3787-4d7a-9bec-5a0311d87c38",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/79b05281-8191-483a-a28a-898482792e69"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T16:26:11Z`
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





