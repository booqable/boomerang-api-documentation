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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "90483791-7f35-540f-b9ed-ec7e31ee17fe",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "0cc3f543-f419-5853-80ee-efb8d9063cad",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "f2d39491-1210-54fb-a5db-b0337e63d231",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "49fc4946-6725-575e-b639-0e6039ef5704",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "a52844e4-880a-561d-b8c7-6e18400e0aa2",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "66034113-bb69-58a1-be9b-4765f536c791",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
          }
        }
      }
    },
    {
      "id": "e101ba90-9adb-5c99-b62d-4e88be91b0aa",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4",
        "location_id": "c9660b96-7afe-493e-8333-e223a0d1a9cb",
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
            "related": "api/boomerang/items/c3d0a5e5-8003-4674-9ce9-b6ad2a99fbf4"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/c9660b96-7afe-493e-8333-e223a0d1a9cb"
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





