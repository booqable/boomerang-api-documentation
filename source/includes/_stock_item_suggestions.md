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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=dcdd1be2-d92b-460b-9541-23d25819a074&filter%5Blocation_id%5D=bae8be31-9131-4554-a284-47c6dda4ac0b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f3fd1019-2d64-5e99-b809-025f3cbc7d75",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a1b16c37-3942-4a00-89d0-e850338b4d24",
        "item_id": "dcdd1be2-d92b-460b-9541-23d25819a074",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a1b16c37-3942-4a00-89d0-e850338b4d24"
          }
        }
      }
    },
    {
      "id": "0e81149b-0b37-5dcf-87b2-af3d881fd1ca",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d59469d7-424f-4198-bd6c-46a7689e93a7",
        "item_id": "dcdd1be2-d92b-460b-9541-23d25819a074",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d59469d7-424f-4198-bd6c-46a7689e93a7"
          }
        }
      }
    },
    {
      "id": "9bfcf281-4c61-5332-b76f-5ab68ecc05f0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "84c61149-4d01-45b6-947d-151f3b32f39f",
        "item_id": "dcdd1be2-d92b-460b-9541-23d25819a074",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/84c61149-4d01-45b6-947d-151f3b32f39f"
          }
        }
      }
    },
    {
      "id": "13d3bce9-96eb-5f99-8595-d9141a056914",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5aba7d79-bcf6-4748-850d-87ed3fa7d5cc",
        "item_id": "dcdd1be2-d92b-460b-9541-23d25819a074",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5aba7d79-bcf6-4748-850d-87ed3fa7d5cc"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T13:09:46Z`
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





