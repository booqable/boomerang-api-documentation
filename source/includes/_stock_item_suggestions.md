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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=c6a89d0f-2bb5-4263-bfc9-b5e9490b94fb&filter%5Blocation_id%5D=2c40a2c0-dcf4-4c23-aada-f7113ae4f767&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0f109acd-9b21-5277-ba69-bb4111383a97",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "638436a2-298d-462f-a5cf-55c2bb38d6f3",
        "item_id": "c6a89d0f-2bb5-4263-bfc9-b5e9490b94fb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/638436a2-298d-462f-a5cf-55c2bb38d6f3"
          }
        }
      }
    },
    {
      "id": "5ac265aa-60d4-5f7d-b54f-e108f9b759c8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "331fa142-53e3-4760-b6a1-ab38efb751be",
        "item_id": "c6a89d0f-2bb5-4263-bfc9-b5e9490b94fb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/331fa142-53e3-4760-b6a1-ab38efb751be"
          }
        }
      }
    },
    {
      "id": "7b32563d-30e5-5385-8695-753c822a776a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f855e253-85ca-497b-96db-7692671a942c",
        "item_id": "c6a89d0f-2bb5-4263-bfc9-b5e9490b94fb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f855e253-85ca-497b-96db-7692671a942c"
          }
        }
      }
    },
    {
      "id": "73041dda-5c2a-5f48-8a9f-5867ec8191e4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eab138dd-9fec-4f0b-a1b8-9c4e425bfdff",
        "item_id": "c6a89d0f-2bb5-4263-bfc9-b5e9490b94fb",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eab138dd-9fec-4f0b-a1b8-9c4e425bfdff"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-16T15:44:25Z`
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





