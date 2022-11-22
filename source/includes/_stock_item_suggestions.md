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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=de8eb73b-e4f8-49aa-a48c-4b99a54e19c3&filter%5Blocation_id%5D=8a937423-3a51-46c7-9f7f-0e795fc3a2a9&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "153983e3-fffa-5e68-a993-ec4c52d422ae",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cd0ea4f2-f1a0-4732-81b3-f3eab0f3dd19",
        "item_id": "de8eb73b-e4f8-49aa-a48c-4b99a54e19c3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cd0ea4f2-f1a0-4732-81b3-f3eab0f3dd19"
          }
        }
      }
    },
    {
      "id": "74cf8b88-83ee-518c-af15-6464bc2a46c0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "46573a7c-20ea-46e7-9e57-a06671c81597",
        "item_id": "de8eb73b-e4f8-49aa-a48c-4b99a54e19c3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/46573a7c-20ea-46e7-9e57-a06671c81597"
          }
        }
      }
    },
    {
      "id": "96fe0617-406e-5e64-a787-3907a9efccfe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "980ed273-a81a-4c5f-bb9d-b522baaaeccb",
        "item_id": "de8eb73b-e4f8-49aa-a48c-4b99a54e19c3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/980ed273-a81a-4c5f-bb9d-b522baaaeccb"
          }
        }
      }
    },
    {
      "id": "c2643760-a4f9-5e59-ab2c-1ae8e58db73f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "afd2aef1-8624-453f-a673-76ff6d6394c9",
        "item_id": "de8eb73b-e4f8-49aa-a48c-4b99a54e19c3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/afd2aef1-8624-453f-a673-76ff6d6394c9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:49:26Z`
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





