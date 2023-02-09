# Inventory levels

Inventory levels provide information on item availability. It describes availability, stock counts, and planned quantities for given items.
## Endpoints
`GET /api/boomerang/inventory_levels`

## Fields
Every inventory level has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid** <br>The associated Item
`order_id` | **Uuid** `readonly`<br>Return data for all items on an order
`location_id` | **Uuid** <br>The associated Location
`location_available` | **Integer** `readonly`<br>The available quantity for the given location
`location_stock_count` | **Integer** `readonly`<br>The quantity of stock present for the given the location
`location_plannable` | **Integer** `readonly`<br>The number of products that can be planned for the given location
`location_planned` | **Integer** `readonly`<br>The planned quantity for the given location
`location_needed` | **Integer** `readonly`<br>The needed quantity for the given location. This quantity does not contain what has already been returned for an order (`planned - stopped`)
`cluster_available` | **Integer** `readonly`<br>The available quantity for the cluster the given location is part of
`cluster_stock_count` | **Integer** `readonly`<br>The stock count for the cluster the given location is part of
`cluster_plannable` | **Integer** `readonly`<br>The planned quantity for the cluster the given location is part of
`cluster_planned` | **Integer** `readonly`<br>The planned quantity for the cluster the given location is part of
`cluster_needed` | **Integer** `readonly`<br>The needed quantity for the cluster the given location is part of. This quantity does not contain what has already been returned for an order (`planned - stopped`)


## Relationships
Inventory levels have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`location` | **Locations** `readonly`<br>Associated Location


## Obtaining inventory levels for a product



> How to fetch inventory levels for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=be6bebe1-dd1a-4d44-8cfd-65871e940f53&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2321c79c-3215-5129-8b04-a7283e357bf2",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "be6bebe1-dd1a-4d44-8cfd-65871e940f53",
        "order_id": null,
        "location_id": "212de90c-4eb1-4f89-8553-5a3ee15b51cd",
        "location_available": 0,
        "location_stock_count": 0,
        "location_plannable": 0,
        "location_planned": 0,
        "location_needed": 0,
        "cluster_available": 0,
        "cluster_stock_count": 0,
        "cluster_plannable": 0,
        "cluster_planned": 0,
        "cluster_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/be6bebe1-dd1a-4d44-8cfd-65871e940f53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/212de90c-4eb1-4f89-8553-5a3ee15b51cd"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/inventory_levels`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_levels]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:09:54Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`item`


`location`






## Obtaining inventory levels for a product for a specific location



> How to fetch inventory levels for a product for a specific location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=a477d7f0-5f8a-42d1-87ab-d6db91a033ae&filter%5Blocation_id%5D=20e554e9-ee3d-4c0f-bd6d-55fcf8005500&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "58df9b4d-dc7a-541d-a9a8-f6ea53851d84",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "a477d7f0-5f8a-42d1-87ab-d6db91a033ae",
        "order_id": null,
        "location_id": "20e554e9-ee3d-4c0f-bd6d-55fcf8005500",
        "location_available": 0,
        "location_stock_count": 0,
        "location_plannable": 0,
        "location_planned": 0,
        "location_needed": 0,
        "cluster_available": 0,
        "cluster_stock_count": 0,
        "cluster_plannable": 0,
        "cluster_planned": 0,
        "cluster_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/a477d7f0-5f8a-42d1-87ab-d6db91a033ae"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/20e554e9-ee3d-4c0f-bd6d-55fcf8005500"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/inventory_levels`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_levels]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:09:54Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





