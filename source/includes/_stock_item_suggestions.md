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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=7a5ca4ac-5fdb-4213-8e26-622e5a1a5110&filter%5Blocation_id%5D=c34b671b-7dad-4b61-8019-6428a0e26e82&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "faccbeda-a6da-532c-86f5-e39f637adb3d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ccb0a20c-f3ac-4cb5-875f-53636bbf5be2",
        "item_id": "7a5ca4ac-5fdb-4213-8e26-622e5a1a5110",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ccb0a20c-f3ac-4cb5-875f-53636bbf5be2"
          }
        }
      }
    },
    {
      "id": "8b2473c9-0674-5d78-9842-30db3422084e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "58989f45-16e6-451a-8c71-71800292a518",
        "item_id": "7a5ca4ac-5fdb-4213-8e26-622e5a1a5110",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/58989f45-16e6-451a-8c71-71800292a518"
          }
        }
      }
    },
    {
      "id": "7c06f893-5e66-56b5-80a0-3ba4bb4689a0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "57de3bd1-5999-489b-9044-dd91a31c92fe",
        "item_id": "7a5ca4ac-5fdb-4213-8e26-622e5a1a5110",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/57de3bd1-5999-489b-9044-dd91a31c92fe"
          }
        }
      }
    },
    {
      "id": "5ce4c322-f349-583e-9a9d-1e783d72aa23",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ea57cbd5-76fc-4ef7-a2c0-c9ea277a8dfa",
        "item_id": "7a5ca4ac-5fdb-4213-8e26-622e5a1a5110",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ea57cbd5-76fc-4ef7-a2c0-c9ea277a8dfa"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T12:50:10Z`
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





