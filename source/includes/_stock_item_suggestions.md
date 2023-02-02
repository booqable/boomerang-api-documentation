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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=95f2d69f-315c-40dd-a759-73e1a6e47ec6&filter%5Blocation_id%5D=3611cfc1-0b41-45ed-b177-8cf9082166d9&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2fdf87d0-8ced-5526-94f2-30fbc8dfe11a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7cbe7e35-ac59-49bc-b457-91b839da4869",
        "item_id": "95f2d69f-315c-40dd-a759-73e1a6e47ec6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7cbe7e35-ac59-49bc-b457-91b839da4869"
          }
        }
      }
    },
    {
      "id": "9748b54a-033f-58e0-92b7-aef266a94ead",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b8ff81df-6d27-41e4-868f-6d48a6d2f070",
        "item_id": "95f2d69f-315c-40dd-a759-73e1a6e47ec6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b8ff81df-6d27-41e4-868f-6d48a6d2f070"
          }
        }
      }
    },
    {
      "id": "661c98f9-a6ef-5ef9-8a02-7fce6efff5dd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "911a77fc-de6a-4f18-a94b-78d7cc10459b",
        "item_id": "95f2d69f-315c-40dd-a759-73e1a6e47ec6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/911a77fc-de6a-4f18-a94b-78d7cc10459b"
          }
        }
      }
    },
    {
      "id": "7cf11751-6e72-5eb9-a8a8-87aa048cf673",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "84149724-eebb-44a5-b33c-f4cb4c340457",
        "item_id": "95f2d69f-315c-40dd-a759-73e1a6e47ec6",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/84149724-eebb-44a5-b33c-f4cb4c340457"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:24:57Z`
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





