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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d5ebfb09-c42d-4693-90c5-6892e85caf0c&filter%5Blocation_id%5D=ddcf5a5d-0212-4b25-b590-278b7382409f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4cda395-47a3-5187-be42-5588df68b5b9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fc2f2977-b802-4a95-8123-3e8be04fad59",
        "item_id": "d5ebfb09-c42d-4693-90c5-6892e85caf0c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fc2f2977-b802-4a95-8123-3e8be04fad59"
          }
        }
      }
    },
    {
      "id": "9aff4637-2cd1-5441-8357-c7f295803f78",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2af8456c-8188-45ca-af39-274d6901a50c",
        "item_id": "d5ebfb09-c42d-4693-90c5-6892e85caf0c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2af8456c-8188-45ca-af39-274d6901a50c"
          }
        }
      }
    },
    {
      "id": "6352fc69-6687-5f9b-8d04-7ba3e94cd0da",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e7717839-a923-4ecc-a8ab-0ef6cc28f929",
        "item_id": "d5ebfb09-c42d-4693-90c5-6892e85caf0c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e7717839-a923-4ecc-a8ab-0ef6cc28f929"
          }
        }
      }
    },
    {
      "id": "b204d8be-cb1a-50fc-82c5-db2b271bfdbc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "621511f4-f4e1-4389-8001-b6bef7fb91f5",
        "item_id": "d5ebfb09-c42d-4693-90c5-6892e85caf0c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/621511f4-f4e1-4389-8001-b6bef7fb91f5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:59:48Z`
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





