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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e8477daf-a685-4444-b0c3-0ec6a8adbcd3&filter%5Blocation_id%5D=2f5d6453-410f-4743-b930-89620191e989&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d37ca71a-a87b-5010-9920-3e7d89cc68c0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7e1f5573-f686-497e-bcc1-915778c3d261",
        "item_id": "e8477daf-a685-4444-b0c3-0ec6a8adbcd3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7e1f5573-f686-497e-bcc1-915778c3d261"
          }
        }
      }
    },
    {
      "id": "9723daaa-c007-5f79-83b3-d738982bff32",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4a72b3e7-9b61-4826-adca-ebe2a1deef54",
        "item_id": "e8477daf-a685-4444-b0c3-0ec6a8adbcd3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4a72b3e7-9b61-4826-adca-ebe2a1deef54"
          }
        }
      }
    },
    {
      "id": "0bce9b17-8aa7-553f-af51-dbdc64d30331",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "df1e6041-9ad7-4996-a891-7222f980e190",
        "item_id": "e8477daf-a685-4444-b0c3-0ec6a8adbcd3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/df1e6041-9ad7-4996-a891-7222f980e190"
          }
        }
      }
    },
    {
      "id": "1359b45d-6fe4-5a1c-b358-42caf8053b1e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "30d7ee57-0b0b-4d19-b104-87ec5665f6ae",
        "item_id": "e8477daf-a685-4444-b0c3-0ec6a8adbcd3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/30d7ee57-0b0b-4d19-b104-87ec5665f6ae"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:36:16Z`
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





