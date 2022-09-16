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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "481f3cdf-69e3-5048-b132-f60c6c404833",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "44dc2583-f9c0-5e78-8005-58d823bf65ba",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "b9409ad8-8c9c-5fef-b375-b62af36d0abd",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "2157fc71-83ef-54df-82eb-27a8bf17b79b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "31c2bed5-27d9-556e-aff7-642d144c3380",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "76290584-a79b-5407-8bff-4aa6d7e39359",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
          }
        }
      }
    },
    {
      "id": "ed0c1b90-b36f-5327-9e5a-944c671b13d3",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55",
        "location_id": "f5695137-7fc1-4113-a5e1-a46d90d1f861",
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
            "related": "api/boomerang/items/7ade2b5c-c193-4ec3-9d6b-6a5aae6cda55"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f5695137-7fc1-4113-a5e1-a46d90d1f861"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T11:48:01Z`
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





