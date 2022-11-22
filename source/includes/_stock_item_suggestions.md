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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=99021ae8-19b6-4e00-bd56-a328f5e174d0&filter%5Blocation_id%5D=af9a7d17-e6bd-4ca5-92c7-f6b788d9cac6&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fb127388-f005-588a-b197-fb9c5e045d60",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0a17591f-a9d8-4299-96f1-d8034fda22ac",
        "item_id": "99021ae8-19b6-4e00-bd56-a328f5e174d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0a17591f-a9d8-4299-96f1-d8034fda22ac"
          }
        }
      }
    },
    {
      "id": "f2fcf053-621f-58bc-995d-0eb5b85cdb3a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "24a0f73f-28b8-41d3-bbac-e598d9923927",
        "item_id": "99021ae8-19b6-4e00-bd56-a328f5e174d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/24a0f73f-28b8-41d3-bbac-e598d9923927"
          }
        }
      }
    },
    {
      "id": "5cfbb85b-5244-55bb-8c57-3125b9020f0c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f4552847-ab6c-4da6-948e-ce001534b4c9",
        "item_id": "99021ae8-19b6-4e00-bd56-a328f5e174d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f4552847-ab6c-4da6-948e-ce001534b4c9"
          }
        }
      }
    },
    {
      "id": "1bf9bd1d-fbb9-5818-8563-4bf487cd38c8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e58f0406-1852-4807-8e5d-08d35243de04",
        "item_id": "99021ae8-19b6-4e00-bd56-a328f5e174d0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e58f0406-1852-4807-8e5d-08d35243de04"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:33:13Z`
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





