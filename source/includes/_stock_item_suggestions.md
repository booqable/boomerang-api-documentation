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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=cc034237-9e38-4aef-95b8-de45b9a79ccc&filter%5Blocation_id%5D=03636802-1e76-4136-88cd-7d35ed1fd97e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "afa47c88-68eb-53f2-9767-29b63ea8dc08",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9c0082a6-0498-4f27-85ee-23ce9da56bba",
        "item_id": "cc034237-9e38-4aef-95b8-de45b9a79ccc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9c0082a6-0498-4f27-85ee-23ce9da56bba"
          }
        }
      }
    },
    {
      "id": "0a818cc6-b471-5525-b52d-5af397b17d3c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d7de6034-2d9c-455d-9139-4db5ed80a686",
        "item_id": "cc034237-9e38-4aef-95b8-de45b9a79ccc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d7de6034-2d9c-455d-9139-4db5ed80a686"
          }
        }
      }
    },
    {
      "id": "9cd501b3-5ead-56b6-96f3-8c2aa87211f1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e8fc5817-1306-4165-a1a7-ddccf3d04f6b",
        "item_id": "cc034237-9e38-4aef-95b8-de45b9a79ccc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e8fc5817-1306-4165-a1a7-ddccf3d04f6b"
          }
        }
      }
    },
    {
      "id": "75899fb9-7c5f-58d8-8aee-e41935e6b7a2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e0551051-31b5-4e85-8fc9-7fd35426001e",
        "item_id": "cc034237-9e38-4aef-95b8-de45b9a79ccc",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e0551051-31b5-4e85-8fc9-7fd35426001e"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
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





