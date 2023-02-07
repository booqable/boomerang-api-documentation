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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f019bbe0-7a68-4488-bc31-3326e39efb3d&filter%5Blocation_id%5D=dd615b11-0d86-47f2-b285-82ce808f4b1d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d4cfba63-425f-551e-99e4-edeb232f5836",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "04ccadc9-9d7e-4c39-b239-deef05c61862",
        "item_id": "f019bbe0-7a68-4488-bc31-3326e39efb3d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/04ccadc9-9d7e-4c39-b239-deef05c61862"
          }
        }
      }
    },
    {
      "id": "3943baa0-3ecd-5fc9-b56e-59c1fc4a1e41",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "26c9f093-6924-4d33-8bf8-c5a22d474d7a",
        "item_id": "f019bbe0-7a68-4488-bc31-3326e39efb3d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/26c9f093-6924-4d33-8bf8-c5a22d474d7a"
          }
        }
      }
    },
    {
      "id": "9788e41f-bc71-53a0-bd22-147953afc0e0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9a207f03-77d4-4525-96a2-4bdcf7c40222",
        "item_id": "f019bbe0-7a68-4488-bc31-3326e39efb3d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9a207f03-77d4-4525-96a2-4bdcf7c40222"
          }
        }
      }
    },
    {
      "id": "2e957cc4-f536-5dcd-a565-df4190534fa1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "04ce257a-75f4-4d11-9593-c8fd71dbfcef",
        "item_id": "f019bbe0-7a68-4488-bc31-3326e39efb3d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/04ce257a-75f4-4d11-9593-c8fd71dbfcef"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T15:17:17Z`
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





