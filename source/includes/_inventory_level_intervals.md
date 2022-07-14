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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=1ad26773-b2e4-4b61-8d7c-f120ba6970be&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "26b7c8ac-8b68-50f8-89bf-f1e2a3919d23",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "ec3056f8-fa75-5a65-812f-0d4c6d6e8a42",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "dbeed813-cf70-5589-b570-e13c54eab2fa",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "452cc604-734d-5218-a32a-51997e38e5c3",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "78279648-1c44-5c68-8e9e-215e472eadda",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "a1c66881-f5ac-5183-b6db-787b16954c67",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
          }
        }
      }
    },
    {
      "id": "b48ce5d5-a8c6-5180-96d0-61791d8c30d8",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "1ad26773-b2e4-4b61-8d7c-f120ba6970be",
        "location_id": "ae7ea7ac-2b6a-4e3c-a9ab-eba804203165",
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
            "related": "api/boomerang/items/1ad26773-b2e4-4b61-8d7c-f120ba6970be"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae7ea7ac-2b6a-4e3c-a9ab-eba804203165"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:48:21Z`
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





