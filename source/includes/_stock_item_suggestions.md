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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bd53e9b5-848a-421d-9873-4e1b32b8beec&filter%5Blocation_id%5D=60eafa57-457e-459b-a11f-5538841f0d9c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "788c1400-d644-5cbf-8f82-571c152e4b99",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "730b93bc-3abe-47d6-9a78-42b381a49138",
        "item_id": "bd53e9b5-848a-421d-9873-4e1b32b8beec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/730b93bc-3abe-47d6-9a78-42b381a49138"
          }
        }
      }
    },
    {
      "id": "47483247-aa76-5fa8-bcde-de336cbe03c9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4b2f4e03-5184-4047-be61-bdbf2a435cbf",
        "item_id": "bd53e9b5-848a-421d-9873-4e1b32b8beec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4b2f4e03-5184-4047-be61-bdbf2a435cbf"
          }
        }
      }
    },
    {
      "id": "4fb8ce2d-36d1-5906-aab5-f81a28eeacac",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7a143338-9238-4af4-b77f-e5b7b0bb4f30",
        "item_id": "bd53e9b5-848a-421d-9873-4e1b32b8beec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7a143338-9238-4af4-b77f-e5b7b0bb4f30"
          }
        }
      }
    },
    {
      "id": "83ad1583-36d8-5621-95b1-046238a94594",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1dd6c00b-2c6f-4aa3-9c15-7b9afb23ef54",
        "item_id": "bd53e9b5-848a-421d-9873-4e1b32b8beec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1dd6c00b-2c6f-4aa3-9c15-7b9afb23ef54"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-18T13:34:28Z`
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





