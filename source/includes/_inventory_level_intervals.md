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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=659d4bde-ca52-4f0f-8a08-3bb57900a25d&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "13b8c1e5-669f-569c-afe7-28e6a39c5aa0",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "4205254a-4013-5c5c-a84b-15f41b13de17",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "56e2248b-a2bb-59a1-8ac4-df49fb3c0693",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "89e61295-3653-5347-a9c1-61ff74344cac",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "13a65c3d-7c40-5766-9ee0-00c88bc6e103",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "a38b65ec-1fe8-5efa-81b1-e0704f02bb36",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
          }
        }
      }
    },
    {
      "id": "5e331b8b-2733-5495-bf4f-48461d753921",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "659d4bde-ca52-4f0f-8a08-3bb57900a25d",
        "location_id": "a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0",
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
            "related": "api/boomerang/items/659d4bde-ca52-4f0f-8a08-3bb57900a25d"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a44ae3a3-2fb6-4e3e-8088-32b0beba5ed0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-01T08:55:19Z`
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





