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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=58ea3d66-6df3-49f5-b553-510ed65dc384&filter%5Blocation_id%5D=f606856a-6a25-4ed7-805e-e4b55b169813&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "81389543-b35d-56bd-b4df-1f75fdaadc8f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "91c67b94-6588-43e0-bfd4-2e64c1483b3f",
        "item_id": "58ea3d66-6df3-49f5-b553-510ed65dc384",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/91c67b94-6588-43e0-bfd4-2e64c1483b3f"
          }
        }
      }
    },
    {
      "id": "4ac961f4-a5f6-5e63-9b32-3e4b1a656e62",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e60514a8-388b-4fa4-b1d4-13353819a966",
        "item_id": "58ea3d66-6df3-49f5-b553-510ed65dc384",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e60514a8-388b-4fa4-b1d4-13353819a966"
          }
        }
      }
    },
    {
      "id": "a0dc3b36-b5cb-56f0-83ef-31a5fb78d9b5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "cb64af85-7fbc-4a17-923b-afdf4f456f3c",
        "item_id": "58ea3d66-6df3-49f5-b553-510ed65dc384",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/cb64af85-7fbc-4a17-923b-afdf4f456f3c"
          }
        }
      }
    },
    {
      "id": "e736da88-4e48-509e-b66b-284bfdbbe6bd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "bd3278f7-f7c1-4a02-9aa1-ac1a39679b82",
        "item_id": "58ea3d66-6df3-49f5-b553-510ed65dc384",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/bd3278f7-f7c1-4a02-9aa1-ac1a39679b82"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T09:43:54Z`
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





