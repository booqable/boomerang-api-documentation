# Inventory level intervals

Inventory level intervals provide a breakdown of stock quantity information by an interval. It returns data about availability, stock counts, and what is planned on orders.

## Fields
Every inventory level interval has the following fields:

Name | Description
- | -
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
- | -
`item` | **Items** `readonly`<br>Associated Item
`location` | **Locations** `readonly`<br>Associated Location


## Listing inventory level intervals



> How to fetch a list of inventory level intervals:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=3f03a3bf-d335-4164-92e1-f182f7fddf18&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "309f34d7-1d55-5b72-ba31-f67964b79f53",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "39bb8800-5dd2-5444-acda-8ab138cd1c13",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "56a25447-8b9b-5318-b490-ad22313b4fbc",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "dde2f170-6a26-57f3-995e-dfd3b8ae3345",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "74eb2136-fe93-5ec2-b25e-8224b1806608",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "6fa64eaa-9191-5879-8c09-54af00fc33cc",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
          }
        }
      }
    },
    {
      "id": "3235fe49-338c-5c82-8799-6182c862f7da",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "3f03a3bf-d335-4164-92e1-f182f7fddf18",
        "location_id": "fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0",
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
            "related": "api/boomerang/items/3f03a3bf-d335-4164-92e1-f182f7fddf18"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/fd9f780b-5e8e-49cd-a71b-5fff7d81e5d0"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=item,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_level_intervals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:15:14Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** `required`<br>`eq`
`till` | **Datetime** `required`<br>`eq`
`interval` | **String** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





