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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=2eea0375-fce7-4b22-9b74-84aa78b2af1f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9fbd7846-2e2d-59c1-a3a7-ebe8b46f944a",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "5f89b287-7f0c-5f32-a58a-bdd1932ddd02",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "0e920c17-dc45-5de2-bd48-0559556bb823",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "b2c506f0-8b63-52b0-adea-d862e1b6df32",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "7532a33a-183d-5756-9885-7835ddb681f2",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "5ebfcee5-065b-53fa-9f4c-5a5adf1dbdf9",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
          }
        }
      }
    },
    {
      "id": "e0e1424f-8b9e-5193-9275-6a3f61b57402",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "2eea0375-fce7-4b22-9b74-84aa78b2af1f",
        "location_id": "7cdde2bf-ab46-4e36-a5d4-4d94ed835134",
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
            "related": "api/boomerang/items/2eea0375-fce7-4b22-9b74-84aa78b2af1f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/7cdde2bf-ab46-4e36-a5d4-4d94ed835134"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:49:26Z`
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





