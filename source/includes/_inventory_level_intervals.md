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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=03043de2-128d-45fd-9b2f-e2df19c9a6be&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5ac16ad4-0d8a-55e4-89af-36a4262b22b0",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "6f7ac0de-639d-5d80-9145-c041dabd1a7a",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "7a5c34c6-f8f8-5006-8a86-d4d8b3eda470",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "f0a463e0-3442-5f30-843c-7c997de855e1",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "c8fbcc93-f786-5392-80d2-439a77229875",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "6bae6d4c-9170-5bf1-b9d9-683d0b6f7919",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
          }
        }
      }
    },
    {
      "id": "fba99474-4974-5423-9233-fd3688a339e6",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "03043de2-128d-45fd-9b2f-e2df19c9a6be",
        "location_id": "ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2",
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
            "related": "api/boomerang/items/03043de2-128d-45fd-9b2f-e2df19c9a6be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ca28c2e4-5e4e-4a9f-83ac-7515f63c19f2"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-07T11:57:44Z`
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





