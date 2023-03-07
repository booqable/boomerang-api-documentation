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
    --url 'https://example.booqable.com/api/boomerang/inventory_level_intervals?filter%5Bfrom%5D=2022-01-01&filter%5Binterval%5D=day&filter%5Bitem_id%5D=a1ad8bc7-93d4-4827-bdc3-932eda6b0d81&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0503a267-0c22-5a6a-8512-607701bd9e5c",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "d1a0ac7f-a1ea-50dc-b5a2-be4261fabab7",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "99704b23-e859-5a01-8809-1ea1c11e60ee",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "55ed95e3-0f4f-59ea-89c8-094b8c531a64",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "fdd9a2b2-0d33-534c-a801-0fb2ed47f395",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "bd189615-6792-527a-816e-6b4fcd354b72",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
          }
        }
      }
    },
    {
      "id": "5dfd2179-35b9-5272-a231-5a0c0fc0f1d5",
      "type": "inventory_level_intervals",
      "attributes": {
        "item_id": "a1ad8bc7-93d4-4827-bdc3-932eda6b0d81",
        "location_id": "a87b73c3-939f-43eb-ad06-3040bb600f6d",
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
            "related": "api/boomerang/items/a1ad8bc7-93d4-4827-bdc3-932eda6b0d81"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/a87b73c3-939f-43eb-ad06-3040bb600f6d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:07:14Z`
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





