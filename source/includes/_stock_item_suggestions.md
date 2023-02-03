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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=34b57dd6-b401-4d04-84b1-a09b1da1f430&filter%5Blocation_id%5D=1287e15e-5deb-4849-aa9c-6e80a6894149&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1058f73a-56a9-5a45-b06e-5c141f314d26",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1c56e9c7-ca1a-44fa-9134-4332640d4add",
        "item_id": "34b57dd6-b401-4d04-84b1-a09b1da1f430",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1c56e9c7-ca1a-44fa-9134-4332640d4add"
          }
        }
      }
    },
    {
      "id": "d74f1382-dd61-5a9a-a17f-bd3ef1377f7a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3ce63488-d1bc-474c-9d66-ab7d4f696a0f",
        "item_id": "34b57dd6-b401-4d04-84b1-a09b1da1f430",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3ce63488-d1bc-474c-9d66-ab7d4f696a0f"
          }
        }
      }
    },
    {
      "id": "cadf3d27-951e-5b10-911b-b3b7d7ec2a5c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a78fa18e-7d50-461b-ad10-06fec28cb266",
        "item_id": "34b57dd6-b401-4d04-84b1-a09b1da1f430",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a78fa18e-7d50-461b-ad10-06fec28cb266"
          }
        }
      }
    },
    {
      "id": "f3068523-5f10-5562-a7c1-24daace7eb08",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "83d9762f-00c6-4237-9287-f75eb4ea1699",
        "item_id": "34b57dd6-b401-4d04-84b1-a09b1da1f430",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/83d9762f-00c6-4237-9287-f75eb4ea1699"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:25:53Z`
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





