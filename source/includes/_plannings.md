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
`POST api/boomerang/plannings/search`

`GET /api/boomerang/plannings/{id}`

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
                    "gte": "2024-03-12T09:15:31Z"
                  }
                },
                {
                  "starts_at": {
                    "lte": "2024-03-15T09:15:31Z"
                  }
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "stops_at": {
                    "gte": "2024-03-12T09:15:31Z"
                  }
                },
                {
                  "stops_at": {
                    "lte": "2024-03-15T09:15:31Z"
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
      "id": "77b54d3d-5a24-4172-92e5-5246855f40b8"
    },
    {
      "id": "abf4ace9-5caf-448d-b7fb-e0170be3bd3f"
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






## Fetching a planning



> How to fetch a planning:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings/89b8e758-df51-4596-a169-c03b725e7f9e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "89b8e758-df51-4596-a169-c03b725e7f9e",
    "type": "plannings",
    "attributes": {
      "created_at": "2024-03-11T09:15:32+00:00",
      "updated_at": "2024-03-11T09:15:33+00:00",
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
      "order_id": "79ca9376-7eb8-4c24-b456-a4053eb15065",
      "item_id": "e74ab97b-4322-4c13-b0c4-d754d632a160",
      "start_location_id": "4198e2ee-dde5-44b8-b861-8dc1a324e95d",
      "stop_location_id": "4198e2ee-dde5-44b8-b861-8dc1a324e95d",
      "parent_planning_id": null,
      "price_tile_id": null
    },
    "relationships": {
      "order": {
        "links": {
          "related": "api/boomerang/orders/79ca9376-7eb8-4c24-b456-a4053eb15065"
        }
      },
      "item": {
        "links": {
          "related": "api/boomerang/items/e74ab97b-4322-4c13-b0c4-d754d632a160"
        }
      },
      "order_line": {
        "links": {
          "related": "api/boomerang/lines?filter[planning_id]=89b8e758-df51-4596-a169-c03b725e7f9e"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/4198e2ee-dde5-44b8-b861-8dc1a324e95d"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/4198e2ee-dde5-44b8-b861-8dc1a324e95d"
        }
      },
      "parent_planning": {
        "links": {
          "related": null
        }
      },
      "nested_plannings": {
        "links": {
          "related": "api/boomerang/plannings?filter[parent_planning_id]=89b8e758-df51-4596-a169-c03b725e7f9e"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[planning_id]=89b8e758-df51-4596-a169-c03b725e7f9e"
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
      "id": "69028e9b-5dab-4acb-ac22-0ae459398067",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-11T09:15:36+00:00",
        "updated_at": "2024-03-11T09:15:36+00:00",
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
        "order_id": "d11ae915-d956-4f50-9e69-f4d910a28e8f",
        "item_id": "8486dbbb-2d04-4db3-839c-2a9f2d50102d",
        "start_location_id": "8f7d9dc3-08fa-4134-ab67-95c1842758be",
        "stop_location_id": "8f7d9dc3-08fa-4134-ab67-95c1842758be",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/d11ae915-d956-4f50-9e69-f4d910a28e8f"
          }
        },
        "item": {
          "links": {
            "related": "api/boomerang/items/8486dbbb-2d04-4db3-839c-2a9f2d50102d"
          }
        },
        "order_line": {
          "links": {
            "related": "api/boomerang/lines?filter[planning_id]=69028e9b-5dab-4acb-ac22-0ae459398067"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/8f7d9dc3-08fa-4134-ab67-95c1842758be"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/8f7d9dc3-08fa-4134-ab67-95c1842758be"
          }
        },
        "parent_planning": {
          "links": {
            "related": null
          }
        },
        "nested_plannings": {
          "links": {
            "related": "api/boomerang/plannings?filter[parent_planning_id]=69028e9b-5dab-4acb-ac22-0ae459398067"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[planning_id]=69028e9b-5dab-4acb-ac22-0ae459398067"
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





