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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=b563dabd-4e97-4a1a-b674-d7f7bc028135&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "706f1d23-886d-57bc-ae6a-02e0bbb112d0",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "81e91952-028a-5f68-a33a-bd97b107b20d",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "6dda91cf-eef6-54ba-8bcf-ea5f17310a87",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "399ae4b0-3639-5fb7-b7c6-c3483c03e95a",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "26cfaaf5-6b6f-5054-8591-93ccea0d6e94",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "8efb5741-08f2-50bf-87d2-0271f03494f1",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
          }
        }
      }
    },
    {
      "id": "dd006e2e-fb12-5c2f-bd37-1666e2afca91",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "b563dabd-4e97-4a1a-b674-d7f7bc028135",
        "location_id": "8a0cc336-fdd7-42ee-a2ed-183e6e36fa38",
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
            "related": "api/boomerang/items/b563dabd-4e97-4a1a-b674-d7f7bc028135"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a0cc336-fdd7-42ee-a2ed-183e6e36fa38"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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





