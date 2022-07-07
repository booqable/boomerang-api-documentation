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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f158675b-da1c-40d9-bac4-c626951d11f8&filter%5Blocation_id%5D=f10f27b1-ca10-4422-ba30-2a8e3aadfc79&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9525ee83-91d0-5c88-99e0-d6aea6261ea5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5b362c39-6047-4856-8450-0a60324eaec1",
        "item_id": "f158675b-da1c-40d9-bac4-c626951d11f8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5b362c39-6047-4856-8450-0a60324eaec1"
          }
        }
      }
    },
    {
      "id": "df05cd62-34dd-5e30-8d1d-02362c26ad7e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3ea9855f-30de-46ee-8d2c-5d3e32dd8022",
        "item_id": "f158675b-da1c-40d9-bac4-c626951d11f8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3ea9855f-30de-46ee-8d2c-5d3e32dd8022"
          }
        }
      }
    },
    {
      "id": "d740c531-9807-586f-8f96-91f113109136",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fe427cd5-1d63-446e-84c5-53a3edb8b5d8",
        "item_id": "f158675b-da1c-40d9-bac4-c626951d11f8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fe427cd5-1d63-446e-84c5-53a3edb8b5d8"
          }
        }
      }
    },
    {
      "id": "e7757b76-c087-5cdd-bd8b-3315e2aeb0c1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9e7b01ec-9d6b-47f1-937d-3bf8b80c76c4",
        "item_id": "f158675b-da1c-40d9-bac4-c626951d11f8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9e7b01ec-9d6b-47f1-937d-3bf8b80c76c4"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-07T12:15:58Z`
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





