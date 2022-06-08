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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=0b3147a8-9007-44e3-ab94-4bd91f1d1340&filter%5Blocation_id%5D=25dc13f4-87c5-4ed9-b729-15a75dca3804&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1fd64cda-671d-57d9-8ac3-57ce5287e074",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "33e1dbda-6307-4c45-905d-259f111abc97",
        "item_id": "0b3147a8-9007-44e3-ab94-4bd91f1d1340",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/33e1dbda-6307-4c45-905d-259f111abc97"
          }
        }
      }
    },
    {
      "id": "88d1e51d-8d42-5883-9cf6-a651ebbca808",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9b1be3e2-f8fc-442b-a451-1368de17c4cc",
        "item_id": "0b3147a8-9007-44e3-ab94-4bd91f1d1340",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9b1be3e2-f8fc-442b-a451-1368de17c4cc"
          }
        }
      }
    },
    {
      "id": "2a243dda-75cc-58d3-9b4c-5c38d1b9e545",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3241d506-946a-4897-953b-ad14c3b90624",
        "item_id": "0b3147a8-9007-44e3-ab94-4bd91f1d1340",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3241d506-946a-4897-953b-ad14c3b90624"
          }
        }
      }
    },
    {
      "id": "99582683-20cc-589d-a511-85c252762fcf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8f826bde-edd2-4483-b00b-7107ad3cee7a",
        "item_id": "0b3147a8-9007-44e3-ab94-4bd91f1d1340",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8f826bde-edd2-4483-b00b-7107ad3cee7a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T14:23:56Z`
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





