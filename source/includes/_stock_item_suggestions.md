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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=dc5775e6-7dbb-494a-ac0a-5bdd05352308&filter%5Blocation_id%5D=d42a3735-3919-4abf-b218-6d70c07246e0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "af7bb11a-7c90-57c2-8422-1821ef81f32d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c04686e5-20ce-4e5a-a525-7f12fa417314",
        "item_id": "dc5775e6-7dbb-494a-ac0a-5bdd05352308",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c04686e5-20ce-4e5a-a525-7f12fa417314"
          }
        }
      }
    },
    {
      "id": "ef03d669-0bf0-5941-901f-92d1b32feafe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dc8c0367-9872-4843-9b8d-4dd8ee5b1aaf",
        "item_id": "dc5775e6-7dbb-494a-ac0a-5bdd05352308",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dc8c0367-9872-4843-9b8d-4dd8ee5b1aaf"
          }
        }
      }
    },
    {
      "id": "ca09bbd3-8258-5ec3-a8e5-58bd8d84dea4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1f930e8e-a460-471c-9b4f-d01db6d4e6ba",
        "item_id": "dc5775e6-7dbb-494a-ac0a-5bdd05352308",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1f930e8e-a460-471c-9b4f-d01db6d4e6ba"
          }
        }
      }
    },
    {
      "id": "3ad28ec8-db3f-52db-8922-531c0cc158e6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "14328785-4e90-4e2a-9cf2-21401572131b",
        "item_id": "dc5775e6-7dbb-494a-ac0a-5bdd05352308",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/14328785-4e90-4e2a-9cf2-21401572131b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:24Z`
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





