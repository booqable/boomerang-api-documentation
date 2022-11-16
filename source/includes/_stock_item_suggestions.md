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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=8361ecda-ac85-4f59-9695-72ee39e9142c&filter%5Blocation_id%5D=8aa3b0bb-561d-4978-9b6e-22fd18c0c01a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7a37036f-6d5b-5d00-b0f9-9113bc58ef23",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f9aae508-2cf2-4a86-84af-82096186e7de",
        "item_id": "8361ecda-ac85-4f59-9695-72ee39e9142c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f9aae508-2cf2-4a86-84af-82096186e7de"
          }
        }
      }
    },
    {
      "id": "dceb9692-01a2-5e5e-9160-63b1bded811c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "32bb2c78-ac25-459d-bf3e-b8403782991d",
        "item_id": "8361ecda-ac85-4f59-9695-72ee39e9142c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/32bb2c78-ac25-459d-bf3e-b8403782991d"
          }
        }
      }
    },
    {
      "id": "8c602725-6559-5fe6-a270-4d0ef307b300",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6d79e33e-23a2-4e64-b2f9-d3b517f515d7",
        "item_id": "8361ecda-ac85-4f59-9695-72ee39e9142c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6d79e33e-23a2-4e64-b2f9-d3b517f515d7"
          }
        }
      }
    },
    {
      "id": "6588b976-db7b-5a50-9779-4a062c211039",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a5a68920-ec95-414b-a09c-3e28c6f3cdcf",
        "item_id": "8361ecda-ac85-4f59-9695-72ee39e9142c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a5a68920-ec95-414b-a09c-3e28c6f3cdcf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:30:09Z`
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





