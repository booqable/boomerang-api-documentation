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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=71e91e2e-0eb7-4115-980d-3282fa37bbf6&filter%5Blocation_id%5D=b8f8474a-a7c5-423f-904c-b858ce1057b7&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7ad76a4e-db85-57b3-9bdc-e8034ffc5f5d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6ee2a7e2-547e-4544-922e-74fd10bd90f0",
        "item_id": "71e91e2e-0eb7-4115-980d-3282fa37bbf6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6ee2a7e2-547e-4544-922e-74fd10bd90f0"
          }
        }
      }
    },
    {
      "id": "a4d13eaf-4f81-5134-abb4-c2d9e048ac00",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "720a6a5f-62fb-4a00-90d5-522fe5af4bfc",
        "item_id": "71e91e2e-0eb7-4115-980d-3282fa37bbf6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/720a6a5f-62fb-4a00-90d5-522fe5af4bfc"
          }
        }
      }
    },
    {
      "id": "78a4752b-928d-5f5d-9fae-dcb4aa17161a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e09dc955-cf08-4db9-aa24-ac2fc9eedbf5",
        "item_id": "71e91e2e-0eb7-4115-980d-3282fa37bbf6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e09dc955-cf08-4db9-aa24-ac2fc9eedbf5"
          }
        }
      }
    },
    {
      "id": "fa290542-4483-57e8-9154-90fed9a893e8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7e807069-ed36-49b6-9e20-328e673bea20",
        "item_id": "71e91e2e-0eb7-4115-980d-3282fa37bbf6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7e807069-ed36-49b6-9e20-328e673bea20"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T08:00:36Z`
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





