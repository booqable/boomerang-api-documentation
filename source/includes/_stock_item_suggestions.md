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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=3dfe871e-f0da-4996-a592-13435bbe9844&filter%5Blocation_id%5D=66a4f4e3-06d2-431e-8609-56123c59d127&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b517c232-1e17-50cc-a5dc-562734cc51a3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9c66def1-09d9-4ce7-80dc-e80780625ea3",
        "item_id": "3dfe871e-f0da-4996-a592-13435bbe9844",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9c66def1-09d9-4ce7-80dc-e80780625ea3"
          }
        }
      }
    },
    {
      "id": "2ef2866a-8934-5131-adab-b8e4665e3c59",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2f3e2ab8-a0bd-48f5-8fc5-38801799d852",
        "item_id": "3dfe871e-f0da-4996-a592-13435bbe9844",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2f3e2ab8-a0bd-48f5-8fc5-38801799d852"
          }
        }
      }
    },
    {
      "id": "1ff6374a-3b6a-5dfd-a765-c7c6f6dcef72",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d299129c-5e71-4207-92a5-fb1aa9b9bf73",
        "item_id": "3dfe871e-f0da-4996-a592-13435bbe9844",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d299129c-5e71-4207-92a5-fb1aa9b9bf73"
          }
        }
      }
    },
    {
      "id": "a9490e37-3df8-582f-b3ce-f87d2b216c58",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f85caa3b-c8dd-446a-ad04-83307e0effa7",
        "item_id": "3dfe871e-f0da-4996-a592-13435bbe9844",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f85caa3b-c8dd-446a-ad04-83307e0effa7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T06:33:35Z`
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





