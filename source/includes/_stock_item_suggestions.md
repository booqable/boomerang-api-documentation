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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7d529b8c-a2fd-4ede-befc-c357db11ccc6&filter%5Blocation_id%5D=87e96866-4a3b-472f-b0eb-1b5ca66b484d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dab68ffc-0e2d-57e1-b3bc-3d164f637c4d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d64b363a-bfde-473f-b864-fd8caecbdaf9",
        "item_id": "7d529b8c-a2fd-4ede-befc-c357db11ccc6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d64b363a-bfde-473f-b864-fd8caecbdaf9"
          }
        }
      }
    },
    {
      "id": "a0605eb7-7e04-59f1-b9bb-239c4981023c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "62422608-4466-4392-80b6-619add90203e",
        "item_id": "7d529b8c-a2fd-4ede-befc-c357db11ccc6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/62422608-4466-4392-80b6-619add90203e"
          }
        }
      }
    },
    {
      "id": "fb2df53f-656b-5ca3-b686-b785b2288187",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "09e56007-fe2e-44a1-bb8f-f7b7d36bbefb",
        "item_id": "7d529b8c-a2fd-4ede-befc-c357db11ccc6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/09e56007-fe2e-44a1-bb8f-f7b7d36bbefb"
          }
        }
      }
    },
    {
      "id": "e60046ac-9ef3-5d5c-9ac7-f8fc6f1fb58b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cc254fcf-1abd-4e30-b7c5-20271fe687e7",
        "item_id": "7d529b8c-a2fd-4ede-befc-c357db11ccc6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cc254fcf-1abd-4e30-b7c5-20271fe687e7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T09:54:41Z`
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





