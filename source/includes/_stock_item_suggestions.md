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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=b359090f-5c76-47ae-8fcc-b433a5cc2ae2&filter%5Blocation_id%5D=ca78715f-38a2-4657-bed4-8eefb8002145&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "952b5fb9-2a84-5966-bfe4-302c3044ac9a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3f675aa5-1b3b-4cbe-b46d-d6b8b2518aaa",
        "item_id": "b359090f-5c76-47ae-8fcc-b433a5cc2ae2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3f675aa5-1b3b-4cbe-b46d-d6b8b2518aaa"
          }
        }
      }
    },
    {
      "id": "e51e08b0-ca62-5044-8e14-74cd0e823d48",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "31d2e7ad-8c55-4f0c-9353-e99050c35c6c",
        "item_id": "b359090f-5c76-47ae-8fcc-b433a5cc2ae2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/31d2e7ad-8c55-4f0c-9353-e99050c35c6c"
          }
        }
      }
    },
    {
      "id": "e528ac7f-c5f9-5283-a9b6-98f6eaa98b8a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f7ba5982-6f3e-4342-8639-ac2466f56e8c",
        "item_id": "b359090f-5c76-47ae-8fcc-b433a5cc2ae2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f7ba5982-6f3e-4342-8639-ac2466f56e8c"
          }
        }
      }
    },
    {
      "id": "f560b5a6-7731-59cd-8e32-b5f6b11816f8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3b5cfad5-365b-4d77-9169-ebc07d0ecbb6",
        "item_id": "b359090f-5c76-47ae-8fcc-b433a5cc2ae2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3b5cfad5-365b-4d77-9169-ebc07d0ecbb6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T11:20:14Z`
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





