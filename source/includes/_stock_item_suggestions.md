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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=a5e71949-1d7a-495d-94c5-fcf54bd0c5b7&filter%5Blocation_id%5D=2930eb08-881c-4886-8fe3-d6828d57355d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3e70905-7802-5e1f-886a-adf2a32164d3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9ab57110-fb57-4e62-b54d-9d3df2201024",
        "item_id": "a5e71949-1d7a-495d-94c5-fcf54bd0c5b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9ab57110-fb57-4e62-b54d-9d3df2201024"
          }
        }
      }
    },
    {
      "id": "6d4c15b5-0dc8-5dee-982f-d9043e90b106",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d7105d6b-e5a1-495d-bb0e-9f71fa51b77b",
        "item_id": "a5e71949-1d7a-495d-94c5-fcf54bd0c5b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d7105d6b-e5a1-495d-bb0e-9f71fa51b77b"
          }
        }
      }
    },
    {
      "id": "5d9480c2-9f22-5469-b8d2-b058816c3761",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6c6390d7-159d-492a-bac3-dfa11e9a1877",
        "item_id": "a5e71949-1d7a-495d-94c5-fcf54bd0c5b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6c6390d7-159d-492a-bac3-dfa11e9a1877"
          }
        }
      }
    },
    {
      "id": "97d6e7da-c717-5377-9163-bb56561f88d1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "77df4902-b6a8-4269-9b84-c4520efce15a",
        "item_id": "a5e71949-1d7a-495d-94c5-fcf54bd0c5b7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/77df4902-b6a8-4269-9b84-c4520efce15a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:15Z`
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





