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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6102ed02-d030-4ca2-8ced-aa87fbcb7a35&filter%5Blocation_id%5D=e74ed52c-0288-4460-8618-4847ae970ff1&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7bcb6595-40fd-549a-a878-a26d15eb2980",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "772db302-c865-4204-9ba8-ed927af42480",
        "item_id": "6102ed02-d030-4ca2-8ced-aa87fbcb7a35",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/772db302-c865-4204-9ba8-ed927af42480"
          }
        }
      }
    },
    {
      "id": "34475481-4bc0-546b-81b1-9f129f808925",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "516eb57e-26c9-4fb0-b7c6-57a21d5e7e67",
        "item_id": "6102ed02-d030-4ca2-8ced-aa87fbcb7a35",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/516eb57e-26c9-4fb0-b7c6-57a21d5e7e67"
          }
        }
      }
    },
    {
      "id": "d4938ebb-72ff-5126-833f-eb649611842b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6d37beb8-bec4-4fe7-b5db-cc361b2efd7e",
        "item_id": "6102ed02-d030-4ca2-8ced-aa87fbcb7a35",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6d37beb8-bec4-4fe7-b5db-cc361b2efd7e"
          }
        }
      }
    },
    {
      "id": "d3bc2820-405e-5224-bc31-4d82142ebe7f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c16169c0-cb8e-46d4-9aec-ea4af44c9206",
        "item_id": "6102ed02-d030-4ca2-8ced-aa87fbcb7a35",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c16169c0-cb8e-46d4-9aec-ea4af44c9206"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-04T10:04:04Z`
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





