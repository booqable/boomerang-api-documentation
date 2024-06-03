# Stock item plannings

Stock item plannings hold information about the planning of individual stock items (for trackable products). They make it possible to know precisely which stock items have been where and define when an item is available during a given period.

Stock item plannings are never directly created or updated through their resource; instead, they are always managed by booking items to an order or transitioning status.

## Endpoints
`DELETE /api/boomerang/stock_item_plannings/{id}`

`GET /api/boomerang/stock_item_plannings`

## Fields
Every stock item planning has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether stock item planning is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the stock item planning was archived
`reserved` | **Boolean** `readonly`<br>Wheter stock item is reserved, meaning it's unavailable for other orders
`started` | **Boolean** `readonly`<br>Wheter stock item is started
`stopped` | **Boolean** `readonly`<br>Wheter stock item is stopped. Meaning it's available again
`stock_item_id` | **Uuid** `readonly`<br>The associated Stock item
`planning_id` | **Uuid** `readonly`<br>The associated Planning
`order_id` | **Uuid** `readonly`<br>The associated Order


## Relationships
Stock item plannings have the following relationships:

Name | Description
-- | --
`stock_item` | **Stock items** `readonly`<br>Associated Stock item
`planning` | **Plannings** `readonly`<br>Associated Planning
`order` | **Orders** `readonly`<br>Associated Order


## Archiving a stock_item planning



> How to archive a stock item planning:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/fb9b6a0f-e360-4c90-9324-4ec8c57a9f11' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fb9b6a0f-e360-4c90-9324-4ec8c57a9f11",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-06-03T09:27:33.694534+00:00",
      "updated_at": "2024-06-03T09:27:33.694534+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "2885cbf3-f238-4344-9ba5-fa6640480cbb",
      "planning_id": "7cba64ce-723d-4bb8-8592-e0a356e39b31",
      "order_id": "0f64d9f1-ef0d-4071-beb4-bfee6d60fc4a"
    },
    "relationships": {
      "stock_item": {
        "links": {
          "related": "api/boomerang/stock_items/2885cbf3-f238-4344-9ba5-fa6640480cbb"
        }
      },
      "planning": {
        "links": {
          "related": "api/boomerang/plannings/7cba64ce-723d-4bb8-8592-e0a356e39b31"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/0f64d9f1-ef0d-4071-beb4-bfee6d60fc4a"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/stock_item_plannings/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_plannings]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Listing stock item plannings



> How to fetch a list of stock item plannings:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6fc9cb83-b157-4ff4-b683-517eeb568765",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-03T09:27:35.459601+00:00",
        "updated_at": "2024-06-03T09:27:35.459601+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "c7156134-77ce-483f-a8ae-a67a9cfa1698",
        "planning_id": "09a79e1d-6c2e-4c7c-81ae-e0638e745b4a",
        "order_id": "a1fd63c7-75df-4deb-9fd3-9d0ec87eb7a7"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c7156134-77ce-483f-a8ae-a67a9cfa1698"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/09a79e1d-6c2e-4c7c-81ae-e0638e745b4a"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/a1fd63c7-75df-4deb-9fd3-9d0ec87eb7a7"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_item_plannings`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=stock_item,planning,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_plannings]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean** <br>`eq`
`started` | **Boolean** <br>`eq`
`stopped` | **Boolean** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`, `not_eq`
`planning_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item` => 
`product` => 
`photo`






`planning`


`order`





