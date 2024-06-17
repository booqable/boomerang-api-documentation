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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7c95d903-ee0e-5625-b064-953a6f47e316",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "512a8913-9358-5610-b558-0e9c940f397c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "c5f43daf-e2bf-5190-b1ed-be4c8dd1180b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "c1980986-b6d5-5929-b75f-31533a2b700b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "5852dc3b-c2ad-5219-bad3-58cff3b666b3",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "4363ce6d-ff87-5020-b510-dcdf9367b715",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
          }
        }
      }
    },
    {
      "id": "030a4b08-98a6-564b-afce-849b8d57739b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7",
        "location_id": "3d05aa2a-acd7-4098-9f9c-748b079cd0ae",
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
            "related": "api/boomerang/items/7bb4b921-cbae-4a3c-8d6e-ac66cf6641d7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/3d05aa2a-acd7-4098-9f9c-748b079cd0ae"
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





