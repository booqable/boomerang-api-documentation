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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=8b21d815-8521-47c0-8e66-6268eae8941d&filter%5Blocation_id%5D=bf0949ab-0546-43f9-8697-4d6e8983f118&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "63173b1a-ed45-50bf-9338-9ed10c37de5b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7415a113-9844-4c4f-8825-edb8606f11b8",
        "item_id": "8b21d815-8521-47c0-8e66-6268eae8941d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7415a113-9844-4c4f-8825-edb8606f11b8"
          }
        }
      }
    },
    {
      "id": "029a936a-05ba-56aa-95be-75a5511c8579",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "476a665a-3eb4-4546-91c5-c6bd2625a340",
        "item_id": "8b21d815-8521-47c0-8e66-6268eae8941d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/476a665a-3eb4-4546-91c5-c6bd2625a340"
          }
        }
      }
    },
    {
      "id": "079f12ed-01d9-5153-9a6a-911b0cc7cb07",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e8083335-8c2f-4e83-9786-db56b0a93aa1",
        "item_id": "8b21d815-8521-47c0-8e66-6268eae8941d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e8083335-8c2f-4e83-9786-db56b0a93aa1"
          }
        }
      }
    },
    {
      "id": "032e662f-88e4-55e3-8277-24bd3dc204a1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5cb0d54f-a93f-4cb2-b898-0b740d5a3c88",
        "item_id": "8b21d815-8521-47c0-8e66-6268eae8941d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5cb0d54f-a93f-4cb2-b898-0b740d5a3c88"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T07:02:00Z`
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





