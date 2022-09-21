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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=8afd5ea1-1c57-4b46-b604-8f1a41742c0e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c1cbc154-9c36-52d3-b64b-0a008552ad7e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "771e83fa-08d2-5f9a-9e56-c0ce3b416c18",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "236653e0-85a7-539a-8c6e-a93388e1deac",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "ba1b08a6-c415-5893-868b-dee11bbfd840",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "12b3a567-2d06-59af-aeca-3a95a50eab2c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "d3f4d4e1-ee4e-53a4-9973-2d1dd6268903",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
          }
        }
      }
    },
    {
      "id": "22e9e9a1-617c-59a6-b607-036e0c91fd6f",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "8afd5ea1-1c57-4b46-b604-8f1a41742c0e",
        "location_id": "33c42334-cc69-4cb4-9ac4-a2038718fa2f",
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
            "related": "api/boomerang/items/8afd5ea1-1c57-4b46-b604-8f1a41742c0e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/33c42334-cc69-4cb4-9ac4-a2038718fa2f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-21T09:04:21Z`
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





