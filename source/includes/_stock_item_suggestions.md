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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=cd2bc298-ff1d-4d71-bc01-66470dc1d813&filter%5Blocation_id%5D=464da851-b6c2-42bb-b89d-3a1a76c25168&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f8038bf7-e826-5f93-97c9-718811b77c81",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "787d849d-38f3-42c1-b20e-b6ce7a698845",
        "item_id": "cd2bc298-ff1d-4d71-bc01-66470dc1d813",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/787d849d-38f3-42c1-b20e-b6ce7a698845"
          }
        }
      }
    },
    {
      "id": "b809070d-7c94-5651-b142-fb8414481eb6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c7b0d138-f8c4-4d98-8932-5c13762fcb66",
        "item_id": "cd2bc298-ff1d-4d71-bc01-66470dc1d813",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c7b0d138-f8c4-4d98-8932-5c13762fcb66"
          }
        }
      }
    },
    {
      "id": "a7e82761-e270-5ab9-91dc-b5007fda3107",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bccf336f-0bbe-44fb-979c-567b6f660521",
        "item_id": "cd2bc298-ff1d-4d71-bc01-66470dc1d813",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bccf336f-0bbe-44fb-979c-567b6f660521"
          }
        }
      }
    },
    {
      "id": "8a5ef5ea-9340-596f-94b3-2305ceed9214",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "45654a56-4271-4668-b4f8-e70daa9fd733",
        "item_id": "cd2bc298-ff1d-4d71-bc01-66470dc1d813",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/45654a56-4271-4668-b4f8-e70daa9fd733"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-03T11:05:12Z`
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





