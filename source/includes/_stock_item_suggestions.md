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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=12076e52-dda5-4eb1-8078-8dd7ddb40a66&filter%5Blocation_id%5D=97412b94-8e81-4ace-a5a1-3eada1e9311b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de401b17-4299-571e-93b9-de3569f180b7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c3349019-9041-47af-9a9d-ac0452460f69",
        "item_id": "12076e52-dda5-4eb1-8078-8dd7ddb40a66",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c3349019-9041-47af-9a9d-ac0452460f69"
          }
        }
      }
    },
    {
      "id": "e86ce158-e33f-5dc3-b64c-38e34bdf37cd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e2b7ddbc-bef8-418f-8729-a7fd1abeec55",
        "item_id": "12076e52-dda5-4eb1-8078-8dd7ddb40a66",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e2b7ddbc-bef8-418f-8729-a7fd1abeec55"
          }
        }
      }
    },
    {
      "id": "6851e3b7-2da6-5be6-ab02-186f2d498302",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ac3969c0-9f99-49a0-bf3c-5cb1d4b4a6af",
        "item_id": "12076e52-dda5-4eb1-8078-8dd7ddb40a66",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ac3969c0-9f99-49a0-bf3c-5cb1d4b4a6af"
          }
        }
      }
    },
    {
      "id": "427317d4-4d94-5646-b490-fe844f82b8a7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e0b67fa3-a8e7-4743-abda-47febd5c64fa",
        "item_id": "12076e52-dda5-4eb1-8078-8dd7ddb40a66",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e0b67fa3-a8e7-4743-abda-47febd5c64fa"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-25T08:52:18Z`
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





