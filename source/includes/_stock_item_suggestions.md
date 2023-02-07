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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=687f7b10-9de9-4a15-ab8b-8314f36e2a6f&filter%5Blocation_id%5D=37e7d5a0-726c-4d5d-9f30-d886398f8a06&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "84c24463-dca7-557b-a930-8e0564049ec8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ae587620-e363-4af8-b91f-e2abe5aea619",
        "item_id": "687f7b10-9de9-4a15-ab8b-8314f36e2a6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ae587620-e363-4af8-b91f-e2abe5aea619"
          }
        }
      }
    },
    {
      "id": "e49ec464-fc71-522d-a005-7a7e22b83b4e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5e94e1ba-d7c8-4480-926f-436e5d3a3447",
        "item_id": "687f7b10-9de9-4a15-ab8b-8314f36e2a6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5e94e1ba-d7c8-4480-926f-436e5d3a3447"
          }
        }
      }
    },
    {
      "id": "177a9dd7-0c96-5e41-9527-c51dd9eac6c1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9baca6bb-e85c-41fb-80bf-1b17a50724cd",
        "item_id": "687f7b10-9de9-4a15-ab8b-8314f36e2a6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9baca6bb-e85c-41fb-80bf-1b17a50724cd"
          }
        }
      }
    },
    {
      "id": "31a65361-2c96-529e-8120-a649248d9c99",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f61ee50a-8284-4713-bc74-f05e914bbab6",
        "item_id": "687f7b10-9de9-4a15-ab8b-8314f36e2a6f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f61ee50a-8284-4713-bc74-f05e914bbab6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:26:13Z`
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





