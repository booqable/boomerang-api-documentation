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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=af9ce332-d0a6-4d85-a8fc-7e1b6b084c04&filter%5Blocation_id%5D=c1a3aeac-ed31-40a3-a862-4b4d26e062ab&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c083be61-66f6-5de1-bffe-85db744f867e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0ba9670d-ec77-4325-b61e-ed92a2d6d8ca",
        "item_id": "af9ce332-d0a6-4d85-a8fc-7e1b6b084c04",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0ba9670d-ec77-4325-b61e-ed92a2d6d8ca"
          }
        }
      }
    },
    {
      "id": "a1d8bde2-1e80-5c60-9a4f-4b99491d6843",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "841d47e7-b19a-4677-b6f7-865e2d284e82",
        "item_id": "af9ce332-d0a6-4d85-a8fc-7e1b6b084c04",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/841d47e7-b19a-4677-b6f7-865e2d284e82"
          }
        }
      }
    },
    {
      "id": "3d1287e7-dc7d-501f-a7d9-e66ac60ee31d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "31eff33c-7df6-4bd8-8d3d-44f706cc82d6",
        "item_id": "af9ce332-d0a6-4d85-a8fc-7e1b6b084c04",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/31eff33c-7df6-4bd8-8d3d-44f706cc82d6"
          }
        }
      }
    },
    {
      "id": "3b718f45-dbdd-56d8-bcbb-3f7649d4338f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e2701e7d-0387-457a-b804-6a795db6292d",
        "item_id": "af9ce332-d0a6-4d85-a8fc-7e1b6b084c04",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e2701e7d-0387-457a-b804-6a795db6292d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-12T06:33:26Z`
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





