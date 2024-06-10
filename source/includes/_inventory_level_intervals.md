# Inventory level intervals

Inventory level intervals provide a breakdown of stock quantity information by an interval. It returns data about availability, stock counts, and what is planned on orders.

## Fields
Every inventory level interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid** <br>The associated Item
`location_id` | **Uuid** <br>The associated Location
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
-- | --
`item` | **Items** `readonly`<br>Associated Item
`location` | **Locations** `readonly`<br>Associated Location


## Listing inventory level intervals



> How to fetch a list of inventory level intervals:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=8677ff0f-1643-4636-8f0b-b4418fd15af3&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "007cffe0-d9b0-51ae-b998-721efee14357",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-01T00:00:00.000000+00:00",
        "till": "2022-01-02T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "2ee50576-9404-5f17-843a-b0d87893faf9",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-02T00:00:00.000000+00:00",
        "till": "2022-01-03T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "69eae5a9-7d8d-54dd-911e-205d9eeedd57",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-03T00:00:00.000000+00:00",
        "till": "2022-01-04T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "a4063181-5dc4-5f2a-be6a-ae05c0287da9",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-04T00:00:00.000000+00:00",
        "till": "2022-01-05T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "c220208e-4c60-5011-a0b0-e225abbb1b47",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-05T00:00:00.000000+00:00",
        "till": "2022-01-06T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "157928b1-2be7-5e1a-bc43-fea99a35e80e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-06T00:00:00.000000+00:00",
        "till": "2022-01-07T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
          }
        }
      }
    },
    {
      "id": "f9cba501-ebf9-5e56-8ed5-ed7f3f530ea9",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8677ff0f-1643-4636-8f0b-b4418fd15af3",
        "location_id": "caeb7333-4a58-4eb2-a75a-eb59b4788652",
        "from": "2022-01-07T00:00:00.000000+00:00",
        "till": "2022-01-08T00:00:00.000000+00:00",
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
            "related": "api/boomerang/items/8677ff0f-1643-4636-8f0b-b4418fd15af3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/caeb7333-4a58-4eb2-a75a-eb59b4788652"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_level_intervals]=item_id,location_id,from`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`item_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`
`interval` | **String** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





