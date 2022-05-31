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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e5e53b55-e06f-482a-b805-bef61635d1b0&filter%5Blocation_id%5D=33b20278-0e8b-4d0c-a775-1be4eaa6664c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0679dff6-0207-57eb-88be-53c8f4acdb25",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c15bee6e-5bdd-4c63-9ba6-5d42a584a3d4",
        "item_id": "e5e53b55-e06f-482a-b805-bef61635d1b0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c15bee6e-5bdd-4c63-9ba6-5d42a584a3d4"
          }
        }
      }
    },
    {
      "id": "0084d8f0-6fb1-5b51-add4-2684e6073a57",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4e0a43d3-5726-4320-8ef9-bf75ae092fef",
        "item_id": "e5e53b55-e06f-482a-b805-bef61635d1b0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4e0a43d3-5726-4320-8ef9-bf75ae092fef"
          }
        }
      }
    },
    {
      "id": "a807d366-add2-5c0e-8d5b-3a02d73e137c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "60bb61e2-ac90-4cd1-8037-53ada60c191b",
        "item_id": "e5e53b55-e06f-482a-b805-bef61635d1b0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/60bb61e2-ac90-4cd1-8037-53ada60c191b"
          }
        }
      }
    },
    {
      "id": "189a8128-4fa4-5885-abc1-df959991d28d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "68215062-cffc-49ab-883b-26111a955053",
        "item_id": "e5e53b55-e06f-482a-b805-bef61635d1b0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/68215062-cffc-49ab-883b-26111a955053"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T08:25:19Z`
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





