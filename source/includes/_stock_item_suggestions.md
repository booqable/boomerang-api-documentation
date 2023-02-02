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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7bfdb68d-560b-4da8-9b83-1773ddf1e510&filter%5Blocation_id%5D=a2802c22-6952-4c1b-a999-15ff86a48533&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "95f00ab0-8b38-5a86-8b68-00f8b4d82544",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7c80ccd5-8840-424e-a014-de463ce7161d",
        "item_id": "7bfdb68d-560b-4da8-9b83-1773ddf1e510",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7c80ccd5-8840-424e-a014-de463ce7161d"
          }
        }
      }
    },
    {
      "id": "c0acd85f-00d9-5969-ab94-ce4fa273557d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "21ad978b-1386-4036-8a5b-e3dd6793776e",
        "item_id": "7bfdb68d-560b-4da8-9b83-1773ddf1e510",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/21ad978b-1386-4036-8a5b-e3dd6793776e"
          }
        }
      }
    },
    {
      "id": "1595a0c5-ed35-54fb-a45a-48bc55ec7b0f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "90f22dba-efac-480f-acd5-e3a756b82368",
        "item_id": "7bfdb68d-560b-4da8-9b83-1773ddf1e510",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/90f22dba-efac-480f-acd5-e3a756b82368"
          }
        }
      }
    },
    {
      "id": "dd74394f-f439-5fa9-b22e-40e344ce8ced",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3f3a45f8-75b0-488d-9e37-fede565a923b",
        "item_id": "7bfdb68d-560b-4da8-9b83-1773ddf1e510",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3f3a45f8-75b0-488d-9e37-fede565a923b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T15:24:28Z`
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





