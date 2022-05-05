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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=3885ccc8-8f37-4633-9f06-07fc41ee8094&filter%5Blocation_id%5D=e05aa2ad-dfac-4d5c-b4f7-badcb23c371f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "edae63a3-fcd6-5898-96d3-c39484428063",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a015bffb-0189-4e6c-85de-d809cc5af8df",
        "item_id": "3885ccc8-8f37-4633-9f06-07fc41ee8094",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a015bffb-0189-4e6c-85de-d809cc5af8df"
          }
        }
      }
    },
    {
      "id": "0c0501ff-cb69-55b8-b825-2baf85f82227",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c43d5677-774d-4c94-9659-c1dc747c57c7",
        "item_id": "3885ccc8-8f37-4633-9f06-07fc41ee8094",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c43d5677-774d-4c94-9659-c1dc747c57c7"
          }
        }
      }
    },
    {
      "id": "f93a3381-56ad-571f-894d-ef8331660c2b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c322fe36-c44c-4f92-8937-3bf5981244fa",
        "item_id": "3885ccc8-8f37-4633-9f06-07fc41ee8094",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c322fe36-c44c-4f92-8937-3bf5981244fa"
          }
        }
      }
    },
    {
      "id": "e93fb57e-bd24-5164-94e6-7a71a2dac12c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c5e93447-a49d-4d77-a016-5383fcecdfa0",
        "item_id": "3885ccc8-8f37-4633-9f06-07fc41ee8094",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c5e93447-a49d-4d77-a016-5383fcecdfa0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T12:25:37Z`
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





