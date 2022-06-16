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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=82df5bed-57c6-46ad-8f65-f6c497af67e2&filter%5Blocation_id%5D=71f52a2b-c9e6-45ad-b43a-350297c8d4c0&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ab5c3ba7-623d-5d59-9950-7d19fbe54fbc",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0ec68b37-acfd-482b-a58c-07c2ba52fc6f",
        "item_id": "82df5bed-57c6-46ad-8f65-f6c497af67e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0ec68b37-acfd-482b-a58c-07c2ba52fc6f"
          }
        }
      }
    },
    {
      "id": "7580a721-49c3-5a9e-9c58-4c429b983687",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "56569d99-f286-410c-8d79-b765b531ce99",
        "item_id": "82df5bed-57c6-46ad-8f65-f6c497af67e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/56569d99-f286-410c-8d79-b765b531ce99"
          }
        }
      }
    },
    {
      "id": "efee89b3-80d6-504c-a5f1-64125b69f1bd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f8862b8a-d24b-4712-b833-7fd02a346ad4",
        "item_id": "82df5bed-57c6-46ad-8f65-f6c497af67e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f8862b8a-d24b-4712-b833-7fd02a346ad4"
          }
        }
      }
    },
    {
      "id": "ba606d6e-328f-5adf-bbfe-c31773aaaa68",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8ee3d5be-0662-42ea-98c6-f4fad7103952",
        "item_id": "82df5bed-57c6-46ad-8f65-f6c497af67e2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8ee3d5be-0662-42ea-98c6-f4fad7103952"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-16T19:29:30Z`
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





