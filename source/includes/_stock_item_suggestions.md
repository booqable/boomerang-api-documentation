# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=26394de0-6024-4f48-a367-4a17c1c496da&filter%5Blocation_id%5D=35eb1682-7b44-4562-a1dd-3d6df159e3ab&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c92162c2-1862-56ca-ad35-f35a13372fab",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6ed5564a-5d3b-403a-aaa7-9e0cc23d791a",
        "item_id": "26394de0-6024-4f48-a367-4a17c1c496da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6ed5564a-5d3b-403a-aaa7-9e0cc23d791a"
          }
        }
      }
    },
    {
      "id": "dad03388-1c8f-52c7-b854-3a0dc20605b0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d4ebbc3a-67ce-4959-b2df-312b96fa85a7",
        "item_id": "26394de0-6024-4f48-a367-4a17c1c496da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d4ebbc3a-67ce-4959-b2df-312b96fa85a7"
          }
        }
      }
    },
    {
      "id": "1cba5da8-c1ac-5306-95ad-4bff4124f339",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7ae80ad7-d71c-40c9-a04c-1dcbd36d5fc9",
        "item_id": "26394de0-6024-4f48-a367-4a17c1c496da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7ae80ad7-d71c-40c9-a04c-1dcbd36d5fc9"
          }
        }
      }
    },
    {
      "id": "30b10435-17d7-5ee3-9131-cc3e085862d5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4859721d-d3da-4abd-b484-fd44a5ef5add",
        "item_id": "26394de0-6024-4f48-a367-4a17c1c496da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4859721d-d3da-4abd-b484-fd44a5ef5add"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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





