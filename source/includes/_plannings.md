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
      "id": "0962787b-ced6-460a-9af7-51e0dd696edd",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-08T18:21:06+00:00",
        "updated_at": "2022-04-08T18:21:06+00:00",
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
        "item_id": "da5bf33a-8ff5-40fc-8c77-4f932dd80c06",
        "order_id": "d8f80be0-87b8-4799-a8a7-47157535978e",
        "start_location_id": "f07ec53e-60e8-40a8-9a88-7368d958f8c1",
        "stop_location_id": "f07ec53e-60e8-40a8-9a88-7368d958f8c1",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/da5bf33a-8ff5-40fc-8c77-4f932dd80c06"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/d8f80be0-87b8-4799-a8a7-47157535978e"
          }
        },
        "order_line": {
          "links": {
            "related": "api/boomerang/lines?filter[planning_id]=0962787b-ced6-460a-9af7-51e0dd696edd"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/f07ec53e-60e8-40a8-9a88-7368d958f8c1"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/f07ec53e-60e8-40a8-9a88-7368d958f8c1"
          }
        },
        "parent_planning": {
          "links": {
            "related": null
          }
        },
        "nested_plannings": {
          "links": {
            "related": "api/boomerang/plannings?filter[planning_id]=0962787b-ced6-460a-9af7-51e0dd696edd"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[planning_id]=0962787b-ced6-460a-9af7-51e0dd696edd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/plannings/61b143cc-a70d-4e90-8c8c-f3d41c1674b9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "61b143cc-a70d-4e90-8c8c-f3d41c1674b9",
    "type": "plannings",
    "attributes": {
      "created_at": "2022-04-08T18:21:08+00:00",
      "updated_at": "2022-04-08T18:21:08+00:00",
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
      "item_id": "5db29569-1721-4744-b943-5b84e7e53825",
      "order_id": "7c3276cf-0cbe-41aa-83f4-27e752df2f53",
      "start_location_id": "83c88892-c66f-4760-b397-807531fa46b2",
      "stop_location_id": "83c88892-c66f-4760-b397-807531fa46b2",
      "parent_planning_id": null
    },
    "relationships": {
      "item": {
        "links": {
          "related": "api/boomerang/items/5db29569-1721-4744-b943-5b84e7e53825"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/7c3276cf-0cbe-41aa-83f4-27e752df2f53"
        }
      },
      "order_line": {
        "links": {
          "related": "api/boomerang/lines?filter[planning_id]=61b143cc-a70d-4e90-8c8c-f3d41c1674b9"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/83c88892-c66f-4760-b397-807531fa46b2"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/83c88892-c66f-4760-b397-807531fa46b2"
        }
      },
      "parent_planning": {
        "links": {
          "related": null
        }
      },
      "nested_plannings": {
        "links": {
          "related": "api/boomerang/plannings?filter[planning_id]=61b143cc-a70d-4e90-8c8c-f3d41c1674b9"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[planning_id]=61b143cc-a70d-4e90-8c8c-f3d41c1674b9"
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





