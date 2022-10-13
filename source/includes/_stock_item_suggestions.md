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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=5a95f89f-c9c6-44fe-b844-1e874333167f&filter%5Blocation_id%5D=f6bf40c1-beea-4776-8b79-47fad188c5a8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f78b7c97-2b8c-5fe1-87b7-eda0ffdde5c9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8330b767-7e17-4d63-bcfc-bc76a915f280",
        "item_id": "5a95f89f-c9c6-44fe-b844-1e874333167f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8330b767-7e17-4d63-bcfc-bc76a915f280"
          }
        }
      }
    },
    {
      "id": "f82a84a8-4c30-5c50-a20e-ca46d798a2c9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "15be30de-94e5-46b4-b034-c2c977ca6d52",
        "item_id": "5a95f89f-c9c6-44fe-b844-1e874333167f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/15be30de-94e5-46b4-b034-c2c977ca6d52"
          }
        }
      }
    },
    {
      "id": "6b61ae05-9ef8-582b-bc49-65b92bed4bb6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6a2cad81-abf5-4a3a-a8ac-1ca994dc2ba4",
        "item_id": "5a95f89f-c9c6-44fe-b844-1e874333167f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6a2cad81-abf5-4a3a-a8ac-1ca994dc2ba4"
          }
        }
      }
    },
    {
      "id": "3ca7b2a1-6680-5f58-8f10-84bdfef92b4e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "127b7748-b9fa-4c28-a394-5ad2a3ec0e59",
        "item_id": "5a95f89f-c9c6-44fe-b844-1e874333167f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/127b7748-b9fa-4c28-a394-5ad2a3ec0e59"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T15:41:57Z`
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





