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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7d4ced4a-d033-4aaf-806a-e74115ce32ff&filter%5Blocation_id%5D=d7dd9716-959d-40b9-a1d9-81983d3857e4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fdd7641b-5a68-56b4-9668-4b4a4085e630",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5e20e43a-4230-4ddf-af96-16c4bd77047d",
        "item_id": "7d4ced4a-d033-4aaf-806a-e74115ce32ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5e20e43a-4230-4ddf-af96-16c4bd77047d"
          }
        }
      }
    },
    {
      "id": "45ac995b-ea4a-546c-935e-1b6d8269a64b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "73f89a4f-0f4e-4b48-adde-c6b6aaa56788",
        "item_id": "7d4ced4a-d033-4aaf-806a-e74115ce32ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/73f89a4f-0f4e-4b48-adde-c6b6aaa56788"
          }
        }
      }
    },
    {
      "id": "06c0724c-5b90-5d92-bb82-537ed1c2e3ce",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "85ddc46a-fa6e-4db6-8aaf-a7b3b43f55d7",
        "item_id": "7d4ced4a-d033-4aaf-806a-e74115ce32ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/85ddc46a-fa6e-4db6-8aaf-a7b3b43f55d7"
          }
        }
      }
    },
    {
      "id": "16fa57ba-1305-5028-8459-4afc7e801ed9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "adb1c64b-b715-4ad3-88cf-033b9c80f6a6",
        "item_id": "7d4ced4a-d033-4aaf-806a-e74115ce32ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/adb1c64b-b715-4ad3-88cf-033b9c80f6a6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-09T12:36:59Z`
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





