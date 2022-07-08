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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=84ffb52f-1025-4080-bce8-385ba78352ec&filter%5Blocation_id%5D=56a07edf-b9d3-4a2f-b76e-ce9ae69014d1&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6229e9c1-dc41-596d-9afa-3a1edba0b696",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ec394b2d-4197-42ca-84ed-2d530e177fad",
        "item_id": "84ffb52f-1025-4080-bce8-385ba78352ec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ec394b2d-4197-42ca-84ed-2d530e177fad"
          }
        }
      }
    },
    {
      "id": "452094b4-1a26-593e-92ea-e90a6deddf2a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2cbbbd79-975a-45ea-b9f6-1102618ef4de",
        "item_id": "84ffb52f-1025-4080-bce8-385ba78352ec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2cbbbd79-975a-45ea-b9f6-1102618ef4de"
          }
        }
      }
    },
    {
      "id": "f99619d1-842d-587b-8237-e7ee26cd31aa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1fb644a7-e5e1-4dfb-911d-2dd23e631f99",
        "item_id": "84ffb52f-1025-4080-bce8-385ba78352ec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1fb644a7-e5e1-4dfb-911d-2dd23e631f99"
          }
        }
      }
    },
    {
      "id": "c3bf630e-29f1-5560-a086-939e6c110afd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "49a62217-d4ce-4915-9ae2-3b090f15884b",
        "item_id": "84ffb52f-1025-4080-bce8-385ba78352ec",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/49a62217-d4ce-4915-9ae2-3b090f15884b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T08:53:16Z`
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





