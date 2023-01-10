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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e0c8af25-2772-408a-b3aa-b1da3fdba7ef&filter%5Blocation_id%5D=7bb3c290-1a27-404f-8349-aafd1a0c2c19&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ccdd899f-6297-5775-be4f-35bf86048b57",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d993efaa-3bf2-4a74-8a61-0c8f393f01da",
        "item_id": "e0c8af25-2772-408a-b3aa-b1da3fdba7ef",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d993efaa-3bf2-4a74-8a61-0c8f393f01da"
          }
        }
      }
    },
    {
      "id": "b889d943-1b6d-5556-b12b-4b7f18a5057a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e0cb1499-3c1a-4e8e-ab58-70c9a6191502",
        "item_id": "e0c8af25-2772-408a-b3aa-b1da3fdba7ef",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e0cb1499-3c1a-4e8e-ab58-70c9a6191502"
          }
        }
      }
    },
    {
      "id": "2c551084-9cd5-52e6-ad25-92f91eedbbe7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "384d58fb-8f13-4d7d-aa28-dea3db66861d",
        "item_id": "e0c8af25-2772-408a-b3aa-b1da3fdba7ef",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/384d58fb-8f13-4d7d-aa28-dea3db66861d"
          }
        }
      }
    },
    {
      "id": "9b9ba1fc-0060-5732-99a6-f520b9def441",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "70c07f4b-1643-493b-bc58-d3ef04e7073e",
        "item_id": "e0c8af25-2772-408a-b3aa-b1da3fdba7ef",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/70c07f4b-1643-493b-bc58-d3ef04e7073e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-10T14:04:56Z`
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





