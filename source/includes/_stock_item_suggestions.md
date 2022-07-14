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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4baf0491-8407-4996-b947-81c577f4116f&filter%5Blocation_id%5D=70634b5c-e743-45a4-80a3-c0a040d3b5bb&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d2951815-c1ca-5e37-a5c4-cc36b674d841",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d44a04a3-b9bd-4897-a875-0b0b458c340d",
        "item_id": "4baf0491-8407-4996-b947-81c577f4116f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d44a04a3-b9bd-4897-a875-0b0b458c340d"
          }
        }
      }
    },
    {
      "id": "c41b857e-d488-5d25-b4e0-39ce4b119829",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eddb1d34-51a9-4b10-9724-49ff0f52f78f",
        "item_id": "4baf0491-8407-4996-b947-81c577f4116f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eddb1d34-51a9-4b10-9724-49ff0f52f78f"
          }
        }
      }
    },
    {
      "id": "d7534e03-fe20-573b-b598-31d6b7c41980",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "856973e8-479d-4de8-a3af-cb70440d06fe",
        "item_id": "4baf0491-8407-4996-b947-81c577f4116f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/856973e8-479d-4de8-a3af-cb70440d06fe"
          }
        }
      }
    },
    {
      "id": "f9b6aa04-ee92-52aa-b300-58859d9c11c4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a742e783-2c27-4381-b34a-413d553ac151",
        "item_id": "4baf0491-8407-4996-b947-81c577f4116f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a742e783-2c27-4381-b34a-413d553ac151"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T11:59:28Z`
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





