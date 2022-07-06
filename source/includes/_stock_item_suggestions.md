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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=0415756b-223b-421d-8c36-739ebdb28a92&filter%5Blocation_id%5D=4b9a1f69-62ad-40af-bb35-94f71f8bd168&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c5956e07-5c1d-5b78-a957-1bd543232704",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ead2d1fa-a275-46c4-8d80-9791556d9789",
        "item_id": "0415756b-223b-421d-8c36-739ebdb28a92",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ead2d1fa-a275-46c4-8d80-9791556d9789"
          }
        }
      }
    },
    {
      "id": "e3e12e2d-5c76-5676-a4d8-e5a62f4c3d5f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cb04fccc-eddd-47f7-a1c7-d053c1ab90ce",
        "item_id": "0415756b-223b-421d-8c36-739ebdb28a92",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cb04fccc-eddd-47f7-a1c7-d053c1ab90ce"
          }
        }
      }
    },
    {
      "id": "40fedcc6-8936-5516-900d-a98fa9f153f7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e5394e66-baee-44ba-8c18-ca248006a52e",
        "item_id": "0415756b-223b-421d-8c36-739ebdb28a92",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e5394e66-baee-44ba-8c18-ca248006a52e"
          }
        }
      }
    },
    {
      "id": "7e677a36-213c-5a42-94f9-10912491eab8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c3e632da-0ba1-4b72-a563-37ba488d9a76",
        "item_id": "0415756b-223b-421d-8c36-739ebdb28a92",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c3e632da-0ba1-4b72-a563-37ba488d9a76"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-06T08:12:01Z`
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





