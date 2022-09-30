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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=298716a5-5357-4dd1-ba16-cc442c913f72&filter%5Blocation_id%5D=28877f82-56aa-458a-b00b-dc00cc2ae269&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "95b6b879-ac32-5897-810d-4dc17879628f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1a0ce221-7638-40fa-a66f-3af2fdfd4bb7",
        "item_id": "298716a5-5357-4dd1-ba16-cc442c913f72",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1a0ce221-7638-40fa-a66f-3af2fdfd4bb7"
          }
        }
      }
    },
    {
      "id": "a57ae436-d7dc-57a7-b922-75fdd9bc0443",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "92eafc2b-062b-459d-8e4f-adbc0dbec9b5",
        "item_id": "298716a5-5357-4dd1-ba16-cc442c913f72",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/92eafc2b-062b-459d-8e4f-adbc0dbec9b5"
          }
        }
      }
    },
    {
      "id": "f189caa9-d64a-5451-918d-cf782dadc1e6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "89e9454d-aa45-44f0-aa40-4335762e474b",
        "item_id": "298716a5-5357-4dd1-ba16-cc442c913f72",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/89e9454d-aa45-44f0-aa40-4335762e474b"
          }
        }
      }
    },
    {
      "id": "b187f727-3f1c-5af6-af6a-cc6c489e1ac3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "07359daf-1ab9-4a78-bbef-bb0c8253e718",
        "item_id": "298716a5-5357-4dd1-ba16-cc442c913f72",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/07359daf-1ab9-4a78-bbef-bb0c8253e718"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-30T11:57:11Z`
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





