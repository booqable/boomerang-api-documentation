# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid**<br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=2a91e28d-2129-4f7b-a079-a0b2546d6ccb&filter%5Blocation_id%5D=3872e83f-5caa-4165-956c-f94dba6fc3a9&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5f0ca330-2433-537a-beed-64ac02169bcd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5d25be7a-23d0-492b-9667-e83ba6db9a9c",
        "item_id": "2a91e28d-2129-4f7b-a079-a0b2546d6ccb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5d25be7a-23d0-492b-9667-e83ba6db9a9c"
          }
        }
      }
    },
    {
      "id": "3bde4406-d370-5c00-bef6-6c7ffdb32527",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2a307190-03d4-44b8-943f-c158d1d46619",
        "item_id": "2a91e28d-2129-4f7b-a079-a0b2546d6ccb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2a307190-03d4-44b8-943f-c158d1d46619"
          }
        }
      }
    },
    {
      "id": "01911ca6-56b2-5fcb-843e-5eeed11c49d0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a4a6d1eb-c740-4905-8723-988b2e8be501",
        "item_id": "2a91e28d-2129-4f7b-a079-a0b2546d6ccb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a4a6d1eb-c740-4905-8723-988b2e8be501"
          }
        }
      }
    },
    {
      "id": "9317567f-94e0-5c8d-bb01-b8211a3d266a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9a973040-a295-408f-b5ce-72e3b6388b7c",
        "item_id": "2a91e28d-2129-4f7b-a079-a0b2546d6ccb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9a973040-a295-408f-b5ce-72e3b6388b7c"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:13:34Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum**<br>`eq`
`order_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`action` | **String_enum**<br>`eq`
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`





