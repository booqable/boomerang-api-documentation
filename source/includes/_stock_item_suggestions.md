# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the item belonging to the suggested stock item
`status` | **String_enum** `readonly`<br>Status of the suggestion. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=710ae4eb-ef0b-415f-a8c9-90605d80bba9&filter%5Blocation_id%5D=6a5ca151-fff5-49b0-b5c8-c6ceb35a20a0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1510df87-76cd-5599-adad-3b33d06ca4be",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0015c4ea-e65b-4cf3-845e-3d062f929030",
        "item_id": "710ae4eb-ef0b-415f-a8c9-90605d80bba9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0015c4ea-e65b-4cf3-845e-3d062f929030"
          }
        }
      }
    },
    {
      "id": "a5cfdd85-0621-55a6-9656-169aa58be712",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "72dcedc4-2488-484e-ab02-de118cce5408",
        "item_id": "710ae4eb-ef0b-415f-a8c9-90605d80bba9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/72dcedc4-2488-484e-ab02-de118cce5408"
          }
        }
      }
    },
    {
      "id": "a199b957-b80d-55a1-a907-b71520882981",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "df25846f-f686-4b31-b5ee-b20247107209",
        "item_id": "710ae4eb-ef0b-415f-a8c9-90605d80bba9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/df25846f-f686-4b31-b5ee-b20247107209"
          }
        }
      }
    },
    {
      "id": "07bc3acb-5908-5d21-913f-744ad47f813e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5aae9596-7ee2-48e6-a8ad-03604245ea8d",
        "item_id": "710ae4eb-ef0b-415f-a8c9-90605d80bba9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5aae9596-7ee2-48e6-a8ad-03604245ea8d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-12T12:56:09Z`
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





