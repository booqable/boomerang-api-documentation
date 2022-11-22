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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=34fa4f0f-297a-45da-9326-1b06f0bb7a55&filter%5Blocation_id%5D=1f075c1b-2c35-4cb2-8716-e3410bde3e78&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "774bc37b-9a8b-5487-943c-e5e275af8a44",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f43c00fb-5e72-4b88-883a-2e095539c0e6",
        "item_id": "34fa4f0f-297a-45da-9326-1b06f0bb7a55",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f43c00fb-5e72-4b88-883a-2e095539c0e6"
          }
        }
      }
    },
    {
      "id": "d1f7a554-b5b5-584c-ad27-d1ae3173efe5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6386ded9-022e-4d32-bac9-efbf5752c4d7",
        "item_id": "34fa4f0f-297a-45da-9326-1b06f0bb7a55",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6386ded9-022e-4d32-bac9-efbf5752c4d7"
          }
        }
      }
    },
    {
      "id": "05af40d6-c8c2-5c19-93d9-5c0d625b640f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7cf9d243-3eaf-4557-b3e1-3d45025c8e74",
        "item_id": "34fa4f0f-297a-45da-9326-1b06f0bb7a55",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7cf9d243-3eaf-4557-b3e1-3d45025c8e74"
          }
        }
      }
    },
    {
      "id": "a6de4015-77b6-53b0-b63d-dc3ea3440d29",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d79903f0-9652-4bea-bb60-b635791f5ea0",
        "item_id": "34fa4f0f-297a-45da-9326-1b06f0bb7a55",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d79903f0-9652-4bea-bb60-b635791f5ea0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:45:19Z`
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





