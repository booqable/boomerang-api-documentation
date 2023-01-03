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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d94c8591-944e-4d82-8fda-57bbfc3096d8&filter%5Blocation_id%5D=7b6c5689-d0b3-4220-b436-c390f53399de&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "515ea82d-c434-5ba4-874b-e4ea9c80e3ac",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e1a0af4a-6ce9-46cf-9f64-8223c06f2437",
        "item_id": "d94c8591-944e-4d82-8fda-57bbfc3096d8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e1a0af4a-6ce9-46cf-9f64-8223c06f2437"
          }
        }
      }
    },
    {
      "id": "60f25c65-a5e2-5b31-818b-7032396aba9a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bf23f34a-4e3c-4a76-9ec9-ccae1571e9bf",
        "item_id": "d94c8591-944e-4d82-8fda-57bbfc3096d8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bf23f34a-4e3c-4a76-9ec9-ccae1571e9bf"
          }
        }
      }
    },
    {
      "id": "a2569257-5f8a-54d6-9561-ef1ea4ceacfe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fafdb071-c4a1-4440-93ba-a5be0b72c93c",
        "item_id": "d94c8591-944e-4d82-8fda-57bbfc3096d8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fafdb071-c4a1-4440-93ba-a5be0b72c93c"
          }
        }
      }
    },
    {
      "id": "95233a33-3f49-5d36-8dbb-885b16d035ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3c934e1d-24fa-42a7-9a07-7e466fa2eba0",
        "item_id": "d94c8591-944e-4d82-8fda-57bbfc3096d8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3c934e1d-24fa-42a7-9a07-7e466fa2eba0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-03T12:11:08Z`
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





