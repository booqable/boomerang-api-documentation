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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=32c07b60-6d65-4a11-9ead-9aba4a34ea53&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d001f7b6-d86e-5be3-82ce-00be81ef013a",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "d2649c47-d2cb-58b5-a1b5-822a6cb5b55c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "b54f4e4e-221b-5593-b613-dcd1c1bb1b0b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "d0d45967-bd2b-53bd-b391-4c8be772afe4",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "12474c9c-d338-50aa-a6f0-462a7e0e86cb",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "cacdd69e-c665-57be-b941-b5f9b5d2bb07",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
          }
        }
      }
    },
    {
      "id": "506e38cd-1d6f-5b58-9f4b-0a5457177eae",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "32c07b60-6d65-4a11-9ead-9aba4a34ea53",
        "location_id": "e72c09cf-0a1b-4f4e-91b0-717e17e8ab43",
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
            "related": "api/boomerang/items/32c07b60-6d65-4a11-9ead-9aba4a34ea53"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/e72c09cf-0a1b-4f4e-91b0-717e17e8ab43"
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





