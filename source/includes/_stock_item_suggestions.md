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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=eb4328b4-93f1-4d84-b42e-fbaf1cf4d78d&filter%5Blocation_id%5D=1248cca3-76dd-4da8-bc5e-c8a5711fd89a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f1099a4d-bc96-5d78-95f5-e18c321efc4b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6c08ed7e-08e5-4f79-95ab-34fffc914c3a",
        "item_id": "eb4328b4-93f1-4d84-b42e-fbaf1cf4d78d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6c08ed7e-08e5-4f79-95ab-34fffc914c3a"
          }
        }
      }
    },
    {
      "id": "25ad4584-898a-524a-ae0c-5746dc8c41c5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9ee1acad-1963-4c71-a9e9-7216d9e8bc38",
        "item_id": "eb4328b4-93f1-4d84-b42e-fbaf1cf4d78d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9ee1acad-1963-4c71-a9e9-7216d9e8bc38"
          }
        }
      }
    },
    {
      "id": "35cb2613-c0fa-559a-a69b-48b1f6162b4d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1b3db13f-d029-4b3b-af0d-847158c527f5",
        "item_id": "eb4328b4-93f1-4d84-b42e-fbaf1cf4d78d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1b3db13f-d029-4b3b-af0d-847158c527f5"
          }
        }
      }
    },
    {
      "id": "dcf6a970-e559-580c-a3c4-dc9bf6d5a68a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "402b21f7-534d-4bc0-aaff-92dcfd4062e0",
        "item_id": "eb4328b4-93f1-4d84-b42e-fbaf1cf4d78d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/402b21f7-534d-4bc0-aaff-92dcfd4062e0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-03T10:17:52Z`
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





