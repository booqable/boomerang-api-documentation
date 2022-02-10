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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=90f4f779-2d5d-4759-aec0-eeee45e9d1e7&filter%5Blocation_id%5D=d346d46b-c402-4096-a680-ee61de63799a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a70e064a-ce8d-57ed-a7a0-bfd7f50e9d1d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "99c91fd6-8d0d-435c-be1d-400a8b25dfa3",
        "item_id": "90f4f779-2d5d-4759-aec0-eeee45e9d1e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/99c91fd6-8d0d-435c-be1d-400a8b25dfa3"
          }
        }
      }
    },
    {
      "id": "23e6ce0c-ad92-5cbd-9c36-e7a73fcad426",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "de9617bb-9870-409a-bc41-71b34e270ec1",
        "item_id": "90f4f779-2d5d-4759-aec0-eeee45e9d1e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/de9617bb-9870-409a-bc41-71b34e270ec1"
          }
        }
      }
    },
    {
      "id": "4354cc2e-b6bd-5511-8d9c-97d804ac4d50",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7885e658-86fb-4b8c-a14d-d2379d446ee4",
        "item_id": "90f4f779-2d5d-4759-aec0-eeee45e9d1e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7885e658-86fb-4b8c-a14d-d2379d446ee4"
          }
        }
      }
    },
    {
      "id": "64cf47a7-0b01-55c0-8b9e-5f0252f8660f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4c7aff15-9612-4cc1-b2e8-112b9648fcd5",
        "item_id": "90f4f779-2d5d-4759-aec0-eeee45e9d1e7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4c7aff15-9612-4cc1-b2e8-112b9648fcd5"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-10T10:30:50Z`
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





