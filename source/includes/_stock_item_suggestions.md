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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=eee48037-ce19-4ba7-a8fe-4c77f56bfd7f&filter%5Blocation_id%5D=828aee33-ad50-4c1f-86d2-bdd1fba88add&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a85ffac7-e091-5a1e-96de-ed36ea82709f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6ea7ac47-e53e-4cde-9132-b6878dbb6462",
        "item_id": "eee48037-ce19-4ba7-a8fe-4c77f56bfd7f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6ea7ac47-e53e-4cde-9132-b6878dbb6462"
          }
        }
      }
    },
    {
      "id": "57f2977a-582b-537c-bd5b-28c110cd922c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b03786b6-9fa1-46cc-9848-b50ec5824017",
        "item_id": "eee48037-ce19-4ba7-a8fe-4c77f56bfd7f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b03786b6-9fa1-46cc-9848-b50ec5824017"
          }
        }
      }
    },
    {
      "id": "0e56d01a-f600-5e41-9f46-9a54d582ea05",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "124383cc-2adb-4736-8e78-8c272a81e165",
        "item_id": "eee48037-ce19-4ba7-a8fe-4c77f56bfd7f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/124383cc-2adb-4736-8e78-8c272a81e165"
          }
        }
      }
    },
    {
      "id": "104281e1-fe29-5b52-9c59-804b85d954e7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fcbdac17-6be0-42ab-932f-c4d50c847830",
        "item_id": "eee48037-ce19-4ba7-a8fe-4c77f56bfd7f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fcbdac17-6be0-42ab-932f-c4d50c847830"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T08:07:51Z`
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





