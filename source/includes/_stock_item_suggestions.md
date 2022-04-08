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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=840fb3b2-5176-4ac7-9e90-5a71240f6eca&filter%5Blocation_id%5D=5e3fcaa3-0ff1-4c2c-b230-e0ceedc7a042&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a5949ef6-74ac-54b6-a9b2-eee5f74ab371",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dcc9f878-671b-484a-838f-68c51f0da845",
        "item_id": "840fb3b2-5176-4ac7-9e90-5a71240f6eca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dcc9f878-671b-484a-838f-68c51f0da845"
          }
        }
      }
    },
    {
      "id": "e3cdc8f4-51ae-5efb-8b4d-4631c82305cc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dfaa97df-59d2-494c-b613-8f9ff9a500b5",
        "item_id": "840fb3b2-5176-4ac7-9e90-5a71240f6eca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dfaa97df-59d2-494c-b613-8f9ff9a500b5"
          }
        }
      }
    },
    {
      "id": "78794b1b-d3b2-559e-b473-fb31ba20877f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "74c2554e-e0cf-41e8-87aa-c94ee4b87419",
        "item_id": "840fb3b2-5176-4ac7-9e90-5a71240f6eca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/74c2554e-e0cf-41e8-87aa-c94ee4b87419"
          }
        }
      }
    },
    {
      "id": "60dba5a5-9c38-529c-bb74-920b32b45c92",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "39f61885-39f5-4756-9474-dd5d628a1d89",
        "item_id": "840fb3b2-5176-4ac7-9e90-5a71240f6eca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/39f61885-39f5-4756-9474-dd5d628a1d89"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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





