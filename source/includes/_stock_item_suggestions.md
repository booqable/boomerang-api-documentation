# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=72253fa7-9769-4c04-9816-9493e54e2304&filter%5Blocation_id%5D=65eba264-4ec8-4bf0-a1ac-ff7ad838b78e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fa50b139-8eaa-572c-b218-77a2dae0a1b5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2113c5bc-a844-4ac3-9714-e58bf1b7469a",
        "item_id": "72253fa7-9769-4c04-9816-9493e54e2304",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2113c5bc-a844-4ac3-9714-e58bf1b7469a"
          }
        }
      }
    },
    {
      "id": "bd76ce5f-7079-5be2-a23d-18556f57be51",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bd0d25e0-7f62-4bf0-95f8-caecbee61112",
        "item_id": "72253fa7-9769-4c04-9816-9493e54e2304",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bd0d25e0-7f62-4bf0-95f8-caecbee61112"
          }
        }
      }
    },
    {
      "id": "fc3c16d0-bfdf-5e48-b655-438bb348e45b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a8212553-f469-42a6-91de-02f5adf81fb7",
        "item_id": "72253fa7-9769-4c04-9816-9493e54e2304",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a8212553-f469-42a6-91de-02f5adf81fb7"
          }
        }
      }
    },
    {
      "id": "3f62ce22-bf2a-5f07-9e20-2692c2800f48",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bcae8e12-1f30-443f-808f-69ae55237bc7",
        "item_id": "72253fa7-9769-4c04-9816-9493e54e2304",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bcae8e12-1f30-443f-808f-69ae55237bc7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T15:51:29Z`
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





