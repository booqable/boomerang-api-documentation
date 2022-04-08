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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9776df78-3cfe-42be-8edc-06190230676c&filter%5Blocation_id%5D=2416a88a-5336-4632-a280-cb22a8b5e7a4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "052d2ba1-cd00-5087-bb14-cc5e4dc53c30",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "147c45e5-7700-4094-9506-39a84432c78b",
        "item_id": "9776df78-3cfe-42be-8edc-06190230676c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/147c45e5-7700-4094-9506-39a84432c78b"
          }
        }
      }
    },
    {
      "id": "d0fd1e17-05e2-5989-9d5d-a3b855002499",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "da15a8e8-ea52-4cb6-893d-6dda18336132",
        "item_id": "9776df78-3cfe-42be-8edc-06190230676c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/da15a8e8-ea52-4cb6-893d-6dda18336132"
          }
        }
      }
    },
    {
      "id": "054b6cfc-3c7e-54dd-abdc-658474d8fac1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d2e32a8d-92e5-46c8-b49f-3d6027ef5f5f",
        "item_id": "9776df78-3cfe-42be-8edc-06190230676c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d2e32a8d-92e5-46c8-b49f-3d6027ef5f5f"
          }
        }
      }
    },
    {
      "id": "b8795e70-065e-5fef-88ec-b193ecab81c2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "de01f7e3-892c-441b-914f-684107345b9a",
        "item_id": "9776df78-3cfe-42be-8edc-06190230676c",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/de01f7e3-892c-441b-914f-684107345b9a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:13Z`
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





