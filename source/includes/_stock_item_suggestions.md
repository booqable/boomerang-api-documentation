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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1f4a8b6c-b3a6-4536-9985-184f835fa8ce&filter%5Blocation_id%5D=8d2ee0e3-2d57-4a31-a260-d79c18e250f4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4656908a-5304-5b21-b8ae-d02d27661606",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "78d71929-e9b4-46f7-b54f-21ca6ec5006f",
        "item_id": "1f4a8b6c-b3a6-4536-9985-184f835fa8ce",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/78d71929-e9b4-46f7-b54f-21ca6ec5006f"
          }
        }
      }
    },
    {
      "id": "23816f0e-48ef-50da-9087-641fd27d71bf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "85966c95-594c-4a62-a1a9-e68c67381865",
        "item_id": "1f4a8b6c-b3a6-4536-9985-184f835fa8ce",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/85966c95-594c-4a62-a1a9-e68c67381865"
          }
        }
      }
    },
    {
      "id": "2f7a22ec-8d46-5d3b-b4b8-2795de073b7d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ba8dd7df-643d-4f99-8693-ec3ee5c1c238",
        "item_id": "1f4a8b6c-b3a6-4536-9985-184f835fa8ce",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ba8dd7df-643d-4f99-8693-ec3ee5c1c238"
          }
        }
      }
    },
    {
      "id": "4b2bb62c-b981-58b5-84e9-1f407d9571bc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1d565dfd-4d75-4505-86fa-6fcb2b360392",
        "item_id": "1f4a8b6c-b3a6-4536-9985-184f835fa8ce",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1d565dfd-4d75-4505-86fa-6fcb2b360392"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-08T13:51:46Z`
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





