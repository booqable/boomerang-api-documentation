# Stock item plannings

Stock item plannings hold information about the planning of individual stock items (for trackable products).
They make it possible to know precisely which stock items have been where and define when an item is available
during a given period.

Stock item plannings are never directly created or updated through their resource;
instead they are created by booking or specifying stock items; they are updated by
starting or stoppinmg them. See the [OrderFulfilments](#order-fulfilments) resource
for examples.

## Endpoints
`GET /api/boomerang/stock_item_plannings`

`DELETE /api/boomerang/stock_item_plannings/{id}`

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
      "id": "92516a19-8329-42da-80a6-d5e469e0bd42",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-24T09:54:51.618658+00:00",
        "updated_at": "2024-06-24T09:54:51.618658+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "1224c6d4-7ed7-4405-ae9e-e13f3e56d9cd",
        "planning_id": "1e57c9e8-e2f7-4c43-9c95-2c68ff29e968",
        "order_id": "ef83a33b-6a6b-4825-9ddd-a74649880d99"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1224c6d4-7ed7-4405-ae9e-e13f3e56d9cd"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/1e57c9e8-e2f7-4c43-9c95-2c68ff29e968"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/ef83a33b-6a6b-4825-9ddd-a74649880d99"
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






## Archiving a stock_item planning



> How to archive a stock item planning:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/d07c6bc8-367c-453f-8992-2b7e1595b0f8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d07c6bc8-367c-453f-8992-2b7e1595b0f8",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-06-24T09:54:52.820483+00:00",
      "updated_at": "2024-06-24T09:54:52.820483+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "aea11d67-3ab4-4430-ba6f-5011addae51c",
      "planning_id": "c28fa1bd-9ce8-4867-a7a5-cf1e0050caef",
      "order_id": "af17963a-119b-4030-8a08-f16836f6e416"
    },
    "relationships": {
      "stock_item": {
        "links": {
          "related": "api/boomerang/stock_items/aea11d67-3ab4-4430-ba6f-5011addae51c"
        }
      },
      "planning": {
        "links": {
          "related": "api/boomerang/plannings/c28fa1bd-9ce8-4867-a7a5-cf1e0050caef"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/af17963a-119b-4030-8a08-f16836f6e416"
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