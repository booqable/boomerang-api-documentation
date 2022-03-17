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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4d5b035d-ca9e-4b7a-b1f7-e0c07dd596e0&filter%5Blocation_id%5D=b56ee776-c07c-49ee-9dbf-91769538f2d6&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e276feef-5d2e-5985-aef3-1570ba252259",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "79a446a2-43a3-4255-8c3b-c96bbf010442",
        "item_id": "4d5b035d-ca9e-4b7a-b1f7-e0c07dd596e0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/79a446a2-43a3-4255-8c3b-c96bbf010442"
          }
        }
      }
    },
    {
      "id": "ee8f67f4-c281-5665-95d9-76169a95793c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d0fb26e5-7979-4dd1-9a4f-b20947eae5d0",
        "item_id": "4d5b035d-ca9e-4b7a-b1f7-e0c07dd596e0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d0fb26e5-7979-4dd1-9a4f-b20947eae5d0"
          }
        }
      }
    },
    {
      "id": "1279e647-b0a8-573a-a24d-275e8914b82e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cab020af-b13b-4d3b-acdc-227b2d5fdc13",
        "item_id": "4d5b035d-ca9e-4b7a-b1f7-e0c07dd596e0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cab020af-b13b-4d3b-acdc-227b2d5fdc13"
          }
        }
      }
    },
    {
      "id": "1f78aaab-f46d-5fb0-af12-f6d5cb193cd6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f648e72b-5d4c-48b1-b819-d6b20b883598",
        "item_id": "4d5b035d-ca9e-4b7a-b1f7-e0c07dd596e0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f648e72b-5d4c-48b1-b819-d6b20b883598"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-17T10:02:08Z`
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





