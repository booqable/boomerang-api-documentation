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
`reserved` | **Boolean** <br>Wheter stock item is reserved, meaning it's unavailable for other orders
`started` | **Boolean** <br>Wheter stock item is started
`stopped` | **Boolean** <br>Wheter stock item is stopped. Meaning it's available again
`stock_item_id` | **Uuid** <br>Associated Stock item
`planning_id` | **Uuid** <br>Associated Planning
`order_id` | **Uuid** <br>Associated Order


## Relationships
Stock item plannings have the following relationships:

Name | Description
-- | --
`order` | **[Order](#orders)** <br>Associated Order
`planning` | **[Planning](#plannings)** <br>Associated Planning
`stock_item` | **[Stock item](#stock-items)** <br>Associated Stock item


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
      "id": "ee7a8dd2-0056-44a6-8661-8bf53bb9988e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-12-02T13:01:19.612671+00:00",
        "updated_at": "2024-12-02T13:01:19.612671+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "09212106-7e3f-452f-a06e-ded8ef1663ed",
        "planning_id": "19340edf-e55f-47dd-a4e8-09474ad27f02",
        "order_id": "9ccd8f75-bf17-431d-8749-405761515888"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/742ef676-8bbc-4f39-b6bc-48c9b8920fc4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "742ef676-8bbc-4f39-b6bc-48c9b8920fc4",
    "type": "stock_item_plannings",
    "attributes": {
      "created_at": "2024-12-02T13:01:20.678871+00:00",
      "updated_at": "2024-12-02T13:01:20.678871+00:00",
      "archived": false,
      "archived_at": null,
      "reserved": false,
      "started": false,
      "stopped": false,
      "stock_item_id": "69002c92-9c19-4ba4-a1bf-10339111c67d",
      "planning_id": "ad127a7e-b83e-4f36-a6ed-06ed7e3daa9c",
      "order_id": "aef7efc8-f614-43b2-9ddf-79484ef3afaa"
    },
    "relationships": {}
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