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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7f100078-9538-4438-b28e-2d01ccdd9aaf&filter%5Blocation_id%5D=71d62030-8e73-4365-b5ba-29f29d0f4272&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2569ce2a-7025-5a02-af65-3c0ff42f164f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8ee7e3c1-295b-40f9-8812-3d99ea9b7db1",
        "item_id": "7f100078-9538-4438-b28e-2d01ccdd9aaf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8ee7e3c1-295b-40f9-8812-3d99ea9b7db1"
          }
        }
      }
    },
    {
      "id": "70a521b7-fdcd-5d01-b96b-0c9c2ca70f34",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "93e855fe-99fc-4e2f-aabe-a02e289bde4a",
        "item_id": "7f100078-9538-4438-b28e-2d01ccdd9aaf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/93e855fe-99fc-4e2f-aabe-a02e289bde4a"
          }
        }
      }
    },
    {
      "id": "a5ec2f28-d15b-5c3d-bc52-ecbee6eba476",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9a182726-4565-42e4-b63d-3bb6b78c9dc3",
        "item_id": "7f100078-9538-4438-b28e-2d01ccdd9aaf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9a182726-4565-42e4-b63d-3bb6b78c9dc3"
          }
        }
      }
    },
    {
      "id": "a2a9830a-ba05-5de8-85f4-f27a9a284477",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ce7ad49d-ca2a-4c62-9da8-3b11a2fb51db",
        "item_id": "7f100078-9538-4438-b28e-2d01ccdd9aaf",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ce7ad49d-ca2a-4c62-9da8-3b11a2fb51db"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:31Z`
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





