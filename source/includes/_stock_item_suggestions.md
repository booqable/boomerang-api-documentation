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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=c18c4f7a-90e6-4147-9b3a-b953784962fc&filter%5Blocation_id%5D=a00b222d-92a9-4cd7-b1ee-3aecbaaf8e1b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eecc3df0-98c2-5f64-a148-70c3c7f9f679",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6375badc-4e52-471c-9ead-e203e68e5253",
        "item_id": "c18c4f7a-90e6-4147-9b3a-b953784962fc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6375badc-4e52-471c-9ead-e203e68e5253"
          }
        }
      }
    },
    {
      "id": "e4e0f8ee-eaed-5686-afe2-0fe618bceefa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1ae4b4f6-2939-4569-90f1-b866f11c8374",
        "item_id": "c18c4f7a-90e6-4147-9b3a-b953784962fc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1ae4b4f6-2939-4569-90f1-b866f11c8374"
          }
        }
      }
    },
    {
      "id": "08e3824a-26fa-5c95-8935-a608b6f420c2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8cf3e369-585a-4cb8-8b7d-ee217188492f",
        "item_id": "c18c4f7a-90e6-4147-9b3a-b953784962fc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8cf3e369-585a-4cb8-8b7d-ee217188492f"
          }
        }
      }
    },
    {
      "id": "1d6f146b-24a8-57c3-9001-b5efc53a1dfd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "adf2cbc3-2f61-407e-ab2a-5b9c6442ccf8",
        "item_id": "c18c4f7a-90e6-4147-9b3a-b953784962fc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/adf2cbc3-2f61-407e-ab2a-5b9c6442ccf8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:48:21Z`
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





