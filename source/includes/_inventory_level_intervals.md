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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=264f73aa-787f-44c5-9482-f52978c6c079&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c3eee24c-abe1-5684-9be2-4be39c5fc13f",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "00d342d1-e9a4-5409-bd65-cbc8b0b9f4cd",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "da642358-78ba-5054-b920-c3b113a187e6",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "c963595d-0ba6-5cee-8ab5-3f65186e0605",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "3f6db529-314a-5dca-abc2-6d18cf420408",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "e39a1f4e-b5a3-5f29-a3cf-2d216114018e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
          }
        }
      }
    },
    {
      "id": "581153e4-6299-5ab7-9eaf-13ce080ea24e",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "264f73aa-787f-44c5-9482-f52978c6c079",
        "location_id": "f2af146a-796e-48cf-87ed-37cdf2cfc03a",
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
            "related": "api/boomerang/items/264f73aa-787f-44c5-9482-f52978c6c079"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/f2af146a-796e-48cf-87ed-37cdf2cfc03a"
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





