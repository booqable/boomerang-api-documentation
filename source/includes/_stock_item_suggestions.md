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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=36f6e6c6-2615-45b9-b8c3-2dbc67281ace&filter%5Blocation_id%5D=1e562d21-ca26-4a6d-b847-a473a873c429&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fc7576ef-2ece-5b73-a449-809182138738",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e9655803-5dca-483d-a8ae-1b99cc21910d",
        "item_id": "36f6e6c6-2615-45b9-b8c3-2dbc67281ace",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e9655803-5dca-483d-a8ae-1b99cc21910d"
          }
        }
      }
    },
    {
      "id": "c90ce7aa-0eb7-52d6-935d-0ec9e3a7903b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8d10184e-7a99-4b06-9496-bc301a66ac92",
        "item_id": "36f6e6c6-2615-45b9-b8c3-2dbc67281ace",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8d10184e-7a99-4b06-9496-bc301a66ac92"
          }
        }
      }
    },
    {
      "id": "082d1852-b763-5a26-b746-c8a7181b9497",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "53015c5a-729a-4df9-ba9b-2fb85b51ac56",
        "item_id": "36f6e6c6-2615-45b9-b8c3-2dbc67281ace",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/53015c5a-729a-4df9-ba9b-2fb85b51ac56"
          }
        }
      }
    },
    {
      "id": "faccb301-4460-587b-9669-eeb809b9de13",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "827dc7bd-4c5f-4ba0-af42-1b84d49a5435",
        "item_id": "36f6e6c6-2615-45b9-b8c3-2dbc67281ace",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/827dc7bd-4c5f-4ba0-af42-1b84d49a5435"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T11:48:02Z`
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





