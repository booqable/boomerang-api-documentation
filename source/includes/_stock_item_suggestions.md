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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=07b4b9c1-c35f-4534-bebf-957bbe3cbc78&filter%5Blocation_id%5D=c3ee59a9-9038-437a-afc7-88835fcf66db&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0d8a2c78-c790-503a-9703-aff739ddb423",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d444af17-64f6-4f41-aa16-22c22aa9aafe",
        "item_id": "07b4b9c1-c35f-4534-bebf-957bbe3cbc78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d444af17-64f6-4f41-aa16-22c22aa9aafe"
          }
        }
      }
    },
    {
      "id": "d5bc250a-dc6c-5f30-9151-46f8443ad56f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d740d1d3-cd2f-401a-8568-45175ba10a10",
        "item_id": "07b4b9c1-c35f-4534-bebf-957bbe3cbc78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d740d1d3-cd2f-401a-8568-45175ba10a10"
          }
        }
      }
    },
    {
      "id": "67476858-2be2-5f81-8d00-33fb4c20662c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c21a03f4-2328-4b41-af66-1fbd72d508d6",
        "item_id": "07b4b9c1-c35f-4534-bebf-957bbe3cbc78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c21a03f4-2328-4b41-af66-1fbd72d508d6"
          }
        }
      }
    },
    {
      "id": "da2adcaa-ab68-50d6-8bc8-9c248e7b277e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "91b522ce-14d1-4b82-802d-feb1e3329692",
        "item_id": "07b4b9c1-c35f-4534-bebf-957bbe3cbc78",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/91b522ce-14d1-4b82-802d-feb1e3329692"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-07T11:57:44Z`
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





