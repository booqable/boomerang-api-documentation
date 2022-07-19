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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6a788926-42b1-4d2d-a3a6-db87a46567fe&filter%5Blocation_id%5D=6393acc6-717f-45c3-8076-2f98e1c8fce4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1bedb759-e7ed-5483-98a0-5b97d84dc73c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "52bae824-4ce7-483e-a76b-e5f357bb4f5d",
        "item_id": "6a788926-42b1-4d2d-a3a6-db87a46567fe",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/52bae824-4ce7-483e-a76b-e5f357bb4f5d"
          }
        }
      }
    },
    {
      "id": "2cd424af-252c-5f95-ab5b-1216f2106056",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a5e3afc9-be74-4b75-b717-4f5bd034c803",
        "item_id": "6a788926-42b1-4d2d-a3a6-db87a46567fe",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a5e3afc9-be74-4b75-b717-4f5bd034c803"
          }
        }
      }
    },
    {
      "id": "fb91a6ab-51ee-5577-be87-2e64d5537c35",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ae675a43-7c79-467e-a062-4027837f3213",
        "item_id": "6a788926-42b1-4d2d-a3a6-db87a46567fe",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ae675a43-7c79-467e-a062-4027837f3213"
          }
        }
      }
    },
    {
      "id": "00b56860-eab3-53fd-8d53-d8a9b435c453",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c03a3c9e-5c82-4a22-9ed9-41a85b527faa",
        "item_id": "6a788926-42b1-4d2d-a3a6-db87a46567fe",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c03a3c9e-5c82-4a22-9ed9-41a85b527faa"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-19T12:34:47Z`
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





