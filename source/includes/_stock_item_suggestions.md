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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1e566b0f-8c87-4d13-a5db-0e05badc2d93&filter%5Blocation_id%5D=3d77d0bf-97c5-4912-9e23-c16995328a5c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f432773f-0ee2-56f0-8c27-7b62b76734de",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "694b9e15-aa28-4ad6-96b1-563dba9dfc5b",
        "item_id": "1e566b0f-8c87-4d13-a5db-0e05badc2d93",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/694b9e15-aa28-4ad6-96b1-563dba9dfc5b"
          }
        }
      }
    },
    {
      "id": "1aca2589-801a-5f57-ba8a-709ad91142db",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "024f5723-ef9d-45f7-a85c-2e7edc08d2e9",
        "item_id": "1e566b0f-8c87-4d13-a5db-0e05badc2d93",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/024f5723-ef9d-45f7-a85c-2e7edc08d2e9"
          }
        }
      }
    },
    {
      "id": "0390aedb-fe6f-5cc5-a37b-8af71ed38309",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "90e26dfe-ccc9-40ec-8521-c6b99f66c71d",
        "item_id": "1e566b0f-8c87-4d13-a5db-0e05badc2d93",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/90e26dfe-ccc9-40ec-8521-c6b99f66c71d"
          }
        }
      }
    },
    {
      "id": "b1c716f5-54e9-575b-96c3-4411719ae942",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4784994d-b321-4e59-a720-7da35ec8cb91",
        "item_id": "1e566b0f-8c87-4d13-a5db-0e05badc2d93",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4784994d-b321-4e59-a720-7da35ec8cb91"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-18T07:33:57Z`
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





