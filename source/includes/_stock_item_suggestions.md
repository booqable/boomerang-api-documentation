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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bd719920-53b7-45f7-ae97-91ddddb34750&filter%5Blocation_id%5D=57ee2bb5-1ae7-4696-9dd2-59d906b0274a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "547217c4-9579-5002-ac33-351544e86a4e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e1d740ae-ddbe-443d-bf9a-ce5c88d30325",
        "item_id": "bd719920-53b7-45f7-ae97-91ddddb34750",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e1d740ae-ddbe-443d-bf9a-ce5c88d30325"
          }
        }
      }
    },
    {
      "id": "0eab9e62-217e-5a41-aa2b-0dfcf36eddfe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2414fa50-2f07-4521-83c5-8c44bf160f38",
        "item_id": "bd719920-53b7-45f7-ae97-91ddddb34750",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2414fa50-2f07-4521-83c5-8c44bf160f38"
          }
        }
      }
    },
    {
      "id": "05864eb9-1c52-5f3c-96c3-10e0d860c5dc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d2ee22e7-16fa-4ce5-8e01-c0fecc6eabc4",
        "item_id": "bd719920-53b7-45f7-ae97-91ddddb34750",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d2ee22e7-16fa-4ce5-8e01-c0fecc6eabc4"
          }
        }
      }
    },
    {
      "id": "0bfbdf7e-1c4d-55f5-891d-6d5babdc3811",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5e1ed619-2ba8-45a8-91b1-1e2f07da5779",
        "item_id": "bd719920-53b7-45f7-ae97-91ddddb34750",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5e1ed619-2ba8-45a8-91b1-1e2f07da5779"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T14:00:04Z`
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





