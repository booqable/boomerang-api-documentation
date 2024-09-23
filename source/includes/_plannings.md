# Plannings

Plannings contain information about the quantitative planning of an item.
An item can either be a product or a bundle. Planning (in combination with
[Stock counts](#stock-counts)) define when an item is available during a
given period. Plannings are never directly created or updated through their
resource; instead, they are always managed by booking items to an order,
updating or deleting its associated line, or transitioning status.

Nested plannings contain information about individual items in a bundle.
Note that nested plannings can not be deleted directly, the parent line
should be deleted instead.

## Endpoints
`GET /api/boomerang/plannings`

`POST api/boomerang/plannings/search`

`GET /api/boomerang/plannings/{id}`

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


## Relationships
Plannings have the following relationships:

Name | Description
-- | --
`item` | **Items** `readonly`<br>Associated Item
`nested_plannings` | **Plannings** `readonly`<br>Associated Nested plannings
`order` | **Orders** `readonly`<br>Associated Order
`order_line` | **Lines** `readonly`<br>Associated Order line
`parent_planning` | **Plannings** `readonly`<br>Associated Parent planning
`start_location` | **Locations** `readonly`<br>Associated Start location
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings
`stop_location` | **Locations** `readonly`<br>Associated Stop location


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
      "id": "bc3aae4b-030a-4945-8730-09f15f979a63",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-09-23T09:23:57.884833+00:00",
        "updated_at": "2024-09-23T09:23:58.292025+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "abee7d8e-020f-4f80-b200-c53c7ff1cb85",
        "item_id": "33da82c2-480c-4322-aa13-e145f759780d",
        "start_location_id": "3261c1c2-0cad-4eab-98d0-39d46459a694",
        "stop_location_id": "3261c1c2-0cad-4eab-98d0-39d46459a694",
        "parent_planning_id": null
      },
      "relationships": {}
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
                    "gte": "2024-09-24T09:23:54Z"
                  }
                },
                {
                  "starts_at": {
                    "lte": "2024-09-27T09:23:54Z"
                  }
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "stops_at": {
                    "gte": "2024-09-24T09:23:54Z"
                  }
                },
                {
                  "stops_at": {
                    "lte": "2024-09-27T09:23:54Z"
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
      "id": "12f9125a-478b-4c5a-990d-b7df5f465353"
    },
    {
      "id": "791a60e8-554c-48d8-9b0e-d20d8380cb66"
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
    --url 'https://example.booqable.com/api/boomerang/plannings/826b5f29-795e-4fb9-bc8e-dd0c6812365e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "826b5f29-795e-4fb9-bc8e-dd0c6812365e",
    "type": "plannings",
    "attributes": {
      "created_at": "2024-09-23T09:23:55.542803+00:00",
      "updated_at": "2024-09-23T09:23:55.916503+00:00",
      "archived": false,
      "archived_at": null,
      "quantity": 1,
      "starts_at": "1980-04-01T12:00:00.000000+00:00",
      "stops_at": "1980-05-01T12:00:00.000000+00:00",
      "reserved_from": "1980-04-01T12:00:00.000000+00:00",
      "reserved_till": "1980-05-01T12:00:00.000000+00:00",
      "reserved": true,
      "started": 0,
      "stopped": 0,
      "location_shortage_amount": 0,
      "shortage_amount": 0,
      "order_id": "5a21b1f5-6d10-4abb-aac3-33a632d84149",
      "item_id": "e5c2da16-f50f-4a29-97f9-a7f99b6cbbd5",
      "start_location_id": "0971dd3c-b4de-4ed4-9d91-d4158032a3f7",
      "stop_location_id": "0971dd3c-b4de-4ed4-9d91-d4158032a3f7",
      "parent_planning_id": null
    },
    "relationships": {}
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





