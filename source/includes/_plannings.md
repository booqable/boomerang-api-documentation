# Plannings

Plannings contain information about the quantitative planning of an item. An item can either be a product or a bundle. Planning (in combination with [Stock counts](#stock-counts)) define when an item is available during a given period. Plannings are never directly created or updated through their resource; instead, they are always managed by booking items to an order, updating or deleting its associated line, or transitioning status.

Nested plannings contain information about individual items in a bundle. Note that nested plannings can not be deleted directly, the parent should be deleted instead.

## Endpoints
`GET /api/boomerang/plannings`

`GET /api/boomerang/plannings/{id}`

## Fields
Every planning has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether planning is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the planning was archived
`quantity` | **Integer** `readonly`<br>Total planned
`starts_at` | **Datetime** `readonly`<br>When the start action is planned
`stops_at` | **Datetime** `readonly`<br>When the stop action is planned
`reserved_from` | **Datetime** `readonly`<br>When the items become unavailable
`reserved_till` | **Datetime** `readonly`<br>When the items become available again
`reserved` | **Boolean** `readonly`<br>Wheter items are reserved
`started` | **Integer** `readonly`<br>Amount of items started
`stopped` | **Integer** `readonly`<br>Amount of items stopped
`location_shortage_amount` | **Integer** `readonly`<br>Amount of items short
`shortage_amount` | **Integer** `readonly`<br>Amount of items short on location (could be there are still available on other locations in the same cluster)
`item_id` | **Uuid** `readonly`<br>The associated Item
`order_id` | **Uuid** `readonly`<br>The associated Order
`start_location_id` | **Uuid** `readonly`<br>The associated Start location
`stop_location_id` | **Uuid** `readonly`<br>The associated Stop location
`parent_planning_id` | **Uuid** `readonly`<br>The associated Parent planning


## Relationships
Plannings have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`order` | **Orders** `readonly`<br>Associated Order
`order_line` | **Lines** `readonly`<br>Associated Order line
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location
`parent_planning` | **Plannings** `readonly`<br>Associated Parent planning
`nested_plannings` | **Plannings** `readonly`<br>Associated Nested plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Listing plannings



> How to fetch a list of plannings:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c920f6f8-967e-43b6-809d-25258f0b97ba",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-08T17:53:07+00:00",
        "updated_at": "2022-04-08T17:53:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4b0cfb98-283b-495a-8e71-05dd467119d6",
        "order_id": "34911acc-b5d6-4331-af33-fd5706f33243",
        "start_location_id": "40e4929a-1784-4673-9f43-6f8b25be9c11",
        "stop_location_id": "40e4929a-1784-4673-9f43-6f8b25be9c11",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/4b0cfb98-283b-495a-8e71-05dd467119d6"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/34911acc-b5d6-4331-af33-fd5706f33243"
          }
        },
        "order_line": {
          "links": {
            "related": "api/boomerang/lines?filter[planning_id]=c920f6f8-967e-43b6-809d-25258f0b97ba"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/40e4929a-1784-4673-9f43-6f8b25be9c11"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/40e4929a-1784-4673-9f43-6f8b25be9c11"
          }
        },
        "parent_planning": {
          "links": {
            "related": null
          }
        },
        "nested_plannings": {
          "links": {
            "related": "api/boomerang/plannings?filter[planning_id]=c920f6f8-967e-43b6-809d-25258f0b97ba"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[planning_id]=c920f6f8-967e-43b6-809d-25258f0b97ba"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/plannings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,order,order_line`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[plannings]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_from` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean**<br>`eq`
`started` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stopped` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`location_shortage_amount` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`item_id` | **Uuid**<br>`eq`, `not_eq`
`order_id` | **Uuid**<br>`eq`, `not_eq`
`start_location_id` | **Uuid**<br>`eq`, `not_eq`
`stop_location_id` | **Uuid**<br>`eq`, `not_eq`
`parent_planning_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






## Fetching a planning



> How to fetch a planning:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings/1b9099a8-5b7f-46b9-a4fb-4415fa1608f3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1b9099a8-5b7f-46b9-a4fb-4415fa1608f3",
    "type": "plannings",
    "attributes": {
      "created_at": "2022-04-08T17:53:09+00:00",
      "updated_at": "2022-04-08T17:53:09+00:00",
      "archived": false,
      "archived_at": null,
      "quantity": 1,
      "starts_at": "1980-04-01T12:00:00+00:00",
      "stops_at": "1980-05-01T12:00:00+00:00",
      "reserved_from": "1980-04-01T12:00:00+00:00",
      "reserved_till": "1980-05-01T12:00:00+00:00",
      "reserved": true,
      "started": 0,
      "stopped": 0,
      "location_shortage_amount": 0,
      "shortage_amount": 0,
      "item_id": "eb1a3989-fc67-4537-a724-1078c4b3e6bd",
      "order_id": "99fccd13-3186-41ff-8e73-6a6328c5a109",
      "start_location_id": "cc01e0d3-cf93-4f81-bcb9-f3bf385d1649",
      "stop_location_id": "cc01e0d3-cf93-4f81-bcb9-f3bf385d1649",
      "parent_planning_id": null
    },
    "relationships": {
      "item": {
        "links": {
          "related": "api/boomerang/items/eb1a3989-fc67-4537-a724-1078c4b3e6bd"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/99fccd13-3186-41ff-8e73-6a6328c5a109"
        }
      },
      "order_line": {
        "links": {
          "related": "api/boomerang/lines?filter[planning_id]=1b9099a8-5b7f-46b9-a4fb-4415fa1608f3"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/cc01e0d3-cf93-4f81-bcb9-f3bf385d1649"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/cc01e0d3-cf93-4f81-bcb9-f3bf385d1649"
        }
      },
      "parent_planning": {
        "links": {
          "related": null
        }
      },
      "nested_plannings": {
        "links": {
          "related": "api/boomerang/plannings?filter[planning_id]=1b9099a8-5b7f-46b9-a4fb-4415fa1608f3"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[planning_id]=1b9099a8-5b7f-46b9-a4fb-4415fa1608f3"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/plannings/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,order,order_line`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[plannings]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`


`parent_planning`


`nested_plannings`





