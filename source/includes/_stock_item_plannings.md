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
      "id": "00069b9a-ee42-48e0-aee5-687efb3b8b18",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:48.789407+00:00",
        "updated_at": "2024-05-27T09:26:48.789407+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "524a9c38-ac58-4235-9f1e-246563b7dca8",
        "planning_id": "e17dae5f-6453-43bb-a740-93d3833f21de",
        "order_id": "fe5339ff-c120-4bbf-aea9-3bdab68245b5"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/524a9c38-ac58-4235-9f1e-246563b7dca8"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/e17dae5f-6453-43bb-a740-93d3833f21de"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/fe5339ff-c120-4bbf-aea9-3bdab68245b5"
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/686dd447-017a-44cf-a596-e643473a423f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "686dd447-017a-44cf-a596-e643473a423f",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-05-27T09:26:50.007770+00:00",
      "updated_at": "2024-05-27T09:26:50.007770+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "8a669a45-92f9-4a8c-b09c-1ca96b0360e3",
      "planning_id": "ee2758e2-d1ce-4259-af22-4feb7672f9c7",
      "order_id": "605710de-3dee-4458-bc81-62bac7004d4f"
    },
    "relationships": {
      "stock_item": {
        "links": {
          "related": "api/boomerang/stock_items/8a669a45-92f9-4a8c-b09c-1ca96b0360e3"
        }
      },
      "planning": {
        "links": {
          "related": "api/boomerang/plannings/ee2758e2-d1ce-4259-af22-4feb7672f9c7"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/605710de-3dee-4458-bc81-62bac7004d4f"
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