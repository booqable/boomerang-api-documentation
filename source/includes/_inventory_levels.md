# Inventory levels

Inventory levels provide information on item availability. It describes availability, stock counts, and planned quantities for given items.
## Endpoints
`GET /api/boomerang/inventory_levels`

## Fields
Every inventory level has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid**<br>The associated Item
`location_id` | **Uuid**<br>The associated Location
`from` | **Datetime** `readonly`<br>Start of the period to provide inventory levels for
`till` | **Datetime** `readonly`<br>End of the period to provide inventory levels for
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
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=aa8a5d47-8fc5-435a-aed7-f99da18cd5a0&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1d927e15-9ae7-5d6c-bc0f-2823f2bd26ad",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "aa8a5d47-8fc5-435a-aed7-f99da18cd5a0",
        "location_id": "3e650a54-d99e-4d13-8627-6c4e13711148",
        "from": null,
        "till": null,
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
            "related": "api/boomerang/items/aa8a5d47-8fc5-435a-aed7-f99da18cd5a0"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e650a54-d99e-4d13-8627-6c4e13711148"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[inventory_levels]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T06:33:35Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`item`


`location`






## Obtaining inventory levels for a product for a specific location



> How to fetch inventory levels for a product for a specific location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_levels?filter%5Bfrom%5D=2022-01-01+09%3A00%3A00&filter%5Bitem_id%5D=ce43d0d9-162a-457f-8e52-740ec065d7aa&filter%5Blocation_id%5D=a71f46ad-44d1-4788-8ed8-b2eacc8b290f&filter%5Btill%5D=2022-01-02+09%3A00%3A00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "559e7ead-899a-5c28-8db5-38b715eb32ed",
      "type": "inventory_levels",
      "attributes": {
        "item_id": "ce43d0d9-162a-457f-8e52-740ec065d7aa",
        "location_id": "a71f46ad-44d1-4788-8ed8-b2eacc8b290f",
        "from": null,
        "till": null,
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
            "related": "api/boomerang/items/ce43d0d9-162a-457f-8e52-740ec065d7aa"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a71f46ad-44d1-4788-8ed8-b2eacc8b290f"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[inventory_levels]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T06:33:35Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





