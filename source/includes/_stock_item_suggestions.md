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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7ec016f9-5778-4e10-bb03-b8b9bca40f43&filter%5Blocation_id%5D=7985c865-deb5-417b-bbd0-bfc6cec6f02d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a1a15ba7-c3a9-5c36-951f-5215ba90bff5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "44b14980-7daa-45f7-bebf-22566d542c35",
        "item_id": "7ec016f9-5778-4e10-bb03-b8b9bca40f43",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/44b14980-7daa-45f7-bebf-22566d542c35"
          }
        }
      }
    },
    {
      "id": "666b15fd-9c39-5995-bb65-bfa514d06a9c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "adfde894-c05a-4a32-9c1a-f132ae51dbd5",
        "item_id": "7ec016f9-5778-4e10-bb03-b8b9bca40f43",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/adfde894-c05a-4a32-9c1a-f132ae51dbd5"
          }
        }
      }
    },
    {
      "id": "36fa04a5-45df-5a5e-a477-b8f7e8c2cd91",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f85efa44-1445-4d2d-af00-7d0f6c684b5e",
        "item_id": "7ec016f9-5778-4e10-bb03-b8b9bca40f43",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f85efa44-1445-4d2d-af00-7d0f6c684b5e"
          }
        }
      }
    },
    {
      "id": "ae4ba012-d5e3-5722-82f0-734dc06984bf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0ffe5777-57eb-49af-89c8-2ec49edf44b6",
        "item_id": "7ec016f9-5778-4e10-bb03-b8b9bca40f43",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0ffe5777-57eb-49af-89c8-2ec49edf44b6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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





