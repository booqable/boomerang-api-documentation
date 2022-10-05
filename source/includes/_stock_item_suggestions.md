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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d3bfc91e-e386-48ef-98a8-5ea1344f5f1e&filter%5Blocation_id%5D=6d821c2f-ccdd-4364-bf49-903c346055eb&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d1e97964-5a6a-5540-9ff0-8c22eca4276c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ba4650cf-f9fb-4e24-b86f-b52b5b9463ff",
        "item_id": "d3bfc91e-e386-48ef-98a8-5ea1344f5f1e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ba4650cf-f9fb-4e24-b86f-b52b5b9463ff"
          }
        }
      }
    },
    {
      "id": "9160d8d6-9c7a-5833-b1ad-826db58e2be2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8cf65a28-b9bb-45f7-ba0b-c5890da1bf81",
        "item_id": "d3bfc91e-e386-48ef-98a8-5ea1344f5f1e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8cf65a28-b9bb-45f7-ba0b-c5890da1bf81"
          }
        }
      }
    },
    {
      "id": "9ee69905-a11f-5ecc-8b65-7c61457a39cf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "117283c8-8177-4c8c-86ea-ff9835b4d3ee",
        "item_id": "d3bfc91e-e386-48ef-98a8-5ea1344f5f1e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/117283c8-8177-4c8c-86ea-ff9835b4d3ee"
          }
        }
      }
    },
    {
      "id": "2a9258f3-c646-5f80-bfba-fe025afecb15",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "87eda26b-fd4a-4690-a4a5-710e4803e8a8",
        "item_id": "d3bfc91e-e386-48ef-98a8-5ea1344f5f1e",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/87eda26b-fd4a-4690-a4a5-710e4803e8a8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-05T11:34:46Z`
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





