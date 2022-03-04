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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=eb46cef8-2afa-4a7a-b6cd-b728dc475651&filter%5Blocation_id%5D=f47ca4f6-ddb6-459c-a160-c94214e90a8b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "602f4120-cf66-5698-8947-ad9ce5d729b6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8bd2463c-cd07-4a2a-a001-e721061ae747",
        "item_id": "eb46cef8-2afa-4a7a-b6cd-b728dc475651",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8bd2463c-cd07-4a2a-a001-e721061ae747"
          }
        }
      }
    },
    {
      "id": "97db693e-66c2-56bd-8766-21068f34dcb4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "94e21201-18f6-4ce2-aeba-8327cfe32899",
        "item_id": "eb46cef8-2afa-4a7a-b6cd-b728dc475651",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/94e21201-18f6-4ce2-aeba-8327cfe32899"
          }
        }
      }
    },
    {
      "id": "6fbfd700-79a6-55c1-b053-7bee87803176",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c57cb299-4c5b-4d42-b7bb-4409d2750eab",
        "item_id": "eb46cef8-2afa-4a7a-b6cd-b728dc475651",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c57cb299-4c5b-4d42-b7bb-4409d2750eab"
          }
        }
      }
    },
    {
      "id": "efe22d5c-6366-5323-8535-0475ca513b8d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7763b44e-cf4a-42a0-8b79-268186d741d5",
        "item_id": "eb46cef8-2afa-4a7a-b6cd-b728dc475651",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7763b44e-cf4a-42a0-8b79-268186d741d5"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-04T10:45:33Z`
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





