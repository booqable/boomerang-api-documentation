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
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=651317c7-5224-47ed-9551-97008041f892&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9f9e4494-b6af-5c0e-af32-486d13187501",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "651317c7-5224-47ed-9551-97008041f892",
        "order_id": null,
        "location_id": "664e98be-2d5f-422c-b5b6-cf913a1a7916",
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
            "related": "api/boomerang/items/651317c7-5224-47ed-9551-97008041f892"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/664e98be-2d5f-422c-b5b6-cf913a1a7916"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=84167dd4-ac37-4b55-9d89-4b44b885117b&filter%5Blocation_id%5D=c7ebf2ba-b723-41e5-8aee-35d347030ab1&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5a0381bb-e713-5035-8bc1-76ff7454c8ef",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "84167dd4-ac37-4b55-9d89-4b44b885117b",
        "order_id": null,
        "location_id": "c7ebf2ba-b723-41e5-8aee-35d347030ab1",
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
            "related": "api/boomerang/items/84167dd4-ac37-4b55-9d89-4b44b885117b"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c7ebf2ba-b723-41e5-8aee-35d347030ab1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:21Z`
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





