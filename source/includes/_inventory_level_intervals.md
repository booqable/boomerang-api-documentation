# Inventory level intervals

Inventory level intervals provide a breakdown of stock quantity information by an interval. It returns data about availability, stock counts, and what is planned on orders.

## Fields
Every inventory level interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid**<br>The associated Item
`location_id` | **Uuid**<br>The associated Location
`from` | **Datetime** `readonly`<br>Start of the period to list inventory levels for
`till` | **Datetime** `readonly`<br>End of the period to list inventory levels for
`location_available` | **Integer** `readonly`<br>The minimum available quantity for the location within the interval
`location_max_available` | **Integer** `readonly`<br>The maximum available quantity for the location within the interval
`location_stock_count` | **Integer** `readonly`<br>The minimum stock count for the location within the interval
`location_max_stock_count` | **Integer** `readonly`<br>The maximum stock count for the location within the interval
`location_planned` | **Integer** `readonly`<br>The minimum planned quantity for the location within the interval
`location_max_planned` | **Integer** `readonly`<br>The maximum planned quantity for the location within the interval
`location_needed` | **Integer** `readonly`<br>The minimum needed quantity for the location within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`)
`location_max_needed` | **Integer** `readonly`<br>The maximum needed quantity for the location within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`)
`cluster_available` | **Integer** `readonly`<br>The minimum available quantity for the cluster within the interval
`cluster_max_available` | **Integer** `readonly`<br>The maximum available quantity for the cluster within the interval
`cluster_stock_count` | **Integer** `readonly`<br>The minimum stock count for the cluster within the interval
`cluster_max_stock_count` | **Integer** `readonly`<br>The maximum stock count for the cluster within the interval
`cluster_planned` | **Integer** `readonly`<br>The minimum planned quantity for the cluster within the interval
`cluster_max_planned` | **Integer** `readonly`<br>The maximum planned quantity for the cluster within the interval
`cluster_needed` | **Integer** `readonly`<br>The minimum needed quantity for the cluster within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`)
`cluster_max_needed` | **Integer** `readonly`<br>The maximum needed quantity for the cluster within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`)


## Relationships
Inventory level intervals have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`location` | **Locations** `readonly`<br>Associated Location


## Listing inventory level intervals



> How to fetch a list of inventory level intervals:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=16b9ffa9-4a60-4740-bc2e-7271e8e18d96&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b85ad413-f76b-5227-b83c-95efc5564fe9",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-01T00:00:00+00:00",
        "till": "2022-01-02T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "a01c757e-074a-5f1a-b48c-ee9b1200c32f",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-02T00:00:00+00:00",
        "till": "2022-01-03T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "d3b54e8e-b0b3-59c3-92bb-d607e3f9ebab",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-03T00:00:00+00:00",
        "till": "2022-01-04T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "1205a58c-27e3-5ab6-8c43-65015446e0b4",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-04T00:00:00+00:00",
        "till": "2022-01-05T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "0b53bd7e-3626-5cb6-9204-29f66c764588",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-05T00:00:00+00:00",
        "till": "2022-01-06T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "8ad72564-8be4-5c74-bedf-528fbc4a18de",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-06T00:00:00+00:00",
        "till": "2022-01-07T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    },
    {
      "id": "d7e3456f-908c-5ed1-a653-38530dd9f13c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "16b9ffa9-4a60-4740-bc2e-7271e8e18d96",
        "location_id": "4162aa38-3ab3-4252-b938-8b3d66c167c4",
        "from": "2022-01-07T00:00:00+00:00",
        "till": "2022-01-08T00:00:00+00:00",
        "location_available": 4,
        "location_max_available": 4,
        "location_stock_count": 4,
        "location_max_stock_count": 4,
        "location_planned": 0,
        "location_max_planned": 0,
        "location_needed": 0,
        "location_max_needed": 0,
        "cluster_available": 4,
        "cluster_max_available": 4,
        "cluster_stock_count": 4,
        "cluster_max_stock_count": 4,
        "cluster_planned": 0,
        "cluster_max_planned": 0,
        "cluster_needed": 0,
        "cluster_max_needed": 0
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/16b9ffa9-4a60-4740-bc2e-7271e8e18d96"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/4162aa38-3ab3-4252-b938-8b3d66c167c4"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/inventory_level_intervals`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[inventory_level_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T14:23:56Z`
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
`interval` | **String** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





