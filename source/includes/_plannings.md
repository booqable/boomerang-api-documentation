# Plannings

Plannings contain information about the quantitative planning of an item.
An item can either be a product or a bundle. Planning (in combination with
[Stock counts](#stock-counts)) define when an item is available during a
given period. Plannings are never directly created or updated through their
resource; instead, they are always managed by booking items to an order,
updating or deleting its associated line, or transitioning status.

Nested plannings contain information about individual items in a bundle.
Note that nested plannings can not be deleted directly, the parent should
be deleted instead.

## Endpoints
`GET /api/boomerang/plannings/{id}`

`POST api/boomerang/plannings/search`

`GET /api/boomerang/plannings`

## Fields
Every planning has the following fields:

Name | Description
-- | --
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
`started` | **Integer** `readonly`<br>Amount of items started. Cannot exceed `quantity`. This attribute is omitted when this is a parent planning for a Bundle. 
`stopped` | **Integer** `readonly`<br>Amount of items stopped. Cannot exceed `quantity` and `started`. This attribute is omitted when this is a parent planning for a Bundle. 
`location_shortage_amount` | **Integer** `readonly`<br>Amount of items short. This attribute is omitted when this is a parent planning for a Bundle. 
`shortage_amount` | **Integer** `readonly`<br>Amount of items short on location (could be there are still available on other locations in the same cluster). This attribute is omitted when this is a parent planning for a Bundle. 
`order_id` | **Uuid** `readonly`<br>The associated Order
`item_id` | **Uuid** `readonly`<br>The associated Item
`start_location_id` | **Uuid** `readonly`<br>The associated Start location
`stop_location_id` | **Uuid** `readonly`<br>The associated Stop location
`parent_planning_id` | **Uuid** `readonly`<br>The associated Parent planning
`price_tile_id` | **Uuid** <br>The associated Price tile


## Relationships
Plannings have the following relationships:

Name | Description
-- | --
`order` | **Orders** `readonly`<br>Associated Order
`item` | **Items** `readonly`<br>Associated Item
`order_line` | **Lines** `readonly`<br>Associated Order line
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location
`parent_planning` | **Plannings** `readonly`<br>Associated Parent planning
`nested_plannings` | **Plannings** `readonly`<br>Associated Nested plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Fetching a planning



> How to fetch a planning:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings/649518fc-a85f-4713-a708-3fc20d234338' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "649518fc-a85f-4713-a708-3fc20d234338",
    "type": "plannings",
    "attributes": {
      "created_at": "2024-04-15T09:26:04+00:00",
      "updated_at": "2024-04-15T09:26:04+00:00",
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
      "order_id": "bdf3dd00-8fbd-43d7-9dd7-48a1cc4b9f8e",
      "item_id": "dba1a7ae-b619-4189-b81e-7f8c7f54c3e5",
      "start_location_id": "78a1a880-9e22-4c7a-be37-afc749603aae",
      "stop_location_id": "78a1a880-9e22-4c7a-be37-afc749603aae",
      "parent_planning_id": null,
      "price_tile_id": null
    },
    "relationships": {
      "order": {
        "links": {
          "related": "api/boomerang/orders/bdf3dd00-8fbd-43d7-9dd7-48a1cc4b9f8e"
        }
      },
      "item": {
        "links": {
          "related": "api/boomerang/items/dba1a7ae-b619-4189-b81e-7f8c7f54c3e5"
        }
      },
      "order_line": {
        "links": {
          "related": "api/boomerang/lines?filter[planning_id]=649518fc-a85f-4713-a708-3fc20d234338"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/78a1a880-9e22-4c7a-be37-afc749603aae"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/78a1a880-9e22-4c7a-be37-afc749603aae"
        }
      },
      "parent_planning": {
        "links": {
          "related": null
        }
      },
      "nested_plannings": {
        "links": {
          "related": "api/boomerang/plannings?filter[parent_planning_id]=649518fc-a85f-4713-a708-3fc20d234338"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[planning_id]=649518fc-a85f-4713-a708-3fc20d234338"
        }
      },
      "price_tile": {
        "links": {
          "related": null
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`


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






## Searching plannings

Use advanced search to make logical filter groups with and/or operators.


> How to search for plannings:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/plannings/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "plannings": "id"
      },
      "filter": {
        "conditions": {
          "operator": "or",
          "attributes": [
            {
              "operator": "and",
              "attributes": [
                {
                  "starts_at": {
                    "gte": "2024-04-16T09:26:10Z"
                  }
                },
                {
                  "starts_at": {
                    "lte": "2024-04-19T09:26:10Z"
                  }
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "stops_at": {
                    "gte": "2024-04-16T09:26:10Z"
                  }
                },
                {
                  "stops_at": {
                    "lte": "2024-04-19T09:26:10Z"
                  }
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "613e93c0-2da9-4d3d-ab18-75e921e2ce7f"
    },
    {
      "id": "d00f5f11-7431-4364-b1e3-2dd14f78f5af"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/plannings/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_from` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean** <br>`eq`
`started` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stopped` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`location_shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`item_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **Uuid** <br>`eq`, `not_eq`
`price_tile_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_type` | **String** <br>`eq`, `not_eq`
`product_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






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
      "id": "60d61b61-a7ae-4c74-92cf-7237bd3b9367",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-15T09:26:12+00:00",
        "updated_at": "2024-04-15T09:26:13+00:00",
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
        "order_id": "5adfa0f1-138f-4783-80ec-fbc116d63143",
        "item_id": "e68883a9-4278-48f6-815b-b64d15ca0d32",
        "start_location_id": "a8632a47-5a26-4c85-ac9d-0159abace52a",
        "stop_location_id": "a8632a47-5a26-4c85-ac9d-0159abace52a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/5adfa0f1-138f-4783-80ec-fbc116d63143"
          }
        },
        "item": {
          "links": {
            "related": "api/boomerang/items/e68883a9-4278-48f6-815b-b64d15ca0d32"
          }
        },
        "order_line": {
          "links": {
            "related": "api/boomerang/lines?filter[planning_id]=60d61b61-a7ae-4c74-92cf-7237bd3b9367"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/a8632a47-5a26-4c85-ac9d-0159abace52a"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/a8632a47-5a26-4c85-ac9d-0159abace52a"
          }
        },
        "parent_planning": {
          "links": {
            "related": null
          }
        },
        "nested_plannings": {
          "links": {
            "related": "api/boomerang/plannings?filter[parent_planning_id]=60d61b61-a7ae-4c74-92cf-7237bd3b9367"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[planning_id]=60d61b61-a7ae-4c74-92cf-7237bd3b9367"
          }
        },
        "price_tile": {
          "links": {
            "related": null
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_from` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean** <br>`eq`
`started` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stopped` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`location_shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`item_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **Uuid** <br>`eq`, `not_eq`
`price_tile_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_type` | **String** <br>`eq`, `not_eq`
`product_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`





