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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1e96c23e-edf8-422d-8ccc-af797b9ed552&filter%5Blocation_id%5D=e88f83a2-5b1b-4214-98bb-34045f4fdb05&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9e449b6-1ebd-5bbf-b09a-fa51fe8bc12b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3013259a-166e-461d-b9d3-f0802a8d8e9a",
        "item_id": "1e96c23e-edf8-422d-8ccc-af797b9ed552",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3013259a-166e-461d-b9d3-f0802a8d8e9a"
          }
        }
      }
    },
    {
      "id": "bab3c091-58d4-512f-91bc-384c03496792",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d8f42b39-9d8d-42a5-843e-d4da611e3f7c",
        "item_id": "1e96c23e-edf8-422d-8ccc-af797b9ed552",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d8f42b39-9d8d-42a5-843e-d4da611e3f7c"
          }
        }
      }
    },
    {
      "id": "6c09f61f-946b-5cf6-84d4-e657121e477a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f7a31c8d-57a9-448a-a452-32571aa21c94",
        "item_id": "1e96c23e-edf8-422d-8ccc-af797b9ed552",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f7a31c8d-57a9-448a-a452-32571aa21c94"
          }
        }
      }
    },
    {
      "id": "90459d41-a54d-5085-873e-7f2566a837d9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "69bd11e0-78b1-4b65-98d7-b0f70b4c778e",
        "item_id": "1e96c23e-edf8-422d-8ccc-af797b9ed552",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/69bd11e0-78b1-4b65-98d7-b0f70b4c778e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:13:30Z`
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





