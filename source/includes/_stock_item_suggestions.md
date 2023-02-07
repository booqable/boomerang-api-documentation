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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=b23168ed-f2c2-4638-8f5b-e4cc853bae2b&filter%5Blocation_id%5D=645c04c5-09cb-494e-9eb7-638f236b189f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9b132c52-c1ad-58c1-98e1-21d578e3c88a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ef824c3e-8218-4f06-8a1f-bc564172a4f9",
        "item_id": "b23168ed-f2c2-4638-8f5b-e4cc853bae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ef824c3e-8218-4f06-8a1f-bc564172a4f9"
          }
        }
      }
    },
    {
      "id": "7e662e5e-aaa2-5d5e-8ff2-f2c36d07c7ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "82c7bea0-805d-4b77-923b-983d18130c2a",
        "item_id": "b23168ed-f2c2-4638-8f5b-e4cc853bae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/82c7bea0-805d-4b77-923b-983d18130c2a"
          }
        }
      }
    },
    {
      "id": "6caf6cc9-2ecb-560d-9605-451647c797df",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a8a12cb9-3267-45a5-9e05-569d60f4f071",
        "item_id": "b23168ed-f2c2-4638-8f5b-e4cc853bae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a8a12cb9-3267-45a5-9e05-569d60f4f071"
          }
        }
      }
    },
    {
      "id": "f2c94c09-6721-5988-9540-6bb2405ced24",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bfe2609c-69af-4632-8b52-c8f0ed2fba6a",
        "item_id": "b23168ed-f2c2-4638-8f5b-e4cc853bae2b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bfe2609c-69af-4632-8b52-c8f0ed2fba6a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:59:22Z`
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





