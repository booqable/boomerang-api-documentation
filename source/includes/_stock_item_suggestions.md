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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=31689dc4-61f0-4150-b27d-a8a50809fe9f&filter%5Blocation_id%5D=e4b0b809-1f9a-4cc8-b754-4476d9811cb0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "375afecb-9e09-5178-afa5-805a457fbaea",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "843d2cbe-ce11-420b-8d6a-af2d1568061c",
        "item_id": "31689dc4-61f0-4150-b27d-a8a50809fe9f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/843d2cbe-ce11-420b-8d6a-af2d1568061c"
          }
        }
      }
    },
    {
      "id": "94f199a3-d6dc-55ce-a6ba-1e3fea5901bf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e5fd65f9-3a4e-4138-9df9-3139fd951cb0",
        "item_id": "31689dc4-61f0-4150-b27d-a8a50809fe9f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e5fd65f9-3a4e-4138-9df9-3139fd951cb0"
          }
        }
      }
    },
    {
      "id": "9e089ea5-eca5-5acb-a671-e7fc0dff913c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8e8f301e-aab1-426a-a7ce-05bce438abdb",
        "item_id": "31689dc4-61f0-4150-b27d-a8a50809fe9f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8e8f301e-aab1-426a-a7ce-05bce438abdb"
          }
        }
      }
    },
    {
      "id": "cc60e658-55a0-558e-bc36-b7bb74de8164",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7937a695-6199-4ec6-a70d-aa847607a043",
        "item_id": "31689dc4-61f0-4150-b27d-a8a50809fe9f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7937a695-6199-4ec6-a70d-aa847607a043"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:57:58Z`
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





