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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bd65fc29-f02d-44c3-8505-b0d2974686d2&filter%5Blocation_id%5D=0752757b-ae10-40ef-8f8f-cfc27867bbd9&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "173d46b5-9db7-5927-b206-452823b0d70a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f6101f8d-0d67-47e6-9ffa-ad968156b509",
        "item_id": "bd65fc29-f02d-44c3-8505-b0d2974686d2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f6101f8d-0d67-47e6-9ffa-ad968156b509"
          }
        }
      }
    },
    {
      "id": "ab47660d-192e-51b7-a45f-68f0fc4c9422",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "50084ecd-79e2-41ce-abac-135b06a0fcbe",
        "item_id": "bd65fc29-f02d-44c3-8505-b0d2974686d2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/50084ecd-79e2-41ce-abac-135b06a0fcbe"
          }
        }
      }
    },
    {
      "id": "647f17e8-ebee-5176-b572-9a20b3b6cbdb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "68b2dd52-eb15-4758-896c-28c2e7f44433",
        "item_id": "bd65fc29-f02d-44c3-8505-b0d2974686d2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/68b2dd52-eb15-4758-896c-28c2e7f44433"
          }
        }
      }
    },
    {
      "id": "136b8c67-d1b5-5748-b747-0cee2bda15e2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "732905df-1996-4e3e-a56c-75d4329af6c1",
        "item_id": "bd65fc29-f02d-44c3-8505-b0d2974686d2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/732905df-1996-4e3e-a56c-75d4329af6c1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T08:17:07Z`
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





