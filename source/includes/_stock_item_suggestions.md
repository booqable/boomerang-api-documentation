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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=173e70e1-7239-45a1-b5a4-d74e8154c4b6&filter%5Blocation_id%5D=f5080dce-90d8-48c1-bf45-f7dcd950843f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a0517010-dd53-593c-adf2-812e472a4c6e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f0fc3560-1369-4469-b8aa-f5b5da426c79",
        "item_id": "173e70e1-7239-45a1-b5a4-d74e8154c4b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f0fc3560-1369-4469-b8aa-f5b5da426c79"
          }
        }
      }
    },
    {
      "id": "968fa6b5-6b91-58cf-acc2-6ee032c11021",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "97eb9f9e-dcf2-468b-91f7-ba9cb9e3e91b",
        "item_id": "173e70e1-7239-45a1-b5a4-d74e8154c4b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/97eb9f9e-dcf2-468b-91f7-ba9cb9e3e91b"
          }
        }
      }
    },
    {
      "id": "573e9428-6a06-5285-923b-19a71b15ce70",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3a0f1166-5ffc-40bf-adae-e32869b62a9d",
        "item_id": "173e70e1-7239-45a1-b5a4-d74e8154c4b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3a0f1166-5ffc-40bf-adae-e32869b62a9d"
          }
        }
      }
    },
    {
      "id": "0127ee1b-395e-5572-8393-8ca63b0a1337",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eca9483f-8a15-4bc8-94c6-f6dbdc327a11",
        "item_id": "173e70e1-7239-45a1-b5a4-d74e8154c4b6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eca9483f-8a15-4bc8-94c6-f6dbdc327a11"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-22T15:50:07Z`
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





