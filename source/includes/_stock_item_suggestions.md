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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6d4ffe80-6bf6-43f2-9e3d-2b8c230ddc59&filter%5Blocation_id%5D=d507d42b-1c24-4524-baa9-ea1bf080e9ff&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "707c50ba-a1b2-5619-bed2-baa7bd4225cf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "22daf08a-b335-48ee-a98d-45538f3ede99",
        "item_id": "6d4ffe80-6bf6-43f2-9e3d-2b8c230ddc59",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/22daf08a-b335-48ee-a98d-45538f3ede99"
          }
        }
      }
    },
    {
      "id": "e802bc31-58d4-5765-9777-49ae8fa8c93d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c394a36c-291c-4de9-9cb6-4f763cf0d122",
        "item_id": "6d4ffe80-6bf6-43f2-9e3d-2b8c230ddc59",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c394a36c-291c-4de9-9cb6-4f763cf0d122"
          }
        }
      }
    },
    {
      "id": "c4f2e523-40fd-5236-b20e-f293fb50a7ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "55f16837-e320-4edf-b637-d4c7bcae152d",
        "item_id": "6d4ffe80-6bf6-43f2-9e3d-2b8c230ddc59",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/55f16837-e320-4edf-b637-d4c7bcae152d"
          }
        }
      }
    },
    {
      "id": "eabdd389-c6b4-53f7-98c8-d8761b2a6546",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "47e093c4-d7d3-4b1e-9dd4-9365ec29a8fa",
        "item_id": "6d4ffe80-6bf6-43f2-9e3d-2b8c230ddc59",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/47e093c4-d7d3-4b1e-9dd4-9365ec29a8fa"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:18:50Z`
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





