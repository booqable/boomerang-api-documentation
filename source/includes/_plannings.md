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
      "id": "ee4c15ec-5e3c-410e-a30a-1f9d6366680e",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-16T09:39:15+00:00",
        "updated_at": "2021-12-16T09:39:15+00:00",
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
        "item_id": "221caea9-8acf-4890-9a9b-6eecc20b7558",
        "order_id": "0196dd82-d05b-423f-82e2-687cefcea0d1",
        "start_location_id": "26fb86d7-4feb-4617-8fed-0c0c1e571cdb",
        "stop_location_id": "26fb86d7-4feb-4617-8fed-0c0c1e571cdb",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/221caea9-8acf-4890-9a9b-6eecc20b7558"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/0196dd82-d05b-423f-82e2-687cefcea0d1"
          }
        },
        "order_line": {
          "links": {
            "related": "api/boomerang/lines?filter[planning_id]=ee4c15ec-5e3c-410e-a30a-1f9d6366680e"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/26fb86d7-4feb-4617-8fed-0c0c1e571cdb"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/26fb86d7-4feb-4617-8fed-0c0c1e571cdb"
          }
        },
        "parent_planning": {
          "links": {
            "related": null
          }
        },
        "nested_plannings": {
          "links": {
            "related": "api/boomerang/plannings?filter[planning_id]=ee4c15ec-5e3c-410e-a30a-1f9d6366680e"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[planning_id]=ee4c15ec-5e3c-410e-a30a-1f9d6366680e"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/plannings?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/plannings/82a0ade1-8bfd-4cf6-b083-125cd67b0475' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "82a0ade1-8bfd-4cf6-b083-125cd67b0475",
    "type": "plannings",
    "attributes": {
      "created_at": "2021-12-16T09:39:17+00:00",
      "updated_at": "2021-12-16T09:39:17+00:00",
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
      "item_id": "e635fc09-a2f6-4c83-b384-eb3ce8bfab32",
      "order_id": "0885fd6b-ef20-48b3-bc5d-94d8ae0f896c",
      "start_location_id": "4244a237-6ec6-4db4-8b57-33d7a81eacfc",
      "stop_location_id": "4244a237-6ec6-4db4-8b57-33d7a81eacfc",
      "parent_planning_id": null
    },
    "relationships": {
      "item": {
        "links": {
          "related": "api/boomerang/items/e635fc09-a2f6-4c83-b384-eb3ce8bfab32"
        }
      },
      "order": {
        "links": {
          "related": "api/boomerang/orders/0885fd6b-ef20-48b3-bc5d-94d8ae0f896c"
        }
      },
      "order_line": {
        "links": {
          "related": "api/boomerang/lines?filter[planning_id]=82a0ade1-8bfd-4cf6-b083-125cd67b0475"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/4244a237-6ec6-4db4-8b57-33d7a81eacfc"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/4244a237-6ec6-4db4-8b57-33d7a81eacfc"
        }
      },
      "parent_planning": {
        "links": {
          "related": null
        }
      },
      "nested_plannings": {
        "links": {
          "related": "api/boomerang/plannings?filter[planning_id]=82a0ade1-8bfd-4cf6-b083-125cd67b0475"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[planning_id]=82a0ade1-8bfd-4cf6-b083-125cd67b0475"
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





