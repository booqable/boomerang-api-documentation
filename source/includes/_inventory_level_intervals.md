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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=6c9ca8fe-cb82-4d02-823f-bb7f5d882056&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9d36843e-0d7a-5626-b0bf-ffc6b2833e0d",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "27ff9594-519e-5971-9e89-918c61c9537e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "625eed7e-5ad6-53fb-8ce3-8d64b95e6329",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "a72f7aa4-ed65-5374-a294-3ed519f01840",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "f994bbb5-5e18-5035-8205-17356a48ca97",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "a99987e5-3037-5c22-afbe-4ba6ec6ccba4",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
          }
        }
      }
    },
    {
      "id": "3d79f324-226a-549a-869f-fa64f4a0f0d3",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "6c9ca8fe-cb82-4d02-823f-bb7f5d882056",
        "location_id": "9856ee9f-a5ee-44b8-ab91-50270ca8cfd5",
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
            "related": "api/boomerang/items/6c9ca8fe-cb82-4d02-823f-bb7f5d882056"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9856ee9f-a5ee-44b8-ab91-50270ca8cfd5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:36:16Z`
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





