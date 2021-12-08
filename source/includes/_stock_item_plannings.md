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
      "id": "5f19e420-2902-47c9-9d6c-2876ee74de79",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-08T12:35:34+00:00",
        "updated_at": "2021-12-08T12:35:34+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "99a9c8f4-af69-4503-9e8e-91f65eaf1032",
        "planning_id": "1a6c1589-4c11-4902-acb5-2ca918a2a06f",
        "order_id": "722cbed4-3ec3-4eb4-9e6d-01dd1963df9f"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/99a9c8f4-af69-4503-9e8e-91f65eaf1032"
          }
        },
        "planning": {
          "links": {
            "related": "api/boomerang/plannings/1a6c1589-4c11-4902-acb5-2ca918a2a06f"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/722cbed4-3ec3-4eb4-9e6d-01dd1963df9f"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/stock_item_plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/stock_item_plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/stock_item_plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/05bd6363-690a-4663-b1af-e9b23c2098d9' \
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