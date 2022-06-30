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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=8b026451-e528-4d62-995d-1bec793591da&filter%5Blocation_id%5D=737b8cd2-8475-47b7-896d-3ad1f2e54c7a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a65cdf54-a195-5949-b49d-c2f63c16546d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c3fb9437-e3ab-40da-a540-9be4f755d6c3",
        "item_id": "8b026451-e528-4d62-995d-1bec793591da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c3fb9437-e3ab-40da-a540-9be4f755d6c3"
          }
        }
      }
    },
    {
      "id": "333397be-d368-5680-8d4a-49959e829fa9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "328e14ee-7466-4fb0-bce6-c9503ec155cf",
        "item_id": "8b026451-e528-4d62-995d-1bec793591da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/328e14ee-7466-4fb0-bce6-c9503ec155cf"
          }
        }
      }
    },
    {
      "id": "3800f68c-9e93-5261-b23e-d3361506a9c3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8956789e-8b91-4b43-a9d9-32e7fbec9de0",
        "item_id": "8b026451-e528-4d62-995d-1bec793591da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8956789e-8b91-4b43-a9d9-32e7fbec9de0"
          }
        }
      }
    },
    {
      "id": "83bd79cf-3a24-54e9-9073-5188ff6892f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "28563c10-ba79-48a1-90bb-eeef316d8c66",
        "item_id": "8b026451-e528-4d62-995d-1bec793591da",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/28563c10-ba79-48a1-90bb-eeef316d8c66"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T08:45:22Z`
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





