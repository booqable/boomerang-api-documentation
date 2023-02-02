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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bd707e06-66b2-439e-af1a-ca4e44d0f8a8&filter%5Blocation_id%5D=eb7942c7-b837-429d-af5d-2284d4cb524d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "06947f4f-8abe-50c0-b3dd-8ec8217544cb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5b446a3d-6c11-4f0b-8be0-2824de4c348d",
        "item_id": "bd707e06-66b2-439e-af1a-ca4e44d0f8a8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5b446a3d-6c11-4f0b-8be0-2824de4c348d"
          }
        }
      }
    },
    {
      "id": "2b13161a-c9d8-56cd-b2fa-d5cad563ecf8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9165e71c-2650-48bc-9868-68f589d2b2ea",
        "item_id": "bd707e06-66b2-439e-af1a-ca4e44d0f8a8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9165e71c-2650-48bc-9868-68f589d2b2ea"
          }
        }
      }
    },
    {
      "id": "90e9343f-f45c-5e1c-bdce-49a45c7a472b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4ff8ff4c-7760-4fcd-a666-dd9fdc17ce6c",
        "item_id": "bd707e06-66b2-439e-af1a-ca4e44d0f8a8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4ff8ff4c-7760-4fcd-a666-dd9fdc17ce6c"
          }
        }
      }
    },
    {
      "id": "d27aa626-83fe-5211-b99f-c31494af66b5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9ede1230-53d2-45ca-83f5-ad618cad9f82",
        "item_id": "bd707e06-66b2-439e-af1a-ca4e44d0f8a8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9ede1230-53d2-45ca-83f5-ad618cad9f82"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:50Z`
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





