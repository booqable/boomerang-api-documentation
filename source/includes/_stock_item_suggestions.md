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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=49e87e9f-22b9-4c8a-b2b0-93fc2c555869&filter%5Blocation_id%5D=5954c434-428f-43b6-9a51-9f7f0a354ba2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "96566a17-74fd-51bd-9b3f-fcb35169f4fc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "758b3c28-57f4-447a-8c34-ad71c99a3eee",
        "item_id": "49e87e9f-22b9-4c8a-b2b0-93fc2c555869",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/758b3c28-57f4-447a-8c34-ad71c99a3eee"
          }
        }
      }
    },
    {
      "id": "5f84984f-f8d5-5196-9462-f00fbb3a82a5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5323348a-bf64-4528-ac65-89a1f7b63a1d",
        "item_id": "49e87e9f-22b9-4c8a-b2b0-93fc2c555869",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5323348a-bf64-4528-ac65-89a1f7b63a1d"
          }
        }
      }
    },
    {
      "id": "0529e894-7b1a-50e2-9735-051b8f212a6c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b9d22cf0-d792-4977-a602-95f0c11dabd8",
        "item_id": "49e87e9f-22b9-4c8a-b2b0-93fc2c555869",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b9d22cf0-d792-4977-a602-95f0c11dabd8"
          }
        }
      }
    },
    {
      "id": "5e1d654a-2a60-5e49-967c-49006f8f1189",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "813c0edc-2487-4578-b7e0-0ba33c14c258",
        "item_id": "49e87e9f-22b9-4c8a-b2b0-93fc2c555869",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/813c0edc-2487-4578-b7e0-0ba33c14c258"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T14:26:12Z`
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





