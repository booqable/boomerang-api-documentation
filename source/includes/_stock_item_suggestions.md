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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=03f32359-6b45-4c79-91e0-36169b603be1&filter%5Blocation_id%5D=c82faf97-e7a8-4dcd-b13f-ce98481c024c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cc1cb5af-7201-5272-91f3-4364bf93cc48",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "07f7a976-1854-4362-ad16-d99116377af5",
        "item_id": "03f32359-6b45-4c79-91e0-36169b603be1",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/07f7a976-1854-4362-ad16-d99116377af5"
          }
        }
      }
    },
    {
      "id": "d491a55f-2736-5a1c-9029-87c5758bff87",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4c64e632-b630-4dcf-849d-40dca14ad599",
        "item_id": "03f32359-6b45-4c79-91e0-36169b603be1",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4c64e632-b630-4dcf-849d-40dca14ad599"
          }
        }
      }
    },
    {
      "id": "80b7dbdc-4996-5852-890c-71eec9b5fbef",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "67e9e11b-bf41-4c8b-9e30-abe546890564",
        "item_id": "03f32359-6b45-4c79-91e0-36169b603be1",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/67e9e11b-bf41-4c8b-9e30-abe546890564"
          }
        }
      }
    },
    {
      "id": "3180d2b9-7d16-5368-b64d-dc9b9bb918fa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e7a96747-502c-4b8f-bc2c-c2771bb40321",
        "item_id": "03f32359-6b45-4c79-91e0-36169b603be1",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e7a96747-502c-4b8f-bc2c-c2771bb40321"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
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





