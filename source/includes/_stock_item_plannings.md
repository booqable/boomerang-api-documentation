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
      "id": "ffe5a25c-4e15-425b-9a5c-3019df28e4df",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-24T09:27:27.321445+00:00",
        "updated_at": "2024-06-24T09:27:27.321445+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "6da3e454-bfad-40ed-af12-684246143063",
        "planning_id": "ea9e9977-db95-447e-be86-2578b0ddba2e",
        "order_id": "7365ab0b-5ab1-41f9-b2d2-78d4e53427a8"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6da3e454-bfad-40ed-af12-684246143063"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/ea9e9977-db95-447e-be86-2578b0ddba2e"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/7365ab0b-5ab1-41f9-b2d2-78d4e53427a8"
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/c5cd5cef-48b9-4cf3-adce-2afcc0f68eb5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c5cd5cef-48b9-4cf3-adce-2afcc0f68eb5",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-06-24T09:27:26.000865+00:00",
      "updated_at": "2024-06-24T09:27:26.000865+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "889a9fdd-7870-4e0b-8d17-4b56e5eab694",
      "planning_id": "2f6eadc8-7a26-4df4-b891-081460fc74ea",
      "order_id": "adce6ede-ebf1-4e65-a1b7-f6c2d5bd4881"
    },
    "relationships": {
      "stock_item": {
        "links": {
          "related": "api/boomerang/stock_items/889a9fdd-7870-4e0b-8d17-4b56e5eab694"
        }
      },
      "planning": {
        "links": {
          "related": "api/boomerang/plannings/2f6eadc8-7a26-4df4-b891-081460fc74ea"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/adce6ede-ebf1-4e65-a1b7-f6c2d5bd4881"
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