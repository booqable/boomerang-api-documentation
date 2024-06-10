# Stock item plannings

Stock item plannings hold information about the planning of individual stock items (for trackable products). They make it possible to know precisely which stock items have been where and define when an item is available during a given period.

Stock item plannings are never directly created or updated through their resource; instead, they are always managed by booking items to an order or transitioning status.

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
      "id": "f3341b5c-e973-48e5-a986-f6186f9a2ba1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:25.824411+00:00",
        "updated_at": "2024-06-10T09:27:25.824411+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "45d74570-9092-4f20-a8fd-0a49121570f4",
        "planning_id": "8e7df894-0147-4d9c-81d5-1f5ac8caac68",
        "order_id": "ff68cb21-61ea-4a60-b1a4-7ddbb8c361e7"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/45d74570-9092-4f20-a8fd-0a49121570f4"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/8e7df894-0147-4d9c-81d5-1f5ac8caac68"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/ff68cb21-61ea-4a60-b1a4-7ddbb8c361e7"
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/e3573c48-1430-485c-9de0-1f6d2ae13d05' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3573c48-1430-485c-9de0-1f6d2ae13d05",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-06-10T09:27:26.750340+00:00",
      "updated_at": "2024-06-10T09:27:26.750340+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "54d38542-4cc8-4604-9a4d-fb16a8646cf8",
      "planning_id": "96da41dc-59a3-43f7-8765-4dede811f4f9",
      "order_id": "06f70ec9-1794-48b1-a803-c86a2770c219"
    },
    "relationships": {
      "stock_item": {
        "links": {
          "related": "api/boomerang/stock_items/54d38542-4cc8-4604-9a4d-fb16a8646cf8"
        }
      },
      "planning": {
        "links": {
          "related": "api/boomerang/plannings/96da41dc-59a3-43f7-8765-4dede811f4f9"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/06f70ec9-1794-48b1-a803-c86a2770c219"
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