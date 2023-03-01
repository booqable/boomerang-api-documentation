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
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=65290f4f-fef1-4423-8b4d-bbc51ca09353&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eda354e5-7975-519c-89a1-192ba4bd90c0",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "65290f4f-fef1-4423-8b4d-bbc51ca09353",
        "order_id": null,
        "location_id": "d75be95c-5bf5-4d1f-a766-4c140768731c",
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
            "related": "api/boomerang/items/65290f4f-fef1-4423-8b4d-bbc51ca09353"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/d75be95c-5bf5-4d1f-a766-4c140768731c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=6a100efb-8d80-44d5-b443-eb47fb0a4107&filter%5Blocation_id%5D=eafb087c-8fa9-4782-90f3-984d5de0e0ae&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f60438b7-40e3-5da6-bd83-06095728274a",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "6a100efb-8d80-44d5-b443-eb47fb0a4107",
        "order_id": null,
        "location_id": "eafb087c-8fa9-4782-90f3-984d5de0e0ae",
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
            "related": "api/boomerang/items/6a100efb-8d80-44d5-b443-eb47fb0a4107"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/eafb087c-8fa9-4782-90f3-984d5de0e0ae"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:52Z`
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





