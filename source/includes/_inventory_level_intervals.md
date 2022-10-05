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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=15ecb904-6d62-4eeb-811e-3aa0f50d3b8c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "663ff4e3-b229-538c-8191-4b79412e2c69",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "44d1edbe-b38b-54b4-9419-30bb0879b1d2",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "4d83d572-9f47-5a33-b93a-17d55783f7f3",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "5e8246cb-c81f-5371-b316-f87a950922ec",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "d77caa3b-9d67-5081-a67d-a60ad36ac4d0",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "f2be3b12-88a7-5bbc-a6a5-7064e5f8c9a4",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
          }
        }
      }
    },
    {
      "id": "85069997-8c54-5f9b-b235-f5443ba55bec",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "15ecb904-6d62-4eeb-811e-3aa0f50d3b8c",
        "location_id": "61f7397f-988f-4ea2-ae54-18e6765b9f9e",
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
            "related": "api/boomerang/items/15ecb904-6d62-4eeb-811e-3aa0f50d3b8c"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/61f7397f-988f-4ea2-ae54-18e6765b9f9e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-05T11:34:45Z`
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





