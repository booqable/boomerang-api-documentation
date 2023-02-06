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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=47542fe2-7e4c-47cc-b08d-a76efabc77a2&filter%5Blocation_id%5D=a339968a-64f7-4e38-918b-7837273127ec&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5776713c-e85c-5574-a3c4-43c1339d2094",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6437e08f-ea56-4f6a-bd8c-7c8cd87aca7b",
        "item_id": "47542fe2-7e4c-47cc-b08d-a76efabc77a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6437e08f-ea56-4f6a-bd8c-7c8cd87aca7b"
          }
        }
      }
    },
    {
      "id": "224a59cf-8904-5512-b9c4-be4f0fa6b207",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "40122c20-5dd8-428c-8a18-a75853183f09",
        "item_id": "47542fe2-7e4c-47cc-b08d-a76efabc77a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/40122c20-5dd8-428c-8a18-a75853183f09"
          }
        }
      }
    },
    {
      "id": "d0ea1e80-5c80-57f7-91b2-2523ee9c87f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2003b95f-c9d4-4993-a9ba-0c6defd4fae4",
        "item_id": "47542fe2-7e4c-47cc-b08d-a76efabc77a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2003b95f-c9d4-4993-a9ba-0c6defd4fae4"
          }
        }
      }
    },
    {
      "id": "e00b2e03-4320-5271-826c-04464e70170e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ce5a42f8-601e-4e00-8fcf-e2b3304ad90b",
        "item_id": "47542fe2-7e4c-47cc-b08d-a76efabc77a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ce5a42f8-601e-4e00-8fcf-e2b3304ad90b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:38:57Z`
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





