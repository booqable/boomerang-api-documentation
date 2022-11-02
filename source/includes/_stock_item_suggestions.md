# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1d164370-c169-4cd5-a810-144841fe6a1a&filter%5Blocation_id%5D=7a47cdf7-ccf8-43e4-b87e-5cad0aaca3bf&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8c5d9efb-d784-5463-b44f-d3cab26f99e8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4e5e72f5-4f2d-452c-8625-36009c8a035c",
        "item_id": "1d164370-c169-4cd5-a810-144841fe6a1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4e5e72f5-4f2d-452c-8625-36009c8a035c"
          }
        }
      }
    },
    {
      "id": "aa1d97b8-2369-5eb8-b661-64eefcbdc535",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "02c40927-5e0e-4b64-9284-4e6d8c4fd481",
        "item_id": "1d164370-c169-4cd5-a810-144841fe6a1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/02c40927-5e0e-4b64-9284-4e6d8c4fd481"
          }
        }
      }
    },
    {
      "id": "c95d7382-e40a-5ed9-907e-193a8d7cb6e1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "91c83eef-e6f9-4448-ab3a-96280f390cab",
        "item_id": "1d164370-c169-4cd5-a810-144841fe6a1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/91c83eef-e6f9-4448-ab3a-96280f390cab"
          }
        }
      }
    },
    {
      "id": "2b653dc0-6faf-5a10-8173-0aace7e44b42",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "78240a4d-6a79-4bea-94a8-546da47026a3",
        "item_id": "1d164370-c169-4cd5-a810-144841fe6a1a",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/78240a4d-6a79-4bea-94a8-546da47026a3"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-02T10:18:14Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`action` | **String_enum** <br>`eq`
`q` | **String** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





