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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=55ef6781-6b74-45a3-8ce4-9199efba1ceb&filter%5Blocation_id%5D=a1ee833b-a9c4-41b1-ae1e-f84f321caa1e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "94cab323-4b79-5781-b63a-eb670a925f73",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "55919a4b-6b2c-4c63-83cf-5f82522ae792",
        "item_id": "55ef6781-6b74-45a3-8ce4-9199efba1ceb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/55919a4b-6b2c-4c63-83cf-5f82522ae792"
          }
        }
      }
    },
    {
      "id": "670ad7df-7d01-5f87-ad2d-de855ebc4cb1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2a3fd4e6-b7e6-4b07-8b86-6d00c02f4d0d",
        "item_id": "55ef6781-6b74-45a3-8ce4-9199efba1ceb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2a3fd4e6-b7e6-4b07-8b86-6d00c02f4d0d"
          }
        }
      }
    },
    {
      "id": "3f271aa4-6985-51ee-bdde-4e5a4e470556",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3a6ece9a-4a5b-4bdc-ac9d-fa228db9ceec",
        "item_id": "55ef6781-6b74-45a3-8ce4-9199efba1ceb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3a6ece9a-4a5b-4bdc-ac9d-fa228db9ceec"
          }
        }
      }
    },
    {
      "id": "63d99208-90a8-5144-893f-e8c25d3907d8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8e1f4020-dac6-4e36-b40a-577ce39b5896",
        "item_id": "55ef6781-6b74-45a3-8ce4-9199efba1ceb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8e1f4020-dac6-4e36-b40a-577ce39b5896"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:23:31Z`
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





