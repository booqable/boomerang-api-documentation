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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9a026065-925b-49b4-a880-58d76eb7b9cd&filter%5Blocation_id%5D=7deeba9f-e034-44e0-b468-fd12f8c69b53&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b5204aa4-a4a4-54f2-b9db-54e8aa67ac83",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c828d7f6-f5e2-4bc6-abd2-5942046933a6",
        "item_id": "9a026065-925b-49b4-a880-58d76eb7b9cd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c828d7f6-f5e2-4bc6-abd2-5942046933a6"
          }
        }
      }
    },
    {
      "id": "7997db34-1366-53cb-9786-9e197957a91f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "41f8526a-2f18-4ac1-8265-e655dcd80621",
        "item_id": "9a026065-925b-49b4-a880-58d76eb7b9cd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/41f8526a-2f18-4ac1-8265-e655dcd80621"
          }
        }
      }
    },
    {
      "id": "0d78dc1e-a100-52d0-89e8-bba3948abf74",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cbbfe5a8-0638-4e95-bf0e-b149fa749d07",
        "item_id": "9a026065-925b-49b4-a880-58d76eb7b9cd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cbbfe5a8-0638-4e95-bf0e-b149fa749d07"
          }
        }
      }
    },
    {
      "id": "e4ee1fb7-713b-5dc6-97ee-24c3c0bbd223",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "49eedd4f-89c4-402d-b515-89eea35fd7e3",
        "item_id": "9a026065-925b-49b4-a880-58d76eb7b9cd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/49eedd4f-89c4-402d-b515-89eea35fd7e3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T12:07:11Z`
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





