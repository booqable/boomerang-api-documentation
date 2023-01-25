# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=08fcd5d6-f340-4cca-aebd-7946b1f4da9e&filter%5Blocation_id%5D=4c6aac34-d55a-4969-82b0-41da236a339e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "811dfd40-34bf-550a-be18-d775ae598ed5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6f06f4cc-384e-473b-973a-40b06982b782",
        "item_id": "08fcd5d6-f340-4cca-aebd-7946b1f4da9e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6f06f4cc-384e-473b-973a-40b06982b782"
          }
        }
      }
    },
    {
      "id": "e01d1aa1-5168-590d-96a1-e9ce3ffabca0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bc3b40c8-0205-4b1c-b4c4-d048d7f5b479",
        "item_id": "08fcd5d6-f340-4cca-aebd-7946b1f4da9e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bc3b40c8-0205-4b1c-b4c4-d048d7f5b479"
          }
        }
      }
    },
    {
      "id": "465ed093-5acc-5c18-a03b-1e064cf691bb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a0c6b6c5-4612-419d-b910-52864442baf8",
        "item_id": "08fcd5d6-f340-4cca-aebd-7946b1f4da9e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a0c6b6c5-4612-419d-b910-52864442baf8"
          }
        }
      }
    },
    {
      "id": "1e2bef59-e21a-59a3-957d-db4c3384a27a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "adc6ce70-8e4e-48fc-9cf3-a27cc0680957",
        "item_id": "08fcd5d6-f340-4cca-aebd-7946b1f4da9e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/adc6ce70-8e4e-48fc-9cf3-a27cc0680957"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-25T12:33:37Z`
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





