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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=73a03589-a8b3-483d-b86b-ff31ba3629b4&filter%5Blocation_id%5D=b6d4e048-5936-485d-a0b9-d85db730b06b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1c5d25b9-47d2-5962-ad44-eeb94e9d3d6b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8df1fb1f-78ec-4ea2-b4e0-4b935af9b160",
        "item_id": "73a03589-a8b3-483d-b86b-ff31ba3629b4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8df1fb1f-78ec-4ea2-b4e0-4b935af9b160"
          }
        }
      }
    },
    {
      "id": "385b9444-47f2-5922-9338-fd6de597659d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bd795fab-f627-4585-ab70-9c93d4277c24",
        "item_id": "73a03589-a8b3-483d-b86b-ff31ba3629b4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bd795fab-f627-4585-ab70-9c93d4277c24"
          }
        }
      }
    },
    {
      "id": "4fc7f252-c69f-5c9e-955b-2c1b8a61bdca",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4e7c50c0-fddd-4a76-8cc9-7444438d0c1e",
        "item_id": "73a03589-a8b3-483d-b86b-ff31ba3629b4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4e7c50c0-fddd-4a76-8cc9-7444438d0c1e"
          }
        }
      }
    },
    {
      "id": "09c7899f-6cea-55a6-98d4-69650fb9e7bc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1ec1fc96-c50e-42a9-80f4-39a1e6ba3bbf",
        "item_id": "73a03589-a8b3-483d-b86b-ff31ba3629b4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1ec1fc96-c50e-42a9-80f4-39a1e6ba3bbf"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T12:40:24Z`
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





