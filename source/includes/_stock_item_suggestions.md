# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=ba4aa4e0-6638-48d0-9da4-efc1e299dc03&filter%5Blocation_id%5D=ce8e43a4-5c4a-4f75-8da9-eb241190e779&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "81ff99e4-cd48-5edb-8220-366445ca1584",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "97f8e477-4889-47b3-9969-b4a8a9c25c34",
        "item_id": "ba4aa4e0-6638-48d0-9da4-efc1e299dc03",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/97f8e477-4889-47b3-9969-b4a8a9c25c34"
          }
        }
      }
    },
    {
      "id": "1967e46d-5e0c-574b-9592-18d89b447597",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "959d0b67-2d68-427a-8a98-2de6a18ff5f5",
        "item_id": "ba4aa4e0-6638-48d0-9da4-efc1e299dc03",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/959d0b67-2d68-427a-8a98-2de6a18ff5f5"
          }
        }
      }
    },
    {
      "id": "944f94cc-f07a-525f-92c9-46a3dcdca149",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f4ba6030-0903-4eb3-9447-e7136df282f2",
        "item_id": "ba4aa4e0-6638-48d0-9da4-efc1e299dc03",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f4ba6030-0903-4eb3-9447-e7136df282f2"
          }
        }
      }
    },
    {
      "id": "a5ddfe16-0022-5856-abde-f1055b857a6f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "12cde6a8-098f-41e1-bbf3-23a46662b884",
        "item_id": "ba4aa4e0-6638-48d0-9da4-efc1e299dc03",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/12cde6a8-098f-41e1-bbf3-23a46662b884"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T14:57:41Z`
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





