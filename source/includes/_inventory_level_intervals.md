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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "39d8d507-2493-5c89-bc1d-d2d3a1aacf4f",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "19f3c55c-d82c-5085-bce1-7abed21c195e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "e2bf29c2-2369-5114-9c20-0d93c62fdc2b",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "449649c1-3be3-522e-8220-cf3cf78ea248",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "2c5a73a5-4058-5b38-b420-acb739ecea69",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "86e92e4f-c764-5b7e-8929-02fa3bb359bb",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
          }
        }
      }
    },
    {
      "id": "2e73da3d-820a-5b80-a900-6f1e246abaad",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f",
        "location_id": "9059727c-0514-4dee-a8c5-2996c77335bc",
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
            "related": "api/boomerang/items/905ccc3a-88ae-4af2-8c0e-a77ad83f1c7f"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/9059727c-0514-4dee-a8c5-2996c77335bc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:26:43Z`
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





