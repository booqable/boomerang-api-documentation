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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e1988836-3a90-4b29-b0a3-d33af06f02aa&filter%5Blocation_id%5D=e24073e7-beb5-446c-a203-57253beb2593&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e81fa44-b899-562b-9045-5cf6316e1334",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "98248699-81b1-434f-9e6c-ad0bff84aba2",
        "item_id": "e1988836-3a90-4b29-b0a3-d33af06f02aa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/98248699-81b1-434f-9e6c-ad0bff84aba2"
          }
        }
      }
    },
    {
      "id": "bc0ab832-909e-5117-b5d6-90ba703aa337",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "239b7ad7-f319-4cb5-a8d4-3ddf6606f678",
        "item_id": "e1988836-3a90-4b29-b0a3-d33af06f02aa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/239b7ad7-f319-4cb5-a8d4-3ddf6606f678"
          }
        }
      }
    },
    {
      "id": "b8dcc1c5-8e23-57cd-9dad-a97f890f63b3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "510a7ecf-3d65-4002-8a92-c1c2582d17ec",
        "item_id": "e1988836-3a90-4b29-b0a3-d33af06f02aa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/510a7ecf-3d65-4002-8a92-c1c2582d17ec"
          }
        }
      }
    },
    {
      "id": "7a59215f-7fbb-5f43-acb8-2432c7d1fec4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "25ccb44e-8f7f-4aac-a6ce-573865c87328",
        "item_id": "e1988836-3a90-4b29-b0a3-d33af06f02aa",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/25ccb44e-8f7f-4aac-a6ce-573865c87328"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T09:50:47Z`
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





