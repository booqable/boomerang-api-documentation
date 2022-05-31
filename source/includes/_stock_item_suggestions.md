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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=677bf210-87d4-407b-bef1-ec7d5185c4bd&filter%5Blocation_id%5D=daaa4f79-0075-476b-b911-f9fc8bf8af58&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3b169cdf-157c-546d-8ab3-3c93eb751524",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4f1978f8-fbdf-4536-b2a0-85c043a62dd5",
        "item_id": "677bf210-87d4-407b-bef1-ec7d5185c4bd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4f1978f8-fbdf-4536-b2a0-85c043a62dd5"
          }
        }
      }
    },
    {
      "id": "5f852960-5a4f-5cd5-abff-8dfa8cf0a65e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5f5f418f-87ab-4ab2-b2b7-4a9c195441e7",
        "item_id": "677bf210-87d4-407b-bef1-ec7d5185c4bd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5f5f418f-87ab-4ab2-b2b7-4a9c195441e7"
          }
        }
      }
    },
    {
      "id": "1a1ab929-df04-5820-9fd9-080705badf73",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "65727aa9-fbee-4516-9b9e-029e2adf996e",
        "item_id": "677bf210-87d4-407b-bef1-ec7d5185c4bd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/65727aa9-fbee-4516-9b9e-029e2adf996e"
          }
        }
      }
    },
    {
      "id": "8f71bd95-6a04-5908-9128-7aa200e8afd6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "304522f6-56fc-4abc-ba0c-6c5eb7fc3b99",
        "item_id": "677bf210-87d4-407b-bef1-ec7d5185c4bd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/304522f6-56fc-4abc-ba0c-6c5eb7fc3b99"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T06:54:18Z`
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





