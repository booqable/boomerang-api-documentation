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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=2bb0e3f8-04da-428c-b68c-07c109e7cecf&filter%5Blocation_id%5D=4527eaf9-2c44-4a69-b094-b9f00635db0c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ed0cbb94-8703-5ffd-afa3-e85d65114f7d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3b63ba63-b6c2-4451-a26a-4407ec15f7b9",
        "item_id": "2bb0e3f8-04da-428c-b68c-07c109e7cecf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3b63ba63-b6c2-4451-a26a-4407ec15f7b9"
          }
        }
      }
    },
    {
      "id": "84d59fc6-0801-5557-8e5c-b9e44af0fa61",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "81c26b8d-0b2f-4572-b854-e07898ddf174",
        "item_id": "2bb0e3f8-04da-428c-b68c-07c109e7cecf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/81c26b8d-0b2f-4572-b854-e07898ddf174"
          }
        }
      }
    },
    {
      "id": "7cf0526b-da4a-5939-b599-59d7c0c5c901",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "497fc67a-4514-49e9-98b9-62f5394f9a55",
        "item_id": "2bb0e3f8-04da-428c-b68c-07c109e7cecf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/497fc67a-4514-49e9-98b9-62f5394f9a55"
          }
        }
      }
    },
    {
      "id": "fb6c3233-4ec7-51ba-8ad1-e730b2da9029",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d52b2077-7431-428d-a5ce-0a6337dba2ad",
        "item_id": "2bb0e3f8-04da-428c-b68c-07c109e7cecf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d52b2077-7431-428d-a5ce-0a6337dba2ad"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T10:16:02Z`
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





