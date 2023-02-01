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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6654426e-31fb-4909-ab45-75a83efeca78&filter%5Blocation_id%5D=2cbbee3a-5013-4b61-96a3-836ec829325a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b2d0b2d8-ab4f-5d0c-8180-6199c1636792",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fa51c416-181b-4c07-aeae-d67683d077f2",
        "item_id": "6654426e-31fb-4909-ab45-75a83efeca78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fa51c416-181b-4c07-aeae-d67683d077f2"
          }
        }
      }
    },
    {
      "id": "fc91f82e-7931-528d-9c00-914b6f7f13ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eaab688b-2bd0-4521-8f39-b91d52da072c",
        "item_id": "6654426e-31fb-4909-ab45-75a83efeca78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eaab688b-2bd0-4521-8f39-b91d52da072c"
          }
        }
      }
    },
    {
      "id": "c3a40613-523d-58e1-bc48-8e13ea34329a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "81b29cdc-d072-45d2-ab0e-a204df273c55",
        "item_id": "6654426e-31fb-4909-ab45-75a83efeca78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/81b29cdc-d072-45d2-ab0e-a204df273c55"
          }
        }
      }
    },
    {
      "id": "1c043783-2966-5590-b1a4-b52dafe6791d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "40029739-5228-4b0f-9342-b646a751ad01",
        "item_id": "6654426e-31fb-4909-ab45-75a83efeca78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/40029739-5228-4b0f-9342-b646a751ad01"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:13:38Z`
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





