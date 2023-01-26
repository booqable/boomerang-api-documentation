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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f25fc9b4-6d32-4a55-8c52-8b11b6fc4072&filter%5Blocation_id%5D=cf044878-6dc5-4c95-b28e-944a96d9569d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "767e9196-56ea-528b-af66-87cb74fd2778",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "72421bdc-6761-49a1-a3c7-d17c8ba29d7a",
        "item_id": "f25fc9b4-6d32-4a55-8c52-8b11b6fc4072",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/72421bdc-6761-49a1-a3c7-d17c8ba29d7a"
          }
        }
      }
    },
    {
      "id": "9da4653c-d577-5099-9251-6e70dd65987a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7ff1618b-1017-49ca-93b8-854d4ea788e3",
        "item_id": "f25fc9b4-6d32-4a55-8c52-8b11b6fc4072",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7ff1618b-1017-49ca-93b8-854d4ea788e3"
          }
        }
      }
    },
    {
      "id": "81aa9bc1-e5f3-59f8-a26a-4a759d43a57d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "deac3739-10a1-4544-b531-2024b7626694",
        "item_id": "f25fc9b4-6d32-4a55-8c52-8b11b6fc4072",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/deac3739-10a1-4544-b531-2024b7626694"
          }
        }
      }
    },
    {
      "id": "7cacaa1f-9a62-5676-b48d-94962d1ce733",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a8e67a84-bb83-4186-b207-adaa0eab6e67",
        "item_id": "f25fc9b4-6d32-4a55-8c52-8b11b6fc4072",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a8e67a84-bb83-4186-b207-adaa0eab6e67"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T10:18:56Z`
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





