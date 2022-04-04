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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=16bdaf76-cae1-4534-a3f2-e91c5f4dc5d7&filter%5Blocation_id%5D=f12f8537-49e9-4da9-8a0d-4f0cd136d1f5&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "26b75359-fc6a-524f-9056-959fac1ce092",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4627059b-7800-4490-864b-6f962f7e4db9",
        "item_id": "16bdaf76-cae1-4534-a3f2-e91c5f4dc5d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4627059b-7800-4490-864b-6f962f7e4db9"
          }
        }
      }
    },
    {
      "id": "32385c15-3f62-59c0-b399-f77b479f5090",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d32c65ff-523b-47fe-a6be-cdd24a76552c",
        "item_id": "16bdaf76-cae1-4534-a3f2-e91c5f4dc5d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d32c65ff-523b-47fe-a6be-cdd24a76552c"
          }
        }
      }
    },
    {
      "id": "5a1e8db4-f247-59c2-9ba9-f7a4b66b368d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c7950e72-fd6f-4004-aba9-7974f610e94f",
        "item_id": "16bdaf76-cae1-4534-a3f2-e91c5f4dc5d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c7950e72-fd6f-4004-aba9-7974f610e94f"
          }
        }
      }
    },
    {
      "id": "b10d5420-7cea-5e6e-b69a-5ca3d5b9a6a6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "06c4160f-3a2a-4849-9276-9e9455fa569b",
        "item_id": "16bdaf76-cae1-4534-a3f2-e91c5f4dc5d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/06c4160f-3a2a-4849-9276-9e9455fa569b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-04T13:21:11Z`
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





