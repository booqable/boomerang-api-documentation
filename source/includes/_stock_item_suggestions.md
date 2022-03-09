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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=91e6679a-789c-4caa-86d8-25820cf02fd2&filter%5Blocation_id%5D=af604e85-f84a-45d7-a277-12c69d604fad&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1540aaaf-42c1-5ef8-a98f-9dfe6a7cddc1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "28d292ad-101f-4d6e-8e99-a980b50510ee",
        "item_id": "91e6679a-789c-4caa-86d8-25820cf02fd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/28d292ad-101f-4d6e-8e99-a980b50510ee"
          }
        }
      }
    },
    {
      "id": "232c8055-2059-536e-9f6d-cce7e3c6840a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bbc4374a-6f83-49b2-9ba6-c3153021d900",
        "item_id": "91e6679a-789c-4caa-86d8-25820cf02fd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bbc4374a-6f83-49b2-9ba6-c3153021d900"
          }
        }
      }
    },
    {
      "id": "945ebe8d-6ad9-5bac-bd8b-ffacc5bb4808",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0a529d7b-8fab-489f-97ae-e097f577ef01",
        "item_id": "91e6679a-789c-4caa-86d8-25820cf02fd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0a529d7b-8fab-489f-97ae-e097f577ef01"
          }
        }
      }
    },
    {
      "id": "c5d7d562-3397-5af5-9452-3b2b15ea3b87",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "afb1bf56-feab-49da-9d2c-36fc73538fe7",
        "item_id": "91e6679a-789c-4caa-86d8-25820cf02fd2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/afb1bf56-feab-49da-9d2c-36fc73538fe7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-09T10:01:28Z`
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





