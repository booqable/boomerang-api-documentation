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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7a3dae3d-04d3-4c2a-bed8-12dbcf6eec8f&filter%5Blocation_id%5D=00acc2fa-ec53-4fc7-a785-c877880471ee&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0b28fb4a-ffd5-5225-a0f6-c334810cb912",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "15312c93-3ee7-4f07-bbfe-31052f437b96",
        "item_id": "7a3dae3d-04d3-4c2a-bed8-12dbcf6eec8f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/15312c93-3ee7-4f07-bbfe-31052f437b96"
          }
        }
      }
    },
    {
      "id": "e3906202-bea9-5d30-82e4-2fa7ce6db079",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "84714263-5f01-4be2-a193-32587284704b",
        "item_id": "7a3dae3d-04d3-4c2a-bed8-12dbcf6eec8f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/84714263-5f01-4be2-a193-32587284704b"
          }
        }
      }
    },
    {
      "id": "474a383b-1759-585e-93e4-b21b611f1c17",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f22dd8da-298f-4f19-836d-cb40d8193bab",
        "item_id": "7a3dae3d-04d3-4c2a-bed8-12dbcf6eec8f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f22dd8da-298f-4f19-836d-cb40d8193bab"
          }
        }
      }
    },
    {
      "id": "16d04326-4204-5add-b270-492273235621",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "14725d83-72f5-458b-9de6-85affebbe7cf",
        "item_id": "7a3dae3d-04d3-4c2a-bed8-12dbcf6eec8f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/14725d83-72f5-458b-9de6-85affebbe7cf"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-21T10:55:43Z`
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





