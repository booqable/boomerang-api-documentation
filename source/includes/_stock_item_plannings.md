# Stock item plannings

Stock item plannings hold information about the planning of individual stock items (for trackable products). They make it possible to know precisely which stock items have been where and define when an item is available during a given period.

Stock item plannings are never directly created or updated through their resource; instead, they are always managed by booking items to an order or transitioning status.

## Endpoints
`GET /api/boomerang/stock_item_plannings`

`DELETE /api/boomerang/stock_item_plannings/{id}`

## Fields
Every stock item planning has the following fields:

Name | Description
- | -
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
- | -
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
      "id": "baaee522-fd4a-4ad3-9be2-c387ca34a29e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-08T18:21:27+00:00",
        "updated_at": "2022-04-08T18:21:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "942ed723-d250-48f8-9efc-f9b066667db5",
        "planning_id": "9a0d145b-25ae-4eec-9cd0-0b8a6846faf6",
        "order_id": "05f0f88e-ac9e-4c27-ab3d-98fdb903b24f"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/942ed723-d250-48f8-9efc-f9b066667db5"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/9a0d145b-25ae-4eec-9cd0-0b8a6846faf6"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/05f0f88e-ac9e-4c27-ab3d-98fdb903b24f"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item,planning,order`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_plannings]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:13Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean**<br>`eq`
`started` | **Boolean**<br>`eq`
`stopped` | **Boolean**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`, `not_eq`
`planning_id` | **Uuid**<br>`eq`, `not_eq`
`order_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/fb3dc3dc-ef5a-4548-a896-8a02229e3f5d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/stock_item_plannings/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item,planning,order`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_plannings]=id,created_at,updated_at`


### Includes

This request does not accept any includes