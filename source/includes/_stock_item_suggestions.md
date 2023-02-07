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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f277011c-f727-4edc-8f6f-038e6696c839&filter%5Blocation_id%5D=28516475-3f01-48da-9dc4-79fa454a892f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6ab20f5b-8b6b-5dd8-ac8b-9466307aa4f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "df943eeb-1b37-49c3-bfb5-714a4b688de2",
        "item_id": "f277011c-f727-4edc-8f6f-038e6696c839",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/df943eeb-1b37-49c3-bfb5-714a4b688de2"
          }
        }
      }
    },
    {
      "id": "8ca2025f-879c-5c60-9ac3-f5a70dc630cc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cb5fc9ad-71a0-466a-a74a-943b3abdb194",
        "item_id": "f277011c-f727-4edc-8f6f-038e6696c839",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cb5fc9ad-71a0-466a-a74a-943b3abdb194"
          }
        }
      }
    },
    {
      "id": "936c7698-7d2c-5ae1-827a-43ab7f00606d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ff384118-5ac2-49a9-9b59-fe8594d74e45",
        "item_id": "f277011c-f727-4edc-8f6f-038e6696c839",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ff384118-5ac2-49a9-9b59-fe8594d74e45"
          }
        }
      }
    },
    {
      "id": "7ff24ad0-dad4-5440-b718-f97154a08215",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "27855dbf-7e4c-4f88-93af-c81da723cd60",
        "item_id": "f277011c-f727-4edc-8f6f-038e6696c839",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/27855dbf-7e4c-4f88-93af-c81da723cd60"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T09:26:34Z`
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





