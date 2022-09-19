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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=fdf26efe-55ad-4325-bc59-cb88ab9e8d97&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ecc79747-f335-5269-8f4e-8e821ffd68f0",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "c1b93f2c-5d86-57ca-8cfb-53bede55634d",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "9be3d523-2e36-57f5-be72-f7450609b68b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "d76a9ae6-3d39-50bc-a38d-6359ced0f3b7",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "e4824952-cac1-507d-9db2-9275d34e8eef",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "463d3cd3-40fd-5b87-a2e2-e56c0732273a",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
          }
        }
      }
    },
    {
      "id": "801c3b83-4333-5071-b843-d2eb3073f6bc",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "fdf26efe-55ad-4325-bc59-cb88ab9e8d97",
        "location_id": "3e5219b6-9106-4f00-a20a-a6cf1739ee61",
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
            "related": "api/boomerang/items/fdf26efe-55ad-4325-bc59-cb88ab9e8d97"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3e5219b6-9106-4f00-a20a-a6cf1739ee61"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T14:12:38Z`
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





