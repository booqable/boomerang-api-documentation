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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e8c19348-4396-4d12-af01-5a8cd1138daa&filter%5Blocation_id%5D=4997174d-d4f1-4f75-870b-c882e791235d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "92660306-edfb-5bf5-91ba-1a23c4ae4cdd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5f83d8a3-6ae6-4f0f-8f89-a894266e5288",
        "item_id": "e8c19348-4396-4d12-af01-5a8cd1138daa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5f83d8a3-6ae6-4f0f-8f89-a894266e5288"
          }
        }
      }
    },
    {
      "id": "ae7d386f-f05e-5b3c-a5c4-8fb0e34733bf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "32c6f491-2f4e-495a-910f-289ae2e21668",
        "item_id": "e8c19348-4396-4d12-af01-5a8cd1138daa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/32c6f491-2f4e-495a-910f-289ae2e21668"
          }
        }
      }
    },
    {
      "id": "602af12c-c877-5f92-ab8b-a7e498d3b194",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "865203f6-695e-4047-b3f5-9d4d76a0620c",
        "item_id": "e8c19348-4396-4d12-af01-5a8cd1138daa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/865203f6-695e-4047-b3f5-9d4d76a0620c"
          }
        }
      }
    },
    {
      "id": "2f16f244-729e-5db5-af31-7d516e1c9621",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ba0d3b2a-6e49-44b4-81d5-90d643fd6d22",
        "item_id": "e8c19348-4396-4d12-af01-5a8cd1138daa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ba0d3b2a-6e49-44b4-81d5-90d643fd6d22"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:31:45Z`
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





