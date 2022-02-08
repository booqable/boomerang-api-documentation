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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=99bbabec-a44d-47d1-9a0b-2ccb49f4bef2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "035cf57a-b467-5a56-ba68-09a23516d7e1",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "ccd282f5-7690-509f-9b10-22f72b88bd4c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "bf95c1ab-dd20-5e31-9926-e7e15c7e9c68",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "57cab8bc-f389-50c6-8344-5062e354e05b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "4de387d8-12a9-5d4a-adf9-399f943c319c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "2688e31b-8def-5bb3-8828-4785ade6b81d",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
          }
        }
      }
    },
    {
      "id": "810588c4-6902-5fb4-80ac-4424be59e0b5",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "99bbabec-a44d-47d1-9a0b-2ccb49f4bef2",
        "location_id": "0b349b54-9fae-4a11-b168-fd1ab4b347b3",
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
            "related": "api/boomerang/items/99bbabec-a44d-47d1-9a0b-2ccb49f4bef2"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/0b349b54-9fae-4a11-b168-fd1ab4b347b3"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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





